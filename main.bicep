param containerAppName string
param location string = resourceGroup().location
param managedEnvironmentId string
param image string

@minValue(1)
param minReplicas int = 0

@minValue(1)
param maxReplicas int = 5

param cpu string = '0.25'
param memory string = '0.5Gi'

param tags object = {}

resource containerApp 'Microsoft.App/containerApps@2023-05-01' = {
  name: containerAppName
  location: location
  tags: tags
  properties: {
    managedEnvironmentId: managedEnvironmentId
    configuration: {
      activeRevisionsMode: 'Single'
      ingress: {
        external: true
        targetPort: 8092
        transport: 'Auto'
      }
    }
    template: {
      containers: [
        {
          name: containerAppName
          image: image
          resources: {
            cpu: cpu
            memory: memory
          }
        }
      ]
      scale: {
        minReplicas: minReplicas
        maxReplicas: maxReplicas
      }
    }
  }
}
