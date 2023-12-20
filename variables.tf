variable "tags" {
  type        = map(string)
  description = "The default tags attached to every resources."
  default = {
    "Terraform" = "true"
  }
}

variable "package_name" {
  type        = string
  description = "The package name."
  default     = "tablestore-php"
}

variable "instance_name" {
  type        = string
  description = "The name of the Tablestore testing instance."
  nullable    = true
  default     = null
}

variable "instance_description" {
  type        = string
  description = "The description of the Tablestore testing instance."
  nullable    = true
  default     = null
}

variable "table_names" {
  type        = map(string)
  description = "A list of tables created in the instance."
  default = {
    "rows" = "rows"
  }
}

variable "user_name" {
  type        = string
  description = "The name of the RAM user."
  nullable    = true
  default     = null
}

variable "user_comments" {
  type        = string
  description = "The description of the RAM user."
  nullable    = true
  default     = null
}

variable "pgp_key" {
  type        = string
  description = "The path of PGP public key used to encrypt the ACS access key secret."

  validation {
    condition     = fileexists(var.pgp_key)
    error_message = "The PGP key does not exists."
  }
}

variable "policy_name" {
  type        = string
  description = "The name of the policy attached to the user."
  nullable    = true
  default     = null
}
