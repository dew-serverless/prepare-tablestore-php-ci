run "setup_tests" {
  module {
    source = "./testing/setup"
  }
}

run "create_ram_user" {
  command = plan

  variables {
    package_name = "tablestore-php"
  }

  assert {
    condition     = alicloud_ram_user.this.name == "ci-tablestore-php"
    error_message = "The user name does not match the default user name."
  }

  assert {
    condition     = alicloud_ram_user.this.comments == "User acting in CI for package tablestore-php."
    error_message = "The user comments does not match the default user comments."
  }
}

run "create_ram_user_with_overrides" {
  command = plan

  variables {
    user_name     = "test-user"
    user_comments = "test-comments"
  }

  assert {
    condition     = alicloud_ram_user.this.name == "test-user"
    error_message = "The user name does not match the one in the variables."
  }

  assert {
    condition     = alicloud_ram_user.this.comments == "test-comments"
    error_message = "The user comments does not match the one in the variables."
  }
}

run "create_ram_policy" {
  command = plan

  variables {
    package_name = "tablestore-php"
  }

  assert {
    condition     = alicloud_ram_policy.this.policy_name == "ci-tablestore-php-policy"
    error_message = "The policy name does not match the default policy name."
  }

  assert {
    condition     = alicloud_ram_policy.this.rotate_strategy == "DeleteOldestNonDefaultVersionWhenLimitExceeded"
    error_message = "The policy version should be rotated automatically."
  }
}

run "create_ram_policy_with_overrides" {
  command = plan

  variables {
    policy_name = "test-policy"
  }

  assert {
    condition     = alicloud_ram_policy.this.policy_name == "test-policy"
    error_message = "The policy name does not match the one in the variables."
  }
}
