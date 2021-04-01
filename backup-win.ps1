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
	            git add .
                git commit -m $logline
                git push
             }

Register-ObjectEvent $filewatcher "Created" -Action $pushaction
Register-ObjectEvent $filewatcher "Changed" -Action $pushaction
Register-ObjectEvent $filewatcher "Deleted" -Action $pushaction
Register-ObjectEvent $filewatcher "Renamed" -Action $pushaction
while ($true) {sleep 5}