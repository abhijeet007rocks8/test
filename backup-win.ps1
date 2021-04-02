$filewatcher = New-Object System.IO.FileSystemWatcher
#$filewatcher.Path = "C:\Users\Abhijeet\Desktop\test\"
$filewatcher.Path = $args
write-host $filewatcher.Path
$filewatcher.Filter = "*.*"
$filewatcher.IncludeSubdirectories = $true
$filewatcher.EnableRaisingEvents = $true   

$writeaction = { $path = $Event.SourceEventArgs.FullPath
                $changeType = $Event.SourceEventArgs.ChangeType
                $logline = "$(Get-Date), $changeType, $path"
                Add-content "D:\FileWatcher_log.txt" -value $logline
              }    

$pushaction = {
                write-host $filewatcher.Path
                $path = $Event.SourceEventArgs.FullPath
                $changeType = $Event.SourceEventArgs.ChangeType
                $logline = "$(Get-Date), $changeType, $path"
	            write-host $logline
                git log
                write-host "Git log"
                git add .
                write-host "Git add"
                git commit -m $logline
                write-host "Git commit"
                git Status
                write-host "Git status"
                git push
                write-host "Git push"
                & ".\push.ps1  $logline"
             }

Register-ObjectEvent $filewatcher "Created" -Action $pushaction
Register-ObjectEvent $filewatcher "Changed" -Action $pushaction
Register-ObjectEvent $filewatcher "Deleted" -Action $pushaction
Register-ObjectEvent $filewatcher "Renamed" -Action $pushaction
while ($true) {sleep 5}