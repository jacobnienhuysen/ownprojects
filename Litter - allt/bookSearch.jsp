<%@include file="Masterpage.jsp" %>

<!DOCTYPE html>
<html lang="sv">

<%
    java.sql.PreparedStatement pst2;
	pst2 = null;
	java.sql.ResultSet rs2;
	rs2 = null;
    
	
	String sq2 = "SELECT * FROM book_literature_category ORDER BY lit_cat_name";
    pst2 = c1.prepareStatement(sq2);
    rs2 = pst2.executeQuery();

%>


  <head>
    <title>Alla böcker</title>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
    <link href="bootstrap-responsive.css" rel="stylesheet" media="screen">
  </head>
  
    
		  
<div class="span8">
		<div class="jumbotron">
			<h2>Sök bok</h2> 
		</div>
<div class="well well-small">

<table width="75%" class="table table-striped">


<form action="searchResult.jsp" method="get">
<tr>
	<td><label class="radio"><input type="radio" value="title" name="ch" checked="checked">Titel</label>
	<label class="radio"><input type="radio" value="author" name="ch">Författare</label></td>
	<td valign="top"><input type="text" name="search" id="search" maxlength="64" placeholder="Sökord"></td>
</tr>
<tr>
	<td><label class="radio"><input type="radio" value="category" name="ch">Kategori</label></td>
	<td>
	<select name="cat" id="cat">
		<% while( rs2.next() ){%>
			<option value = "<%= rs2.getString("lit_cat_name") %>"><%= rs2.getString("lit_cat_name") %></option>
		<%}%>
	</select>
	</td>
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

if(pst2!=null) pst2.close();
if(rs2!=null) rs2.close();

if(c1!=null) c1.close();
%>
