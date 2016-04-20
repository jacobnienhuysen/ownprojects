<%@include file="Masterpage.jsp" %>

<!DOCTYPE html>
<html lang=s>

        <% 

        java.sql.Statement s3,s4,s5,s6;

        java.sql.ResultSet rs3,rs4,rs5,rs6;

        java.sql.PreparedStatement pst3,pst4,pst5,pst6;
      
		s3 = null;
		s4 = null;
		s5 = null;
		s6 = null;
		
		pst3 = null;
		pst4 = null;
		pst5 = null;
		pst6 = null;
	
		rs3 = null;
		rs4 = null;
		rs5 = null;
		rs6 = null;
		
		String did = (String)request.getParameter("did");
        
		String sq3 = "SELECT * FROM book_literature_discussion WHERE ldis_did = '"+did+"'";
		

		pst3 = c1.prepareStatement(sq3);
		rs3 = pst3.executeQuery();
		rs3.next();
		
		String lit = rs3.getString("ldis_lid");
		
		String sq4 = "SELECT * FROM book_literature WHERE lit_lid = '"+lit+"'";
        pst4 = c1.prepareStatement(sq4);
		rs4 = pst4.executeQuery();
		rs4.next();
		
		
		String sq5 = "SELECT * FROM book_literature_discussion_comment WHERE lidi_ldid = '"+did+"' ORDER BY lidi_time ASC";
		
		pst5 = c1.prepareStatement(sq5);
		rs5 = pst5.executeQuery();
		
	
		List<String> litComments = new ArrayList<String>();
		List<String> litWriter = new ArrayList<String>();		
		List<String> litComTime = new ArrayList<String>();
		
		if(!litComments.isEmpty()){
			litComments.clear();
		}
		if(!litWriter.isEmpty()){
		litWriter.clear();
		}
		if(!litComTime.isEmpty()){
		litComTime.clear();
		}
		
		while(rs5.next()){
			litComments.add(rs5.getString("lidi_text"));
			litWriter.add(rs5.getString("lidi_uid"));
			litComTime.add(rs5.getString("lidi_time"));
		}
		
		Collections.reverse(litComments);
		Collections.reverse(litWriter);
		Collections.reverse(litComTime);
		
		String pubYear = rs4.getString("lit_published");	
		pubYear = pubYear.substring(0,4);
		
		%>
  <head>
    <title>Chat</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
    <link href="bootstrap-responsive.min.css" rel="stylesheet" media="screen">
  </head>
  
    
    
<div id="myModal7" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
    <h3 id="myModalLabel">Skriv en kommentar:</h3>
  </div>
  <div class="modal-body">
		<form action="addcomment.jsp?&fn=<%=rs1.getString("user_uid")%>&did=<%= did %>" method="post" >
		<textarea rows="10" cols="50" style="width: 95%; height:100%;" id="com" name="com" placeholder="Skriv din kommentar"></textarea>
  </div>
   <div class="modal-footer">
    <a class="btn" data-dismiss="modal" aria-hidden="true">Stäng</a>
    <button class="btn btn-primary" type="submit">Skicka</button>
	</form>
  </div>
  </div>
	
<div class="span6">

<div class="jumbotron">
		<h2>Bok: <a href="bokprofilsida.jsp?lid=<%= rs4.getString("lit_lid")%>"> <%= rs4.getString("lit_title")%> (<%= pubYear %>) </a></h2>
		<h3>Tråd: <%= rs3.getString("ldis_topic")%></h3>
</div> 
		<a href="#myModal7" data-toggle="modal" ><input type="button" value="Skriv en kommentar"></a> 
<br>	
<br>
<% 
if(!litComments.isEmpty()){
	int x = 0;

		for(String str : litComments){
			
			String writer = litWriter.get(x);
			String comTime = litComTime.get(x);
			
			String sq6 = "SELECT * FROM book_user WHERE user_uid = '"+writer+"'";
			pst6 = c1.prepareStatement(sq6);
			rs6 = pst6.executeQuery();
			rs6.next();
			
			comTime = comTime.substring(0,16);
			
			
			%> 	
			<div class = "well">
			<%= comTime %> <a href = "otheruser.jsp?id=<%= writer %>"> <%= rs6.getString("user_user_name") %></a> <br>
			<div>
	
			- <%=  str  %> 
			
			</div>
			</div>
			<% 
			
			x++;
		}	
	}else{
			%><div class = "well">
Det finns inga kommentarer. <a href="#myModal7" data-toggle="modal" >Skriv den första.</a>
</div>
<%	} %>

 
<div class="footer">
&copy; PVT Grupp 10 
</div>  
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


</html>