# Reference: Az.CosmosDB | https://docs.microsoft.com/powershell/module/az.cosmosdb
# Create Cosmos DB SQL API account with firewall

Function New-RandomString {
    Param ([Int]$Length = 10) return $( -join ((97..122) + (48..57) | Get-Random -Count $Length | ForEach-Object { [char]$_ }))
}

$uniqueId = New-RandomString -Length 7 # Random alphanumeric string for unique resource names
$apiKind = "Sql"
$locations = @("westeurope") # Regions ordered by failover priority
$resourceGroupName = "testrsg" # Resource Group must already exist
$accountName = "cosmos-$uniqueId" # Must be all lower case
$consistencyLevel = 'Session'

# These are the IP's needed in the CosmosDB Firewall to allow requests from the Azure Portal
# https://docs.microsoft.com/en-us/azure/cosmos-db/how-to-configure-firewall#allow-requests-from-the-azure-portal
$ipRules = @(
    "104.42.195.92",
    "40.76.54.131",
    "52.176.6.30",
    "52.169.50.45",
    "52.187.184.26"
)

Write-Output -InputObject "Creating account $accountName"
$cosmosDBParams = @{
    Name                    = $accountName
    ResourceGroupName       = $resourceGroupName
    Location                = $locations
    ApiKind                 = $apiKind
    DefaultConsistencyLevel = $consistencyLevel
    IpRule                  = $ipRules
    Verbose                 = $true
    Debug                   = $true
}

New-AzCosmosDBAccount @cosmosDBParams