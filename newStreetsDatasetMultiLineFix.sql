-- Create a temporary table to store the dumped geometries
CREATE TABLE gis_staging.streets_tempgeom AS
SELECT
    id, -- replace with the primary key or unique identifier for your table
    (ST_Dump(geom)).geom AS dumped_geom
FROM
    gis_staging.streets_00026
WHERE
    GeometryType(geom) = 'MULTILINESTRING';
	
-- Change the geometry type to a generic geometry
ALTER TABLE gis_staging.streets_00026
ALTER COLUMN geom TYPE geometry USING geom::geometry;
	
-- Update the geom column in gis_staging.streets_00026 using dumped_geom from gis_staging.streets_tempgeom
UPDATE gis_staging.streets_00026 AS target
SET geom = temp.dumped_geom
FROM gis_staging.streets_tempgeom AS temp
WHERE target.id = temp.id;

