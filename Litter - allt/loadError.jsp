<%@include file="Masterpage.jsp" %>

<% 
String errorMessage = null;
try{
Integer errorID = Integer.parseInt(request.getParameter("id"));


if(errorID == 1){
	errorMessage="Boken du försöker ladda upp finns redan i registret.";
}
else if(errorID == 2){
	errorMessage="Du har inte angett giltigt ISBN-nummer.";
}
else if(errorID == 3){
	errorMessage="Du har inte angett ett giltigt årtal.";
}
else if(errorID == 4){
	errorMessage="Du har inte rättigheterna till den här boken.";
}
else if(errorID == 5){
	errorMessage="En bok med det ISBN-numret finns redan i registret.";
}
else if(errorID == 6){
	errorMessage="Användarnamnet eller emailadressen är redan registrerad.";
}
else if(errorID == 7){
	errorMessage="Felaktig inmatning.";
}
else if(errorID == 8){
	errorMessage="Fel lösenord.";
}
else if(errorID == 9){
	errorMessage="Minst ett av ISBN10 och ISBN13 måste fyllas i.";
}
else if(errorID == 10){
	errorMessage="E-mailadresserna måste vara identiska.";
}
else if(errorID == 11){
	errorMessage="Lösenorden måste vara identiska.";
}
else{
	errorMessage="Nu vet jag inte riktigt varför du är på den här sidan...";
}

}catch(NumberFormatException e){errorMessage="Nu vet jag inte riktigt varför du är på den här sidan...";}
%>

<!DOCTYPE html>
<html lang="en">


  <head>
    <title>Laddningsfel</title>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
    <link href="bootstrap-responsive.css" rel="stylesheet" media="screen">
  </head>
  
   
		  
<div class="span5">
		<div class="jumbotron">
			<h2>Fel vid laddning:</h2> 
		</div>
<div class="well well-small">


<h4><%= errorMessage %></h4>

<h5><a href="javascript:history.go(-1)"><< Bakåt</a></h5>

	</div>





</div>
</div>   
</div>

    
<div class="footer">
    <p>&copy; PVT Grupp 10 </p>
</div>  
	  
<!-- Le javascript 
================================================== -->
<!-- Placed at the end of the document so the pages load faster --> 
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>

</body>
</html>
