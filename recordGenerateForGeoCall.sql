--Generate record in GeoCall for the new base
insert into gcdefault.versionhistory (key, versionnumber, createdon) values ('base', 19, now());
 
grant usage on schema gcverbase00019 to appadmin;
 
grant select on all tables in schema gcverbase00019 to appadmin;
 
update gcdefault.versionhistory
set createdon = now() at time zone 'cst'
where versionnumber='18' and key = 'base';