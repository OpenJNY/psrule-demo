@description('storage account name')
param storage_account_name string = 'st${uniqueString(resourceGroup().name)}'

@description('storage account location')
param location string = 'eastus'

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storage_account_name
  location: location
  kind: 'StorageV2'
  properties: {
    allowBlobPublicAccess: false
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Deny'
    }
  }
  sku: {
    name: 'Premium_LRS'
  }
  tags: {
    env: 'dev'
  }
}

resource blobservice 'Microsoft.Storage/storageAccounts/blobServices@2021-09-01' = {
  parent: storageaccount
  name: 'default'
  properties: {
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      days: 10
      enabled: true
    }
  }
}
