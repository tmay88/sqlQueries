Multipolygon fix
/***
select fulladdress, st_astext(shape) from gcverbase00023.parcels where fulladdress = '2126 COUNTRY CLUB BLVD'

select fulladdress, st_astext(shape) from gcverbase00022.parcels where fulladdress = '2126 COUNTRY CLUB BLVD'

select count(*) from gcverbase00023.parcels where st_astext(shape) like 'MULTI%'

select countyname, count(*) from gcverbase00023.parcels
where st_GeometryType(shape) = 'ST_MultiPolygon'
group by countyname

select fulladdress, st_astext(shape) from gcverbase00023.parcels where fulladdress = '2126 COUNTRY CLUB BLVD'

update gcverbase00023.parcels 
set shape = st_dump(parcels.shape)
where fulladdress = '2126 COUNTRY CLUB BLVD'
***/

--find real multipolys
SELECT objectid, ST_NumGeometries(shape) as num_geom
FROM gcverbase00023.parcels
WHERE ST_NumGeometries(shape) = 1 and st_GeometryType(shape) = 'ST_MultiPolygon';

--create the table to hold the corrected parcels
CREATE TABLE gcverbase00023.parcels_fix
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

ALTER TABLE gcverbase00023.parcels_fix
    OWNER to pgadmin;
    
--insert the modified data into the fix table
insert into gcverbase00023.parcels_fix
(objectid, housenum, predir, streetname, pretype, streettype, sufdir, countyname, fulladdress, 
placename, createddate, editor, gcverbase, prop_id, geo_id, shape)
select objectid, housenum, predir, streetname, pretype, streettype, sufdir, countyname, fulladdress, 
placename, createddate, editor, gcverbase, prop_id, geo_id, (ST_Dump(shape)).geom as geom
from gcverbase00023.parcels
WHERE ST_NumGeometries(shape) = 1 and st_GeometryType(shape) = 'ST_MultiPolygon';
--INSERT 0 861516
--Query returned successfully in 18 secs 805 msec.

--data check
select fulladdress, st_astext(shape) from gcverbase00023.parcels_fix where fulladdress = '2126 COUNTRY CLUB BLVD'
--data corrected

select max(objectid) from gcverbase00023.parcels
--52409689

insert into gcverbase00023.parcels
(objectid, housenum, predir, streetname, pretype, streettype, sufdir, countyname, fulladdress, 
placename, createddate, editor, gcverbase, prop_id, geo_id, shape)
select objectid + 52409689, housenum, predir, streetname, pretype, streettype, sufdir, countyname, fulladdress, 
placename, createddate, editor, gcverbase, prop_id, geo_id, shape
from gcverbase00023.parcels_fix
--INSERT 0 861516
--Query returned successfully in 1 min 6 secs.

--delete the incorrect records
select * from gcverbase00023.parcels
WHERE ST_NumGeometries(shape) = 1 and st_GeometryType(shape) = 'ST_MultiPolygon';
--Successfully run. Total query runtime: 21 secs 284 msec.
--861516 rows affected.
delete from gcverbase00023.parcels
WHERE ST_NumGeometries(shape) = 1 and st_GeometryType(shape) = 'ST_MultiPolygon';
--DELETE 861516
--Query returned successfully in 23 secs 986 msec.

select countyname, count(*) from gcverbase00023.parcels
where st_GeometryType(shape) = 'ST_MultiPolygon'
group by countyname

select count(*) from gcverbase00023.parcels
where st_GeometryType(shape) = 'ST_MultiPolygon'
--14,755

update gcverbase00023.parcels
set ts =
to_tsvector('simple', concat_ws(' ', fulladdress
, coalesce(gcverbase00023.dir_expand(predir), '')
, coalesce(gcverbase00023.dir_expand(sufdir), '')
, coalesce(gcverbase00023.type_expand(streettype), '')
, coalesce(gcverbase00023.expand_premod(split_part(streetname, ' ', 2)), '')))
where ts IS NULL
--UPDATE 890079
--Query returned successfully in 2 min 1 secs.