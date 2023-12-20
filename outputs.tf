output "ots_instance_id" {
  value       = alicloud_ots_instance.this.id
  description = "The Tablestore instance name."
}

output "ots_table_rows" {
  value       = alicloud_ots_table.rows.id
  description = "The table name for testing row operations."
}

output "ram_user_id" {
  value       = alicloud_ram_user.this.id
  description = "The RAM user ID."
}

output "ram_user_name" {
  value       = alicloud_ram_user.this.name
  description = "The RAM user name."
}

output "ram_policy_id" {
  value       = alicloud_ram_policy.this.id
  description = "The policy ID attached to the RAM user."
}

output "ram_policy_type" {
  value       = alicloud_ram_policy.this.type
  description = "The policy type."
}

output "ram_policy_attachment_count" {
  value       = alicloud_ram_policy.this.attachment_count
  description = "The count of the policy attached to the user."
}

output "ram_policy_default_version" {
  value       = alicloud_ram_policy.this.default_version
  description = "The default statement version of the policy."
}

output "ram_policy_version_id" {
  value       = alicloud_ram_policy.this.version_id
  description = "The default statement version of the policy."
}

output "access_key_id" {
  value       = alicloud_ram_access_key.this.id
  description = "The ACS access key ID for the user."
}

output "access_key_secret" {
  value       = alicloud_ram_access_key.this.encrypted_secret
  description = "The ACS access key secret encrypted by PGP public key for the user."
}
