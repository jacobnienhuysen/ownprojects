<!DOCTYPE html>

<html lang="sv">
<head>
	<meta charset="UTF-8">
	<title></title>
	<link rel="stylesheet" type="text/css" href="songstyles.css">
</head>

<?php

if(!isset($_GET["id"])){

	echo "song error";
	//header("Location: index.php");

	exit();

}
else{

	$id = $_GET["id"];
	
	require_once "get/login.php";
	
	$db_server = mysqli_connect($db_hostname, $db_username, $db_password, $db_database)
	or die('database connection error');
		
		$db_server->set_charset("utf8");
		
		$query="SELECT * FROM songs WHERE song_id='" . $id . "'";
		
		$result = $db_server->query($query);
	
		if(mysqli_num_rows($result)<1){
				echo "no song";
		}
	
}

while($obj = $result->fetch_object()){

?>







<body>
	<h3><?= $obj->song_title ?></h3>
	
	<p class="mel">Melodi: <?= $obj->song_mel ?> (<?= $obj->song_orig ?>)</p>
	
	<p><?= nl2br($obj->song_lyric) ?></p>
	
	<div id="comment">
		<h4>Kommentarer:</h4>
		<?= nl2br($obj->song_com) ?>
	</div>
	
</body>

<?php

	}

?>

</html>

<?php
	mysqli_free_result($result);
	mysqli_close($db_server);
?>