<%@include file="Masterpage.jsp" %>

<!DOCTYPE html>
<html lang="sv">

        <% 
        java.sql.ResultSet rs2,rs3;
        java.sql.PreparedStatement pst2,pst3;

		pst2 = null;
		pst3 = null;

		rs2 = null;
		rs3 = null;
		
		String frB = (String)request.getParameter("t");
		String ch = (String)request.getParameter("ch");
		String user = (String)request.getParameter("user");
		String sch = (String)request.getParameter("sch");
		String lookFor = "";
		String sq2 = "";
		
		if(ch!=null){
			if(ch.equals("user")){
				lookFor = (String)request.getParameter("search");
				sq2 = "SELECT * FROM book_user WHERE user_user_name LIKE ? ORDER BY user_user_name";
				pst2 = c1.prepareStatement(sq2);
				pst2.setString(1, "%" + lookFor + "%");
				rs2 = pst2.executeQuery();
			}
			else if(ch.equals("school")){
				lookFor = (String)request.getParameter("sch");
				sq2 = "SELECT * FROM book_user INNER JOIN book_user_school ON book_user.user_uid=book_user_school.usho_uid WHERE book_user_school.usho_school_name LIKE ? ORDER BY book_user.user_user_name";
				pst2 = c1.prepareStatement(sq2);
				pst2.setString(1, "%" + lookFor + "%");
				rs2 = pst2.executeQuery();
			}
		}
		else{
			response.sendRedirect("bookList.jsp");
		}
		
		Integer startAtUser = 0;
		Integer shownCnt = 0;
		
		if(frB!=null){
			startAtUser = Integer.parseInt(frB);
		}

        %> 


  <head>
    <title>Sök användare</title>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
    <link href="bootstrap-responsive.css" rel="stylesheet" media="screen">
  </head>
  
		  
<div class="span8">
		<div class="jumbotron">
			<h2>Sökresultat</h2> 
		</div>
<div class="well well-small">

<table class="table table-striped">


<%
	if(rs2.next()){
		rs2.beforeFirst();
		
		for(int y=0;y<startAtUser;y++){
			rs2.next();
		}
		while(rs2.next()){
		
			String sq3 = "SELECT usho_school_name FROM book_user_school WHERE usho_uid= ?";
			pst3 = c1.prepareStatement(sq3);
			pst3.setString(1, rs2.getString("user_uid"));
			rs3 = pst3.executeQuery();
			rs3.next();
			
		
%> 
<!-- Användare börjar //-->
<div class="media">
	<a class="pull-left" href="#">
	<% if(rs2.getString("user_picture") == null) { %> 
	<img class="media-object" style="height:100px;" src="img/sil.png"> 
	<% } else { %> 
	<img class="media-object" style="height:100px;" src="displayprofilepic.jsp?id=<%=rs2.getString("user_uid")%>">	
	<% } %> 
	</a>
		<div class="media-body">
			<a href="otheruser.jsp?id=<%=rs2.getString("user_uid")%>"> <h5 class"media-heading" ><%= rs2.getString("user_user_name") %> </h5></a>
			<%= rs3.getString("usho_school_name") %><br>
			<b>Medlem sedan:</b> <% String crcr = rs2.getString("user_registered"); crcr = crcr.substring(0,10); out.print(crcr);%>
		</div>
	</div>
<hr>
<!-- Användare slutar //-->
<% 	shownCnt++;
	if(shownCnt==5)
		break;
}
}else{
	%><tr><td><h5>Det finns inga användare som matchar dina kriterier.</h5></td></tr><%
}%>	




<!-- Visningsalternativ //-->

<tr>

<td colspan="2" class="text-center">
<a href="userSearch.jsp">< Ny sökning</a>
<%if(startAtUser>1){%>
<a href="userResult.jsp?search=<%=user%>&ch=<%=ch%>&sch=<%=sch%>&t=<%=startAtUser-5%>">Bakåt</a>  <%}%>
<b><%= startAtUser+1 %> - <%= startAtUser+5 %></b>
<%if(rs2.next()){%><a href="userResult.jsp?user=<%=user%>&ch=<%=ch%>&sch=<%=sch%>&t=<%= startAtUser+5 %>">Framåt</a><%}%>
</td>
</tr>

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
