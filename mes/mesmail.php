<?php
if(!$_POST){
	echo "Något gick fel =(";
}
else{
	$success = false;
	$to = "mes@disk.su.se";
	$namn = $_POST["namn"];
	$mail = $_POST["mail"];
	$subject = "Mail från hemsidan";
	$message = $_POST["mess"] . "\r\n\r\nNamn: ". $namn . "\r\nMail: " . $mail;
	$headers = "MIME-Version: 1.0" . "\r\n" . "Content-type: text/plain; charset=UTF-8" . "\r\n" . "From: " . $mail . "\r\nName: " . $namn;
	
	$success = mail($to,$subject,$message,$headers);
	
	if($success){
		header('Location: tack.html');
	}
	else{
		echo "Något gick fel =(";
	}
}
?>