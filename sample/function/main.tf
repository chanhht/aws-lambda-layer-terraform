resource "time_static" "this" {}

output "current_time" {
  value = time_static.this.rfc3339
}