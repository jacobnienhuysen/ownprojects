<?php
header("Content-Type:text/plain");
if(isset($_POST)){
	print_r($_POST);
}

	$name = $_FILES['pic']['name'];
	$type = $_FILES['pic']['type'];
	$size = $_FILES['pic']['size'];
	
	echo "File: " . $name;
	echo "type: " . $type;
	echo file_get_contents($_FILES['pic']['tmp_name']);
?>