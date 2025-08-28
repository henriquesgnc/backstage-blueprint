{% if values.provider == 'aws' %}
resource "aws_s3_bucket" "this" {
  bucket = "${var.name}-${var.environment}"
  tags   = var.tags
}
{% elif values.provider == 'gcp' %}
resource "google_storage_bucket" "this" {
  name     = "${var.name}-${var.environment}"
  location = "US"
  labels   = var.tags
}
{% elif values.provider == 'azure' %}
resource "azurerm_resource_group" "this" {
  name     = "${var.name}-${var.environment}"
  location = "eastus"
  tags     = var.tags
}
{% endif %}
