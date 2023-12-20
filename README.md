# Prepare Tablestore PHP CI

The module helps you quickly issue API credentials and create a testing
Tablestore instance that you could use for the integration tests in the
package `tablestore-php`. The user permissions are strictly limited to
the scope of testing the API.

## Example Usage

```terraform
module "tablestore_ci" {
  source = "github.com/dew-serverless/prepare-tablestore-php-ci"

  package_name = "tablestore-php"

  pgp_key = "public.gpg"
}

output "access_key_id" {
  value       = module.tablestore_ci.access_key_id
  description = "The ACS access key ID for the user."
}

output "access_key_secret" {
  value       = module.tablestore_ci.access_key_secret
  description = "The ACS access key secret encrypted by PGP public key for the user."
}

output "tablestore_endpoint" {
  value       = module.tablestore_ci.ots_instance_endpoint
  description = "The Tablestore instance public endpoint."
}

output "tablestore_instance_name" {
  value       = module.tablestore_ci.ots_instance_id
  description = "The Tablestore instance name."
}
```

The ACS access key secret is encrypted by the PGP public key, here's a quick
tip to get the raw secret:

```bash
terraform output -raw access_key_secret | base64 --decode | gpg --decrypt
```


## Argument Reference

The module accepts the following arguments:

| Argument             | Necessity | type        | Description |
| -------------------- | --------- | ----------- | ----------- |
| package_name         | optional  | string      | The package name. Default: `tablestore-php`|
| instance_name        | optional  | string      | The name of the Tablestore testing instance. |
| instance_description | optional  | string      | The description of the Tablestore testing instance. |
| table_names          | optional  | map(string) | A list of tables created in the instance. |
| user_name            | optional  | string      | The name of the RAM user. Default: `ci-{package_name}` |
| user_comments        | optional  | string      | The description of the RAM user. |
| pgp_key              | required  | string      | The path of the PGP public key used to encrypt the ACS access key secret. |
| policy_name          | optional  | string      | The name of the policy which is attached to the user. |

## Attribute Reference

The module outputs the following attributes:

| Attribute                    | Description |
| ---------------------------- | ----------- |
| ots_instance_endpoint        | The Tablestore instance public endpoint. |
| ots_instance_id              | The Tablestore instance name. |
| ots_table_rows               | The table name for testing row operations. |
| ram_user_id                  | The RAM user ID. |
| ram_user_name                | The RAM user name. |
| ram_policy_id                | The ID of the policy attached to the RAM user. |
| ram_policy_type              | The policy type. |
| ram_policy_attachment_count  | The count of the policy attached to the user. |
| ram_policy_default_version   | The default statement version of the policy. |
| ram_policy_version_id        | The default statement version of the policy. |
| access_key_id                | The ACS access key ID for the user. |
| access_key_secret            | The ACS access key secret is encrypted by the PGP public key for the user. |
