[cmdletBinding()]
Param(
    [Parameter(ValueFromPipeline =$true,ValueFromPipelineByPropertyName =$true)]
    [string[]]$Textzeichenfolgenarray
)
begin
{
    #wird einmalig ausgeführt
    Import-Module -Name ActiveDirectory

    $CimSession = New-CimSession -ComputerName $ComputerName 
}
process
{
#wird für jedes Element in der Pipeline ausgeführt
    foreach($item in $Textzeichenfolgenarray)
    {
    #Try Stufe 1
        try
        {

        }
        catch
        {

        }

    #Try Stufe 2
        try
        {
            throw "Fehler"
        }
        catch [DivideByZeroException]
        {
            Write-Host "Ausnahme: Division durch Null"
        }
        catch [System.Net.WebException],[System.Exception]
        {
            Write-Host "Weitere Ausnahme"
        }

     #Try Stufe 3
        $cimsession = New-CimSession -ComputerName localhost
        try
        {
            Get-CimInstance -ClassName Win32_Process -Filter "Name='mspaint.exe'"
        }
        catch
        {
            
        }
        finally
        {
            $CimSession.Close()
        }        
        
    }
}
end
{
#wird zum schlus einmal ausgeführt
    $CimSession.Close()
}