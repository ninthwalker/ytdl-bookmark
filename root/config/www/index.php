<?php
# Get Youtube URL from bookmark
$cmd = 'youtube-dl --config-location /config/youtube-dl.conf '.$_REQUEST['v'];
$url = $_REQUEST['v'];

# date used for log
$date = date("h:i:s");
$log = "/downloads/logs/$url-$date.log"

# Run youtube-dl command in background and output to log
shell_exec("$cmd &> $log &");

# TODO: redirect to webpage to show d/l status or maybe just back to originating URL
#header('Location: status.php');
echo "File Download has started for {$url} <p>";
$file = escapeshellarg("$log");
$line = `tail -n 1 $file`;
echo $line;
echo "<p>";
?>
