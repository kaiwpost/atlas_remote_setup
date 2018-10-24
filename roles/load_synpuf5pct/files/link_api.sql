ALTER SCHEMA synpuf5pct
  OWNER TO ohdsi_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA synpuf5pct TO ohdsi_admin;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA synpuf5pct TO ohdsi_admin;

INSERT INTO webapi.source (source_id, source_name, source_key, source_connection, source_dialect)
VALUES (1, 'SYNPUF 5%', 'synpuf5pct', 'jdbc:postgresql://localhost:5432/ohdsi?user=ohdsi_admin_user&password=admin1', 'postgresql')
ON CONFLICT (source_id) DO UPDATE
SET source_name = EXCLUDED.source_name,
    source_key = EXCLUDED.source_key,
    source_connection = EXCLUDED.source_connection;

INSERT INTO webapi.source_daimon (source_daimon_id, source_id, daimon_type, table_qualifier, priority)
VALUES (1, 1, 0, 'synpuf5pct', 2),
       (2, 1, 1, 'synpuf5pct', 2),
       (3, 1, 2, 'webapi', 2),
       (4, 1, 3, 'webapi', 2)
ON CONFLICT (source_daimon_id) DO UPDATE
  SET source_id = EXCLUDED.source_id,
    daimon_type = EXCLUDED.daimon_type,
    table_qualifier = EXCLUDED.table_qualifier,
    priority = EXCLUDED.priority;
