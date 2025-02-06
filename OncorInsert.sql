DO $$ 
DECLARE
    table_name_var text;
BEGIN
    -- Loop through tables in the specified schema
    FOR table_name_var IN (SELECT table_name FROM information_schema.tables WHERE table_schema = 'gisload' AND table_type = 'BASE TABLE') 
    LOOP
        -- Construct and execute dynamic SQL to insert data into giseditor_current.servicearea
        EXECUTE format('INSERT INTO giseditor_current.servicearea (code, geom) SELECT code, geom FROM %I.%I', 'gisload', table_name_var);
    END LOOP;
END $$;