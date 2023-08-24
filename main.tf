provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "terraform"
  location = "France Central"
}

resource "azurerm_app_service_plan" "example" {
  name                = "myAppServicePlan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "Windows"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "example" {
  name                = "myAppService"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  site_config {
    dotnet_framework_version = "v5.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "14"
  }

  connection_string {
    name  = "MyDatabase"
    type  = "SQLServer"
    value = "Server=myserver;Database=mydb;User Id=myuser;Password=mypassword;"
  }

  tags = {
    environment = "production"
  }
}
