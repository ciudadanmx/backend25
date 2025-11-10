import re

INPUT_FILE = "dump_fixed_ts_cleaned.sql"
OUTPUT_FILE = "dump_fixed_ts_final.sql"

# Patrón más seguro: números convertidos a timestamp solo para campos *_at
pattern = re.compile(r"(?:'[^']*',\s*)*(\d+)(?=::timestamp|--timestamp_marker)")

def fix_timestamp(match):
    num = int(match.group(1))
    # Si es demasiado grande, asumimos milisegundos
    if num > 10**10:
        num = num / 1000
    return str(num)

with open(INPUT_FILE, "r", encoding="utf-8") as f:
    content = f.read()

# Este reemplazo solo afecta a los patrones marcados como timestamp
content_fixed = pattern.sub(fix_timestamp, content)

with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
    f.write(content_fixed)

print(f"✅ Archivo listo para intentar subir: {OUTPUT_FILE}")
