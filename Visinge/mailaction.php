<?php
if($_POST){
	
	$my_email = "jacob.nienhuysen@gmail.com";
	$namn = $_REQUEST['namn'];
	$mail = $_REQUEST['mail'];
	$mess = $_REQUEST['mess'];
	$subject = "Mail från Visinge.com";
	
	$message = "Namn: " . $namn ."\r\nE-mail: " . $mail . "\r\nMeddelande: " . $mess;
	
	//send email
	mail($my_email, $subject, $message, "From: " . $mail);
	
}
 ?>