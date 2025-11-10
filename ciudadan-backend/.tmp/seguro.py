import re

INPUT_FILE = "dump_fixed_ts.sql"
OUTPUT_FILE = "dump_fixed_ts_final_safe.sql"

# Columnas que son timestamps
timestamp_columns = {'created_at', 'updated_at', 'time', 'released_at', 'scheduled_at', 'fecha_registro', 'fecha_membresia', 'fecha_nacimiento'}

insert_pattern = re.compile(r"INSERT INTO (\w+)\s*\((.*?)\)\s*VALUES\s*\((.*?)\);", re.IGNORECASE | re.DOTALL)

def fix_timestamps(match):
    table = match.group(1)
    columns = [c.strip() for c in match.group(2).split(',')]
    values = [v.strip() for v in match.group(3).split(',')]

    for i, col in enumerate(columns):
        col_name = col.lower()
        val = values[i]

        # Si es columna de timestamp y valor es solo un número
        if col_name in timestamp_columns:
            num_match = re.match(r"^\d+$", val)
            if num_match:
                num = int(val)
                # Si está en milisegundos
                if num > 10**10:
                    num = num / 1000
                values[i] = f"to_timestamp({num})"

    return f"INSERT INTO {table} ({', '.join(columns)}) VALUES ({', '.join(values)});"

with open(INPUT_FILE, 'r', encoding='utf-8') as f:
    content = f.read()

content_fixed = insert_pattern.sub(fix_timestamps, content)

with open(OUTPUT_FILE, 'w', encoding='utf-8') as f:
    f.write(content_fixed)

print(f"✅ Archivo listo: {OUTPUT_FILE}")
