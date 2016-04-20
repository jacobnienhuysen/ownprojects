<?php
header("Content-Type:text/plain");
require_once "get/login.php";
$db_server = mysqli_connect($db_hostname,$db_username,$db_password,$db_database); 

if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }

$query = "SELECT * FROM bab_annons";
$result = mysqli_query($db_server, $query);
$row = mysqli_fetch_array($result, MYSQLI_ASSOC);

print_r($row);

	
/*
while($row = $result->fetch_array())
{
$rows[] = $row;
}

foreach($rows as $row)
{
echo $row['CountryCode'];
}
*/
	mysqli_free_result($result);
	mysqli_close($db_server);

?>
