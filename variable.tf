variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
  default = "Demo-RG"
}

variable "location" {
  type        = string
  description = "RG location in Azure"
  default = "eastus"
}

variable "keyvault_name" {
  type        = string
  description = "Key Vault name in Azure"
   default = "az31key21"
}

variable "secret_name" {
  type        = string
  description = "Key Vault Secret name in Azure"
}

variable "secret_value" {
  type        = string
  description = "Key Vault Secret value in Azure"
   sensitive   = true
}