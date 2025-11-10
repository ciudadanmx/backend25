import re

INPUT_FILE = "dump.sql"
OUTPUT_FILE = "dump_fixed.sql"

# Esto busca valores numéricos que estén al final de un INSERT y correspondan a created_at o updated_at
timestamp_pattern = re.compile(r"(\b\d{9,}\b)")  # números grandes (posible epoch)
created_updated_cols = ["created_at", "updated_at"]

def fix_line(line):
    # Solo aplicamos a líneas INSERT
    if line.strip().upper().startswith("INSERT INTO"):
        # Convertimos todos los números grandes a to_timestamp(n)
        def repl(m):
            val = m.group(1)
            return f"to_timestamp({val})"
        line = timestamp_pattern.sub(repl, line)
    return line

def main():
    with open(INPUT_FILE, "r", encoding="utf-8") as f:
        lines = f.readlines()

    fixed_lines = [fix_line(l) for l in lines]

    with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
        f.writelines(fixed_lines)

    print(f"✅ Archivo corregido guardado en: {OUTPUT_FILE}")

if __name__ == "__main__":
    main()
