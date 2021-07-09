<#
.Synopsis
   Erstellt einen TestFolder
.DESCRIPTION
   Erstellt einen TestFolder
.EXAMPLE
   New-TestFolder -Path 'C:\'
.EXAMPLE
   New-TestFolder -Path 'C:\' -FileAmount 1
#>

[CmdLetbinding()]
Param(
    [Parameter(Mandatory=$true)]
    [ValidateScript({Test-Path $_})]
    [String]$Path,

    [ValidateNotNUll()]
    [Int]$FolderAmount = 2,

    [ValidateNotNUll()]
    [Int]$FileAmount = 10
)

function New-TestItem
{
    [CmdLetbinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [ValidateScript({Test-Path $_})]
        [String]$Path,
        
        [ValidateNotNUll()]
        [Int]$Count = 10,

        [ValidateSet('File','Directory')]
        [String]$ItemType
    )
    
    for ($i = 0; $i -lt $Count; $i++)
    { 
        $newName = "buffer$i"
        if($ItemType -eq 'File') {
            $newName += '.txt'
        }
        
        Try {
            $newItem = New-Item -Path $Path -Name $newName -ItemType $ItemType -ErrorAction Stop
            $newItem | Write-Output
            Write-Verbose "Created $ItemType `"$($newItem.FullName)`""
        } catch {
            Write-Error $_
        }
    }
}

$rootFolderName = 'TestFiles'
$rootPath = "$Path\$rootFolderName"

if(Test-Path -Path $rootPath) {
    $rootFolder = Get-Item $rootPath    
} else {
    Try {
        $rootFolder = New-Item -Path $Path -Name 'TestFiles' -ItemType Directory -Force
        Write-Verbose "Created Folder `"$($rootFolder.Fullname)`""
    } catch {
        throw       
    }    
}

New-TestItem -Path $rootFolder.FullName -ItemType File -Count $FileAmount | Out-Null
$subFolder = New-TestItem -Path $rootFolder.FullName -ItemType Directory -Count $FolderAmount

foreach ($folder in $subFolder)
{
    New-TestItem -Path $folder.FullName -ItemType File -Count $FileAmount | Out-Null
}