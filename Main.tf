provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "ankushrg"
  location = "East US"
}

resource "azurerm_sql_server" "sqlserver" {
  name                         = "mysqlserver5591"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  administrator_login          = "adminuser"
  administrator_login_password = "P@ssw0rd123!"
}

resource "azurerm_sql_database" "sqldb" {
  name                = "mysqldb5591"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  server_name         = azurerm_sql_server.sqlserver.name
  edition             = "Basic"
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  requested_service_objective_name = "S0"
}

terraform {
  backend "azurerm" {
    resource_group_name  = "Storagerg"
    storage_account_name = "storageaccount5591"
    container_name       = "tfstate"
    key                  = "sqldb.terraform.tfstate"
    access_key = "9DcT8nW/iKr0v2t8bfFIfM24sfJRGva1oD4macMbw6UkSwUXYHJr0ErQzgv15oErzQebT6lpi4zl+ASt2Lfeeg=="
  }
}
