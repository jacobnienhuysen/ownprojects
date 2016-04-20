<!DOCTYPE html>

<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@include file="Masterpage.jsp" %>

<html>
 
  <head>
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
   <link href="bootstrap-responsive.css" rel="stylesheet"> 
  </head>
  
   

		  
		  
	<div class="span10">
	<div class="jumbotron">
		  
		  <p><h2>Skapa Bokcirkel</h2></p>
    <form name="laddaupp" action="addgroupcircle.jsp?id=<%=un%>" method="post">
    
    <legend>Fyll i nedan:</legend>
	<table>
	<tr>
	<td>
    <p><label><b>Cirkelnamn</b></label>
	<input type="text" name="name" id="namef" placeholder="Cirkelnamn" maxlength="50" required data-original-title="Max 50 tecken." data-placement="right"></br>
   </td>
   </tr>
    <tr>
	<td><p><label><b>Presentation</b></label>
    <TEXTAREA name="info" id="infof" ROWS="6" maxlength="200" style="resize:none; width:250px" data-original-title="Max 200 tecken." data-placement="right" required></TEXTAREA></br>
  </td>
   </tr>

	<tr><td>
    <button type="submit" class="btn">Skapa</button>
    <button type="reset" class="btn">Rensa</button>
	</td>
	</tr>
	</table>
	</form>		
    
    
    </div>
	 <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster --> 
			<script src="js/jquery.min.js"></script>
	<script src="js/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/bootstrap-tooltip.js"></script>
	<script>
	$(function ()  {
		$("#namef").tooltip();
		$("#infof").tooltip();  

	});  
	</script>
	<script src="js/jquery.min.js"></script>
	<script src="js/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<%
        if(pst1!=null) pst1.close();
        if(rs1!=null) rs1.close();
        if(c1!=null) c1.close();
        %>
    </body>
    </html>