# Create Azure Policy Definition and Assignment on Subscription Level
# This policy defines which IPs will be allowed in CosmosDB firewall
# Run Login-AzAccount before running this script

[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $PolicyName = 'cosmos-db-vnet-ip-filter',

    [Parameter()]
    [string]
    $PolicyDisplayName = 'Filter IP Addresses on CosmosDB',

    [Parameter()]
    [string]
    $PolicyDescription = 'This policy ensures that only predefined IPs are allowed on Cosmos DB accounts',

    [Parameter(Mandatory)]
    [string]
    $SubscriptionId
)

Write-Output -InputObject 'Creating Azure Policy Definition'
$definitionParams = @{
    Name        = $PolicyName
    DisplayName = $PolicyDisplayName
    Description = $PolicyDescription
    Policy      = "$PSScriptRoot/azurepolicy.rules.json"
    Parameter   = "$PSScriptRoot/azurepolicy.parameters.json"
    Mode        = 'Indexed'
}
$definition = New-AzPolicyDefinition @definitionParams


$subscription = Get-AzSubscription -SubscriptionId $SubscriptionId
Write-Output -InputObject "Creating Azure Policy Assignment '$PolicyName' on subscription '$($subscription.Name)'"
$assignmentParams = @{
    Name             = $PolicyName
    Scope            = "/subscriptions/$($subscription.Id)"
    PolicyDefinition = $definition
    PolicyParameter  = "$PSScriptRoot/azurepolicy.approvedipscosmosdb.json"
}

$assignment = New-AzPolicyAssignment @assignmentParams
$assignment