# Overview
This solution showcases how to create an Azure Policy which allows/denies specific IP addresses in CosmosDB Firewall.

# Files

## CreateAzurePolicy.ps1
This PowerShell script creates the Azure Policy Definition and Assignment on a subscription level.
Make sure to run Login-AzAccount and select the correct subscription before running this script.

## azurepolicy.rules.ps1
File containing the policy rules definition.

## azurepolicy.parameters.json
File containing the policy parameter definition.

## azurepolicy.approvedipcosmosdb.json
File containing the assignment parameter values. Modify if you want to assign different IPs.
The IPs provided in this file are the IPs as described in this article:
https://docs.microsoft.com/en-us/azure/cosmos-db/how-to-configure-firewall#allow-requests-from-the-azure-portal

## CreateNewCosmosDB.ps1
This PowerShell script creates a new CosmosDB Account.
This is to test out the policy created before ( only if you don't have an CosmosDB account yet ).
