<%@include file="Masterpage.jsp" %>

<!DOCTYPE html>

<% 

		java.sql.ResultSet rs2,rs3;

        java.sql.PreparedStatement pst2,pst3;
		
		rs2 = null;
		rs3 = null;
		
		pst2 = null;
		pst3 = null;
	
		String sq2 = "SELECT * FROM book_literature_discussion INNER JOIN book_literature_discussion_comment ON book_literature_discussion.ldis_did=book_literature_discussion_comment.lidi_ldid ORDER BY book_literature_discussion_comment.lidi_time DESC";
		String sq10 = "SELECT * FROM book_circle_discussion INNER JOIN book_circle_discussion_comment ON book_circle_discussion.cdis_did=book_circle_discussion_comment.cdic_did ORDER BY book_circle_discussion_comment.cdic_time DESC";

		
		pst2 = c1.prepareStatement(sq2);
		rs2 = pst2.executeQuery();
		
		
%>


<html>
  <head>
 
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
   <link href="bootstrap-responsive.css" rel="stylesheet"> 
 </head>
<body>

<div class="span5">
		<div class="jumbotron">
			<h2>Chattar:</h2> 
		</div>		
<div class="well well-small">
	
<h5>Aktiva Litteraturdiskussioner:</h4>
<% 
		int x=0;	
		
		ArrayList<String> litdis = new ArrayList<String>();
		
		while(rs2.next()){	
			
			String litTopic = rs2.getString("ldis_topic");
			
			if(!(litdis.contains(topic))){
				
				litdis.add(litTopic);

				String sq3 = "SELECT * FROM book_literature WHERE lit_lid ='"+rs2.getString("ldis_lid")+"'";
				
				pst3 = c1.prepareStatement(sq3);
				rs3 = pst3.executeQuery();
				rs3.next();
				
				%><li><a href="litchat.jsp?did=<%= rs2.getString("ldis_did") %>" ><%= litTopic %></a> i <a href="bokprofilsida.jsp?lid=<%= rs2.getString("ldis_lid")%>">  <%= rs3.getString("lit_title") %> </a></li><%
			
				x++;
			
				if(x==10) break;
			}
		}%>
		
<h5>Aktiva Bokcirkeldiskussioner:</h5>
<% 
		int y = 0;	
		rs10.beforeFirst();
		
		ArrayList<String> cirdis = new ArrayList<String>();
		
	
		
		while(rs10.next()){	
			
			
			String cirTopic = rs10.getString("cdis_topic");
			
			if(!(cirdis.contains(cirTopic))){
			
			String sg4 = "SELECT * FROM book_circle WHERE crcl_cid ='"+rs10.getString("cdis_cid")+"'";
			
			pst4 = c1.prepareStatement(sg4);
			rs4 = pst4.executeQuery();
			rs4.next();
			
			%><li><a href="circhat.jsp?did=<%= rs10.getString("cdis_cid") %>" ><%= stri3 %></a> i <a href="cirkelprofilsida.jsp?cid=<%= rs10.getString("cdis_cid")%>">  <%= rs9.getString("crcl_name") %> </a></li><%
		
			y++;
		
			if(y==10) break;
		    }
			
		}%>

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
		
%>
</html>