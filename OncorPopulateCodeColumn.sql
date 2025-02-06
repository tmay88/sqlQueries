DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'oncorfinals') LOOP
        EXECUTE '
            UPDATE oncorfinals.' || r.tablename || ' t
            SET code = UPPER(''' || r.tablename || ''')
        ';
    END LOOP;
END $$;