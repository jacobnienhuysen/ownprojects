<%@include file="Masterpage.jsp" %>


<%
    java.sql.PreparedStatement pst2;
	pst2 = null;
	java.sql.ResultSet rs2;
	rs2 = null;
    
	
	String sq2 = "SELECT * FROM book_literature_category ORDER BY lit_cat_name";
    pst2 = c1.prepareStatement(sq2);
    rs2 = pst2.executeQuery();

%>
<!DOCTYPE html>
<html>
 
  <head>
	<title>Ladda upp</title>
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
   <link href="bootstrap-responsive.css" rel="stylesheet"> 
   
  </head>
  
	<div class="span10">
	<div class="jumbotron">
		  
	<p><h2>Ladda upp kurslitteratur</h2></p>
    <form name="laddaupp" action="loadCheck.jsp" method="post">
    
    <legend>Fyll i nedan:</legend>
	<table>
	
	<tr><td><b>Titel</b></td></tr>
	<tr valign="middle"><td><input type="text" name="title" id="titlef" maxlength="64" placeholder="Titel" data-original-title="Max 64 tecken." data-placement="right" required></td></tr>
    
	<tr><td><b>Författare</b></td></tr>
    <tr valign="middle"><td><input type="text"  name="author" id="authorf" placeholder="Författare" data-original-title="Flera författare kan anges. Separera namnen med semikolon (;)" data-placement="right" required></td></tr>
    
	<tr><td><b>Utgivningsår</b></td></tr>
    <tr valign="middle"><td><input type="text" name="bookYear" id="datef" maxlength="4" placeholder="ÅÅÅÅ" data-original-title="Ange året då boken publicerades" data-placement="right" required></td></tr>
    
	<tr><td><b>ISBN 10</b></td></tr>
    <tr valign="middle"><td><input type="text" name="isbn10" id="ISBN10f" maxlength="10" placeholder="XXXXXXXXXX" data-original-title="10 siffror" data-placement="right"></td></tr>
   
	<tr><td><b>ISBN 13</b></td></tr>
    <tr valign="middle"><td><input type="text" name="isbn13" id="ISBN13f" maxlength="13" placeholder="XXXXXXXXXXXXX" data-original-title="13 siffror" data-placement="right"></td></tr>
	
	<tr><td><b>Kategori:</b></td></tr>
	<tr><td>
	<select name="cat" id="cat">
		<% while( rs2.next() ){%>
			<option value = "<%= rs2.getString("lit_cat_name") %>"><%= rs2.getString("lit_cat_name") %></option>
		<%}%>
	</select>
	</td></tr>
	
	<tr><td><b>Baksidestext</b></td></tr>
	
	<tr><td><TEXTAREA name="infoText" id="infof" ROWS="8" maxlength="500" style="resize:none; width:350px" data-original-title="Max 500 tecken." data-placement="right">Skriv in text</TEXTAREA></td></tr>
	
	<tr><td>
    <button type="submit" class="btn btn-success">Fortsätt</button>
    <button type="reset" class="btn btn-primary">Rensa</button>
	</td>
	</tr>
	</table>
	</form>		
    
    </div>


	<%
        if(pst1!=null) pst1.close();
        if(rs1!=null) rs1.close();
		if(pst2!=null) pst2.close();
        if(rs2!=null) rs2.close();
        if(c1!=null) c1.close();
        %>
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
		$("#titlef").tooltip();
		$("#authorf").tooltip();  
		$("#datef").tooltip();  
		$("#ISBN10f").tooltip(); 
		$("#ISBN13f").tooltip();  
		$("#infof").tooltip(); 
	});  
	</script>
	<script src="js/jquery.min.js"></script>
	<script src="js/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
		
    </body>
    </html>