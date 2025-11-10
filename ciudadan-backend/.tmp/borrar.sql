DO $$
DECLARE
    r RECORD;
BEGIN
    -- Recorre todas las tablas en el schema public
    FOR r IN
        SELECT tablename
        FROM pg_tables
        WHERE schemaname = 'public'
    LOOP
        -- Construye y ejecuta el TRUNCATE para cada tabla
        EXECUTE format('TRUNCATE TABLE %I RESTART IDENTITY CASCADE;', r.tablename);
    END LOOP;
END$$;
