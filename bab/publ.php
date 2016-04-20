<?php
	header("Cache-Control: private, must-revalidate, max-age=0");
	header("Pragma: no-cache");
	header("Expires: Fri, 4 Jun 2010 12:00:00 GMT");
	
	session_start();
	if(!isset($_SESSION["title"])){
		header("Location: index.php");
		exit();
	}
	
	require_once "get/login.php";
	$db_server = mysqli_connect($db_hostname,$db_username,$db_password,$db_database); 

	if (mysqli_connect_errno()){
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
		exit();
	}
	
	$title = $_SESSION["title"];
	$book = $_SESSION["book"];
	$cat = $_SESSION["cat"];
	$owner = $_SESSION["owner"];
	$email = $_SESSION["email"];
	$tele = $_SESSION["tele"];
	$text = $_SESSION["text"];
	$price = $_SESSION["price"];
	$type = $_SESSION["type"];
	$pic = NULL;
	
	$success = FALSE;
	
	if($type == "salj"){
		$query = "INSERT INTO bab_annons_sal(ann_title, ann_owner, ann_phone, ann_email, ann_book, ann_cat, ann_comment, ann_price) VALUES (?,?,?,?,?,?,?,?)";
		$stmt = mysqli_prepare($db_server, $query);
		mysqli_stmt_bind_param($stmt, "sssssssd", $title, $owner, $tele, $email, $book, $cat, $text, $price);
		
		if($pic!=NULL){
			$stmt->send_long_data(8, $pic);
		}
		
		mysqli_stmt_execute($stmt);
		mysqli_stmt_close($stmt);
		mysqli_close($db_server);
		$success = TRUE;
	}
	if($type == "kop"){
		$query = "INSERT INTO bab_annons_kop(ann_title, ann_owner, ann_phone, ann_email, ann_book, ann_cat, ann_comment) VALUES (?,?,?,?,?,?,?)";
		$stmt = mysqli_prepare($db_server, $query);
		mysqli_stmt_bind_param($stmt, "sssssss", $title, $owner, $tele, $email, $book, $cat, $text);
		
		if($pic!=NULL){
			$stmt->send_long_data(7, $pic);
		}
		
		mysqli_stmt_execute($stmt);
		mysqli_stmt_close($stmt);
		mysqli_close($db_server);
		$success = TRUE;
	}
	
	if($success){
		//Denna kod skickar ett mail till moderatorn som ska kontrollera annonsen före publicering
		
		$to = "jacob.nienhuysen@gmail.com";
		$from = "Buy-A-Book";
		$subject = "En annons väntar på Buy-A-Book";
		$message = "En annons av typen '" . $type . "' väntar på verifiering på Buy-A-Book.\r\n\r\nRubrik: ". $title ."\r\nEmail: " . $email;
		$date = date("D F j Y H:i:s");
		$headers = "MIME-Version: 1.0" . "\r\n" . "Content-type: text/plain; charset=UTF-8" . "\r\n" . "FROM: ". $from . "\r\n" . "DATE: " . $date . "\r\n";
				
		mail($to,$subject,$message,$headers);
		
		//Denna kod skickar ett bekräftande mail till annonsören
		
		$to = $email;
		$from = "Buy-A-Book";
		$subject = "Bekräftelse";
		$message = "Din annons '" . $title . "' har emottagits av oss.\r\n\r\nDen kommer nu att granskas och om den godkänns för publicering kommer du att få en bekräftelse inom 24 timmar.\r\n\r\nMed vänliga hälsningar Buy-A-Book\r\n\r\nOBS! Detta är ett autogenererat mail. Om du vill kontakta oss, använd istället adressen bab@visinge.com!";
		$date = date("D F j Y H:i:s");
			
		$headers = "MIME-Version: 1.0" . "\r\n" . "Content-type: text/plain; charset=UTF-8" . "\r\n" . "FROM: ". $from . "\r\n" . "DATE: " . $date . "\r\n";
				
		mail($to,$subject,$message,$headers);
		session_destroy();
		$_SESSION = array();
		header("Location: final.php?id=succ");
		exit();
	}
	else{
		session_destroy();
		$_SESSION = array();
		header("Location: final.php?id=err");
		exit();
	}
	
	/*
	//Använd denna kod ifall du vill tillåta bilder i annonserna.
	
	$fileName = NULL;
	$fileSize = NULL;
	$fileType = NULL; 
	
	if(!empty($_FILES['pic']['name'])){
		
		if (($_FILES['pic']['type'] == 'image/jpeg')||($_FILES['pic']['type'] == 'image/gif')||($_FILES['pic']['type'] == 'image/png')) {
			$pic = file_get_contents($_FILES['pic']['tmp_name']);#file_get_contents($_FILES['pic']['tmp_name']);
			$fileName = $_FILES['pic']['name'];
			$fileSize = $_FILES['pic']['size'];
			$fileType = $_FILES['pic']['type']; 
		}
		else{
			echo 'The picture is not a picture.';
		}	
	}
	
	
	$query = NULL;
	$stmt = NULL;
	$null = NULL;
	
	*/
	
?>