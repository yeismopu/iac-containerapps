param containerAppName string
param location string
param managedEnvironmentId string
param image string

@minValue(0)
param cpu string

param memory string
param minReplicas int
param maxReplicas int
param tags object = {}

resource containerApp 'Microsoft.Web/containerApps@2023-05-01' = {
  name: containerAppName
  location: location
  tags: tags
  properties: {
    managedEnvironmentId: managedEnvironmentId
    configuration: {
      ingress: {
        external: true
        targetPort: 80
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
