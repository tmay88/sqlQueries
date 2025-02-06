UPDATE sde.parcels
SET placename = 'RURAL'
WHERE countyname = 'EL PASO' AND placename = 'CANUTILLO'
AND NOT ST_intersects(shape, (select shape from sde.places where countyname = 'EL PASO' AND
							  placename = 'CANUTILLO'));

SELECT placename, count(placename) FROM sde.parcels WHERE countyname = 'EL PASO'
GROUP BY placename
ORDER BY placename


SELECT placename, shape FROM sde.parcels
WHERE st_intersects(shape, (select shape from sde.places where countyname = 'EL PASO'
							  AND placename = 'HOMESTEAD MEADOWS SOUTH'));
							  



	(SELECT * FROM sde.parcels
	WHERE st_intersects(shape, (select shape from sde.places where countyname = 'EL PASO'
							  AND placename = 'CANUTILLO')))
	EXCEPT
	SELECT * FROM gcverbase00013.parcels
	WHERE st_intersects(shape, (select shape from sde.places where countyname = 'EL PASO'
							  AND placename = 'CANUTILLO'))
UNION ALL
	(SELECT * FROM gcverbase00013.parcels
	WHERE st_intersects(shape, (select shape from sde.places where countyname = 'EL PASO'
							  AND placename = 'CANUTILLO')))
	EXCEPT
	SELECT * FROM gsde.parcels
	WHERE st_intersects(shape, (select shape from sde.places where countyname = 'EL PASO'
							  AND placename = 'CANUTILLO'))								