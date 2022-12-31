# Generate random string to be used as suffix in bastion host name
resource "random_string" "rs_name" {
  length  = 5
  upper   = false
  special = false
}
