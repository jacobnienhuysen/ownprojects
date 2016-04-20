<?php
header("Content-Type:text/plain");

if(!$_POST){
	header("Location: index.php");
	exit();
}

if($_GET["id"] == NULL || $_GET["int"] == NULL){
	header("Location: index.php");
	exit();
}
$id = $_GET["id"];
$int = $_GET["int"];
$query = NULL;

$id = $id/2/3;
#$mid = $id*3*2;
$bcc = $_POST["bcc"];

if($int != "true" && $int != "false"){
	header("Location: index.php");
	exit();
}

require_once "get/login.php";
$mysqli = new mysqli($db_hostname,$db_username,$db_password,$db_database); 

if (mysqli_connect_errno()){
	echo "Failed to connect to MySQL: " . mysqli_connect_error();
}


if($int == "true"){
	$query = "SELECT ann_email, ann_title FROM bab_annons_sal WHERE ann_aid=?";
}
if($int == "false"){
	$query = "SELECT ann_email, ann_title FROM bab_annons_kop WHERE ann_aid=?";
}

	$stmt = $mysqli->prepare($query);
	$stmt->bind_param("d", $id);
	$stmt->execute();
	$stmt->store_result();
	$stmt->bind_result($ann_email,$ann_title);
	$stmt->fetch();
	$rows = $stmt->num_rows;


if($rows<1){
	header("Location: index.php");
	exit();
}
	$text = strip_tags($_POST["text"]);
	$to = $ann_email;
	$from = $_POST["mail"];
	$subject = "Ang. din annons '" . $ann_title. "' på Buy-A-Book";
	$reminder = "Det här meddelandet skickades från Buy-A-Book, Portalen för begagnad kurslitteratur.";
	$message = $text. "\r\n\r\n" . $reminder;
	$date = date("D F j Y H:i:s");
	
	if($bcc == "yes"){
		$headers = "MIME-Version: 1.0\r\nContent-type: text/plain; charset=UTF-8\r\nFrom: " . $_POST["namn"] . " <" . $from . ">\r\nBCC: " . $_POST["mail"] . "\r\nDate: " . $date . "\r\n";
		mail($to,$subject,$message,$headers);
	}
	else{
		$headers = "MIME-Version: 1.0\r\nContent-type: text/plain; charset=UTF-8\r\nFrom: " . $_POST["namn"] . " <" . $from . ">\r\nDate: " . $date . "\r\n";
		mail($to,$subject,$message,$headers);
	}

	$stmt->close();
	$mysqli->close();
	header("Location: index.php");
	exit();

?>