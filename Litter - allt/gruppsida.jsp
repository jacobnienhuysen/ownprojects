

<!DOCTYPE html>

<%@include file="Masterpage.jsp" %>

<html lang="sv">




        <% 

        
        java.sql.ResultSet rs2,rs3,rs4,rs5,rs6;

        java.sql.PreparedStatement pst2,pst3,pst4,pst5,pst6;

		pst2 = null;
		pst3 = null;
		pst4 = null;
		pst5 = null;
		pst6 = null;

		rs2 = null;
		rs3 = null;
		rs4 = null;
		rs5 = null;
		rs6 = null;

        String sq2 = "SELECT * FROM book_circle WHERE crcl_owner_uid=? ORDER BY crcl_created ASC";
		pst2 = c1.prepareStatement(sq2);
		pst2.setString(1, un);
		rs2 = pst2.executeQuery();
		
		String sq3 = "SELECT * FROM book_circle INNER JOIN book_user_circle ON book_circle.crcl_cid=book_user_circle.ucrl_circle_cid WHERE ucrl_uid= ? AND NOT book_circle.crcl_owner_uid= ? ORDER BY ucrl_joined ASC";
		pst3 = c1.prepareStatement(sq3);
		pst3.setString(1, un);
		pst3.setString(2, un);
		rs3 = pst3.executeQuery();

		rs3.next();

        %> 


<html>
  <head>
    <title>Mina cirklar</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
   <link href="bootstrap-responsive.css" rel="stylesheet"> 
  </head>
  

   
		  
<div class="span5">
		<div class="jumbotron">
			<h2>Cirklar jag har startat:</h2> 
		</div>
<div class="well well-small">

<table class="table table-striped">


<%
	if(!rs2.next()){
		%><tr><td><li>Du har inte startat några cirklar. Ta chansen nu!</li></td></tr><%
	}else{
		rs2.beforeFirst();
		while( rs2.next() ){
			String sq5 = "SELECT * FROM book_user_circle WHERE ucrl_circle_cid= ?";
			pst5 = c1.prepareStatement(sq5);
			pst5.setString(1, rs2.getString("crcl_cid"));
			rs5 = pst5.executeQuery();
				int membAnt = 0;
			while(rs5.next()){
				membAnt++;
		}
%> 
<!-- Grupp börjar //-->
<tr>
	<td width="130"><img src="<%if(rs2.getString("crcl_picture")==null){ out.print("img/CROWD.jpg"); } else { out.print("displaycircpic.jsp?cid="+rs2.getString("crcl_cid")); } %>" width="125"></td>
	<td><a href="cirkelprofil.jsp?id=<%=rs2.getString("crcl_cid")%>"> <h5><%= rs2.getString("crcl_name") %> </a></h5>
	<b>Startad:</b> <% String crcr = rs2.getString("crcl_created"); crcr = crcr.substring(0,10); out.print(crcr);%><br>
	<b>Antal medlemmar:</b> <%= membAnt %></td>
</tr>


<!-- Grupp slutar //-->
<% }
}%>	
</table>
</div>


	<div class="jumbotron">
		<h2>Cirklar jag är medlem i:</h2> 
	</div>
<div class="well well-small">

<table class="table table-striped">
<%
	if(!rs3.next()){
		%><tr><td><li>Du har inte medlem i några cirklar. </li></td></tr><%
	}else{
		rs3.beforeFirst();
		while( rs3.next() ){
			String sq4 = "SELECT * FROM book_user INNER JOIN book_circle ON book_circle.crcl_owner_uid=book_user.user_uid INNER JOIN book_user_circle ON book_user_circle.ucrl_circle_cid=book_circle.crcl_cid WHERE ucrl_uid= ? AND crcl_cid= ?";
			pst4 = c1.prepareStatement(sq4);
			pst4.setString(1, un);
			pst4.setString(2, rs3.getString("crcl_cid"));
			rs4 = pst4.executeQuery();
			rs4.next();
			
			String sq6 = "SELECT * FROM book_user_circle WHERE ucrl_circle_cid= ?";
			pst6 = c1.prepareStatement(sq6);
			pst6.setString(1, rs3.getString("crcl_cid"));
			rs6 = pst6.executeQuery();
				int membAnt = 0;
			while(rs6.next()){
				membAnt++;
		}
			
			
			
%> 
<!-- Grupp börjar //-->
<tr>
	<td width="130"><img src="<%if(rs3.getString("crcl_picture")==null){ out.print("img/CROWD.jpg");} else{ out.print("displaycircpic.jsp?cid="+rs3.getString("crcl_cid"));} %>" width="125"></td>
	<td><a href="cirkelprofil.jsp?id=<%=rs3.getString("crcl_cid")%>" ><h5><%= rs3.getString("crcl_name") %> </a></h5>
	<b>Startad av:</b><a href="otheruser.jsp?id=<%=rs4.getString("user_uid")%>"> <%= rs4.getString("user_user_name")%></a><br>
	<b>Gick med:</b> <% String crjd = rs3.getString("ucrl_joined"); crjd = crjd.substring(0,10); out.print(crjd);%><br>
	<b>Antal medlemmar:</b> <%= membAnt %> </td>
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

if(pst4!=null) pst4.close();
if(rs4!=null) rs4.close();

if(pst5!=null) pst5.close();
if(rs5!=null) rs5.close();

if(pst6!=null) pst6.close();
if(rs6!=null) rs6.close();

if(c1!=null) c1.close();
%>

  
  
  

  
 <!-- Le javascript
    ================================================== -->
   <!-- Placed at the end of the document so the pages load faster --> 

  
</html> 
  