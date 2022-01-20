# --- modules/sf-db-grants/main.tf ---

locals {

  # temp pseudo
  # for each database
  #   for each type of grant
  #     for each type of privilege
  #       Grant this privilege to a list of roles
  # DB -> Grant Type -> Privilege -> [Roles] to grant it to
  # EIS_LAB   ->  Schema Grant  ->  USAGE    ->  [Role1, Role2]
  #                             ->  MONITOR  ->  [Role1]
  #           ->  Table grant   ->  SELECT   ->  [Role1, Role2, Role3]
  #                             ->  DELETE   ->  [Role1]

  // Turn the nested sets of db, schema, table and view privleges into flattened lists
  db_privilege_list = flatten([
    for database in tomap(var.grants): [
      for db_privilege in tomap(database.db_privileges): {
        database = "${database.name}"
        privilege = "${db_privilege.privilege}"
        roles = db_privilege.roles
      }
    ]
  ])
  schema_privilege_list = flatten([
    for database in tomap(var.grants): [
      for schema_privilege in tomap(database.schema_privileges): {
        database = "${database.name}"
        privilege = "${schema_privilege.privilege}"
        roles = schema_privilege.roles
      }
    ]
  ])
  table_privilege_list = flatten([
    for database in tomap(var.grants): [
      for table_privilege in tomap(database.table_privileges): {
        database = "${database.name}"
        privilege = "${table_privilege.privilege}"
        roles = table_privilege.roles
      }
    ]
  ])
  view_privilege_list = flatten([
    for database in tomap(var.grants): [
      for view_privilege in tomap(database.view_privileges): {
        database = "${database.name}"
        privilege = "${view_privilege.privilege}"
        roles = view_privilege.roles
      }
    ]
  ])

  // Convert the privilege lists into maps, so that they can be used in for_each
  db_privilege_map = {
    for db_privilege in local.db_privilege_list : "${db_privilege.database}_${db_privilege.privilege}_db_privilege" => db_privilege
  }
  schema_privilege_map = {
    for schema_privilege in local.schema_privilege_list : "${schema_privilege.database}_${schema_privilege.privilege}_schema_privilege" => schema_privilege
  }
  table_privilege_map = {
    for table_privilege in local.table_privilege_list : "${table_privilege.database}_${table_privilege.privilege}_table_privilege" => table_privilege
  }
  view_privilege_map = {
    for view_privilege in local.view_privilege_list : "${view_privilege.database}_${view_privilege.privilege}_view_privilege" => view_privilege
  }

}

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
