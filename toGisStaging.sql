select * from gis_staging.parcels_00024 where countyname in ('HARRIS')
--1435251 rows affected.

select * from gis_staging.parcels where countyname in ('HARRIS')
--1378778 rows affected.

select * from gcverbase00023.parcels where countyname in ('HARRIS');
--1378778 rows affected.

update gis_staging.parcels_00024
set gcverbase = '00024'
where countyname in ('HARRIS');
--UPDATE 1435251, Query returned successfully in 11 secs 371 msec.

select countyname, gcverbase, count(gcverbase) from gis_staging.parcels
where countyname in ('HARRIS')
group by countyname, gcverbase;
---"HARRIS"	"00008"	754172
---"HARRIS"	"00014"	624606

delete from gis_staging.parcels
where countyname in ('HARRIS');
---DELETE 1378778; Query returned successfully in 1 secs 44 msec.

select max(objectid) from gis_staging.parcels
---52448654

insert into gis_staging.parcels
(objectid, housenum, predir, streetname, pretype, streettype, sufdir, countyname, fulladdress, 
placename, createddate, editor, gcverbase, prop_id, geo_id, shape)
select objectid + 52448654, housenum, predir, streetname, pretype, streettype, sufdir, countyname, fulladdress, 
placename, '2024-09-12 00:00:000', editor, gcverbase, prop_id, geo_id, shape
from gis_staging.parcels_00024
where countyname in ('HARRIS');
---INSERT 0 1435251; Query returned successfully in 5 min 32 secs.

select countyname, gcverbase, count(gcverbase) from gis_staging.parcels
where countyname in ('HARRIS')
group by countyname, gcverbase;
---"HARRIS"	"00024"	1435251

update gis_staging.parcels
set ts =
to_tsvector('simple', concat_ws(' ', fulladdress
, coalesce(gis_staging.dir_expand(predir), '')
, coalesce(gis_staging.dir_expand(sufdir), '')
, coalesce(gis_staging.type_expand(streettype), '')
, coalesce(gis_staging.expand_premod(split_part(streetname, ' ', 2)), '')))
where countyname in ('HARRIS');
---UPDATE 1435251; Query returned successfully in 3 min 31 secs.