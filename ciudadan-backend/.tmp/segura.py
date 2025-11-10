import re

INPUT_FILE = "dump_fixed_ts.sql"       # tu dump actual con ::timestamp mal
OUTPUT_FILE = "dump_final_ya.sql"        # archivo limpio

# Patrón: to_timestamp(<número>) seguido de ::timestamp(<cualquier número>)
pattern = re.compile(r'(to_timestamp\(\d+\))::timestamp\(\d+\)', re.IGNORECASE)

with open(INPUT_FILE, 'r', encoding='utf-8') as f:
    content = f.read()

# Reemplaza todo por solo to_timestamp(<número>)
content_fixed = pattern.sub(r'\1', content)

with open(OUTPUT_FILE, 'w', encoding='utf-8') as f:
    f.write(content_fixed)

print(f"✅ Archivo limpio listo: {OUTPUT_FILE}")
