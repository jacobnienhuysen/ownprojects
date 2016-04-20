
<%@include file="Masterpage.jsp" %>

<!DOCTYPE html>

        <% 
		
		java.sql.ResultSet rs2,rs3,rs4,rs5,rs6,rs7,rs8,rs9;

        java.sql.PreparedStatement pst2,pst3,pst4,pst5,pst6,pst7,pst8,pst9;
		
		rs2 = null;
		rs3 = null;
		rs4 = null;
		rs5 = null;
		rs6 = null;
		rs7 = null;
		rs8 = null;
		rs9 = null;
		
		pst2 = null;
		pst3 = null;
		pst4 = null;
		pst5 = null;
		pst6 = null;
		pst7 = null;
		pst8 = null;
		pst9 = null;
		
		String sq2 = "SELECT * FROM book_feed ORDER BY feed_time DESC";
		
		pst2 = c1.prepareStatement(sq2);
		rs2 = pst2.executeQuery();
		
        %> 

<html>
  <head>
    <title>Aktivitetsflöde</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
   <link href="bootstrap-responsive.css" rel="stylesheet"> 
 </head>
 
 <body>
 
<div class="span5">
		<div class="jumbotron">
			<h2>Nyhetsfeed</h2> 
		</div>
		
<div class="well well-small">
		
<%	
	int i = 0;
	
	
	while(rs2.next()){
	if(i == 35) break;
	try{	
		String user = rs2.getString("feed_uid");
		
		String sq3 = "SELECT * FROM book_user WHERE user_uid = "+user+" ";
		
		pst3 = c1.prepareStatement(sq3);
		rs3 = pst3.executeQuery();
		rs3.next();
		
		String userName = rs3.getString("user_user_name");
		
		String time = rs2.getString("feed_time");
	
		
		time = time.substring(11,16);
		
		
		if(!(rs2.getString("feed_book_upload") == null)){	
			// skriv ut att anv la upp en bok
			
			String lidAdd = rs2.getString("feed_book_upload");
			
			String sq4 = "SELECT * FROM book_literature WHERE lit_lid = "+lidAdd+"";
			
			pst4 = c1.prepareStatement(sq4);
			rs4 = pst4.executeQuery();
			rs4.next();
			
			String bookNameAdd = rs4.getString("lit_title");
			
			
			
		%> 
			
		
		<%= time %>: <a href="otheruser.jsp?id=<%= user %>"> <%= userName %> </a> laddade upp boken <a href="bokprofilsida.jsp?lid=<%= lidAdd %>"> <%= bookNameAdd %></a><br>
			
		<%
		i++;
		}
		
		if(!(rs2.getString("feed_school_change") == null)){	
			// skriv ut att anv bytte skola
			
			String schoolName = rs2.getString("feed_school_change");
			
			%>
		
		<%= time %>: <a href="otheruser.jsp?id=<%= user %>"> <%= userName %> </a> började studera vid <%= schoolName %><br>
			
<%		i++;
		}
		
		if(!(rs2.getString("feed_circle_join") == null)){	
			// skriv ut att anv gick med i en cirkel
			
			String circleId = rs2.getString("feed_circle_join");
					
			String sq5 = "SELECT * FROM book_circle WHERE crcl_cid = "+circleId+"";
			
			pst5 = c1.prepareStatement(sq5);
			rs5 = pst5.executeQuery();
			rs5.next();
			
			String circleName = rs5.getString("crcl_name");
			
		%>

			<%= time %>: <a href="otheruser.jsp?id=<%= user %>"> <%= userName %> </a> gick med i gruppen <a href=" "><%= circleName %> </a><br>

		<% 
		i++;
		}
		
		if(!(rs2.getString("feed_user_follow") == null)){	
			// skriv ut att anv började följa en anv
			
			String otherUser = rs2.getString("feed_user_follow");
			
			String sq6 = "SELECT * FROM book_user WHERE user_uid = "+otherUser+" ";
			
			pst6 = c1.prepareStatement(sq6);
			rs6 = pst6.executeQuery();
			rs6.next();
	
			String otherUserName = rs6.getString("user_user_name");
			
		%>
		
			<%= time %>: <a href="otheruser.jsp?id=<%= user %>"> <%= userName %> </a> började följa <a href="otheruser.jsp?id=<%= otherUser %>"><%= otherUserName %></a><br>
		
		<%
		i++;
		}
		
		if(!(rs2.getString("feed_book_follow") == null)){	
			// skriv ut att anv började följa en bok
			
			String lidFol = rs2.getString("feed_book_follow");
			
			String sq7 = "SELECT * FROM book_literature WHERE lit_lid = "+lidFol+"";
			
			pst7 = c1.prepareStatement(sq7);
			rs7 = pst7.executeQuery();
			rs7.next();
			
			String bookNameFol = rs7.getString("lit_title");
			
			
			
		%>
		
			<%= time %>: <a href="otheruser.jsp?id=<%= user %>"> <%= userName %> </a> började följa boken <a href="bokprofilsida.jsp?lid=<%= lidFol %>"> <%= bookNameFol %> </a><br>
		
		<%
		i++;
		}	
		
		if(!(rs2.getString("feed_book_chat") == null)){	
			// skriv ut att anv skrev i en bokdiskussion
			
			String litDid = rs2.getString("feed_book_chat");
			
			String sq8 = "SELECT * FROM book_literature_discussion WHERE ldis_did = "+litDid+"";
			
			pst8 = c1.prepareStatement(sq8);
			rs8 = pst8.executeQuery();
			rs8.next();
			
			String litChatName = rs8.getString("ldis_topic");
			
		%>
		
			<%= time %>: <a href="otheruser.jsp?id=<%= user %>"> <%= userName %> </a> deltog i diskussionen <a href="litchat.jsp?did=<%= litDid %> "> <%= litChatName %> </a><br>
		
		<%
		i++;
		}
		
		if(!(rs2.getString("feed_circle_chat") == null)){	
			// skriv ut att anv skrev i en gruppdiskussion
			
			String cirDid = rs2.getString("feed_book_chat");
			
			String sq9 = "SELECT * FROM book_circle_discussion WHERE cdis_did = "+cirDid+"";
			
			pst9 = c1.prepareStatement(sq9);
			rs9 = pst9.executeQuery();
			rs9.next();
			
			String cirChatName = rs9.getString("cdis_topic");
			
		%>
		
			<%= time %>: <a href="otheruser.jsp?id=<%= user %>"> <%= userName %> </a> deltog i diskussionen <a href="circhat.jsp?did=<%= cirDid %> "> <%= cirChatName %> </a><br>
			
		<%
		i++;
		}
	
		}catch(SQLException e) {
			
		}
	} 
 %>

</div>


<div class="footer">
	<p>&copy; PVT Grupp 10</p>
</div>  
</div>


 <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster --> 
	<script src="js/jquery.min.js"></script>
   
 <script src="js/bootstrap.min.js"></script>
</body>
<%
		
		if(c1!=null) c1.close();
		
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
		
		if(pst7!=null) pst7.close();
        if(rs7!=null) rs7.close();
		
		if(pst8!=null) pst8.close();
        if(rs8!=null) rs8.close();
		
		if(pst9!=null) pst9.close();
        if(rs9!=null) rs9.close();
		
%>
</html>