<%@include file="Masterpage.jsp" %>

<!DOCTYPE html>
<html lang="sv">

        <% 
		
		
		String cid = request.getParameter("cid");
		
		Boolean adminView = false;
		
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
		
		String sq2 = "SELECT * FROM book_user INNER JOIN book_user_circle ON book_user.user_uid=book_user_circle.ucrl_uid WHERE book_user_circle.ucrl_circle_cid = ? ORDER BY book_user_circle.ucrl_joined DESC";
		pst2 = c1.prepareStatement(sq2);
		pst2.setString(1, cid);
		rs2 = pst2.executeQuery();
		
		String sq3 = "SELECT * FROM book_circle WHERE crcl_cid= ?";
		pst3 = c1.prepareStatement(sq3);
		pst3.setString(1, cid);
		rs3 = pst3.executeQuery();
		rs3.next();
		
		String adminId = rs3.getString("crcl_owner_uid");
		
		String sq4 = "SELECT * FROM book_user WHERE user_uid= ?";
		pst4 = c1.prepareStatement(sq4);
		pst4.setString(1, adminId);
		rs4 = pst4.executeQuery();
		rs4.next();
		
		String adminUn = rs4.getString("user_user_name");
		
		if(un.equals(adminId)){
		adminView = true;
		}
		
		String sq5 = "SELECT * FROM book_user WHERE NOT EXISTS (SELECT * FROM book_user_circle WHERE book_user.user_uid=book_user_circle.ucrl_uid AND book_user_circle.ucrl_circle_cid=?) ORDER BY book_user.user_user_name";
		pst5 = c1.prepareStatement(sq5);
		pst5.setString(1, cid);
		rs5 = pst5.executeQuery();
		
        %> 


  <head>
    <title>AnvÃ¤ndare</title>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
    <link href="bootstrap-responsive.css" rel="stylesheet" media="screen">
	
	<script language="javascript">
	<!--
		function kick(pid,pnm){
			
			var val= confirm("Vill du verkligen kasta ut "+pnm+"?");
				if(val==true){
				window.location="kickUserCircle.jsp?uid="+pid+"&cid=<%= cid %>";
				}
		}
		
		
	//-->
	</script>
	
  </head>
  
   
		  
<div class="span5">
		<div class="jumbotron">
			<h2>Administrera <a href="cirkelprofil.jsp?id=<%= cid %>" ><%= rs3.getString("crcl_name") %></a>:</h2> 
		</div>
<div class="well well-small">

<h4>Cirkeladministrat&ouml;r: <a href="otheruser.jsp?id=<%= adminId %>" > <%= adminUn %> </a></h4> 
<hr>
<h5>Medlemmar:</h5> 
<%
	while( rs2.next() ){		
%> 

<%  
	if(!rs2.getString("user_uid").equals(adminId)){%>
		<a href="javascript:kick(<%= rs2.getString("user_uid")%>,'<%= rs2.getString("user_user_name") %>')" class="badge badge-important" alt="Kasta ut" title="Kasta ut">X</a>
		<a href="otheruser.jsp?id=<%= rs2.getString("user_uid") %>"> <%= rs2.getString("user_user_name") %></a>  <br>

<% }
}%>	

<hr>
<h5>Byt namn:</h5> 
<form method="post" action="updateCircle.jsp?cid=<%= cid %>&do=1">
	<input type="text" name="name" id="namef" placeholder="Cirkelnamn" value="<%= rs3.getString("crcl_name") %>" maxlength="50" required><br>
<input type="submit" value="Spara" class="btn btn-primary">
</form>

<hr>
<h5>&Auml;ndra presentation:</h5> 
<form method="post" action="updateCircle.jsp?cid=<%= cid %>&do=2">
	<TEXTAREA name="info" id="infof" ROWS="6" maxlength="250" style="resize:none; width:250px" data-original-title="Max 200 tecken." data-placement="right" required><%= rs3.getString("crcl_info_text") %></TEXTAREA><br>
<input type="submit" value="Spara" class="btn btn-primary">
</form>

<hr>
<h5>Ladda upp cirkelprofilbild:</h5> 
<form method="post" action="CirclePicServlet?cid=<%= cid %>" enctype="multipart/form-data">
	<input type="file" name="photo" id="photo" accept="image/*" required><br>
<input type="submit" value="Ladda upp" class="btn btn-primary">
</form>

<hr>
<h5>Bjud in anv&auml;ndare:</h5> 
<% 
String body = adminUn + " har bjudit in dig till cirkeln " + rs3.getString("crcl_name") + " pÃ¥ MyLitter.se";
String redirect = "GroupAdmin.jsp?cid="+cid+"";
%>
<form method="post" action="cirInvite.jsp?body=<%= body %>&redirect=<%= redirect %>">
	<select name="friend"  >
		<%while( rs5.next() ){%>
			
			<option value = "<%= rs5.getString("user_uid") %>"><%= rs5.getString("user_user_name") %></option>
		<%}%>
	</select>
<input type="submit" value="Skicka inbjudan" class="btn btn-primary">
</form>

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
