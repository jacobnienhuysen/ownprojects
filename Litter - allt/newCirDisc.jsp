

<%@include file="Masterpage.jsp" %>

<!DOCTYPE html>



<html lang=s>
  <head>
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
   <link href="bootstrap-responsive.css" rel="stylesheet"> 
 </head>
 
 <body>
 
 <div class="span5">
		<div class="jumbotron">
			<h2>Skapa en ny diskussion:</h2> 
		</div>
		
<div class="well well-small">

<form name="circDisc" action="createCirDisc.jsp?cid=<%=request.getParameter("cid")%>" method="post">
<tr>
<td class="text">Vad ska din diskussion handla om:</td>
<td><input name="circDisc" type="text" id="circDisc" required></td>
</tr>
<tr><td><input type="submit" value="Skapa Diskussion"></td>

</div>

<div class="footer">
	<p>&copy; PVT Grupp 10</p>
</div>  
</div>

 <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster --> 
	<script src="js/jquery.min.js"></script>
   
 <script src="js/bootstrap.min.js"></script>
</body>


<%
		
		if(c1!=null) c1.close();
		
		if(pst1!=null) pst1.close();
        if(rs1!=null) rs1.close();


%>
</html>