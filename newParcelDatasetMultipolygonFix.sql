--Permissions on new tables
ALTER TABLE gis_staging.parcels
    OWNER to pgadmin;
 
GRANT ALL ON TABLE gis_staging.parcels TO sde;
 
GRANT ALL ON TABLE gis_staging.parcels TO pgadmin;


--Create new table with our standard columns/data
CREATE TABLE gis_staging.parcels00024_fix
(
    objectid integer NOT NULL,
    housenum character varying(10) COLLATE pg_catalog."default",
    predir character varying(10) COLLATE pg_catalog."default",
    streetname character varying(100) COLLATE pg_catalog."default",
    pretype character varying(10) COLLATE pg_catalog."default",
    streettype character varying(10) COLLATE pg_catalog."default",
    sufdir character varying(10) COLLATE pg_catalog."default",
    countyname character varying(100) COLLATE pg_catalog."default",
    fulladdress character varying(150) COLLATE pg_catalog."default",
    placename character varying(100) COLLATE pg_catalog."default",
    createddate timestamp without time zone,
    editor character varying(2) COLLATE pg_catalog."default",
    gcverbase character varying(5) COLLATE pg_catalog."default",
    prop_id character varying(50) COLLATE pg_catalog."default",
    geo_id character varying(50) COLLATE pg_catalog."default",
    metro character varying(25) COLLATE pg_catalog."default",
    gdb_geomattr_data bytea,
    shape geometry,
	ts tsvector,
    CONSTRAINT enforce_srid_shape CHECK (st_srid(shape) = 4326)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

--Query returned successfully in 102 msec.
	
insert into gis_staging.parcels00024_fix
(objectid, housenum, predir, streetname, pretype, streettype, sufdir, countyname, fulladdress, 
placename, createddate, editor, gcverbase, prop_id, geo_id, shape)
select objectid, housenum, predir, streetname, pretype, streettype, sufdir, countyname, fulladdress, 
placename, createddate, editor, gcverbase, prop_id, geo_id, (ST_Dump(geom)).geom as geom
from gis_staging.parcels_00024;

--INSERT 0 1435251
--Query returned successfully in 17 secs 277 msec.
--Remove the first upload of parcels. Recreate the empty table

CREATE TABLE gis_staging.parcels_00024
(
    objectid integer NOT NULL,
    housenum character varying(10) COLLATE pg_catalog."default",
    predir character varying(10) COLLATE pg_catalog."default",
    streetname character varying(100) COLLATE pg_catalog."default",
    pretype character varying(10) COLLATE pg_catalog."default",
    streettype character varying(10) COLLATE pg_catalog."default",
    sufdir character varying(10) COLLATE pg_catalog."default",
    countyname character varying(100) COLLATE pg_catalog."default",
    fulladdress character varying(150) COLLATE pg_catalog."default",
    placename character varying(100) COLLATE pg_catalog."default",
    createddate timestamp without time zone,
    editor character varying(2) COLLATE pg_catalog."default",
    gcverbase character varying(5) COLLATE pg_catalog."default",
    prop_id character varying(50) COLLATE pg_catalog."default",
    geo_id character varying(50) COLLATE pg_catalog."default",
    metro character varying(25) COLLATE pg_catalog."default",
    gdb_geomattr_data bytea,
    shape geometry,
	ts tsvector,
    CONSTRAINT enforce_srid_shape CHECK (st_srid(shape) = 4326)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE gis_staging.parcels_00024
    OWNER to pgadmin;
	
--Success
	
insert into gis_staging.parcels_00024
(objectid, housenum, predir, streetname, pretype, streettype, sufdir, countyname, fulladdress, 
placename, createddate, editor, gcverbase, prop_id, geo_id, shape)
select objectid, housenum, predir, streetname, pretype, streettype, sufdir, countyname, fulladdress, 
placename, createddate, editor, gcverbase, prop_id, geo_id, shape
from gis_staging.parcels00024_fix

--INSERT 0 1435251
--Query returned successfully in 11 secs 395 msec.

select count(*)
from gis_staging.parcels_00024
where st_NumGeometries(shape) > 1;

--None selected. Success

SELECT ST_GeometryType(shape) AS geometry_type, count(*) AS count
FROM gis_staging.parcels_00024
GROUP BY ST_GeometryType(shape);

