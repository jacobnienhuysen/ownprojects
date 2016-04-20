<?php
header('Content-Type: text/plain');
$id = dba_open("nytt.db", "c", "gdbm");

if (!$id) {
	echo "Database error.\n";
	exit;
}

$date = date("Y-m-d H:i:s");
$remaddr = $_SERVER["REMOTE_ADDR"];
$visitor_name = gethostbyaddr($remaddr);
$husagent = $_SERVER["HTTP_USER_AGENT"];
$str = "\nBESKRIVNING: $husagent" . "\nDATUM: $remaddr = $visitor_name" . "\nPUBLICERAT: $date";

$key = dba_firstkey($id);

while ($key != false){
	if (true){
		echo "\n" . dba_fetch($key, $id);
	}
	$key = dba_nextkey($id);
}
dba_insert($date,$str,$id);
echo "\n$str";

dba_close($id);
?>