WITH proc_table AS (
    SELECT
        st_union(st_buffer(geom, 45.72)) AS buffered_geom
    FROM x.table --insert table name here; must be in EPSG 3857
)

SELECT 'Aug 2023' AS month, count(*) AS count
FROM proc_table proc
JOIN ticketarea2023.t08_august2023 AS x23 
ON st_intersects(x23.geom, proc.buffered_geom)

UNION ALL

SELECT 'Sep 2023' AS month, count(*) AS count
FROM proc_table proc
JOIN ticketarea2023.t09_september2023 AS x23 
ON st_intersects(x23.geom, proc.buffered_geom)

UNION ALL

SELECT 'Oct 2023' AS month, count(*) AS count
FROM proc_table proc
JOIN ticketarea2023.t10_october2023 AS x23 
ON st_intersects(x23.geom, proc.buffered_geom)

UNION ALL

SELECT 'Nov 2023' AS month, count(*) AS count
FROM proc_table proc
JOIN ticketarea2023.t11_november2023 AS x23 
ON st_intersects(x23.geom, proc.buffered_geom)

UNION ALL

SELECT 'Dec 2023' AS month, count(*) AS count
FROM proc_table proc
JOIN ticketarea2023.t12_december2023 AS x23 
ON st_intersects(x23.geom, proc.buffered_geom)

UNION ALL

SELECT 'Jan 2024' AS month, count(*) AS count
FROM proc_table proc
JOIN ticketarea2024.t01_january2024 AS x24
ON st_intersects(x24.geom, proc.buffered_geom)

UNION ALL

SELECT 'Feb 2024' AS month, count(*) AS count
FROM proc_table proc
JOIN ticketarea2024.t02_february2024 AS x24
ON st_intersects(x24.geom, proc.buffered_geom)

UNION ALL

SELECT 'Mar 2024' AS month, count(*) AS count
FROM proc_table proc
JOIN ticketarea2024.t03_march2024 AS x24
ON st_intersects(x24.geom, proc.buffered_geom)

UNION ALL

SELECT 'Apr 2024' AS month, count(*) AS count
FROM proc_table proc
JOIN ticketarea2024.t04_april2024 AS x24
ON st_intersects(x24.geom, proc.buffered_geom)

UNION ALL

SELECT 'May 2024' AS month, count(*) AS count
FROM proc_table proc
JOIN ticketarea2024.t05_may2024 AS x24 
ON st_intersects(x24.geom, proc.buffered_geom)

UNION ALL

SELECT 'June 2024' AS month, count(*) AS count
FROM proc_table proc
JOIN ticketarea2024.t06_june2024 AS x24 
ON st_intersects(x24.geom, proc.buffered_geom)

UNION ALL

SELECT 'July 2024' AS month, count(*) AS count
FROM proc_table proc
JOIN ticketarea2024.t07_july2024 AS x24 
ON st_intersects(x24.geom, proc.buffered_geom)