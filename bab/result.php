<?php

if(!isset($_GET["int"]) || !isset($_GET["ch"])){
	header("Location: search.php");
	exit();
}  


$type = $_GET["int"];
$choice = $_GET["ch"];
$title = "";
$title2 = "";
$cat = "";
$cat2 = "";
$order = "";

require_once "get/login.php";
$mysqli = new mysqli($db_hostname,$db_username,$db_password,$db_database);  

if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }

$query = NULL;  


if($type == "all"){
	if($choice == "title"){
		$title = "%" . $_GET["title"] . "%";
		$query = "(SELECT ann_aid, ann_title, ann_cat, ann_date FROM bab_annons_sal WHERE ann_show > 0 AND ann_title LIKE ?) UNION (SELECT ann_aid, ann_title, ann_cat, ann_date FROM bab_annons_kop WHERE ann_show > 0 AND ann_title LIKE ?)";
		$stmt = $mysqli->prepare($query);
		$stmt->bind_param("ss", $title, $title);
	}
	
	if($choice == "cat"){
		$cat = $_GET["cat"];
		$query = "(SELECT ann_aid, ann_title, ann_cat, ann_date FROM bab_annons_sal WHERE ann_show > 0 AND ann_cat = ?) UNION (SELECT ann_aid, ann_title, ann_cat, ann_date FROM bab_annons_kop WHERE ann_show > 0 AND ann_cat = ?)";
		$stmt = $mysqli->prepare($query);
		$stmt->bind_param("ss", $cat, $cat);
	}
	
	$stmt->execute();
	$stmt->bind_result($ann_aid, $ann_title, $ann_cat, $ann_date);
	$stmt->store_result();
	$rows = $stmt->num_rows;	
}

if($type == "salj"){
	if($choice == "title"){
		$title = "%" . $_GET["title"] . "%";
		$query = "SELECT ann_aid, ann_title, ann_cat, ann_date FROM bab_annons_sal WHERE ann_show > 0 AND ann_title LIKE ?";
		$stmt = $mysqli->prepare($query);
		$stmt->bind_param("s", $title);
	}
	if($choice == "cat"){
		$cat = $_GET["cat"];
		$query = "SELECT ann_aid, ann_title, ann_cat, ann_date FROM bab_annons_sal WHERE ann_show > 0 AND ann_cat = ?";
		$stmt = $mysqli->prepare($query);
		$stmt->bind_param("s", $cat);
	}
	
	$stmt->execute();
	$stmt->bind_result($ann_aid, $ann_title, $ann_cat, $ann_date);
	$stmt->store_result();
	$rows = $stmt->num_rows;
}

if($type == "kop"){
	if($choice == "title"){
		$title = "%" . $_GET["title"] . "%";
		$query = "SELECT ann_aid, ann_title, ann_cat, ann_date FROM bab_annons_kop WHERE ann_show > 0 AND ann_title LIKE ?";
		$stmt = $mysqli->prepare($query);
		$stmt->bind_param("s", $title);
	}
	if($choice == "cat"){
		$cat = $_GET["cat"];
		$query = "SELECT ann_aid, ann_title, ann_cat, ann_date FROM bab_annons_kop WHERE ann_show > 0 AND ann_cat = ?";
		$stmt = $mysqli->prepare($query);
		$stmt->bind_param("s", $cat);
	}
	
	$stmt->execute();
	$stmt->bind_result($ann_aid, $ann_title, $ann_cat, $ann_date);
	$stmt->store_result();
	$rows = $stmt->num_rows;
}

/*
if(isset($_GET["orderby"])){
	$order = " ORDER BY " . $_GET["orderby"];
}
*/

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

<div class="form">
	<div class="title">Sökresultat</div>
	<hr>
	
	<div class="front_left">
		<table class="front-list">
			<tr class="front-list">
				<td class="headl">Rubrik</td>
				<td class="headc">Kategori</td>
				<td class="headr">Publicerad</td>
			</tr>
			<?php
			if($rows<1){
				echo "	<tr class='dark'>\r\n";
				echo "		<td colspan='3'>Inga annonser som matchade dina kriterer hittades.</td>\r\n";
				echo "	</tr>\r\n";
			}
			else{
				$even = true;
				while($stmt->fetch()){
					$date =  strtotime($ann_date);
					if($even)
						$class = ' class="dark"';
					else
						$class ="";
						
					echo "	<tr".$class.">\r\n";
					echo "		<td><a href='anns.php?id=".$ann_aid. "'>". $ann_title."</a></td>\r\n";
					echo "		<td>". $ann_cat."</td>\r\n";
					echo "		<td>". date("y-m-d",$date) ."</td>\r\n";
					echo "	<tr>\r\n";
					$even = !$even;
				}
			}
			?>
		</table>
	</div>
	
	<div class="line"><hr></div>
		<a href="search.php">Ny sökning</a> | <a href="index.php">Startsidan</a>
</div>
	
	
	
	

</body>
</html>
<?php
	$mysqli->close();
?>