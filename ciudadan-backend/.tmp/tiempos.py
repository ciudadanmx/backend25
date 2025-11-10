import re

INPUT_FILE = "dump_fixed_ts.sql"
OUTPUT_FILE = "dump_fixed_ts_cleaned.sql"

# Patrón: to_timestamp(numero)::timestamp(numero_mal)
pattern = re.compile(r'to_timestamp\((\d+)\)::timestamp\(\d+\)')

def fix_timestamp(match):
    num = int(match.group(1))
    # Ajuste si es milisegundos
    if num > 10**10:
        num = num / 1000
    return f"to_timestamp({num})::timestamp"

with open(INPUT_FILE, "r", encoding="utf-8") as f:
    content = f.read()

content_fixed = pattern.sub(fix_timestamp, content)

with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
    f.write(content_fixed)

print(f"✅ Archivo limpio guardado en: {OUTPUT_FILE}")