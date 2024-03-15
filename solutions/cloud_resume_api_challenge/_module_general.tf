#Prep ZIP file function Deployment
data "archive_file" "compress_function_files" {
  type        = "zip"
  source_dir  = "../function"
  output_path = "../files/function.zip"
}

#Get Azure tenant and environment info
data "azurerm_client_config" "current" {}