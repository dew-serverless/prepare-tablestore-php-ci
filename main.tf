# ============================================================================
# Supports
# ============================================================================

data "local_file" "pgp_key" {
  filename = var.pgp_key
}

resource "random_string" "instance_name" {
  length  = 16
  special = false
}

# ============================================================================
# Tablestore Resources
# ============================================================================

resource "alicloud_ots_instance" "this" {
  name        = var.instance_name != null ? var.instance_name : random_string.instance_name.id
  description = var.instance_description != null ? var.instance_description : "Testing instance for package ${var.package_name}."
  tags        = var.tags
}

resource "alicloud_ots_table" "rows" {
  instance_name = alicloud_ots_instance.this.id
  table_name    = var.table_names.rows
  time_to_live  = 60 * 60 * 24 * 3 // 3 days
  max_version   = 2

  primary_key {
    name = "key"
    type = "String"
  }
}

# ============================================================================
# RAM Resources
# ============================================================================

resource "alicloud_ram_user" "this" {
  name     = var.user_name != null ? var.user_name : "ci-${var.package_name}"
  comments = var.user_comments != null ? var.user_comments : "User acting in CI for package ${var.package_name}."
}

resource "alicloud_ram_access_key" "this" {
  user_name = alicloud_ram_user.this.name
  pgp_key   = data.local_file.pgp_key.content_base64
}

resource "alicloud_ram_policy" "this" {
  policy_name     = var.policy_name != null ? var.policy_name : "${alicloud_ram_user.this.name}-policy"
  policy_document = <<EOF
  {
    "Version": "1",
    "Statement": [
      {
        "Action": "ots:*",
        "Resource": [
          "acs:ots:${var.region}:*:instance/test*",
          "acs:ots:${var.region}:*:instance/${alicloud_ots_instance.this.id}",
          "acs:ots:${var.region}:*:instance/${alicloud_ots_instance.this.id}/table*"
        ],
        "Effect": "Allow"
      },
      {
        "Action": "ots:ListInstance",
        "Resource": [
          "acs:ots:${var.region}:*:instance/*"
        ],
        "Effect": "Allow"
      }
    ]
  }
  EOF

  rotate_strategy = "DeleteOldestNonDefaultVersionWhenLimitExceeded"
}

resource "alicloud_ram_user_policy_attachment" "this" {
  policy_name = alicloud_ram_policy.this.id
  policy_type = alicloud_ram_policy.this.type
  user_name   = alicloud_ram_user.this.name
}
