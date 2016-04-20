<%@include file="Masterpage.jsp" %>

<!DOCTYPE html>
<html lang="sv">


  <head>
    <title>Sök cirklar</title>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
    <link href="bootstrap-responsive.css" rel="stylesheet" media="screen">
  </head>
  
    
		  
<div class="span8">
		<div class="jumbotron">
			<h2>Sök cirklar</h2> 
		</div>
<div class="well well-small">

<table width="75%" class="table table-striped">


<form action="circResult.jsp" method="get">
<tr>
	<td><label class="radio"><input type="radio" value="cname" name="ch" checked="checked">Cirkelnamn</label>
	<label class="radio"><input type="radio" value="ccreator" name="ch">Startad av</label></td>
	<td valign="top"><input type="text" name="search" id="search" maxlength="64" placeholder="Sökord"></td>
</tr>


<tr>
	<td colspan="3">
	<button type="submit" class="btn btn-success">Sök</button>
    <button type="reset" class="btn btn-primary">Rensa</button></td>
</tr>
</form>

</table>

</div>
</div>

</div>

<div class="footer text-center">
    <p>&copy; PVT Grupp 10 </p>
</div>  
	  
<!-- Le javascript 
================================================== -->
<!-- Placed at the end of the document so the pages load faster --> 
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>

</body>
<%
if(pst1!=null) pst1.close();
if(rs1!=null) rs1.close();

if(c1!=null) c1.close();
%>
