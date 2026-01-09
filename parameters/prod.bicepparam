using '../main.bicep'

param containerAppName = 'app-integra-prod'
param location = 'eastus'
param managedEnvironmentId = '/subscriptions/XXXX/resourceGroups/rg-integra-prd-services/providers/Microsoft.Web/managedEnvironments/cae-integra-prod'
param image = 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
param cpu = '0.5'
param memory = '1Gi'
param minReplicas = 1
param maxReplicas = 3

param tags = {
  environment: 'prod'
  owner: 'infra'
}
