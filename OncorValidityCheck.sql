DO $$
DECLARE
	r RECORD;
BEGIN
	FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'oncor') LOOP
		EXECUTE 'SELECT '|| r.tablename ||' AS tablename, st_isValidReason(geom) FROM oncor.' || r.tablename || ' WHERE NOT st_isValid(geom)
				 UNION ALL
				';
	END LOOP;
END $$