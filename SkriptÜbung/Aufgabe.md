# Übungsaufgabe

Erstellen Sie ein Skript welches ein Verzeichnis mit TestFiles anlegt. Nach dem Schema von C:\TestFiles welches Sie auf dem Server1 (DC) finden.
Die verschiedenen Entwicklungsschritte sollten Sie am besten mit GIT mitprotokollieren, die Parameter sollten validiert sein. Ebenso soll das 
Skript tauglich sein, von PowerShell Anwendern welche Get-Help kennen, benutzt zu werden.

Folgende Eingabemöglichkeiten sollten mindestens vorhanden sein.
* Path
* Anzahl Ordner
* Anzahl Dateien 
* Verbose Ausgabe

Optional bei Zeit:
* Name des TestFiles Verzeichnisses
* Dateiinhalt
    * Auswahl über vorgegebene Werte (zb ipconfig, RandomNumber, . . . )
* Ausgabe nicht als Ordner sondern als Zip wie unter C:\Ablage\TestFiles.zip