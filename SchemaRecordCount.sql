SELECT relname AS table_name, reltuples::bigint AS row_count
FROM pg_catalog.pg_class c
JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
WHERE n.nspname = 'oncorfinals' -- Specify the schema name
  AND c.relkind = 'r' -- Only select regular tables
ORDER BY table_name;




