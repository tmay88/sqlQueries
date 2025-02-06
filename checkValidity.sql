--GEOS errors report
select st_isvalidreason(geom) from x.
where not st_isvalid(geom);

--Correct GEOS errors
update x.
set geom = st_makevalid(geom)
where not st_isvalid(geom);

--Transforms collections into Multi-polygons
update x.
set geom = st_multi(st_collectionextract(st_makevalid(geom),3))
where st_geometrytype(geom) = 'ST_GeometryCollection';

--deletes NULL geometries
delete from x.
where geom IS NULL;

--remove duplicate nodes
update x.
set geom = st_multi(st_simplify(geom, 0));

--last resort: null buffer creation
update x.
set geom = st_multi(st_buffer(geom, 0))
where not st_isvalid(geom);

