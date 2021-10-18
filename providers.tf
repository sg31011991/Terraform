provider "azurerm" {
version = "~>2.77.0"
  features {}
}
######################   Hub/Network Subscripction Details  ########################
provider "azurerm" {
  features {}
  tenant_id       = "2820a647-5c83-4072-bede-49db397d0b02"
    subscription_id = "091ff267-8f48-43d4-b2dd-068a2abab814"
    client_id       = "69e84fac-6d0c-4436-b87b-ec4f18a38433"
    client_secret   = "QLo5UqZiG2bLayPUw-TKgQDg4Zfu6ZsA7d" 
  alias = "spoke2"
}
##########################  Prod Subscription/Spoke1   ###############
provider "azurerm" {
  features {}
  tenant_id       = "2820a647-5c83-4072-bede-49db397d0b02"
    subscription_id = "0eb65fc2-7cec-4e86-9d4b-fee47aebe0bb"
    client_id       = "69e84fac-6d0c-4436-b87b-ec4f18a38433"
    client_secret   = "QLo5UqZiG2bLayPUw-TKgQDg4Zfu6ZsA7d" 
  alias = "spoke1"
}

###################   Non Prod /  Spoke2 ###########################################

provider "azurerm" {
  features {}
  tenant_id       = "2820a647-5c83-4072-bede-49db397d0b02"
    subscription_id = "0eb65fc2-7cec-4e86-9d4b-fee47aebe0bb"
    client_id       = "69e84fac-6d0c-4436-b87b-ec4f18a38433"
    client_secret   = "QLo5UqZiG2bLayPUw-TKgQDg4Zfu6ZsA7d" 
  alias = "hub"
}