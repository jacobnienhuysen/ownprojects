<?php
if($_GET["id"] == NULL){
	header("Location: index.php");
	exit();
}
$id = $_GET["id"];

require_once "get/login.php";
$db_server = mysqli_connect($db_hostname,$db_username,$db_password,$db_database); 

if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }

  $id = $id/10/7/4;
  $mid = $id*3*2;
  
$query = "SELECT * FROM bab_annons_kop WHERE ann_aid='".$id."'";
$result = mysqli_query($db_server,$query);


if(mysqli_num_rows($result)<1){
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
	
<?php
	while($obj = $result->fetch_object()){
?>
	<!-- ANNONS BÖRJAR //-->
	<div class="annons">
		<i>Köpes/Sökes</i>
		<div class="title"><?= $obj->ann_title ?><?php if ($obj->ann_book != NULL){echo ' - <i>"' . $obj->ann_book . '"</i>'; } ?></div>
		<div class="line"><hr></div>
		<div class="left">
			<div class="comment"><?= $obj->ann_comment ?></div>
			
			<div class="info">	<?php if ($obj->ann_phone != NULL){
									echo '<img src="pics/phone.jpg" width="25" style="vertical-align: middle;"> ' . $obj->ann_phone . '<br>';
								}?>
								<?php if($obj->ann_email != NULL){
									echo '<img src="pics/mail.png" width="25" style="vertical-align: middle;"> <a href="mail.php?id='. $mid .'&int=false">Maila annonsören</a>';
								}?>
			</div>
		</div>
		
		<div class="line"><hr></div>
		<div class="data"><b>Publicerad:</b> <?= $obj->ann_date ?> | <b>Kategori:</b> <?= $obj->ann_cat ?> | <b>Annonsör:</b> <?= $obj->ann_owner ?></div>
		<div class="line"><hr></div>
		<a href="index.php">Stäng</a>
	</div>
	<!-- ANNONS SLUT //-->
<?php
	}
	?>
</html>
<?php
mysqli_free_result($result);
mysqli_close($db_server);
?>