# --- modules/sf-db-grants/variables.tf ---

variable "grants" {
  type = map( # represents a group of databases
    object({ # represents a database
      name              = string
      db_privileges     = map( # represents a type of grant and a group of privileges under it
        object({ # represents a privilege
            privilege       = string
            roles           = list(string) # represents a list of roles to grant the privilege to
            shares          = optional(list(string))
        })
      )
      schema_privileges = map(
        object({
            privilege       = string
            roles           = list(string)
            shares          = optional(list(string))
            schema_name     = optional(string)
        })
      )
      table_privileges  = map(
        object({
            privilege       = string
            roles           = list(string)
            shares          = optional(list(string))
            schema_name     = optional(string)
            table_name      = optional(string)
        })
      )
      view_privileges   = map(
        object({
            privilege       = string
            roles           = list(string)
            shares          = optional(list(string))
            schema_name     = optional(string)
            view_name       = optional(string)
        })
      )
    })
  )
  description = "A map of databases that contains the database name as well as a list of object privileges to grant to the SA"
  default     = null
}
