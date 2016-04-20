<%@include file="Masterpage.jsp" %>

<!DOCTYPE html>
<html lang="sv">

        <% 
        java.sql.ResultSet rs2,rs3,rs4;
        java.sql.PreparedStatement pst2,pst3,pst4;

		pst2 = null;
		pst3 = null;
		pst4 = null;

		rs2 = null;
		rs3 = null;
		rs4 = null;
		
		String frB = (String)request.getParameter("t");
		String ch = (String)request.getParameter("ch");
		String search = (String)request.getParameter("search");
		String lookFor = "";
		String sq2 = "";
		
		if(ch!=null){
			if(ch.equals("cname")){
				lookFor = (String)request.getParameter("search");
				sq2 = "SELECT * FROM book_circle WHERE crcl_name LIKE ? ORDER BY crcl_name";
				pst2 = c1.prepareStatement(sq2);
				pst2.setString(1, "%" + lookFor + "%");
				rs2 = pst2.executeQuery();
			}
			else if(ch.equals("ccreator")){
				lookFor = (String)request.getParameter("search");
				sq2 = "SELECT * FROM book_circle INNER JOIN book_user ON book_circle.crcl_owner_uid=book_user.user_uid WHERE book_user.user_user_name LIKE ? ORDER BY book_circle.crcl_name";
				pst2 = c1.prepareStatement(sq2);
				pst2.setString(1, "%" + lookFor + "%");
				rs2 = pst2.executeQuery();
			}
		}
		else{
			response.sendRedirect("circSearch.jsp");
		}
		
		Integer startAtCirc = 0;
		Integer shownCnt = 0;
		
		if(frB!=null){
			startAtCirc = Integer.parseInt(frB);
		}

        %> 


  <head>
    <title>Sök böcker</title>
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
		
		for(int y=0;y<startAtCirc;y++){
			rs2.next();
		}
		rs2.beforeFirst();
		while( rs2.next() ){
			String sq3 = "SELECT * FROM book_user WHERE user_uid= ?";
			pst3 = c1.prepareStatement(sq3);
			pst3.setString(1, rs2.getString("crcl_owner_uid"));
			rs3 = pst3.executeQuery();
			
			String sq4 = "SELECT * FROM book_user_circle WHERE ucrl_circle_cid= ?";
			pst4 = c1.prepareStatement(sq4);
			pst4.setString(1, rs2.getString("crcl_cid"));
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
<% 	shownCnt++;
	if(shownCnt==5)
		break;
}
}else{
	%><tr><td><h5>Det finns inga circklar som matchar dina kriterier.</h5></td></tr><%
}%>	




<!-- Visningsalternativ //-->

<tr>

<td colspan="2" class="text-center">
<a href="circSearch.jsp">< Ny sökning</a>
<%if(startAtCirc>1){%>
<a href="circResult.jsp?search=<%=search%>&ch=<%=ch%>&t=<%=startAtCirc-5%>">Bakåt</a>  <%}%>
<b><%= startAtCirc+1 %> - <%= startAtCirc+5 %></b>
<%if(rs2.next()){%><a href="bookResult.jsp?search=<%=search%>&ch=<%=ch%>&t=<%= startAtCirc+5 %>">Framåt</a><%}%>
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
