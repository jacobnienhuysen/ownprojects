<?php
require_once "get/login.php";
$db_server = mysqli_connect($db_hostname,$db_username,$db_password,$db_database); 

if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }

$query1 = "SELECT ann_aid, ann_title, ann_book, ann_date, ann_cat FROM bab_annons_sal WHERE ann_show > 0 ORDER BY ann_date DESC LIMIT 10";
$query2 = "SELECT ann_aid, ann_title, ann_book, ann_date, ann_cat FROM bab_annons_kop WHERE ann_show > 0 ORDER BY ann_date DESC LIMIT 10";
$result1 = $db_server->query($query1);
$result2 = $db_server->query($query2);


if(mysqli_num_rows($result2)<1){
	
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

<div class="front">
	<div class="main-title">Buy-A-Book</div>
	<div class="line">Portalen för begagnad kurslitteratur</div>
	<div class="line"><hr></div>
	
	
	<div class="front_left">
		<div class="front-title">Säljes</div>
		<table class="front-list">
			<tr class="front-list">
				<td class="headl">Rubrik</td>
				<td class="headc">Kategori</td>
				<td class="headr">Publicerad</td>
			</tr>
			<?php
			if(mysqli_num_rows($result1)<1){
				echo "	<tr class='dark'>\r\n";
				echo "		<td colspan='3'>Inga annonser publicerade ännu.<br><a href='new.php'>Publicera den första nu!</a></td>\r\n";
				echo "	</tr>\r\n";
			}
			else{
				$even = true;
				while($obj = $result1->fetch_object()){
					$id = $obj->ann_aid *4*7*10;
					$date =  strtotime($obj->ann_date);
					if($even)
						$class = ' class="dark"';
					else
						$class ="";
						
					echo "	<tr".$class.">\r\n";
					echo "		<td><a href='anns.php?id=".$id. "'>". $obj->ann_title."</a></td>\r\n";
					echo "		<td>". $obj->ann_cat."</td>\r\n";
					echo "		<td>". date("Y-m-d",$date) ."</td>\r\n";
					echo "	<tr>\r\n";
					$even = !$even;
				}
			}
			?>
		</table>
	</div>
	
	<div class="front_right">
		<div class="front-title">Köpes/Önskas</div>
		<table class="front-list">
			<tr class="front-list">
				<td class="headl">Rubrik</td>
				<td class="headc">Kategori</td>
				<td class="headr">Publicerad</td>
			</tr>
			<?php
			if(mysqli_num_rows($result2)<1){
				echo "	<tr class='dark'>\r\n";
				echo "		<td colspan='3'>Inga annonser publicerade ännu.<br><a href='new.php'>Publicera den första nu!</a></td>\r\n";
				echo "	</tr>\r\n";
			}
			else{
				$even = true;
				while($obj = $result2->fetch_object()){
					$id = $obj->ann_aid *4*7*10;
					$date =  strtotime($obj->ann_date);
					if($even)
						$class = ' class="dark"';
					else
						$class ="";
						
					echo "	<tr".$class.">\r\n";
					echo "		<td><a href='annk.php?id=".$id. "'>". $obj->ann_title."</a></td>\r\n";
					echo "		<td>". $obj->ann_cat."</td>\r\n";
					echo "		<td>". date("Y-m-d",$date) ."</td>\r\n";
					echo "	<tr>\r\n";
					$even = !$even;
				}
			}
			?>
		</table>
	</div>
	<div class="line"><hr></div>
	<div class="line"><a href="new.php">Skapa annons</a> | <a href="search.php">Sök annonser</a> | <a href="villkor.php" target="_blank">Villkor</a></div>
	<div class="line"><hr></div>
	<div class="copy">Copyright: &copy; 2014 Jacob Nienhuysen</div>

</div>
	
	
	
	

</body>
</html>
<?php
	mysqli_close($db_server);
?>