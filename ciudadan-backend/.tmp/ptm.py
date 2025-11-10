import re
import sys
from pathlib import Path

if len(sys.argv) < 3:
    print("Usage: python fix_order_and_fks.py <input.sql> <output.sql>")
    sys.exit(1)

input_path = Path(sys.argv[1])
output_path = Path(sys.argv[2])

sql = input_path.read_text(encoding="utf-8")

# 0) Basic cleanup
# remove sqlite pragmas and transactions
sql = re.sub(r'(?im)^\s*PRAGMA[^\r\n]*\r?\n', '', sql)
sql = re.sub(r'(?im)^\s*BEGIN TRANSACTION;?\r?\n', '', sql)
sql = re.sub(r'(?im)^\s*COMMIT;?\r?\n', '', sql)

# normalize backticks -> double quotes removed (we'll use bare identifiers)
sql = sql.replace("`", "")

# normalize whitespace of create table starts to ease finding them
# find CREATE TABLE blocks (including IF NOT EXISTS and quoted names)
table_blocks = re.findall(r'(?is)(CREATE\s+TABLE\s+(?:IF\s+NOT\s+EXISTS\s+)?["\']?([A-Za-z0-9_]+)["\']?\s*\(.*?\)\s*;)', sql)

if not table_blocks:
    print("No CREATE TABLE blocks found. Exiting.")
    sys.exit(1)

# collect table names and raw blocks
tables = []
for full, tname in table_blocks:
    tables.append((tname, full))

# function to fix a single CREATE TABLE block:
def fix_table_block(raw):
    t = raw

    # remove double quotes around identifiers for simplicity
    t = re.sub(r'"([A-Za-z0-9_]+)"', r'\1', t)

    # change datetime -> timestamp (case-insensitive)
    t = re.sub(r'(?i)\bdatetime\b', 'timestamp', t)

    # Fix id patterns like: id INTEGER PRIMARY KEY AUTOINCREMENT  OR "id" INTEGER PRIMARY KEY AUTOINCREMENT
    t = re.sub(r'(?i)\b(id)\b\s+integer\s+primary\s+key\s+autoincrement', r'\1 SERIAL PRIMARY KEY', t)
    t = re.sub(r'(?i)\b(id)\b\s+integer\s+primary\s+key', r'\1 INTEGER PRIMARY KEY', t)  # leave non-autoinc ints alone

    # Remove duplicate SERIAL if mistakenly repeated (e.g. SERIAL PRIMARY KEY SERIAL)
    t = re.sub(r'(?i)\bSERIAL\s+PRIMARY\s+KEY\s+SERIAL\b', 'SERIAL PRIMARY KEY', t)
    t = re.sub(r'(?i)\bSERIAL\s+PRIMARY\s+KEY\s+NOT\s+NULL\b', 'SERIAL PRIMARY KEY', t)

    # Convert "FLOAT" or "REAL" to appropriate Postgres types: keep float, but ensure syntax ok
    t = re.sub(r'(?i)\breal\b', 'double precision', t)

    # Extract and remove CONSTRAINT ... FOREIGN KEY ... lines (could be multiple per block)
    fk_patterns = []
    # match CONSTRAINT name FOREIGN KEY (...) REFERENCES ref_table(...) [ON DELETE ...]
    for m in re.finditer(r'(?is)(CONSTRAINT\s+[A-Za-z0-9_]+\s+FOREIGN\s+KEY\s*\([^\)]*\)\s+REFERENCES\s+[A-Za-z0-9_]+\s*\([^\)]*\)[^,;\)]*)(,)?', t):
        fk = m.group(1).strip()
        fk_patterns.append(fk)
    # also catch inline "FOREIGN KEY (...) REFERENCES ..." without CONSTRAINT name
    for m in re.finditer(r'(?is)(FOREIGN\s+KEY\s*\([^\)]*\)\s+REFERENCES\s+[A-Za-z0-9_]+\s*\([^\)]*\)[^,;\)]*)(,)?', t):
        fk = m.group(1).strip()
        # avoid double-capturing ones already captured as CONSTRAINTs
        if not any(fk.lower() in s.lower() for s in fk_patterns):
            fk_patterns.append(fk)

    # remove those fk lines from table definition
    for fk in fk_patterns:
        # remove occurrences followed by optional comma
        t = re.sub(re.escape(fk) + r'\s*,?', '', t, flags=re.IGNORECASE)

    # ensure CREATE TABLE has IF NOT EXISTS and stripped quotes
    t = re.sub(r'(?i)CREATE\s+TABLE\s+(?:"|\')?([A-Za-z0-9_]+)(?:"|\')?', r'CREATE TABLE IF NOT EXISTS \1', t, count=1)

    # tidy up repeated commas (commas left at end)
    t = re.sub(r',\s*\)', r')', t)

    # ensure trailing semicolon
    t = t.strip()
    if not t.endswith(';'):
        t = t + ';'

    return t, fk_patterns

fixed_create_stmts = []
fk_statements = []
seen_fk = set()
table_names = []

# Process in the order they were found (we will emit CREATEs first)
for tname, raw in tables:
    fixed, fks = fix_table_block(raw)
    fixed_create_stmts.append((tname, fixed))
    table_names.append(tname)
    # convert each fk pattern into an ALTER TABLE statement, with unique constraint names
    for fk in fks:
        fk_clean = fk.strip().rstrip(',')
        # if it already contains CONSTRAINT name, extract it; else create one
        m = re.match(r'(?is)CONSTRAINT\s+([A-Za-z0-9_]+)\s+FOREIGN\s+KEY\s*\((.*?)\)\s+REFERENCES\s+([A-Za-z0-9_]+)\s*\((.*?)\)(.*)', fk_clean, flags=re.IGNORECASE)
        if m:
            cname, cols, ref_table, ref_cols, tail = m.group(1), m.group(2), m.group(3), m.group(4), m.group(5)
            # determine source table name from context not available here; we'll attach later using mapping
            # We'll store as tuple (constraint_name, cols, ref_table, ref_cols, tail, origin_table_placeholder)
            fk_statements.append((None, cname, cols.strip(), ref_table.strip(), ref_cols.strip(), tail.strip()))
        else:
            # inline FK without CONSTRAINT name
            m2 = re.match(r'(?is)FOREIGN\s+KEY\s*\((.*?)\)\s+REFERENCES\s+([A-Za-z0-9_]+)\s*\((.*?)\)(.*)', fk_clean, flags=re.IGNORECASE)
            if m2:
                cols, ref_table, ref_cols, tail = m2.group(1), m2.group(2), m2.group(3), m2.group(4)
                fk_statements.append((None, None, cols.strip(), ref_table.strip(), ref_cols.strip(), tail.strip()))
            else:
                # fallback: keep raw
                fk_statements.append((None, None, None, None, None, fk_clean))

# Now we need origin table for each fk: the fk was extracted from a particular CREATE block.
# We re-run extraction with knowledge of origin.
fk_statements = []  # rebuild with origin
for tname, raw in tables:
    # fix raw like before to remove quotes
    raw_no_quotes = raw.replace("`", "").replace('"', '')
    # find fk occurrences and capture full text
    for m in re.finditer(r'(?is)(CONSTRAINT\s+[A-Za-z0-9_]+\s+FOREIGN\s+KEY\s*\([^\)]*\)\s+REFERENCES\s+[A-Za-z0-9_]+\s*\([^\)]*\)[^,;\)]*)(,)?', raw_no_quotes):
        fk = m.group(1).strip().rstrip(',')
        mm = re.match(r'(?is)CONSTRAINT\s+([A-Za-z0-9_]+)\s+FOREIGN\s+KEY\s*\((.*?)\)\s+REFERENCES\s+([A-Za-z0-9_]+)\s*\((.*?)\)(.*)', fk, flags=re.IGNORECASE)
        if mm:
            cname, cols, ref_table, ref_cols, tail = mm.group(1), mm.group(2), mm.group(3), mm.group(4), mm.group(5)
            fk_statements.append((tname, cname, cols.strip(), ref_table.strip(), ref_cols.strip(), tail.strip()))
    for m in re.finditer(r'(?is)(FOREIGN\s+KEY\s*\([^\)]*\)\s+REFERENCES\s+[A-Za-z0-9_]+\s*\([^\)]*\)[^,;\)]*)(,)?', raw_no_quotes):
        fk = m.group(1).strip().rstrip(',')
        # skip CONSTRAINT ones already captured
        if 'CONSTRAINT' in fk.upper():
            continue
        mm = re.match(r'(?is)FOREIGN\s+KEY\s*\((.*?)\)\s+REFERENCES\s+([A-Za-z0-9_]+)\s*\((.*?)\)(.*)', fk, flags=re.IGNORECASE)
        if mm:
            cols, ref_table, ref_cols, tail = mm.group(1), mm.group(2), mm.group(3), mm.group(4)
            fk_statements.append((tname, None, cols.strip(), ref_table.strip(), ref_cols.strip(), tail.strip()))
        else:
            fk_statements.append((tname, None, None, None, None, fk))

# Deduplicate fk_statements by canonical tuple
seen = set()
fk_final = []
for item in fk_statements:
    key = tuple(item)
    if key in seen:
        continue
    seen.add(key)
    fk_final.append(item)

# Build final SQL: all CREATE TABLE (fixed) first, then ALTER TABLE statements for FK
out_lines = []
# fixed CREATEs: apply fix_table_block again to ensure cleaned version
for tname, raw in tables:
    clean, _ = fix_table_block(raw)
    out_lines.append(clean)

# Now generate ALTER TABLEs
for origin_table, cname, cols, ref_table, ref_cols, tail in fk_final:
    # ensure origin_table exists
    if not origin_table:
        continue
    # construct constraint name if absent
    if not cname:
        # generate a name
        cname = f"{origin_table}_{(cols or 'fk').replace(' ','').replace(',','_')}_fk"
    # normalize parentheses
    cols_fmt = f"({cols})" if cols else ""
    ref_cols_fmt = f"({ref_cols})" if ref_cols else ""
    tail_part = f" {tail}" if tail else ""
    stmt = f"ALTER TABLE {origin_table} ADD CONSTRAINT {cname} FOREIGN KEY {cols_fmt} REFERENCES {ref_table} {ref_cols_fmt}{tail_part};"
    out_lines.append(stmt)

# write output
output_path.write_text("\n\n".join(out_lines), encoding="utf-8")
print("Wrote", output_path)