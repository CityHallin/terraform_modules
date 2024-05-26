
#General
variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment type"
  type        = string
  validation {
    condition = contains([
      "dev",
      "prd"
    ], var.environment)
    error_message = "Choose from restricted variable list of Azure environments (example: dev, prd)"
  }
}



