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

#Virtual Machine
variable "vm_size" {
  description = "VM size SKU"
  type        = string
}

variable "vm_image_publisher" {
  description = "Image Publisher"
  type        = string
}

variable "vm_image_offer" {
  description = "Image Offer"
  type        = string
}

variable "vm_image_sku" {
  description = "Image Sku"
  type        = string
  validation {
    condition = contains([
      "2022-datacenter-azure-edition",
      "2019-Datacenter"
    ], var.vm_image_sku)
    error_message = "Not using a valid image for var.vm_image_sku."
  }
}

variable "vm_image_version" {
  description = "Image version"
  type        = string
}

variable "vm_username" {
  description = "Windows VM username"
  type        = string
  sensitive   = true
}

variable "vm_password" {
  description = "Windows VM password"
  type        = string
  sensitive   = true
}

#VM Tags
variable "vm_startup_automation" {
  description = "VM enabled for Automation Account Runbooks to auto-start"
  type        = string
}

variable "vm_stop_automation" {
  description = "VM enabled for Automation Account Runbooks to auto-stop"
  type        = string
}

variable "vm_restart_automation" {
  description = "VM enabled for Automation Account Runbooks to auto-restart"
  type        = string
}

#NSG
variable "remote_ip_address" {
  description = "Used by NSG to allow an IP address through for RDP ability to VM"
  type        = string
}

variable "runner_ip_address" {
  description = "GitHub Runner IP address to allow through NSG"
  type        = string
  default     = ""
}

#DNS
variable "dns_namespace" {
  description = "Namesapce of the DNS zone that will be used (i.e. example.com)"
  type        = string
}

#Virtual Network
variable "vnet_address_range" {
  description = "VNET address range"
  type        = list(any)
}

variable "snet_address_range" {
  description = "Subnet address range"
  type        = list(any)
}