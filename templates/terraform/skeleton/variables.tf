variable "name" {
  description = "Resource name prefix"
  type        = string
  default     = "${{ values.moduleName }}"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
