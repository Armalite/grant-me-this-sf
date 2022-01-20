# --- modules/sf-db-grants/providers.tf ---
terraform {
  required_providers {
    snowflake = {
      source                = "chanzuckerberg/snowflake"
      configuration_aliases = [snowflake.ACCOUNTADMIN, snowflake.SECURITYADMIN]
    }
    aws = {}
  }
}
