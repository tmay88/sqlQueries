ArcGIS Pro - Use Pairwise Buffer to buffer, dissolve, explode, repair file. 
--63742
Send File to G drive
Load into postgres:
create table gisload.comst_final (gid serial not null, code varchar (10), dccode varchar (10),geom geometry("MULTIPOLYGON", 4326))

--Repair Geometry
UPDATE gisload.comst
SET geom = st_makeValid(geom)
where not st_isValid(geom);
--Query returned successfully in 1 min 16 secs.

--Recheck Geometry
select id, st_isvalidreason(geom) from gisload.comst
where not st_isvalid(geom) order by id;
--Nothing returned. Check

--Subdivide without dissolve
insert into gisload.comst_final(geom)
select st_multi(st_subdivide(geom)) as geom from gisload.comst;
--INSERT 0 281566
--Query returned successfully in 11 min 37 secs.

update gisload.comst_final set code = 'COMST', dccode = 'COMST';
--UPDATE 281566
Query returned successfully in 24 secs 644 msec.

--Recheck Geometry
select gid, st_isvalidreason(geom) from gisload.comst_final
where not st_isvalid(geom) order by st_isvalidreason(geom) desc;

select st_npoints(geom) from gisload.comst_final order by st_npoints(geom) desc;

select * from giseditor_current.servicearea where code = 'COMST'
--Successfully run. Total query runtime: 23 secs 849 msec.
280132 rows affected.

delete from giseditor_current.servicearea where code = 'COMST'
--DELETE 280132
Query returned successfully in 560 msec.

insert into giseditor_current.servicearea (code, geom)
select code, geom from gisload.comst_final
--INSERT 0 281566
Query returned successfully in 1 min 42 secs.
