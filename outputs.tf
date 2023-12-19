output "ots_instance_id" {
  value = alicloud_ots_instance.this.id
}

output "ots_table_rows" {
  value = alicloud_ots_table.rows.id
}

output "ram_user_id" {
  value = alicloud_ram_user.this.id
}

output "ram_user_name" {
  value = alicloud_ram_user.this.name
}

output "ram_policy_id" {
  value = alicloud_ram_policy.this.id
}

output "ram_policy_type" {
  value = alicloud_ram_policy.this.type
}

output "ram_policy_attachment_count" {
  value = alicloud_ram_policy.this.attachment_count
}

output "ram_policy_default_version" {
  value = alicloud_ram_policy.this.default_version
}

output "ram_policy_version_id" {
  value = alicloud_ram_policy.this.version_id
}

output "access_key_id" {
  value = alicloud_ram_access_key.this.id
}

output "access_key_secret" {
  value = alicloud_ram_access_key.this.encrypted_secret
}
