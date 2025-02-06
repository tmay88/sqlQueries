DO $$
DECLARE
	r RECORD;
BEGIN
	FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'oncor') LOOP
		EXECUTE 'UPDATE oncor.' || r.tablename || ' SET geom = st_multi(st_collectionextract(st_makevalid(geom),3));
				 DELETE FROM oncor.' || r.tablename || ' WHERE geom IS NULL;
				 UPDATE oncor.' || r.tablename || ' SET geom = st_multi(st_simplify(geom, 0));
				 SELECT st_isValidReason(geom) FROM oncor.' || r.tablename || ' WHERE NOT st_isValid(geom);';
	END LOOP;
END $$