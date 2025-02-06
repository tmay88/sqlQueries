--10ft = 3.048
--25ft = 7.62
--50ft = 15.24
--100ft = 30.48
--150ft = 45.72
--200ft = 60.96

create table x. (gid serial not null,geom geometry("MULTIPOLYGON", 4326));

INSERT INTO x.
SELECT row_number() over() as fid, st_union(st_buffer(a.geom::geography, 91.44)::geometry) as geom
FROM x. a

