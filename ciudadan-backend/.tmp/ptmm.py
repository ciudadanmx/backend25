import re

INPUT_FILE = "tables_clean.sql"
OUTPUT_FILE = "tables_clean_fixed.sql"

create_table_pattern = re.compile(r'CREATE TABLE IF NOT EXISTS (\w+)', re.IGNORECASE)
constraint_pattern = re.compile(r'ALTER TABLE\s+(\w+)\s+ADD CONSTRAINT\s+(\w+)', re.IGNORECASE)

def main():
    with open(INPUT_FILE, "r", encoding="utf-8") as f:
        lines = f.readlines()

    # Extraer tablas definidas
    tables = set()
    for line in lines:
        m = create_table_pattern.search(line)
        if m:
            tables.add(m.group(1))

    seen_constraints = set()
    cleaned_lines = []
    skip_count = 0

    for line in lines:
        m = constraint_pattern.search(line)
        if m:
            table, constraint = m.groups()
            if constraint in seen_constraints:
                print(f"⏭️  Eliminando duplicado: {constraint}")
                skip_count += 1
                continue
            if table not in tables:
                print(f"⏭️  Eliminando constraint en tabla inexistente: {table}")
                skip_count += 1
                continue
            seen_constraints.add(constraint)
        cleaned_lines.append(line)

    with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
        f.writelines(cleaned_lines)

    print(f"\n✅ Archivo limpio guardado en: {OUTPUT_FILE}")
    print(f"🗑️ {skip_count} constraints removidos")

if __name__ == "__main__":
    main()