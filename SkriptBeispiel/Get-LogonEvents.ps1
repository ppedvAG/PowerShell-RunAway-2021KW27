[cmdletBinding(PositionalBinding=$false)] #PositionalBinding schaltet für dieses Skript die Standard Positionzuweisung zu Parameter aus. Ermöglicht aber weiterhin die manuelle Zuweisung
param(
#ValidateScript ermöglich custom Validierungen
[ValidateScript({Test-NetConnection -ComputerName $PSItem -CommonTCPPort WINRM -InformationLevel Quiet})]
[string]$ComputerName = "localhost" ,

[Parameter(Mandatory=$true, Position=0)] #Mandatory = $true erzeugt einen Pflichtparameter , Position = 0 weißt dem Parameter die Standard Position 0 zu 
[ValidateSet(4624,4625,4634)] #ValidateSet lässt nur angegebene Werte zu
[int]$EventId ,

#ValidateRange lässt nur den angegebenen Wertebereich zu
[ValidateRange(5,20)]
[int]$Newest = 4, #Einziger Ort an dem ein nicht zulässiger Wert innerhalb des Skriptes gesetzt werden kann

[ValidateScript({Test-Path -Path $PSItem})]
[string]$Filepath = "nopath"
)
#Abragen und vorfiltern der Daten 
$Data = Get-EventLog -LogName Security -ComputerName $ComputerName | Where-Object -FilterScript {$PSItem.EventID -eq $EventId} | Select-Object -First $Newest



if($Filepath -ne "nopath")
{
#Der Block wird allerdings fehlschlagen weil die Eingaben in die ParameterVariable $Filepath weiterhin vom ValidateScript validiert werden
if(($Filepath.EndsWith("\")) -eq $false)
{
    $Filepath += "\"
}

$Filepath += "Export.txt"
Out-File -InputObject $Data -FilePath $Filepath
}
else
{
    
   $Data
}