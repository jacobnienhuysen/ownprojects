<?php
	$success = FALSE;
if(!isset($_GET["id"])){
	header("Location: index.php");
	exit();
}
else{
	if($_GET["id"] == "succ"){
		$success = TRUE;
	}
	if($_GET["id"] == "err"){
		$success = FALSE;
	}
}

?>

<!DOCTYPE html>
<html>
<head>
	<title>Buy-a-Book - Portalen f�r begagnad kurslitteratur</title>
	<link rel="stylesheet" type="text/css" href="stilar.css">
	<meta name="Author" content="Jacob Nienhuysen">
</head>

<body class="index">
		
	<div class="show">
	<?php if($success){
		echo '<div class="message">';
			echo 'Tack!<br>';
			echo 'Din annons har nu skickats till oss f�r granskning. Om den godk�nns f�r publicering kommer du att f� en bekr�ftelse skickad till emailadressen du uppgav.<p>';
			echo 'Efter eventuell publicering p� hemsidan kommer annonsen att ligga tillg�nglig i 60 dagar.<p>';	
			echo '<a href="index.php">Till startsidan</a>';
		echo '</div>';
	}
	else{
		echo '<div class="message">';
			echo 'Ett fel uppstod!<br>';
			echo 'Din annons har inte skickats. F�rs�k igen senare!<p>';
				
			echo '<a href="index.php">Till startsidan</a>';
		echo '</div>';	
			
	}?>
	</div>
</body>
</html>

