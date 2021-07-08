
Get-EventLog -LogName System | Where-Object -FilterScript {$PSItem.EventID -eq 4624} | Select-Object -First 10
