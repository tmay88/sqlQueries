create table x. (
       gid serial not null,
       code varchar (10),
       geom geometry("MULTIPOLYGON", 4326)
       );

insert into x.(geom) select st_multi(st_subdivide((st_dump(st_union(geom))).geom)) as geom from x.;

update x. set code = '*';
alter table x. drop column gid;

select st_npoints(geom) from x.
order by st_npoints(geom) desc

select * from x.
