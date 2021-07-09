<#
.Synopsis
   Skript zum erstellen eines TestFiles Verzeichnisses
.DESCRIPTION
   Mithilfe dieses Skriptes kann ein Verzeichniss angelegt werden, in welchem sich dann TestFiles befinden
.PARAMETER Path
   Gibt an unter welchen Pfad das TestFiles Verzeichnis angelegt wird
.EXAMPLE
   .\MoeglicheLoesung.ps1 -Path C:\

   Bei dieser Verwendung wird unter C:\ ein Verzeichniss TestFiles angelegt in welchem dann 2 ordner und 2 TestFiles angelegt werden
.EXAMPLE
   .\MoeglicheLoesung.ps1 -Path C:\ -DirCount 5 -FileCount 9

   Bei dieser Verwendung wird unter C:\ ein Verzeichniss TestFiles angelegt in welchem dann 5 ordner und 9 TestFiles angelegt werden
.EXAMPLE
   .\MoeglicheLoesung.ps1 -Path C:\ -DirCount 5 -FileCount 9 -Force

   Bei dieser Verwendung wird unter C:\ ein Verzeichniss TestFiles angelegt in welchem dann 5 ordner und 9 TestFiles angelegt werden. Sollte das Verzeichnis bereits vorhanden sein wird dieses gelöscht / überschrieben.
#>
[cmdletBinding(PositionalBinding=$false)]
param(
    [Parameter(Mandatory=$true,HelpMessage="Pfad unter dem der TestFiles Ordner angelegt werden soll")]
    [ValidateScript({Test-Path -Path $PSItem})]
    [string]$Path,

    [ValidateRange(1,100)]
    [int]$DirCount = 2,

    [ValidateRange(1,100)]
    [int]$FileCount = 2,

    [switch]$Force,

    [ValidateLength(2,20)]
    [string]$TestDirName = "TestFiles"
)



if($Path.EndsWith("\"))
{
    [string]$TestDirPath = $Path + "$TestDirName"
}
else
{
    [string]$TestDirPath = $Path + "\$TestDirName"
}

if((Test-Path -Path $TestDirPath))
{
    Write-Verbose -Message "Ordner bereits vorhanden"
    if($Force)
    {
        Remove-Item -Path $TestDirPath -Recurse -Force
    }
    else
    {
        Write-Error -Message "Ordner bereits vorhanden" -Exception [System.IO.IOException]
        exit
    }
}

New-Item -Path $TestDirPath -ItemType Directory

function New-TestFiles
{
    [cmdletBinding(PositionalBinding=$false)]
    param(
        [ValidateScript({Test-Path -Path $PSItem})]
        [Parameter(Mandatory=$true)]
        [string]$Path,

        [ValidateRange(1,100)]
        [int]$FileCount = 9,

        [ValidateLength(2,20)]
        [string]$NamePräfix = "File",

        [ValidateLength(2,20)]
        [string]$FileContent = ""
    )
   
    Write-Verbose -Message "Erstellen der Dateien innerhalb von New-TestFiles"
    for($i = 1; $i -le $FileCount; $i ++)
    {
        Write-Progress -Activity "Erstellen der Dateien" -Id 2 -ParentId 1 -Status "Erstelle Datei $i von $FileCount" -PercentComplete ((100 / $FileCount)*$i)
        $fileName = $NamePräfix + "-" + ("{0:D3}" -f $i) + ".txt"
        New-Item -Path $Path -Name $fileName -ItemType File -Value $FileContent | Out-Null
    }
}

New-TestFiles -Path $TestDirPath -FileCount $FileCount -NamePräfix "Datei"

Write-Verbose -Message "Beginn erstellen der Ordner"
for($i = 1; $i -le $DirCount; $i++)
{
    Write-Progress -Id 1 -Activity "Erstellen der Verzeichnisse" -Status "Erstelle Verzeichnis $i von $DirCount" -PercentComplete ((100/$DirCount) * $i)
    $DirName = "Ordner" + ("{0:D3}" -f $i)
    
    $dir = New-Item -Path $TestDirPath -Name $DirName -ItemType Directory

    New-TestFiles -Path $dir.FullName -FileCount $FileCount -NamePräfix ($DirName + "-Datei") | Out-Null
}


