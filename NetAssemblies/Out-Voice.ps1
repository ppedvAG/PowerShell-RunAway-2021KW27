[cmdletBinding()]
param(
   [ValidateLength(1,500)]
   [Parameter(Mandatory=$true)]
   [string]$text
)

do
{
    $audioservice = Get-Service -Name Audiosrv

    if($audioservice.Status -ne "Running")
    {
        $audioservice.Start()
        Start-Sleep -Milliseconds 15
    }
    Start-Sleep -Milliseconds 20
}until((Get-Service -Name Audiosrv).Status -eq "Running")

#Add-Tyoe ermöglicht das Laden von .Net Assemblies in die PowerShell
Add-Type -AssemblyName System.Speech

#erzeugen einer neuen Instanz der Klasse
$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer

$speak.Rate = 0

$voices = $speak.GetInstalledVoices().VoiceInfo

$speak.SelectVoice($voices[1].Name)

#Ausführen der SpeakFuntion
$speak.Speak($text)

#Am Ende der Verwendung von .Net Objekten oder Assemblies sollten diese Disposed werden
$speak.Dispose()

