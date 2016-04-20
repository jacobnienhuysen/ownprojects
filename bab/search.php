<?php

require_once "get/login.php";
$db_server = mysqli_connect($db_hostname,$db_username,$db_password,$db_database); 

if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }

$query = "SELECT * FROM bab_category";

$result = mysqli_query($db_server,$query);
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

<div class="annons">
	<div class="title">S�k annons</div>
	<hr>
	<form method="get" action="result.php">
	<div class="form_left">
		<table>
			<tr valign="top">
				<td>Typ:</td>
				<td><input type="radio" name="int" value="all" checked="true" class="mail">Alla<br>
					<input type="radio" name="int" value="salj" class="mail">S�ljes<br>
					<input type="radio" name="int" value="kop" class="mail">K�pes/S�kes<p>
				</td>
			</tr>
			<tr valign="top">
				<td><input type="radio" name="ch" value="title" class="mail" checked="true">Rubrik: </td>
				<td><input type="text" name="title" placeholder="Ange s�kord" class="mail" size="30"><p></td>
			</tr>
			<tr valign="top">
				<td><input type="radio" name="ch" value="cat" class="mail">Kategori:</td>
				<td><select name="cat" class="mail">
						<?php
						while($obj = $result->fetch_object()){
							echo "<option value='" . $obj->cat_name . "'>" . $obj->cat_name . "</option>\r\n";
						}
						?>
					</select><p>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="S�k" class="mail">
				</td>
			</tr>
		</table>

	</div>
	</form>
	<div class="line"><hr></div>
		<a href="index.php">Startsidan</a>
</div>
	
	
	
	

</body>
</html>
<?php
	mysqli_close($db_server);
?>