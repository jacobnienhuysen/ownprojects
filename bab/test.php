<?php

/*
	insert into mail.php:
	action="action.php?id=<?= $obj->ann_aid ?>&int=<?= $int ?>">
*/

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

if($int != "true" && $int != "false"){
	header("Location: index.php");
	exit();
}

require_once "get/login.php";
$db_server = mysqli_connect($db_hostname,$db_username,$db_password,$db_database); 

if (mysqli_connect_errno()){
	echo "Failed to connect to MySQL: " . mysqli_connect_error();
}


if($int == "true"){
	$query = "SELECT ann_email, ann_title FROM bab_annons_sal WHERE ann_aid='".$id."'";
}
if($int == "false"){
	$query = "SELECT ann_email, ann_title FROM bab_annons_kop WHERE ann_aid='".$id."'";
}

$result = mysqli_query($db_server,$query);

if(mysqli_num_rows($result)<1){
	header("Location: index.php");
	exit();
}

$obj = $result->fetch_object();
	
	function spamcheck($field){
		//filter_var() sanitizes the e-mail
		//address using FILTER_SANITIZE_EMAIL
		$field=filter_var($field, FILTER_SANITIZE_EMAIL);

		//filter_var() validates the e-mail
		//address using FILTER_VALIDATE_EMAIL
		
		if(filter_var($field, FILTER_VALIDATE_EMAIL)){
			return TRUE;
		}
		else{
			return FALSE;
		}
	}
	
	if (isset($_POST['mail'])) {//if "email" is filled out, proceed
		//check if the email address is invalid
		$mailcheck = spamcheck($_POST['mail']);
		if ($mailcheck==FALSE){
			echo "Invalid input";
		}
		else{
		
			$to = $obj->ann_email;
			$from = $_POST["mail"];
			$name = $_POST["namn"];
			$sendCopy = $_POST["bcc"];
			$subject = "Ang. din annons '" . $obj->ann_title. "' på Buy-A-Book";
			$reminder = "Det här mailet har skickats via 'Buy-A-Book - portalen för begagnad kurslitteratur.'";
			$message = $_POST["text"]. "\r\n\r\n" . $reminder;
			$date = date("D F j Y H:i:s");
			
			if($sendCopy == "yes"){
				$headers = "MIME-Version: 1.0" . "\r\n" . "Content-type: text/plain; charset=UTF-8" . "\r\n" . "FROM: " . $name . "<". $from . ">\r\n" . "BCC: ". $from . "\r\n" . "DATE: " . $date . "\r\n";
			}
			else{
				$headers = "MIME-Version: 1.0" . "\r\n" . "Content-type: text/plain; charset=UTF-8" . "\r\n" . "FROM: " . $name . "<". $from . ">\r\n" . "DATE: " . $date . "\r\n";
			}
			
			mail($to,$subject,$message,$headers);
			header("Location: index.php");
			exit();
		}
	}
?>