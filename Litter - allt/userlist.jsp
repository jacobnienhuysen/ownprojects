<%@include file="Masterpage.jsp" %>

<!DOCTYPE html>
<html lang="en">




        <% 

        
        java.sql.Statement s1,s2,s3;
        java.sql.ResultSet rs2,rs3;

        java.sql.PreparedStatement pst2,pst3;

        s1 =null;
		s2 = null;
		s3 = null;

		pst2 = null;
		pst3 = null;

		rs2 = null;
		rs3 = null;

        
		String sq2 = "SELECT * FROM book_user_school WHERE usho_uid='"+un+"'";
		String sq3 = "SELECT * FROM book_user ORDER BY user_user_name";
		
       
		pst2 = c1.prepareStatement(sq2);
		pst3 = c1.prepareStatement(sq3);

       
		rs2 = pst2.executeQuery();
		rs3 = pst3.executeQuery();
		
		
		rs2.next();
		rs3.next();

        %> 


  <head>
    <title>Användare</title>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
    <link href="bootstrap-responsive.css" rel="stylesheet" media="screen">
  </head>
  
   
		  
<div class="span7">
		<div class="jumbotron">
			<h2>Litters användare:</h2> 
		</div>
<div class="well">

<%
	if(!rs3.next()){
		%><li>Det finns inga användare</li><%
	}else{
		rs3.beforeFirst();
		while( rs3.next() ){
		
%> 
<!-- Användare börjar //-->
<div class="media">
	<a class="pull-left" href="#">
	<% if(rs3.getString("user_picture") == null) { %> 
	<img class="media-object" style="height:100px;" src="img/sil.png"> 
	<% } else { %> 
	<img class="media-object" style="height:100px;" src="displayprofilepic.jsp?id=<%=rs3.getString("user_uid")%>">	
	<% } %> 
	</a>
		<div class="media-body">
			<a href="otheruser.jsp?id=<%=rs3.getString("user_uid")%>"> <h5 class"media-heading" ><%= rs3.getString("user_user_name") %> </h5></a>
			<b>Medlem sedan:</b> <% String crcr = rs3.getString("user_registered"); crcr = crcr.substring(0,10); out.print(crcr);%>
		</div>
	</div>
<hr>
<!-- Användare slutar //-->

<% }
}%>	
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
