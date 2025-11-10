import re

INPUT_FILE = "dump_fixed.sql"
OUTPUT_FILE = "dump_fixed_ts.sql"

pattern = re.compile(r'(\d+)\.to_timestamp')

with open(INPUT_FILE, "r", encoding="utf-8") as f:
    content = f.read()

# Reemplaza "123.to_timestamp" → "to_timestamp(123)::timestamp"
content_fixed = pattern.sub(r'to_timestamp(\1)::timestamp', content)

with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
    f.write(content_fixed)

print(f"✅ Archivo corregido guardado en: {OUTPUT_FILE}")
