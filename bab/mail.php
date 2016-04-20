<?php
if(!isset($_GET["id"]) || !isset($_GET["int"])){
	header("Location: index.php");
	exit();
}
$id = $_GET["id"];
$int = $_GET["int"];

if($int != "true" && $int != "false"){
	header("Location: index.php");
	exit();
}

require_once "get/login.php";
$mysqli = new mysqli($db_hostname,$db_username,$db_password,$db_database); 

if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }
  
  $mid = $id/2/3;
  
  $query = NULL;
  
if($int == "true"){
	$query = "SELECT ann_title FROM bab_annons_sal WHERE ann_aid=?";
}
if($int == "false"){
	$query = "SELECT ann_title FROM bab_annons_kop WHERE ann_aid=?";
}

	$stmt = $mysqli->prepare($query);
	$stmt->bind_param("d", $mid);
	$stmt->execute();
	$stmt->store_result();
	$stmt->bind_result($title);
	$stmt->store_result();
	$rows = $stmt->num_rows;	

if($rows<1){
	header("Location: index.php");
	exit();
}
?>
<!DOCTYPE html>
<html>
<head>
	<title>Buy-a-Book - Portalen för begagnad kurslitteratur</title>
	<link rel="stylesheet" type="text/css" href="stilar.css">
	<meta name="Author" content="Jacob Nienhuysen">
	<meta name="Description" content="Köp och sälj begagnad kurslitteratur på Buy-A-Book!">
	<meta name="KeyWords" content="Jacob, Nienhuysen, buyabook, buy, book, kursböcker, kursbok, kurslitteratur, universitet, högskola, dsv, su, kth, litteratur, böcker, java, programmering, logik">
</head>

<body class="index">

<!-- ANNONS BÖRJAR //-->

<div class="annons">
	<div class="title">Maila annonsören</div>
	<hr>
	<form method="post" action="action.php?id=<?=$id?>&int=<?=$int?>">
	
		<table>
			<tr>
				<td>Ditt namn:</td>
				<td><input type="text" name="namn" id="namn" maxlength="32" size="32" class="mail" placeholder="Ditt namn" required></td>
			</tr>
			<tr>
				<td>Din email:</td>
				<td><input type="email" name="mail" id="mail" maxlength="32" size="32" class="mail" placeholder="Din e-post" required></td>
			</tr>
			<tr>
				<td colspan="2"><input type="checkbox" name="bcc" id="bcc" value="yes" class="mail">Skicka kopia till mig</td>
			</tr>
			<tr>
				<td colspan="2"><textarea name="text" rows="8" cols="50" maxlength="250" class="mail" required></textarea><td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="Skicka" class="mail">
								<input type="reset" value="Rensa" class="mail"></td>
			</tr>
		</table>
	
	</form>
</div>

<!-- ANNONS SLUT //-->

</html>

<?php
	$stmt->close();
	$mysqli->close();
?>