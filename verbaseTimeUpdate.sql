update gcdefault.versionhistory
set createdon = '2024-09-19 12:20:00'
where versionnumber='14' and key = 'base';

--other helpful queries
insert into gcdefault.versionhistory (key, versionnumber, createdon) values ('base', 18, now());
 
grant usage on schema gcverbase00018 to appadmin;
 
grant select on all tables in schema gcverbase00018 to appadmin;
 
update gcdefault.versionhistory
set createdon = now() at time zone 'cst'
where versionnumber='18' and key = 'base';