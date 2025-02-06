DO $$ 
DECLARE
    month_table RECORD;
    result RECORD;
    query TEXT;
BEGIN
    FOR month_table IN 
        SELECT 'Jul 2023' AS month, 'ticketarea2023.t07_july2023' AS table_name
        UNION ALL
        SELECT 'Aug 2023', 'ticketarea2023.t08_august2023'
        UNION ALL
        SELECT 'Sep 2023', 'ticketarea2023.t09_september2023'
        UNION ALL
        SELECT 'Oct 2023', 'ticketarea2023.t10_october2023'
        UNION ALL
        SELECT 'Nov 2023', 'ticketarea2023.t11_november2023'
        UNION ALL
        SELECT 'Dec 2023', 'ticketarea2023.t12_december2023'
        UNION ALL
        SELECT 'Jan 2024', 'ticketarea2024.t01_january2024'
        UNION ALL
        SELECT 'Feb 2024', 'ticketarea2024.t02_february2024'
        UNION ALL
        SELECT 'Mar 2024', 'ticketarea2024.t03_march2024'
        UNION ALL
        SELECT 'Apr 2024', 'ticketarea2024.t04_april2024'
        UNION ALL
        SELECT 'May 2024', 'ticketarea2024.t05_may2024'
        UNION ALL
        SELECT 'Jun 2024', 'ticketarea2024.t06_june2024'
    LOOP
        query := format('
            SELECT ''%s'' AS month, count(*) AS count
            FROM (SELECT st_union(st_buffer(geom, 45.72)) AS buffered_geom FROM x.table) AS proc
            JOIN %s AS x
            ON st_intersects(x.geom, proc.buffered_geom)
        ', month_table.month, month_table.table_name);

        FOR result IN EXECUTE query LOOP
            RAISE NOTICE 'Month: %, Count: %,', result.month, result.count;
        END LOOP;
    END LOOP;
END $$;
