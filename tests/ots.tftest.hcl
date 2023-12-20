run "setup_tests" {
  module {
    source = "./testing/setup"
  }
}

run "create_ots_instance" {
  command = plan

  variables {
    package_name = "${run.setup_tests.prefix}package"
  }

  assert {
    condition     = alicloud_ots_instance.this.description == "Testing instance for package ${var.package_name}."
    error_message = "The instance description does not match the default instance description."
  }
}

run "create_ots_instance_with_overrides" {
  command = plan

  variables {
    instance_name        = "testinstance"
    instance_description = "test-description"
  }

  assert {
    condition     = alicloud_ots_instance.this.name == "testinstance"
    error_message = "The instance name does not match the one in variables."
  }

  assert {
    condition     = alicloud_ots_instance.this.description == "test-description"
    error_message = "The instance description does not match the one in variables."
  }
}

run "create_rows_table" {
  command = plan

  assert {
    condition     = alicloud_ots_table.rows.table_name == "rows"
    error_message = "The table should be named [rows] by default."
  }

  assert {
    condition     = alicloud_ots_table.rows.time_to_live == 60 * 60 * 24 * 3
    error_message = "The data was supposed to be self-destructing in 3 days."
  }

  assert {
    condition     = alicloud_ots_table.rows.max_version > 1
    error_message = "The max version should be greater than 1 to test multiple data version retrieval."
  }
}

run "create_rows_table_with_overrides" {
  command = plan

  variables {
    table_names = {
      rows = "myrows"
    }
  }

  assert {
    condition     = alicloud_ots_table.rows.table_name == "myrows"
    error_message = "The table name does not match the one in variables."
  }
}
