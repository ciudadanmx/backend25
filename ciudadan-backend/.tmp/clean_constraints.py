import psycopg2
import re

# ⚡ Configura tus credenciales de Supabase (Postgres)
DB_CONFIG = {
    "dbname": "postgres",
    "user": "postgres",
    "password": "Kolabora%4033.420",
    "host": "db.hlndtqccucuyceaedrgs.supabase.co",
    "port": 5432,
    "sslmode": "require",
}

# Archivo SQL original
INPUT_FILE = "tables_clean.sql"
# Archivo SQL limpio
OUTPUT_FILE = "tables_clean_fixed.sql"

# Regex para detectar constraints
constraint_pattern = re.compile(
    r'ALTER TABLE\s+(\w+)\s+ADD CONSTRAINT\s+(\w+)\s+FOREIGN KEY',
    re.IGNORECASE
)

def get_existing_constraints(cursor):
    cursor.execute("SELECT conname FROM pg_constraint;")
    return {row[0] for row in cursor.fetchall()}

def get_existing_tables(cursor):
    cursor.execute("SELECT tablename FROM pg_tables WHERE schemaname='public';")
    return {row[0] for row in cursor.fetchall()}

def main():
    conn = psycopg2.connect(**DB_CONFIG)
    cur = conn.cursor()

    existing_constraints = get_existing_constraints(cur)
    existing_tables = get_existing_tables(cur)

    print(f"🔎 {len(existing_constraints)} constraints detectados en la base")
    print(f"📋 {len(existing_tables)} tablas detectadas en la base")

    cleaned_lines = []
    skip_count = 0

    with open(INPUT_FILE, "r", encoding="utf-8") as f:
        for line in f:
            match = constraint_pattern.search(line)
            if match:
                table, constraint = match.groups()
                if constraint in existing_constraints:
                    print(f"⏭️  Saltando constraint duplicado: {constraint}")
                    skip_count += 1
                    continue
                if table not in existing_tables:
                    print(f"⏭️  Saltando constraint en tabla inexistente: {table}")
                    skip_count += 1
                    continue
            cleaned_lines.append(line)

    with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
        f.writelines(cleaned_lines)

    print(f"\n✅ Archivo limpio guardado en: {OUTPUT_FILE}")
    print(f"🗑️ {skip_count} líneas removidas")

    cur.close()
    conn.close()

if __name__ == "__main__":
    main()