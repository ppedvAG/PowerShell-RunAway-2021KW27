[cmdletBinding(DefaulParameterSetName="Set1")]
param(
[Parameter(Mandatory=$true, ParameterSetName="Set1")]
[Parameter(Mandatory=$false, ParameterSetName="Set2")]
[switch]$Param1,

[Parameter(Mandatory=$true, ParameterSetName="Set2")]
[switch]$Param2
)