<?php
	header("Cache-Control: private, must-revalidate, max-age=0");
	header("Pragma: no-cache");
	header("Expires: Fri, 4 Jun 2010 12:00:00 GMT");

	
	if(!isset($_POST["q"])){
		header("Location: index.php");
		exit();
	}
	
	if(!isset($_POST["email"])){
		header("Location: index.php");
		exit();
	}
	
	if(isset($_POST['void']))
	{
		publish();
	} 
	
	$title = strip_tags($_POST["title"]);
	$book = strip_tags($_POST["book"]);
	$cat = strip_tags($_POST["category"]);
	$owner = strip_tags($_POST["owner"]);
	$email = strip_tags($_POST["email"]);
	$email2 = strip_tags($_POST["email2"]);
	$tele = strip_tags($_POST["tele"]);
	$text = strip_tags($_POST["text"]);
	$price = strip_tags($_POST["price"]);
	$type = strip_tags($_POST["type"]);
	$valid = strip_tags($_POST["valid"]);
	
	$correct = TRUE;
	
	if($email!=$email2){
		$correct = FALSE;
		$error = "Du har inte fyllt i emailadresserna korrekt.";
	}
	
	if($type == "salj" && $price == NULL){
		$correct = FALSE;
		$error = "Du m�ste ange ett pris i en S�lj-annons.";
	}
	
	
if($correct){
	session_start();
	$_SESSION['title'] = $title;
	$_SESSION['book'] = $book;
	$_SESSION['cat'] = $cat;
	$_SESSION['owner'] = $owner;
	$_SESSION['email'] = $email;
	$_SESSION['tele'] = $tele;
	$_SESSION['text'] = $text;
	$_SESSION['price'] = $price;
	$_SESSION['type'] = $type;
	
?>
<!DOCTYPE html>
<html>
<head>
	<title>Buy-a-Book - Portalen f�r begagnad kurslitteratur</title>
	<link rel="stylesheet" type="text/css" href="stilar.css">
	<meta name="Author" content="Jacob Nienhuysen">
	<meta name="Description" content="K�p och s�lj begagnad kurslitteratur p� Buy-A-Book!">
	<meta name="KeyWords" content="Jacob, Nienhuysen, buyabook, buy, book, kursb�cker, kursbok, kurslitteratur, universitet, h�gskola, dsv, su, kth, litteratur, b�cker, java, programmering, logik">
</head>

<body class="index">
		
	<form method="post" action="publ.php" enctype="multipart/form-data">
		<div class="show">
			
				H�r kan du se hur din annons kommer att se ut n�r den har publicerats.<br>
				Svar p� den h�r annonsen kommer att skickas till: <b><?= $email ?></b>.<p>
				Kontrollera att alla uppgifter st�mmer innan du g�r vidare!<p>
				
				<input type="button" value="�ndra" onClick="javascript:window.history.go(-1)" class="mail">
				<input type="submit" value="Publicera" class="mail">
		
		</div>
	</form>	
		
		
		<div class="show">
			<!-- ANNONS B�RJAR //-->
			<div class="annons">
				<?php if($type=="salj") echo "<i>S�ljes</i>"; else echo "<i>K�pes/S�kes</i>";?>
				<div class="title"><?= $title ?><?php if ($book != NULL){echo ' - <i>"' . $book . '"</i>'; } ?></div>
				<div class="line"><hr></div>
				<div class="left">
					<div class="comment"><?= $text ?></div>
					
					<?php if($type=="salj") echo '<div class="price">'. $price . ' kr</div>'; ?>
			
					<div class="info">
					<?php if ($tele != NULL){
						echo '<img src="pics/phone.jpg" width="25" style="vertical-align: middle;"> ' . $tele. '<br>';
					}
					if($email != NULL){
						echo '<img src="pics/mail.png" width="25" style="vertical-align: middle;"> Maila annons�ren';
					}?>
					</div>
				</div>
				<div class="line"><hr></div>
				<div class="data"><b>Publicerad:</b> <?= date("Y-m-d H:i:s") ?> | <b>Kategori:</b> <?= $cat ?> | <b>Annons�r:</b> <?= $owner ?></div>
			
			</div>
			<!-- ANNONS SLUT //-->
		</div>

</html>
<?php
}
else{?>
	<!DOCTYPE html>
	<html>
	<head>
		<title>Buy-a-Book - Portalen f�r begagnad kurslitteratur</title>
		<link rel="stylesheet" type="text/css" href="stilar.css">
		<meta name="Author" content="Jacob Nienhuysen">
	</head>
	
	<body class="index">
	
	<?php
		echo "<div class='error'>\r\n";
		echo "<h2>Ett fel uppstod</h2>\r\n";
		echo "	" . $error . "<p>\r\n";
		echo "	<a href='javascript:window.history.go(-1)'><< Bak�t</a>";
		echo "</div>";
	
	?>
	
	</body>
	</html>
<?php
}
?>
