<?php
if(!isset($_GET["int"]) || !isset($_GET["id"])){
	header("Location: index.php");
}

require_once "get/login.php";
$mysqli = new mysqli($db_hostname,$db_username,$db_password,$db_database); 

if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }

$id = $_GET["id"];  
$from = NULL;
$email = NULL;
$title = NULL;

if($_GET["int"] == "salj"){
	$from = "bab_annons_sal";
}
else if($_GET["int"] == "kop"){
	$from = "bab_annons_kop";
}
else{
	header("Location: index.php");
}

	$query = "SELECT ann_email, ann_title FROM " .$from . " WHERE ann_aid=?";
	
	$stmt = $mysqli->prepare($query);
	$stmt->bind_param("d", $id);
	$stmt->execute();
	$stmt->store_result();
	$stmt->bind_result($email,$title);
	$stmt->fetch();
	$rows = $stmt->num_rows;
	
	if($rows<1){
		echo "annonsen finns inte.<br><a href='index.php'>Åter</a>";
		$mysqli->close();
		exit();
	}
	else{
	
		$show = 1;
		$query = "UPDATE ". $from ." SET ann_show=? WHERE ann_aid=?";
		$stmt = $mysqli->prepare($query);
		$stmt->bind_param("dd", $show, $id);
		$stmt->execute();
		
		
		
		$to = $email;
		$from = "Buy-A-Book";
		$subject = "Din annons har godkänts";
		$message = "Din annons '" . $title . "' har nu godkänts och publicerats på Buy-A-Book.\r\n\r\nDen kommer nu att finnas synlig på www.visinge.com/bab i 60 dagar.\r\n\r\nMed vänliga hälsningar Buy-A-Book\r\n\r\nOBS! Detta är ett autogenererat mail. Om du vill kontakta oss, använd istället adressen bab@visinge.com!";
		$date = date("D F j Y H:i:s");
			
		$headers = "MIME-Version: 1.0" . "\r\n" . "Content-type: text/plain; charset=UTF-8" . "\r\n" . "FROM: ". $from . "\r\n" . "DATE: " . $date . "\r\n";
		
		
		mail($to,$subject,$message,$headers);
		
	}
		header("Location: index.php");

		$stmt->close();
		$mysqli->close();
	
?>