

<!DOCTYPE html>

<%@include file="Masterpage.jsp" %>

<html lang="sv">




        <% 

        
        java.sql.ResultSet rs2,rs3,rs4,rs5,rs6;

        java.sql.PreparedStatement pst2,pst3,pst4,pst5,pst6;

		pst2 = null;

		rs2 = null;

        String sq2 = "SELECT * FROM book_user INNER JOIN book_user_follows ON book_user.user_uid=book_user_follows.ufol_uid_followee WHERE ufol_uid_follower='"+un+"' ORDER BY book_user_follows.ufol_start_time ASC";
		
	   
		pst2 = c1.prepareStatement(sq2);
       
		rs2 = pst2.executeQuery();

        %> 


<html>
  <head>
    <title>Mina vänner</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
   <link href="bootstrap-responsive.css" rel="stylesheet"> 
  </head>
  

   
		  
<div class="span5">
		<div class="jumbotron">
			<h2>Mina vänner</h2> 
		</div>
<div class="well well-small">

<table class="table table-striped">


<%
	if(!rs2.next()){
		%><tr><td><li>Du har inga vänner</li></td></tr><%
	}else{
		rs2.beforeFirst();
		while( rs2.next() ){
		
%> 
<!-- Vän börjar //-->
<tr>
	<td width="130"><img src="<%if(rs2.getString("user_picture")==null){ out.print("img/sil.png"); } else { out.print("displayprofilepic.jsp?id="+rs2.getString("user_uid")); } %>" width="125"></td>
	<td><a href="otheruser.jsp?id=<%=rs2.getString("user_uid")%>"> <h5><%= rs2.getString("user_user_name") %> </a></h5>
	<b>Vän sedan:</b> <% String crcr = rs2.getString("ufol_start_time"); crcr = crcr.substring(0,10); out.print(crcr);%></td>
</tr>


<!-- Vän slutar //-->
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

if(c1!=null) c1.close();
%>

  
  
  

  
 <!-- Le javascript
    ================================================== -->
   <!-- Placed at the end of the document so the pages load faster --> 

  
</html> 
  