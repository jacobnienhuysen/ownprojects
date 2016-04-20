<!DOCTYPE html>
<html>
  <head>
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
	 
   <link href="bootstrap.css" rel="stylesheet"/>
<style>
#footerse {
    position: fixed;
    bottom: 10%;
	width: 20%;
	text-align: left;
	right: 10%;

	
  
}
</style>

</head>
<body>
<span class="hidden-phone hidden-tablet">

<% 
		
		java.sql.ResultSet rse2,rse3,rse4,rse5,rse6,rse7,rse8,rse9;

        java.sql.PreparedStatement psta2,psta3,psta4,psta5,psta6,psta7,psta8,psta9;
		
		rse2 = null;
		rse3 = null;
		rse4 = null;
		rse5 = null;
		rse6 = null;
		rse7 = null;
		rse8 = null;
		rse9 = null;
		
		psta2 = null;
		psta3 = null;
		psta4 = null;
		psta5 = null;
		psta6 = null;
		psta7 = null;
		psta8 = null;
		psta9 = null;
		
		String sql2 = "SELECT * FROM book_feed ORDER BY feed_time DESC";
		
		psta2 = c1.prepareStatement(sql2);
		rse2 = psta2.executeQuery();
		
        %> 

<div id="footerse"><div class="alert alert-success">
  <button type="button" class="close" data-dismiss="alert">&times;</button>
     		
<%	
	int in = 0;
	
	
	while(rse2.next()){
	if(in == 4) break;
	try{	
		String user = rse2.getString("feed_uid");
		
		String sql3 = "SELECT * FROM book_user WHERE user_uid = "+user+" ";
		
		psta3 = c1.prepareStatement(sql3);
		rse3 = psta3.executeQuery();
		rse3.next();
		
		String userName = rse3.getString("user_user_name");
		
		String time = rse2.getString("feed_time");
	
		
		time = time.substring(11,16);
		
		
		if(!(rse2.getString("feed_book_upload") == null)){	
			// skriv ut att anv la upp en bok
			
			String lidAdd = rse2.getString("feed_book_upload");
			
			String sql4 = "SELECT * FROM book_literature WHERE lit_lid = "+lidAdd+"";
			
			psta4 = c1.prepareStatement(sql4);
			rse4 = psta4.executeQuery();
			rse4.next();
			
			String bookNameAdd = rse4.getString("lit_title");
			
			
			
		%> 
			
		
		<%= time %>: <a href="otheruser.jsp?id=<%= user %>"> <%= userName %> </a> laddade upp boken <a href="bokprofilsida.jsp?lid=<%= lidAdd %>"> <%= bookNameAdd %></a><br>
			
		<%
		in++;
		}
		
		if(!(rse2.getString("feed_school_change") == null)){	
			// skriv ut att anv bytte skola
			
			String schoolName = rse2.getString("feed_school_change");
			
			%>
		
		<%= time %>: <a href="otheruser.jsp?id=<%= user %>"> <%= userName %> </a> började studera vid <%= schoolName %><br>
			
<%		in++;
		}
		
		if(!(rse2.getString("feed_circle_join") == null)){	
			// skriv ut att anv gick med in en cirkel
			
			String circleId = rse2.getString("feed_circle_join");
					
			String sql5 = "SELECT * FROM book_circle WHERE crcl_cid = "+circleId+"";
			
			psta5 = c1.prepareStatement(sql5);
			rse5 = psta5.executeQuery();
			rse5.next();
			
			String circleName = rse5.getString("crcl_name");
			
		%>

			<%= time %>: <a href="otheruser.jsp?id=<%= user %>"> <%= userName %> </a> gick med in gruppen <a href=" "><%= circleName %> </a><br>

		<% 
		in++;
		}
		
		if(!(rse2.getString("feed_user_follow") == null)){	
			// skriv ut att anv började följa en anv
			
			String otherUser = rse2.getString("feed_user_follow");
			
			String sql6 = "SELECT * FROM book_user WHERE user_uid = "+otherUser+" ";
			
			psta6 = c1.prepareStatement(sql6);
			rse6 = psta6.executeQuery();
			rse6.next();
	
			String otherUserName = rse6.getString("user_user_name");
			
		%>
		
			<%= time %>: <a href="otheruser.jsp?id=<%= user %>"> <%= userName %> </a> började följa <a href="otheruser.jsp?id=<%= otherUser %>"><%= otherUserName %></a><br>
		
		<%
		in++;
		}
		
		if(!(rse2.getString("feed_book_follow") == null)){	
			// skriv ut att anv började följa en bok
			
			String lidFol = rse2.getString("feed_book_follow");
			
			String sql7 = "SELECT * FROM book_literature WHERE lit_lid = "+lidFol+"";
			
			psta7 = c1.prepareStatement(sql7);
			rse7 = psta7.executeQuery();
			rse7.next();
			
			String bookNameFol = rse7.getString("lit_title");
			
			
			
		%>
		
			<%= time %>: <a href="otheruser.jsp?id=<%= user %>"> <%= userName %> </a> började följa boken <a href="bokprofilsida.jsp?lid=<%= lidFol %>"> <%= bookNameFol %> </a><br>
		
		<%
		in++;
		}	
		
		if(!(rse2.getString("feed_book_chat") == null)){	
			// skriv ut att anv skrev in en bokdiskussion
			
			String litDid = rse2.getString("feed_book_chat");
			
			String sql8 = "SELECT * FROM book_literature_discussion WHERE ldis_did = "+litDid+"";
			
			psta8 = c1.prepareStatement(sql8);
			rse8 = psta8.executeQuery();
			rse8.next();
			
			String litChatName = rse8.getString("ldis_topic");
			
		%>
		
			<%= time %>: <a href="otheruser.jsp?id=<%= user %>"> <%= userName %> </a> deltog in diskussionen <a href="litchat.jsp?did=<%= litDid %> "> <%= litChatName %> </a><br>
		
		<%
		in++;
		}
		
		if(!(rse2.getString("feed_circle_chat") == null)){	
			// skriv ut att anv skrev in en gruppdiskussion
			
			String cirDid = rse2.getString("feed_book_chat");
			
			String sql9 = "SELECT * FROM book_circle_discussion WHERE cdis_did = "+cirDid+"";
			
			psta9 = c1.prepareStatement(sql9);
			rse9 = psta9.executeQuery();
			rse9.next();
			
			String cirChatName = rse9.getString("cdis_topic");
			
		%>
		
			<%= time %>: <a href="otheruser.jsp?id=<%= user %>"> <%= userName %> </a> deltog in diskussionen <a href="circhat.jsp?did=<%= cirDid %> "> <%= cirChatName %> </a><br>
			
		<%
		in++;
		}
	
		}catch(SQLException e) {
			
		}
	} 
 %>
         

</div></div> 

</span>

<%
		
		

		if(psta2!=null) psta2.close();
        if(rse2!=null) rse2.close();
		
		if(psta3!=null) psta3.close();
        if(rse3!=null) rse3.close();
		
		if(psta4!=null) psta4.close();
        if(rse4!=null) rse4.close();
		
		if(psta5!=null) psta5.close();
        if(rse5!=null) rse5.close();
		
		if(psta6!=null) psta6.close();
        if(rse6!=null) rse6.close();
		
		if(psta7!=null) psta7.close();
        if(rse7!=null) rse7.close();
		
		if(psta8!=null) psta8.close();
        if(rse8!=null) rse8.close();
		
		if(psta9!=null) psta9.close();
        if(rse9!=null) rse9.close();
		
%>

    
    


