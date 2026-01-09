@description('Nombre de la Azure Container App')
param containerAppName string

@description('Región donde se despliega el recurso')
param location string

@description('Resource ID del Managed Environment (Container Apps Environment)')
param managedEnvironmentId string

@description('Imagen del contenedor (ACR o público)')
param image string

@description('CPU asignado al contenedor')
param cpu float = 0.25

@description('Memoria asignada al contenedor')
param memory string = '0.5Gi'

@description('Número mínimo de réplicas')
param minReplicas int = 0

@description('Número máximo de réplicas')
param maxReplicas int = 5

@description('Tags del recurso')
param tags object

resource containerApp 'Microsoft.App/containerapps@2025-02-02-preview' = {
  name: containerAppName
  location: location
  kind: 'containerapps'
  tags: tags

  properties: {
    managedEnvironmentId: managedEnvironmentId
    workloadProfileName: 'Consumption'

    configuration: {
      activeRevisionsMode: 'Single'

      ingress: {
        external: true
        targetPort: 8092
        traffic: [
          {
            latestRevision: true
            weight: 100
          }
        ]
      }

      registries: [
        {
          server: split(image, '/')[0]
          identity: 'system-environment'
        }
      ]

      maxInactiveRevisions: 100
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

        rules: [
          {
            name: 'cpu-scaler'
            custom: {
              type: 'cpu'
              metadata: {
                type: 'Utilization'
                value: '80'
              }
            }
          }
          {
            name: 'http-scaler'
            http: {
              metadata: {
                concurrentRequests: '100'
