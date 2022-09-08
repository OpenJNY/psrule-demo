@description('Location for all resources.')
param location string = resourceGroup().location

var vnetName = 'vnet-test'

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
    ]
  }
  tags: {
    env: 'dev'
  }
}
