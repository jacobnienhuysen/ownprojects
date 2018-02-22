<?php
	$message = "";
	
	/*Databaskopplingen har modifierats av säkerhetsskäl*/
	require_once "get/login.php";
	
	$db_server = mysqli_connect($db_hostname, $db_username, $db_password, $db_database)
	or die('database connection error');
	
	$query_event = "SELECT * FROM events WHERE event_id > 1 ORDER BY event_date ASC";
	$result_event = $db_server->query($query_event);
		
	if(mysqli_num_rows($result_event)<1){
		echo "Database error: event";
	}
	
	$query_fri="SELECT song_id, song_title FROM songs WHERE song_eventid =1 ORDER BY song_title ASC";
	$result_fri = $db_server->query($query_fri);
			if(mysqli_num_rows($result_fri)<1){
		echo "Database error: fristående";
	}
	
	$query_poems="SELECT poem_id, poem_title FROM poems ORDER BY poem_title ASC";
	$result_poems = $db_server->query($query_poems);
			if(mysqli_num_rows($result_poems)<1){
		echo "Database error: poems";
	}
	

?>

<!DOCTYPE html>
<html lang="sv">

<head>
	<meta charset="UTF-8">
	<meta name="description" content="Välkommen till Jacobs Ord!">
	<meta name="keywords" content="Jacob, Nienhuysen, visinge.com, visinge, Jacobs, ord, poesi, sångtexter, ord, texter, spex, gyckel, poetry, songs, music, lyrics, guitar, photos, photo, gallery, book, cd, album, Kvinnosyner, en, samling, stenar, diktsamling">
	<meta name="author" content="Jacob Nienhuysen">	
	<title>Jacobs Ord</title>
	
	<link rel="stylesheet" type="text/css" href="styles.css">
	
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>
	<script src="scripts/scripts.js"></script>
</head>

<body>

	<div id="back">
		<img id="bgimage" src="images/back6.JPG" alt="Background">
		<div id="texture"></div>
	</div>
	
	<div id="wrapper">
	
		<div id="menu">
			<img src="images/jacobsord_vit_s.png" alt="Jacobs Ord">
			<ul class="menulist">
				<li><a href="#profil" class="clicky">Profil</a></li>
				<li class="has-sub" id="has-sub"><a href="#">Sångtexter</a>
					<ul class="sublist">
						<li class="sub"><a href="#shows" class="clicky">Från föreställningar</a></li>
						<li class="sub last"><a href="#misc" class="clicky">Fristående</a></li>
					</ul>
				</li>
				<li><a href="#poems" class="clicky">Dikter</a></li>
				<li><a href="#contact" class="clicky">Kontakt</a><li>
			</ul>
		</div>
		
		<div id="content">
			<div id="contentHolder"></div>
			<div id="lyricHolder">
				<span class="close" id="closeLyric"></span>
				<div id="lcontent"></div>
			</div>
		</div>
		
	</div>
	
	<div id="splash">
		<img src="images/jacobsord_vit_l.png" alt="Screen">
	</div>
	
	<div id="profil" class="filler">
		<h2 class="filler_head">Profil</h2>
		<img src="images/profil.JPG" alt="Profilbild" class="profile-pic">
		<table class="profile-text">
			<tr>
				<td class="what">Namn:</td>
				<td>Jacob Nienhuysen</td>
			</tr>
			<tr>
				<td class="what">Född:</td>
				<td>1986</td>
			</tr>
			<tr>
				<td class="what">Bor:</td>
				<td>Stockholm</td>
			</tr>
			<tr>
				<td class="what">Beskrivning:</td>
				<td>poet, sångtextförfattare, spexare, underhållare</td>
			</tr>
			<tr>
				<td class="what">Instrument:</td>
				<td>sång, gitarr, piano</td>
			</tr>
		</table>
	</div>
	
	<div id="shows" class="filler">
		<h2 class="filler_head">Föreställningar</h2>
		
		<ul class="titles">
		<?php
			
			while($obj = $result_event->fetch_object()){
				
				$event_id = $obj->event_id;
				$event_name = $obj->event_name;
				
				$query_event_songs = "SELECT song_title, song_id FROM songs WHERE song_eventid ='". $event_id . "' ORDER BY song_title ASC";
				$result_event_songs = $db_server->query($query_event_songs);
		
				if(mysqli_num_rows($result_event_songs)>0){
					
					echo "<li>" . $event_name . "\r\n";
					echo "<ul class='event'>\r\n";
					
					while($obj = $result_event_songs->fetch_object()){
						echo "<li class='song'><a href='#' onclick='loadLyrics(" . $obj->song_id . ");return false;'>"  . $obj->song_title . "</a></li>\r\n";
					}
					
					echo "</ul>\r\n";
					echo "</li>\r\n";
				}
			}
		?>
		</ul>
	</div>
	
	<div id="misc" class="filler">
		<h2 class="filler_head">Fristående</h2>
		
		<ul class="titles">
		<?php
			
			while($obj = $result_fri->fetch_object()){
				echo "<li class='song'><a href='#' onclick='loadLyrics(" . $obj->song_id . ");return false;'>"  . utf8_encode($obj->song_title) . "</a></li>\r\n";
			}
		?>
		</ul>
		
	</div>
	
	<div id="poems" class="filler">
		<h2 class="filler_head">Dikter</h2>
		
		<ul class="titles">
		<?php
			
			while($obj = $result_poems->fetch_object()){
				echo "<li class='song'><a href='#' onclick='loadPoem(" . $obj->poem_id . ");return false;'>"  . utf8_encode($obj->poem_title) . "</a></li>\r\n";
			}
		?>
		</ul>
	</div>
	
	<div id="contact" class="filler">
	
		<h2 class="filler_head">Kontakt</h2>
		
		<form method="post" id="eform" name="eform" onsubmit="sendMail();return false;">
			
			<label for="namn">Namn</label>
			<input type="text" name="namn" id="namn" required>
			
			<label for="mail">E-post</label>
			<input type="email" name="mail" id="mail" required>
			
			<label for="mess">Meddelande</label>
			<textarea id="mess" name="mess" required></textarea>
			
			<input type="submit" value="Skicka">
				
		</form>
		
		<span id="aviser"></span>
		
	</div>
	
	<div id="song" class="filler">
		
	
	</div>
	
	

</body>
</html>