# SF DB Grants Module
Maybe there's a better way to handle Snowflake grants. Maybe there's a worse way. Maybe we just like to be different.

## Why
The sf-db-grants module just allows another way to specify grants at the database level by being able to group all privileges and coresponding roles to grant these privileges to, under one module call. If you want your beautiful_database grants specified in one readable place, simply call the sf-db-grants module for that database and specify all required grant types and privileges, and roles to assign privileges to inside the hierarchical map format.

```hcl
module "grants_for_my_beautiful_database" {
  source = "./sf-db-grants"
  providers = {
    snowflake.ACCOUNTADMIN  = snowflake.ACCOUNTADMIN
    snowflake.SECURITYADMIN = snowflake.SECURITYADMIN
  }

  grants = {
    BEAUTIFUL_DB = { # the database for these grants
      name = "beautiful_db"
      db_privileges = { # a map of all the db grant privileges
        usage = { # a privilege (can create more of child maps under this layer for more privilegers, see examples below)
          privilege = "USAGE" 
          roles     = ["SWEET_SNOWFLAKE_ROLE", "SALTY_SNOWFLAKE_ROLE"] # a list of roles the privilege will be granted to
        }
      }
      schema_privileges = { # a map of all the schema grant privileges # a list of roles the privilege will be granted to
        usage = { # a privilege
          privilege = "USAGE" 
          roles     = ["SWEET_SNOWFLAKE_ROLE", "SALTY_SNOWFLAKE_ROLE"] # a list of roles the privilege will be granted to
        }
      }
      table_privileges = { # a map of all the table grant privileges
        select = { # a privilege
          privilege = "SELECT" 
          roles     = ["SWEET_SNOWFLAKE_ROLE", "SALTY_SNOWFLAKE_ROLE"] # a list of roles the privilege will be granted to
        }
        references = { # a privilege
          privilege = "REFERENCES" 
          roles     = ["SWEET_SNOWFLAKE_ROLE", "SALTY_SNOWFLAKE_ROLE"] # a list of roles the privilege will be granted to
        }
      }
      view_privileges = { # a map of all the view grant privileges
        select = { # a privilege
          privilege = "SELECT" 
          roles     = ["SWEET_SNOWFLAKE_ROLE", "SALTY_SNOWFLAKE_ROLE"] # a list of roles the privilege will be granted to
        }
        references = { # a privilege
          privilege = "REFERENCES" 
          roles     = ["SWEET_SNOWFLAKE_ROLE", "SALTY_SNOWFLAKE_ROLE", "BITTER_SNOWFLAKE_ROLE"] # a list of roles the privilege will be granted to
        }
      }
    }
  }
}
```
