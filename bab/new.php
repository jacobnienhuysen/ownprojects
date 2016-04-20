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
	<title>Buy-a-Book - Portalen för begagnad kurslitteratur</title>
	<link rel="stylesheet" type="text/css" href="stilar.css">
	<meta name="Author" content="Jacob Nienhuysen">
	<meta name="Description" content="Köp och sälj begagnad kurslitteratur på Buy-A-Book!">
	<meta name="KeyWords" content="Jacob, Nienhuysen, buyabook, buy, book, kursböcker, kursbok, kurslitteratur, universitet, högskola, dsv, su, kth, litteratur, böcker, java, programmering, logik">
</head>

<body class="index">

<!-- ANNONS BÖRJAR //-->

<div class="form">
	<div class="title">Skapa annons</div>
	<hr>
	<form method="post" enctype="multipart/form-data" action="check.php">
	<div class="form_left">
		
		<table>
			<tr>
				<td>Typ av annons:</td>
				<td><input type="radio" name="type" value="salj" class="mail" checked="true">Säljes
					<input type="radio" name="type" value="kop" class="mail">Köpes/Sökes <font color="red">*</font>
				</td>
			</tr>
			<tr>
				<td>Annonsens rubrik:</td>
				<td><input type="text" name="title" id="title" class="mail" maxlength="32" size="30" required> <font color="red">*</font></td>
			</tr>
			<tr>
				<td>Kategori:</td>
				<td><select name="category" class="mail" required>
						<option value="choose" disabled selected>Välj kategori</option>
						<?php
						while($obj = $result->fetch_object()){
							echo "<option value='" . $obj->cat_name . "'>" . $obj->cat_name . "</option>\r\n";
						}
						?>
					</select> <font color="red">*</font>
				</td>
			</tr>
			<tr>
				<td>Bok:</td>
				<td><input type="text" name="book" id="book" class="mail" maxlength="64" size="30"></td>
			</tr>
			<tr>
				<td>Pris (om säljes):</td>
				<td><input type="number" min="0" max="9999" name="price" id="price" class="mail" maxlength="4" size="10"> kr</td>
			</tr>
			<tr>
				<td>Ditt namn:</td>
				<td><input type="text" name="owner" id="owner" class="mail" maxlength="32" size="30" required> <font color="red">*</font></td>
			</tr>
			<tr>
				<td>Din emailadress:</td>
				<td><input type="email" name="email" id="email" class="mail" maxlength="32" size="30" required> <font color="red">*</font></td>
			</tr>
			<tr>
				<td>Bekräfta emailadress:</td>
				<td><input type="email" name="email2" id="email" class="mail" maxlength="32" size="30" required> <font color="red">*</font></td>
			</tr>
			<tr>
				<td>Ditt telefonnummer:</td>
				<td><input type="tel" name="tele" id="tele" class="mail" maxlength="28" size="30"></td>
			</tr>
			<tr>
				<td colspan="2"><p>Beskrivning: <font color="red">*</font><br>
				<textarea name="text" rows="8" cols="60" maxlength="500" class="mail" required></textarea></td>
			</tr>
			<tr>
				<td colspan="2"><input type="checkbox" name="valid" id="valid" value="yes" class="mail" required>
				Jag godkänner <a href="villkor.php" target="_blank">villkoren</a> för annonser på Buy-A-Book. <font color="red">*</font><p></td>
			</tr>
			<tr>
				<td colspan="2"><input type="reset" value="Rensa" class="mail"><input type="submit" value="Nästa" class="mail"> </td>
			</tr>
		</table>
	</div>
	<input type="hidden" name="q" value="ok">
	</form>
	<div class="line"><hr></div>
		<a href="index.php">Startsidan</a>
	
</div>

<!-- ANNONS SLUT //-->

</html>

<?php
	mysqli_free_result($result);
	mysqli_close($db_server);
?>