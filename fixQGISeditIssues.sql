/*This will assign brand new objectid values in case there are duplicates in the data*/
WITH numbered_rows AS (
    SELECT ctid, ROW_NUMBER() OVER (ORDER BY objectid) AS new_objectid
    FROM gis_staging.parcels_00019
)
UPDATE gis_staging.parcels_00019
SET objectid = numbered_rows.new_objectid
FROM numbered_rows
WHERE gis_staging.parcels_00019.ctid = numbered_rows.ctid;

/*This will grant a primary key to objectid 
that should allow edits to be made in QGIS as the pgadmin user*/
ALTER TABLE gis_staging.parcels_00019 ADD PRIMARY KEY (objectid);