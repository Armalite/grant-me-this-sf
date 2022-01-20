module "grant-me-this" {
  source = "./sf-db-grants"
  providers = {
    snowflake.ACCOUNTADMIN  = snowflake.ACCOUNTADMIN
    snowflake.SECURITYADMIN = snowflake.SECURITYADMIN
  }

  grants = {
    BEAUTIFUL_DB = { # the database for these grants
      name = "beautiful_db"
      db_privileges = { # the sf db grant privileges
        usage = {
          privilege = "USAGE"                                  # a privilege
          roles     = ["SWEET_SNOWFLAKE_ROLE", "SALTY_SNOWFLAKE_ROLE"] # a list of roles the privilege will be granted to
        }
      }
      schema_privileges = { # the sf schema grant privileges
        usage = {
          privilege = "USAGE"
          roles     = ["SWEET_SNOWFLAKE_ROLE", "SALTY_SNOWFLAKE_ROLE"]
        }
      }
      table_privileges = { # the sf table grant privileges
        select = {
          privilege = "SELECT"
          roles     = ["SWEET_SNOWFLAKE_ROLE", "SALTY_SNOWFLAKE_ROLE"]
        }
        references = {
          privilege = "REFERENCES"
          roles     = ["SWEET_SNOWFLAKE_ROLE", "SALTY_SNOWFLAKE_ROLE"]
        }
      }
      view_privileges = { # the sf view grant privileges
        select = {
          privilege = "SELECT"
          roles     = ["SWEET_SNOWFLAKE_ROLE", "SALTY_SNOWFLAKE_ROLE"]
        }
        references = {
          privilege = "REFERENCES"
          roles     = ["SWEET_SNOWFLAKE_ROLE", "SALTY_SNOWFLAKE_ROLE", "BITTER_SNOWFLAKE_ROLE"]
        }
      }
    }
  }
}
