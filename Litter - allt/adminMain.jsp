<%@include file="Masterpage.jsp" %>

<!DOCTYPE html>
<html lang="sv">

        <% 
		
		String err = (String)request.getParameter("id");
		
        java.sql.ResultSet rs2, rs3, rs4, rs5;

        java.sql.PreparedStatement pst2, pst3, pst4, pst5;

		pst2 = null;
		pst3 = null;
		pst4 = null;
		pst5 = null;
		
		rs2 = null;
		rs3 = null;
		rs4 = null;
		rs5 = null;
		
		String sq2 = "SELECT * FROM book_user WHERE user_uid= ?";
		pst2 = c1.prepareStatement(sq2);
		pst2.setString(1, un);
		rs2 = pst2.executeQuery();
		rs2.next();
		
		String sq3 = "SELECT * FROM book_user WHERE NOT user_uid= ?";
		pst3 = c1.prepareStatement(sq3);
		pst3.setString(1, un);
		rs3 = pst3.executeQuery();
		
		String sq4 = "SELECT * FROM book_literature";
		pst4 = c1.prepareStatement(sq4);
		rs4 = pst4.executeQuery();
		
		String sq5 = "SELECT * FROM book_circle";
		pst5 = c1.prepareStatement(sq5);
		rs5 = pst5.executeQuery();
		
        %> 


  <head>
    <title>MyLitter Admin</title>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
    <link href="bootstrap-responsive.css" rel="stylesheet" media="screen">
	
	<script language="javascript">
	<!--
		function kickUser(){
			var e = document.getElementById("user");
			var user = e.options[e.selectedIndex].text;
			var uid = e.options[e.selectedIndex].value;
			var val = confirm("Radera användaren ''" + user + "''?\nÅtgärden kan inte ångras.");
			
			if(val==true){
				window.location="adminAction.jsp?ac=us&id="+uid;
			}
		}

		function kickBook(){
			var e = document.getElementById("book");
			var book = e.options[e.selectedIndex].text;
			var lid = e.options[e.selectedIndex].value;
			var val = confirm("Radera boken ''" + book + "''?\nÅtgärden kan inte ångras.");
			
			if(val==true){
				window.location="adminAction.jsp?ac=bo&id="+lid;
			}
		}

		function kickCirc(){
			var e = document.getElementById("circ");
			var circ = e.options[e.selectedIndex].text;
			var cid = e.options[e.selectedIndex].value;
			var val = confirm("Radera cirkeln ''" + circ + "''?\nÅtgärden kan inte ångras.");
			
			if(val==true){
				window.location="adminAction.jsp?ac=ci&id="+cid;
			}
		}		
		
	//-->
	</script>
	
  </head>
  
   
		  
<div class="span8">
		<div class="jumbotron">
			<h2>MyLitter Admin</h2> 
		</div>
<div class="well well-small">

<legend>Administratör: <%= rs2.getString("user_user_name")%></legend>

<label>Användare</label>
<form class="form-horizontal">
	<select name="user" id="user">
		<% while( rs3.next() ){%>
			<option value = "<% Integer uid = (Integer.parseInt(rs3.getString("user_uid"))+1)*7; out.print(uid); %>"><%= rs3.getString("user_user_name") %></option>
		<%}%>
	</select>
	<input type="button" class="btn btn-primary" value="Detaljer" onClick="showUser()">
	<input type="button" class="btn btn-danger" value="Ta bort" onClick="kickUser()">
</form>

<%if(err == null){
	%><%
}else if(err.equals("1")){
	%><b class="alert alert-success">Användaren har raderats.</b><%
}%>

<hr>

<label>Böcker</label>
<form class="form-horizontal">
	<select name="book" id="book">
		<% while( rs4.next() ){%>
			<option value = "<% Integer lid = (Integer.parseInt(rs4.getString("lit_lid"))+1)*7; out.print(lid);%>"><%= rs4.getString("lit_title") %></option>
		<%}%>
	</select>
	<input type="button" class="btn btn-primary" value="Detaljer" onClick="showBook()">
	<input type="button" class="btn btn-danger" value="Ta bort" onClick="kickBook()">
</form>

<%if(err == null){
	%><%
}else if(err.equals("2")){
	%><b class="alert alert-success">Boken har raderats.</b><%
}%>

<hr>

<label>Cirklar</label>
<form class="form-horizontal">
	<select name="circ" id="circ">
		<% while( rs5.next() ){%>
			<option value = "<% Integer cid = (Integer.parseInt(rs5.getString("crcl_cid"))+1)*7; out.print(cid); %>"><%= rs5.getString("crcl_name") %></option>
		<%}%>
	</select>
	<input type="button" class="btn btn-primary" value="Detaljer" onClick="showCirc()">
	<input type="button" class="btn btn-danger" value="Ta bort" onClick="kickCirc()">
</form>

<%if(err == null){
	%><%
}else if(err.equals("3")){
	%><b class="alert alert-success">Cirkeln har raderats.</b><%
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

if(pst4!=null) pst4.close();
if(rs4!=null) rs4.close();

if(pst5!=null) pst5.close();
if(rs5!=null) rs5.close();
/*
if(pst6!=null) pst6.close();
if(rs6!=null) rs6.close();
*/
if(c1!=null) c1.close();
%>
