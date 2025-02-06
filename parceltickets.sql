SELECT * FROM gcverbase00014.parcels WHERE *column* IN (NULL);

SELECT * FROM gcverbase00014.parcels
WHERE ST_touches(shape,(SELECT shape FROM gcverbase00014.parcels WHERE objectid = '5303672'))

update gis_staging.parcels
set housenum = '307',
predir = NULL,
streetname = 'NARCISSUS',
pretype = NULL,
streettype = 'ST',
sufdir = NULL,
fulladdress = '307 NARCISSUS ST',
createddate = '2023-03-28',
editor = 'TM',
ts =
to_tsvector('simple', concat_ws(' ', fulladdress
, coalesce(gis_staging.dir_expand(predir), '')
, coalesce(gis_staging.dir_expand(sufdir), '')
, coalesce(gis_staging.type_expand(streettype), '')
, coalesce(gis_staging.expand_premod(split_part(streetname, ' ', 2)), '')))
where objectid = '2790916';
-----------------------------------------------------------------

shape = st_geomfromtext('MULTIPOLYGON(((-95.519791103307 31.3525091991937,-95.5206794823258 31.353090450426,
-95.5214684286224 31.3536063012402,-95.5221732782353 31.3540674496114,-95.5236462413151 31.3550308214142,-95.5241865042967 31.3550141402832,-95.5241900364723 31.3553042342786,-95.524191596846 31.355432309912,-95.5242000194501 31.3558536282352,
-95.5242248857155 31.3569469025101,-95.5238427684448 31.3567087032959,-95.5237056603796 31.356609330132,-95.5235733232669 31.3565053027898,
-95.5234459709057 31.356396790786,-95.5233238090102 31.3562839697744,-95.5232944008627 31.3562551001788,-95.5225705518815 31.3555451388496,-95.5201411579086 31.3530114164935,-95.5199054615376 31.352797511172,
-95.519791103307 31.3525091991937)))', 4326)

-----------------------------------------------------------------
SELECT p.objectid, p.fulladdress, p.shape
FROM gcverbase00018.parcels AS p, gcverbase00018.parcels AS ref_poly
WHERE p.placename = 'HOUSTON'
AND ref_poly.objectid = '8868599'
AND ST_DWithin(p.shape::geography, ref_poly.shape::geography, 10)
LIMIT 10;

SELECT target_parcel.objectid, target_parcel.fulladdress, target_parcel.shape
FROM gcverbase00021.parcels AS target_parcel, gcverbase00021.parcels AS ref_parcel
WHERE ref_parcel.objectid = '5464231'
AND ST_DWithin(ST_CollectionExtract(ref_parcel.shape::geometry, 3)::geography, 
               ST_CollectionExtract(target_parcel.shape::geometry, 3)::geography, 10);

