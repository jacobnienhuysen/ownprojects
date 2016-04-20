<%@include file="Masterpage.jsp" %>
<!DOCTYPE html>
<html lang=s>

        <% 

        

        java.sql.ResultSet rs2,rs3,rs4,rs5;

        java.sql.PreparedStatement pst2,pst3,pst4,pst5;
		
		pst2 = null;
	
		rs2 = null;
		
		String lit = (String)request.getParameter("lid");
        
		String sq2 = "SELECT * FROM book_literature_discussion WHERE ldis_lid = '"+lit+"'";
		String sq3 = "SELECT * FROM book_literature WHERE lit_lid='"+lit+"'";
		pst2 = c1.prepareStatement(sq2);
		pst3 = c1.prepareStatement(sq3);
		rs2 = pst2.executeQuery();
		rs3 = pst3.executeQuery();
		
		rs3.next();
		
		%>
  <head>
    <title>Bokdiskussioner</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
    <link href="bootstrap-responsive.min.css" rel="stylesheet" media="screen">
  </head>
  
    
    
<div class="span5">
		<div class="jumbotron">
			<h2>Diskussioner om "<a href="bokprofilsida.jsp?lid=<%= lit %>"><%=rs3.getString("lit_title") %></a>"</h2>
		</div>
<div class="well well-small">

<%if(!rs2.next()){%>
	<table border="0" width="100%">
		<tr>
			<th>Det finns inga diskussioner</th>
			<td align="center" valign="top"><a href="newDisc.jsp?lid=<%= lit %>" class="btn btn-primary">Ny diskussion</a></td>
		</tr>
	</table>

<%}else{
	rs2.beforeFirst();%>
	<table border="0" width="100%">
		<tr>
			<th>Pågående diskussioner:</th>
			<td align="center" valign="top" rowspan="2"><a href="newDisc.jsp?lid=<%= lit %>" class="btn btn-primary">Ny diskussion</a></td>
		</tr>
	
		<tr>
			<td>
				<table class="table table-striped" border="0">
					<tr>
						<td rowspan="2">
						<% while( rs2.next() ){%>
						<li><a href="litchat.jsp?did=<%= rs2.getString("ldis_did") %>"><%= rs2.getString("ldis_topic") %></a></li>
						<%}%>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
<%}%>



</div>
	


 
<div class="footer">
&copy; PVT Grupp 10 
</div>  
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
		if(pst3!=null) pst3.close();
        if(rs3!=null) rs3.close();
		if(c1!=null) c1.close();
%>


</html>