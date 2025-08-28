terraform {
  required_version = ">= 1.5.0"
  required_providers {
{% if values.provider == 'aws' %}
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
{% elif values.provider == 'gcp' %}
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
{% elif values.provider == 'azure' %}
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0"
    }
{% endif %}
  }
{% if values.backend == 's3' %}
  backend "s3" {
    bucket  = "SET_BACKEND_BUCKET"
    key     = "terraform-${{ values.moduleName }}/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
{% elif values.backend == 'gcs' %}
  backend "gcs" {
    bucket = "SET_BACKEND_BUCKET"
    prefix = "terraform-${{ values.moduleName }}"
  }
{% elif values.backend == 'azurerm' %}
  backend "azurerm" {
    resource_group_name  = "SET_RESOURCE_GROUP"
    storage_account_name = "SET_STORAGE_ACCOUNT"
    container_name       = "tfstate"
    key                  = "terraform-${{ values.moduleName }}.tfstate"
  }
{% endif %}
}
