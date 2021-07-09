function Color-Console
{
    $Host.UI.RawUI.BackgroundColor = "white"
    $Host.UI.RawUI.ForegroundColor = "Black"

    $starttime = (Get-Date).ToShortTimeString()
    $PSVersion = $PSVersionTable.PSVersion.Major

    $Host.UI.RawUI.WindowTitle = "PowerShell: $PSVersion gestartet um: $starttime"

    if((Get-Command -Name Set-PSReadlineOption).Version.Major -lt 2)
    {   #Bei Windows Server 2016 oder vor Windows 10 1809
        Set-PSReadlineOption -TokenKind Command -ForegroundColor DarkBlue
        Set-PSReadlineOption -TokenKind Parameter -ForegroundColor Blue
        Set-PSReadlineOption -TokenKind Number -ForegroundColor DarkRed
        Set-PSReadlineOption -TokenKind Member -ForegroundColor Black
        Set-PSReadlineOption -TokenKind Variable -ForegroundColor DarkGreen
        Set-PSReadlineOption -TokenKind Comment -ForegroundColor Green
    }
    else
    {   #Ab Windows Server 2019 oder ab Windows 10 1809
        Set-PSReadlineOption -Colors @{"Parameter" = [ConsoleColor]::Blue                                       
                                       "Command" = [ConsoleColor]::DarkBlue
                                       "Number" = [ConsoleColor]::DarkRed
                                       "Member" = [ConsoleColor]::Black
                                       "Variable" = [ConsoleColor]::DarkGreen
                                       "Comment" = [ConsoleColor]::Green
                                        }
    }

    Clear-Host
}
Color-Console

function prompt
{#wird beim erstellen einer neuen Zeile ausgeführt
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal] $identity
    $adminRole = [Security.Principal.WindowsBuiltinRole]::Administrator


    if($principal.IsInRole($adminRole))
    {
        $Status = "[Admin]"
    }
    else
    {
        $Status = "[User]"
    }


    $location = Get-Location
    if($location.Path.Length -gt 25)
    {
        Write-Host -Object "Path: $($location.Path)" 
        Write-Host -Object "[$((Get-Date).ToShortTimeString())]$Status " -ForegroundColor (Get-Random -Maximum 16 -Minimum 1) -NoNewline

    }
    else
    {
    Write-Host -Object "[$((Get-Date).ToShortTimeString())]$Status $($location.Path) " -ForegroundColor (Get-Random -Maximum 16 -Minimum 1) -NoNewline
    }
}