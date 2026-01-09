using '../main.bicep'

param containerAppName = 'ca-integra-usuarios-prd'
param location = 'eastus'

param managedEnvironmentId = '/subscriptions/e0c2c160-cda3-4e60-8bd1-697cb301517f/resourceGroups/rg-integra-prd-services/providers/Microsoft.App/managedEnvironments/cae-tdm-pdn-integra'

param image = 'crintegratdmpdn-abcmeufbfbb8fcer.azurecr.io/integra/integra-usuarios:v1'

param tags = {
  Ambiente: 'Produccion'
  Responsable: 'Arus'
  Servicio: 'Monitoreo'
  Creador: 'Yeison Fernando Montoya Puerta'
}
