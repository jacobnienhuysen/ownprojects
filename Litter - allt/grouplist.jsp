<%@include file="Masterpage.jsp" %>

<!DOCTYPE html>
<html lang="en">




        <% 

        
        java.sql.ResultSet rs2,rs3,rs4;

        java.sql.PreparedStatement pst2,pst3,pst4;

		pst2 = null;
		pst3 = null;
		pst4 = null;

		rs2 = null;
		rs3 = null;
		rs4 = null;

        
		String sq2 = "SELECT * FROM book_circle";
		
		pst2 = c1.prepareStatement(sq2);
       
		rs2 = pst2.executeQuery();
	
	
	

        %> 


  <head>
    <title>Cirklar</title>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
    <link href="bootstrap-responsive.css" rel="stylesheet" media="screen">
  </head>
  
   
		  
<div class="span5">
		<div class="jumbotron">
			<h2>Litters cirklar:</h2> 
		</div>
<div class="well well-small">
<table class="table table-striped">


<%
	if(!rs2.next()){
		%><tr><td><li>Det finns inga cirklar. Bli först med att starta en!</li></td></tr><%
	}else{
		rs2.beforeFirst();
		while( rs2.next() ){
			String sq3 = "SELECT * FROM book_user WHERE user_uid='"+rs2.getString("crcl_owner_uid")+"'";
			String sq4 = "SELECT * FROM book_user_circle WHERE ucrl_circle_cid='"+rs2.getString("crcl_cid")+"'";
			pst3 = c1.prepareStatement(sq3);
			pst4 = c1.prepareStatement(sq4);
			rs3 = pst3.executeQuery();
			rs4 = pst4.executeQuery();
			rs3.next();
				int membAnt = 0;
			while(rs4.next()){
				membAnt++;
			}
%> 
<!-- Grupp börjar //-->
<tr>
	<td width="130"><img src="<%if(rs2.getString("crcl_picture")==null){ out.print("img/CROWD.jpg"); } else { out.print("displaycircpic.jsp?cid="+rs2.getString("crcl_cid")); } %>" width="125"></td>
	<td><a href="cirkelprofil.jsp?id=<%=rs2.getString("crcl_cid")%>"> <h5><%= rs2.getString("crcl_name") %> </a></h5>
	<b>Startad av:</b><a href="otheruser.jsp?id=<%= rs3.getString("user_uid")%>"> <%= rs3.getString("user_user_name")%></a><br>
	<b>Startad:</b> <% String crcr = rs2.getString("crcl_created"); crcr = crcr.substring(0,10); out.print(crcr);%><br>
	<b>Antal medlemmar:</b> <%= membAnt %></td>
</tr>


<!-- Grupp slutar //-->
<% }
}%>	
</table>


</div>





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

if(pst3!=null) pst3.close();
if(rs3!=null) rs3.close();

if(c1!=null) c1.close();
%>
