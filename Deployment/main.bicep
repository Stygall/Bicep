
//!when using the following extension for Visual Studio Code the comments are more readable; aaron-bond.better-comments


//* this parameter defines the scope of the file. 
//* in this case that scope is "resource group" this is because infield supplies the subscriptions and resource groups in which workloads are deployed. 
//* this means that this file will be scoped on an existing resource group.
targetScope = 'subscription'


//* enviroment params //
@description('this parameter is bound to a certain set of allowed values and describes whether or not a resource will be redeployed')
@allowed([
  'new'
  'existing'
])
param newOrExisting string

@description('''this parameter is bound to a certain set of allowed values and describes in which azure region the resources will be deployed.
this is limited to two regions as to comply with the GDPR law''')
@allowed([
  'westeurope'
  'northeurope'
])
param parLocation string

@description('''this parameter is bound to a certain set of allowed values and describes in which step of the otap scale the deployment exists, 
where testing is the enviroment where bicep changes can be tested''')
@allowed([
  'development'
  'acceptation'
  'preproduction'
  'production'
  'testing'
])
param parEnv string

@description('''this parameter describes the name of the workload that will be deployed within this infrastructure. 
this variable will be used to build the resource names. therefore it cannot be longer than 35 characters, 
otherwise the container registry cannot be given a name due to Azure restrictions''')
@maxLength(10)
param workload string

@description('this parameter describes the name of the target resource group in which the network resources will be deployed')
param parNetworkResourceGroupName string

@description('this parameter describes the different location used by the actiongroup')
param parGlobalLocation string

@description('this parameter describes the name of the virtual network in which the network resources will be deployed')
param parVnetName string 

@description('this parameter describes the set of tags given to the aks cluster')
param parTags object


//* sql parameters //
@description('this parameter describes the admin username of the sql server')
param parSQLAdminUserName string 

@description('this parameter describes the admin password of the sql server')
@secure()
param parSQLAdminPassword string 


//* actiongroup params //
@description('this parameter describes which name the action group uses')
param parActionGroupShortName string

@description('this parameter describes whether or not the aks cluster has local accounts disabled')
param parActionGroupEnabled bool

@description('this parameter describes which sms receievers the action group uses')
param parActionGroupSmsReceivers array

@description('this parameter describes which webhook recievers the action group uses')
param parActionGroupWebhookReceivers array

@description('this parameter describes which itsm recievers the action group uses')
param parActionGroupItsmReceivers array

@description('this parameter describes which azure app push notification recievers the action group uses')
param parActionGroupAzureAppPushReceivers array

@description('this parameter describes which automation runbook recievers the action group uses')
param parActionGroupAutomationRunbookReceivers array

@description('this parameter describes which voice recievers the action group uses')
param parActionGroupVoiceReceivers array

@description('this parameter describes which logic app recievers the action group uses')
param parActionGroupLogicAppReceivers array

@description('this parameter describes which azure function recievers the action group uses')
param parActionGroupAzureFunctionReceivers array

@description('this parameter describes which arm role recievers the action group uses')
param parActionGroupArmRoleReceivers array


//* log analytics workspace parametes //
@description('this parameter describes a list of email recievers and the corresponding settings')
param parWorkspaceActionEmailReceiver01 object


//? ===============================================================================================================================================
//? variables //

//* variable mapping functions //
@description('this variable map translates a given location into a shortcode')
var locationMap = {
  westeurope: 'weu'
  northeurope: 'neu'
}

@description('this variable map translates a given deployment enviroment into a shortcode')
var enviromentMap = {
  development: 'dev'
  acceptation: 'acc'
  preproduction: 'pre'
  production: 'prod'
  testing: 'test'
}

@description('this variable map translates a given deployment enviormnet into a subnet ip range')
//ff aanpassen
var subnetMap = {
  development: '10.116.8.0/23'
  acceptation: '10.116.10.0/23'
  production: '10.116.12.0/23'
  testing: '10.116.14.0/23'
}

@description('this variable map translates a given deployment enviormnet into a subnet ip range')
//ff aanpassen
var subnetMap02 = {
  development: '10.116.16.0/23'
  acceptation: '10.116.18.0/23'
  production: '10.116.20.0/23'
  testing: '10.116.22.0/23'
}

var vmIpMap = {
  development: '10.116.8.5/23'
  acceptation: '10.116.10.5/23'
  production: '10.116.12.5/23'
  testing: '10.116.14.5/23'
}


//* varable map outputs //
@description('this variable is the output for the corresponding variable map function')
var env = enviromentMap[toLower(parEnv)]

@description('this variable is the output for the corresponding variable map function')
var shortCode = locationMap[toLower(parLocation)]

@description('this variable is the output for the corresponding variable map function')
var subnetPrefix = subnetMap[toLower(parEnv)]

@description('this variable is the output for the corresponding variable map function')
var subnetPrefix02 = subnetMap02[toLower(parEnv)]

@description('this variable is the output for the corresponding variable map funciton')
var vmPrivateIp = vmIpMap[toLower(parEnv)]


//* variable name builders //
@description('this variable builds the name for the main resource group resource using the outputs from the mapping variables')
var resourceGroupName = toLower('rg-${workload}-${env}-${shortCode}')

@description('this variable builds the name for the subnet resource using the outputs from the mapping variables')
var subnetName  = toLower('snet-${workload}-${env}-${shortCode}')

@description('this variable builds the name for the ip configuration resource using the outputs from the mapping variables')
var ipConfigName  = toLower('snet-${workload}-${env}-${shortCode}')

@description('this variable builds the name for the network security group resource using the outputs from the mapping variables')
var networkSecurityGroupName = toLower('nsg-${workload}-${env}-${shortCode}')

@description('this variable builds the name for the virtual machine resource')
var vmName = toLower('vm-${workload}-server-${env}-${shortCode}-01')

@description('this variable builds the name for the virtual machine scale set resource')
var vmScaleSetName = toLower('vmss-${workload}-node_manager-${env}-${shortCode}-01')

@description('this variable builds the name for the action group resource using the outputs from the mapping variables')
var actionGroupName = toLower('ag-${workload}-${env}-${shortCode}-01')

@description('this variable builds the name for the log analytics workspace resource using the outputs from the mapping variables')
var workspaceName = toLower('law-${workload}-${env}-${shortCode}-01')

@description('this variable builds the name for the virtual machine resource')
var sqlName = toLower('sql-${workload}')

//@description('this variable builds the name for the data disk resources')
//var dataDiskName = toLower('disk-${workload}-${env}-${shortCode}')


//* arrays and dictionaries of params //
@description('''this variable is an array of lists of email recievers, 
each list has to be defined as a variable under the cluster variable. 
each profile is an object with its own params''')
var actionEmailReceivers = [
  parWorkspaceActionEmailReceiver01
]



//? ===============================================================================================================================================
//? enviroment bicep //

//* resource group bicep //
resource resourceGroup_resource 'Microsoft.Resources/resourceGroups@2022-09-01'  ={
  name: resourceGroupName
  location: parLocation
}


//* alerting bicep //
module actionGroup_module '../ResourceModules/modules/insights/action-group/main.bicep' = {
  name: actionGroupName
  scope: resourceGroup_resource
  params: {
    name: actionGroupName
    location: parGlobalLocation
    groupShortName: parActionGroupShortName
    enabled: parActionGroupEnabled
    emailReceivers: actionEmailReceivers
    smsReceivers: parActionGroupSmsReceivers
    webhookReceivers: parActionGroupWebhookReceivers
    itsmReceivers: parActionGroupItsmReceivers
    azureAppPushReceivers: parActionGroupAzureAppPushReceivers
    automationRunbookReceivers: parActionGroupAutomationRunbookReceivers
    voiceReceivers: parActionGroupVoiceReceivers
    logicAppReceivers: parActionGroupLogicAppReceivers
    azureFunctionReceivers: parActionGroupAzureFunctionReceivers
    armRoleReceivers: parActionGroupArmRoleReceivers
  }
}


//* monitoring bicep //
module workspace_module'../ResourceModules/modules/operational-insights/workspace/main.bicep' = {
  name: workspaceName
  scope: resourceGroup_resource 
  params: {
    name: workspaceName
    location: parLocation
    tags: parTags
    diagnosticLogCategoriesToEnable: [
      'allLogs'
    ]
    diagnosticMetricsToEnable: [
      'AllMetrics'
    ]    
  }
}
//? ===============================================================================================================================================
//? networking bicep //

resource get_Vnet 'Microsoft.Network/virtualNetworks@2023-02-01' existing = {
  name: parVnetName
  scope: resourceGroup_resource
} 


//* network security group bicep // 
module networkSecurityGroup_module '../ResourceModules/modules/network/network-security-group/main.bicep' =  if (toLower(newOrExisting) == 'new'){
  name: '${networkSecurityGroupName}-01'
  scope: resourceGroup(parNetworkResourceGroupName)
  params: {
    location: parLocation
    name: '${networkSecurityGroupName}-01'
  }
  dependsOn: [
    get_Vnet
  ]
}

module networkSecurityGroup_module02 '../ResourceModules/modules/network/network-security-group/main.bicep' =  if (toLower(newOrExisting) == 'new'){
  name: '${networkSecurityGroupName}-02'
  scope: resourceGroup(parNetworkResourceGroupName)
  params: {
    location: parLocation
    name: '${networkSecurityGroupName}-02'
  }
  dependsOn: [
    get_Vnet
  ]
}


//*subnet bicep // 
module subnet_module '../ResourceModules/modules/network/virtual-network/subnet/main.bicep' =  if (toLower(newOrExisting) == 'new'){
  name: '${subnetName}-01'
  scope: resourceGroup(parNetworkResourceGroupName)
  params: {
    addressPrefix:  subnetPrefix
    name: '${subnetName}-01'
    virtualNetworkName: get_Vnet.name
    networkSecurityGroupId: networkSecurityGroup_module.outputs.resourceId
  }
  dependsOn: [
    get_Vnet
    networkSecurityGroup_module
  ]
}

module subnet_module02 '../ResourceModules/modules/network/virtual-network/subnet/main.bicep' =  if (toLower(newOrExisting) == 'new'){
  name: '${subnetName}-02'
  scope: resourceGroup(parNetworkResourceGroupName)
  params: {
    addressPrefix:  subnetPrefix02
    name: '${subnetName}-02'
    virtualNetworkName: get_Vnet.name
    networkSecurityGroupId: networkSecurityGroup_module02.outputs.resourceId
  }
  dependsOn: [
    get_Vnet
    networkSecurityGroup_module02
  ]
}


//? ===============================================================================================================================================
//? workload bicep //

//* azure sql bicep //
module sqlDb_module01 '../ResourceModules/modules/sql/server/main.bicep' = {
  scope: resourceGroup_resource
  name: '${sqlName}-${env}-${shortCode}-01'
  params: {
    location: parLocation
    name: '${sqlName}-sysconfig-${env}-${shortCode}-01'
    administratorLogin: parSQLAdminUserName
    administratorLoginPassword: parSQLAdminPassword
  }
  dependsOn: [
    workspace_module
  ]
}

module sqlDb_module02 '../ResourceModules/modules/sql/server/main.bicep' = {
  scope: resourceGroup_resource
  name: '${sqlName}-${env}-${shortCode}-02'
  params: {
    location: parLocation
    name: '${sqlName}-syslog-${env}-${shortCode}-02'
    administratorLogin: parSQLAdminUserName
    administratorLoginPassword: parSQLAdminPassword
  }
  dependsOn: [
    workspace_module
  ]
}
