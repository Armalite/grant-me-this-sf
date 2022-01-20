# --- modules/sf-db-grants/main.tf ---

// Apply all the db, schema, table and view privileges on each database specified, for the role
resource "snowflake_database_grant" "privileges" {
  provider = snowflake.SECURITYADMIN

  for_each = local.db_privilege_map
  database_name = each.value.database
  privilege     = each.value.privilege
  roles         = each.value.roles
}

resource "snowflake_schema_grant" "privileges" {
  provider = snowflake.SECURITYADMIN

  for_each = local.schema_privilege_map
  database_name = each.value.database
  privilege     = each.value.privilege
  on_future     = true
  roles         = each.value.roles
}

resource "snowflake_table_grant" "privileges" {
  provider = snowflake.SECURITYADMIN

  for_each = local.table_privilege_map
  database_name = each.value.database
  privilege     = each.value.privilege
  on_future     = true
  roles         = each.value.roles
}

resource "snowflake_view_grant" "privileges" {
  provider = snowflake.SECURITYADMIN

  for_each = local.view_privilege_map
  database_name = each.value.database
  privilege     = each.value.privilege
  on_future     = true
  roles         = each.value.roles
}
