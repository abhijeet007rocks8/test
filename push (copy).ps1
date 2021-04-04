$message = $args[0]
write-host $message
git add .
git commit -m  $message
git push