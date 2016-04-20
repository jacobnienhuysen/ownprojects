<%@include file="Masterpage.jsp" %>

<% 
	java.sql.ResultSet rs2 = null;

    java.sql.PreparedStatement pst2 = null;
	
	String lid =(String)request.getParameter("id");
	
	String sq2 = "SELECT * FROM book_literature WHERE lit_lid= ?";
	pst2 = c1.prepareStatement(sq2);
	pst2.setString(1, lid);
	rs2 = pst2.executeQuery();
	rs2.next();

%>

<!DOCTYPE html>
<html lang="en">


  <head>
    <title>Ladda upp kurslitteratur</title>
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


<h4><%= rs2.getString("lit_title") %></h4>

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
<%
	if(c1!=null) c1.close();	
	if(rs1!=null) rs1.close();
	if(rs2!=null) rs2.close();
	if(pst1!=null) pst1.close();
	if(pst2!=null) pst2.close();
	%>
