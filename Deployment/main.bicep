//!when using the following extension for Visual Studio Code the comments are more readable; aaron-bond.better-comments


// this parameter defines the scope of the file. 
// in this case that scope is "resource group" this is because infield supplies the subscriptions and resource groups in which workloads are deployed. 
// this means that this file will be scoped on an existing resource group.
targetScope = 'subscription'


//* deployment scope params
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
@maxLength(12)
param workload string

@description('this parameter describes the name of the target resource group in which the network resources will be deployed')
param parNetworkResourceGroupName string

@description('this parameter describes the id of the target subscription in which the infrastructure will be deployed')
param parSubscription string

@description('this parameter describes the different location used by the actiongroup')
param parGlobalLocation string

@description('this parameter describes the name of the virtual network in which the network resources will be deployed')
param parVnetName string 

@description('this parameter describes the set of tags given to the aks cluster')
param parTags object


//* node pool params
@description('this parameter describes the amount of times this node pool is rolled out')
param parPoolCount int

@description('this parameter describes the vm size of the node pool')
param parPoolVmSize string 

@description('this parameter describes the disk size of the node pool')
param parPoolOsDiskSizeGB int 

@description('this parameter describes the disk type of the node pool')
param parPoolOsDiskType string 

@description('this parameter describes the kubelet disk type of the node pool')
param parPoolKubeletDiskType string 

@description('this parameter describes the type of the node pool')
param parPoolType string

@description('this parameter describes which availability zones the node pool uses')
param parPoolAvailabilityZones array 

@description('this parameter describes the maximum amount of pods of the node pool')
param parPoolMaxCount int 

@description('this parameter describes the minimum amount of pods of the node pool')
param parPoolMinCount int 

@description('this parameter describes whether or not the node pool has autoscaling enabled')
param parPoolEnableAutoScaling bool 

@description('this parameter describes the orchestrator version of the node pool')
param parPoolOrchestratorVersion string 

@description('this parameter describes whether or not the node pool has a public ip')
param parPoolEnableNodePublicIP bool 

@description('this parameter describes whether or not the node pool has custom ca trust enabled')
param parPoolEnableCustomCATrust bool 

@description('this parameter describes the mode of the node pool')
param parPoolMode string

@description('this parameter describes the os type of the node pool')
param parPoolOsType string 

@description('this parameter describes the os sku of the node pool')
param parPoolOsSKU string 

@description('''this parameter describes whether or not the node pool has
Federal Information Process Standard enabled''')
param parPoolEnableFIPS bool 



//* registry params
@description('this parameter describes the sku used by the registry')
param parRegistrySku string

@description('this parameter describes whether or not the registry has an admin user')
param parRegistryAdminUserEnabled bool

@description('this parameter describes whether or not the registry has a public data endpoint')
param parRegistryDataEndpointEnabled bool

@description('this parameter describes whether or not the registry has a public network access enabled')
param parRegistryPublicNetworkAccess string

@description('this parameter describes whether or not the registry has a network bypass option')
param parRegistryNetworkRuleBypassOptions string

@description('this parameter describes whether or not the registry is zone redundant')
param parRegistryZoneRedundancy string

@description('this parameter describes whether or not the registry can be pulled')
param parRegistryAnonymousPullEnabled bool

@description('this parameter describes whether or not the trust policy is enabled within the registry')
@allowed([
  'disabled'
  'enabled'
])
param parTrustPolicyStatus string

@description('this parameter describes whether or not the export policy is enabled within the registry')
@allowed([
  'disabled'
  'enabled'
])
param parRegistryExportPolicyStatus string

@description('this parameter describes the amount of retention days')
param parRegistryRetentionPolicyDays int

@description('this parameter describes whether or not the retention policy is enabled within the registry')
@allowed([
  'disabled'
  'enabled'
])
param parRegistryRetentionPolicyStatus string

@description('this parameter describes whether or not the quarantine policy is enabled within the registry')
@allowed([
  'disabled'
  'enabled'
])
param parRegistryQuarantinePolicyStatus string 

@description('this parameter describes the amount of soft delete days')
param parRegistrySoftDeletePolicyDays int

@description('this parameter describes whether or not the soft delete policy is enabled within the registry')
@allowed([
  'disabled'
  'enabled'
])
param parRegistrySoftDeletePolicyStatus string

@description('''this parameter describes whether or not the azure ad authentication as arm
 policy is enabled within the registry''')
@allowed([
  'disabled'
  'enabled'
])
param parRegistryAzureADAuthenticationAsArmPolicyStatus string



//* managed cluster params
@description('this parameter describes the sku used by the aks cluster')
param parClusterSku string

@description('this parameter describes the kubernetes version used by the aks cluster')
param parClusterKubernetesVersion string

@description('this parameter describes the requirements of the user principal profile used by the aks cluster')
param parClusterServicePrincipalProfile object

@description('this parameter describes the requirements of the vault secret provider used by the aks cluster')
param parClusterVaultSecretProvider bool 

@description('this parameter describes whether or not the aks cluster rotates its secrets')
@secure()
param parClusterEnableSecretRotation string 

@description('this parameter describes whether or not the aks cluster has azure rbac enabled')
param parClusterEnableRBAC bool

@description('this parameter describes which network plugin the aks cluster uses')
param parClusterNetworkPlugin string 

@description('this parameter describes which load balancer sku the aks cluster uses')
param parClusterLoadBalancerSku string 

@description('this parameter describes which dns service ip the aks cluster uses')
param parClusterDnsServiceIP string 

@description('this parameter describes which service cidr the aks cluster uses')
param parClusterServiceCidr string 

@description('this parameter describes which outbound type the aks cluster uses')
param parClusterOutboundType string

@description('this parameter describes whether or not the aks cluster has local accounts disabled')
param parClusterDisableLocalAccounts bool

@description('this parameter describes which oidc issuer profile the aks cluster uses')
param parClusterEnableOidcIssuerProfile bool


//* roll assignment params
@description('this parameter describes which name the role assignment module uses')
param parRollAssignmentName string

@description('this parameter describes which identity gets a new role assignment')
param parRollAssignmentPrincipalType string 

@description('this parameter describes which role assignment is given through the role assignment module uses')
param parRollAssignmentRollDefinitionId string 



//* actiongroup params
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



//* keyvault parameters
@description('this parameter describes which sku the key vault uses')
param parVaultSku string

@description('this parameter describes which policies the key vault uses')
param parVaultAccessPolicies array 

@description('this parameter describes if virtual machines can access the key vault')
param parVaultEnabledForDeployment bool

@description('this parameter describes whether disk encryption is allowed using the key vault')
param parVaultEnabledForDiskEncryption bool

@description('this parameter describes whether template deployment is allowed using the key vault')
param parVaultEnabledForTemplateDeployment bool

@description('this parameter describes whether soft delete is turned on in the key vault. default is true')
param parVaultEnableSoftDelete bool

@description('this parameter describes how many days a soft deleted key vault will persist')
param parVaultSoftDeleteRetentionInDays int

@description('this parameter describes whether or not rbac authorisation is turned on for the key vault')
param parVaultEnableRbacAuthorization bool

@description('this parameter describes whether or not the key vault accepts public network traffic and has only two allowed values')
@allowed([
  'Enabled'
  'Disabled'
])
param parVaultPublicNetworkAccess string

@description('this parameter describes whether or not the key vault has purge protection available')
param parVaultEnablePurgeProtection bool



//* managed identities parameters
@description('this parameter describes if the managed identity has its default telemetry enabled')
param parManagedIdentityEnableDefaultTelemetry bool



//* log analytics workspace parametes
@description('this parameter describes a list of email recievers and the corresponding settings')
param parWorkspaceActionEmailReceiver01 object



//* variable mapping functions
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
var subnetMap = {
  development: '10.116.0.0/23'
  acceptation: '10.116.2.0/23'
  production: '10.116.4.0/23'
  testing: '10.116.6.0/23'
}


//* varable map outputs
@description('this variable is the output for the correszponding variable map function')
var env = enviromentMap[toLower(parEnv)]

@description('this variable is the output for the corresponding variable map function')
var shortCode = locationMap[toLower(parLocation)]

@description('this variable is the output for the corresponding variable map function')
var subnetPrefix = subnetMap[toLower(parEnv)]



//* variable name builders
@description('this variable builds the name for the main resource group resource using the outputs from the mapping variables')
var resourceGroupName = toLower('rg-${workload}-${env}-${shortCode}')

@description('this variable builds the name for the subnet resource using the outputs from the mapping variables')
var subnetName  = toLower('snet-${workload}-${env}-${shortCode}-01')

@description('this variable builds the name for the network security group resource using the outputs from the mapping variables')
var networkSecurityGroupName = toLower('nsg-${workload}-${env}-${shortCode}-01')

@description('this variable builds the name for the aks cluster resource')
var clusterName = toLower('aks-${workload}-${env}-${shortCode}-01')

@description('this variable builds the name for the aks cluster node resource group resource using the outputs from the mapping variables')
var clusterNodeResourceGroup= toLower('rg-node-${workload}-${env}-${shortCode}-01')

@description('this variable builds the name for the aks cluster dns resource using the outputs from the mapping variables')
var clusterDnsPrefix = toLower('dns-${clusterName}')

@description('this variable builds the name for the key vault resource using the outputs from the mapping variables')
var vaultName = toLower('kv-${workload}-${env}-01')

@description('this variable builds the name for the container registry resource using the outputs from the mapping variables')
var registryName = toLower('cr${workload}${env}${shortCode}01')

@description('this variable builds the name for the action group resource using the outputs from the mapping variables')
var actionGroupName = toLower('ag-${env}-${shortCode}-01')

@description('this variable builds the name for the log analytics workspace resource using the outputs from the mapping variables')
var workspaceName = toLower('law-${workload}-${env}-${shortCode}-01')

@description('this variable builds the name for the user assigned managed identity resource using the outputs from the mapping variables')
var managedIdentityName = toLower('mi-acr-${workload}-${env}-${shortCode}-01')



//* arrays and dictionaries of params
@description('''this variable describes the ids of the managed identities that get used by the role assignment module.
however the format is very odd but this is the way microsoft decided to do it...
it identifies the id by using the keys of a dictionary as a value.
if it aint broken dont fix it i guess''')
var managedIdentities = {
  '/subscriptions/${parSubscription}/resourcegroups/${resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/${managedIdentityName}': {}
}

@description('''this variable is an array of lists of email recievers, 
each list has to be defined as a variable under the cluster variable. 
each profile is an object with its own params''')
var actionEmailReceivers = [
  parWorkspaceActionEmailReceiver01
]


//? =================================================================================================================================================================== ?//
//* network resource deployments
resource resourceGroup_resource 'Microsoft.Resources/resourceGroups@2022-09-01'  ={
  name: resourceGroupName
  location: parLocation
}


resource get_Vnet 'Microsoft.Network/virtualNetworks@2023-02-01' existing = {
  name: parVnetName
  scope: resourceGroup(parNetworkResourceGroupName)
} 

module networkSecurityGroup_module '../ResourceModules.v0.10.0/modules/Network/networkSecurityGroups/main.bicep' =  if (toLower(newOrExisting) == 'new'){
  name: networkSecurityGroupName
  scope: resourceGroup(parNetworkResourceGroupName)
  params: {
    location: parLocation
    name: networkSecurityGroupName
  }
  dependsOn: [
    get_Vnet
  ]
}

module subnet_module '../ResourceModules.v0.10.0/modules/Network/virtualNetworks/subnets/main.bicep' =  if (toLower(newOrExisting) == 'new'){
  name: subnetName
  scope: resourceGroup(parNetworkResourceGroupName)
  params: {
    addressPrefix:  subnetPrefix
    name: subnetName
    virtualNetworkName: get_Vnet.name
    networkSecurityGroupId: networkSecurityGroup_module.outputs.resourceId
  }
  dependsOn: [
    get_Vnet
    networkSecurityGroup_module
  ]
}


//? =================================================================================================================================================================== ?//
//* building the agentpool properties
@description('this parameter describes the requirements of the system node pool used by the aks cluster')
var clusterSystemPool01 = {
  name: 'systempool01'
  count: parPoolCount
  vmSize: parPoolVmSize
  osDiskSizeGB: parPoolOsDiskSizeGB
  osDiskType: parPoolOsDiskType
  kubeletDiskType: parPoolKubeletDiskType
  type: parPoolType
  availabilityZones: parPoolAvailabilityZones
  maxCount: parPoolMaxCount
  minCount: parPoolMinCount
  enableAutoScaling: parPoolEnableAutoScaling
  orchestratorVersion: parPoolOrchestratorVersion
  enableNodePublicIP: parPoolEnableNodePublicIP
  enableCustomCATrust: parPoolEnableCustomCATrust
  tags: parTags
  mode: parPoolMode
  osType: parPoolOsType
  osSKU: parPoolOsSKU
  enableFIPS: parPoolEnableFIPS
  vnetSubnetId: subnet_module.outputs.resourceId
}

@description('this parameter describes the requirements of the user node pool used by the aks cluster')
var clusterUserPool01 = {
  name: 'userpool01'
  count: parPoolCount
  vmSize: parPoolVmSize
  osDiskSizeGB: parPoolOsDiskSizeGB
  osDiskType: parPoolOsDiskType
  kubeletDiskType: parPoolKubeletDiskType
  type: parPoolType
  availabilityZones: parPoolAvailabilityZones
  maxCount: parPoolMaxCount
  minCount: parPoolMinCount
  enableAutoScaling: parPoolEnableAutoScaling
  orchestratorVersion: parPoolOrchestratorVersion
  enableNodePublicIP: parPoolEnableNodePublicIP
  enableCustomCATrust: parPoolEnableCustomCATrust
  tags: parTags
  mode: parPoolMode
  osType: parPoolOsType
  osSKU: parPoolOsSKU
  enableFIPS: parPoolEnableFIPS
  vnetSubnetId: subnet_module.outputs.resourceId
}


//? =================================================================================================================================================================== ?//
//* workload and monitoring resources deployment
module registry_module '../ResourceModules.v0.10.0/modules/ContainerRegistry/registries/main.bicep' = if (toLower(newOrExisting) == 'new') {
  name: registryName
  scope: resourceGroup(resourceGroupName)
  params: {
    name: registryName
    location: parLocation
    acrSku: parRegistrySku
    acrAdminUserEnabled: parRegistryAdminUserEnabled
    dataEndpointEnabled: parRegistryDataEndpointEnabled
    publicNetworkAccess: parRegistryPublicNetworkAccess
    networkRuleBypassOptions: parRegistryNetworkRuleBypassOptions
    zoneRedundancy: parRegistryZoneRedundancy
    anonymousPullEnabled: parRegistryAnonymousPullEnabled
    trustPolicyStatus: parTrustPolicyStatus
    exportPolicyStatus: parRegistryExportPolicyStatus
    retentionPolicyDays: parRegistryRetentionPolicyDays
    retentionPolicyStatus: parRegistryRetentionPolicyStatus
    quarantinePolicyStatus: parRegistryQuarantinePolicyStatus
    softDeletePolicyDays: parRegistrySoftDeletePolicyDays
    softDeletePolicyStatus: parRegistrySoftDeletePolicyStatus
    azureADAuthenticationAsArmPolicyStatus: parRegistryAzureADAuthenticationAsArmPolicyStatus
  }
  dependsOn: [
    resourceGroup_resource
  ]
}

module managedIdentity_module '../ResourceModules.v0.10.0/modules/ManagedIdentity/userAssignedIdentities/main.bicep' = {
  name: managedIdentityName
  scope: resourceGroup(resourceGroupName)
  params: {
    location: parLocation
    name: managedIdentityName
    tags: parTags
    enableDefaultTelemetry: parManagedIdentityEnableDefaultTelemetry
  }
  dependsOn: [
    resourceGroup_resource
  ]
}

module actionGroup_module '../ResourceModules.v0.10.0/modules/Insights/actionGroups/main.bicep' = {
  name: actionGroupName
  scope: resourceGroup(resourceGroupName)
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
  dependsOn: [
    resourceGroup_resource
  ]
}

module vault_module '../ResourceModules.v0.10.0/modules/KeyVault/vaults/main.bicep' = if (toLower(newOrExisting) == 'new'){
  name: vaultName
  scope: resourceGroup(resourceGroupName)
  params: {
    name: vaultName
    location: parLocation
    vaultSku: parVaultSku
    accessPolicies: parVaultAccessPolicies
    enableVaultForDeployment: parVaultEnabledForDeployment
    enableVaultForDiskEncryption: parVaultEnabledForDiskEncryption
    enableVaultForTemplateDeployment: parVaultEnabledForTemplateDeployment
    enableSoftDelete: parVaultEnableSoftDelete
    softDeleteRetentionInDays: parVaultSoftDeleteRetentionInDays
    enableRbacAuthorization: parVaultEnableRbacAuthorization
    publicNetworkAccess: parVaultPublicNetworkAccess
    enablePurgeProtection: parVaultEnablePurgeProtection
  }
}

module workspace_module'../ResourceModules.v0.10.0/modules/OperationalInsights/workspaces/main.bicep' = {
  name: workspaceName
  scope: resourceGroup(resourceGroupName)
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
  dependsOn: [
    resourceGroup_resource
  ]
}



//? =================================================================================================================================================================== ?//
//* azure kubernetes service cluster deployment
module cluster_module '../ResourceModules.v0.10.0/modules/ContainerService/managedClusters/main.bicep' = {
  name: clusterName
  scope: resourceGroup(resourceGroupName)
  params: {
    name: clusterName
    location: parLocation
    tags: parTags
    aksClusterSkuTier: parClusterSku
    userAssignedIdentities: managedIdentities
    aksClusterKubernetesVersion: parClusterKubernetesVersion
    aksClusterDnsPrefix: clusterDnsPrefix
    agentPools: [
      clusterUserPool01
      clusterSystemPool01
    ]
    primaryAgentPoolProfile: [
      clusterSystemPool01
    ]
    aksServicePrincipalProfile: parClusterServicePrincipalProfile
    enableKeyvaultSecretsProvider: parClusterVaultSecretProvider
    enableSecretRotation: parClusterEnableSecretRotation
    nodeResourceGroup: clusterNodeResourceGroup
    enableRBAC: parClusterEnableRBAC
    aksClusterNetworkPlugin: parClusterNetworkPlugin
    aksClusterLoadBalancerSku: parClusterLoadBalancerSku
    aksClusterDnsServiceIP: parClusterDnsServiceIP
    aksClusterServiceCidr: parClusterServiceCidr
    aksClusterOutboundType: parClusterOutboundType
    disableLocalAccounts: parClusterDisableLocalAccounts
    enableOidcIssuerProfile: parClusterEnableOidcIssuerProfile
  }
}



//? =================================================================================================================================================================== ?//
//* automated rbac
module rollAssignment_module '../ResourceModules.v0.10.0/modules/Authorization/roleAssignments/resourceGroup/main.bicep' = {
  scope: resourceGroup(parNetworkResourceGroupName)
  name: parRollAssignmentName
  params: {
    principalId: managedIdentity_module.outputs.principalId
    principalType: parRollAssignmentPrincipalType
    roleDefinitionIdOrName: parRollAssignmentRollDefinitionId
  }
  dependsOn: [
    resourceGroup_resource
  ]
}

