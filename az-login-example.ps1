$env:ARM_TENANT_ID = "<your-tenant-id>"
$env:ARM_CLIENT_ID = "<your-client-id>"
$env:ARM_CLIENT_SECRET = "<your-client-secret>"
$env:ARM_SUBSCRIPTION_ID = "<your-subscription-id>"

$env:AZURE_SUBSCRIPTION_ID = $env:ARM_SUBSCRIPTION_ID
$env:AZURE_TENANT_ID = $env:ARM_TENANT_ID
$env:AZURE_CLIENT_ID = $env:ARM_CLIENT_ID
$env:AZURE_CLIENT_SECRET = $env:ARM_CLIENT_SECRET

az login --service-principal -u $env:AZURE_CLIENT_ID -p $env:AZURE_CLIENT_SECRET --tenant $env:AZURE_TENANT_ID
az account set --subscription $env:AZURE_SUBSCRIPTION_ID