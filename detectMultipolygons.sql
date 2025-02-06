--Find true/real Multipolygons
select count(*)
from gis_staging.parcels_00024_redo
where st_NumGeometries(geom) > 1;

--Detect single feature polygons that are categorized as st_multipolygon
SELECT count(*)
FROM gis_staging.parcels_00024_redo
WHERE ST_NumGeometries(geom) = 1 and st_GeometryType(geom) = 'ST_MultiPolygon';