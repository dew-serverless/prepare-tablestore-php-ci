terraform {
  required_providers {
    random = {
      source  = "hashicorp/random",
      version = "~> 3.6"
    }
  }
}

resource "random_string" "prefix" {
  length  = 4
  special = false
  upper   = false
}

output "prefix" {
  value = random_string.prefix.id
}
