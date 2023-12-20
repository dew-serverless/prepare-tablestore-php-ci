run "pgp_key_file_existence" {
  command = plan

  variables {
    pgp_key = "./not-exists.gpg"
  }

  expect_failures = [
    var.pgp_key
  ]
}
