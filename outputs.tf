output "app_service_url" {
  description = "URL of the created Azure App Service."
  value       = azurerm_app_service.example.default_site_hostname
}