
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

variable "region" {
  description = "Azure region"
  type        = string
  validation {
    condition = contains([
      "northcentralus",
      "westcentralus",
      "westus",
      "northeurope"
    ], var.region)
    error_message = "Choose from restricted variable list of Azure regions (variables.tf)"
  }
}

#NSG
variable "remote_ip_address" {
  description = "Used by NSG to allow an IP address through for RDP ability to VM"
  type        = string
}

