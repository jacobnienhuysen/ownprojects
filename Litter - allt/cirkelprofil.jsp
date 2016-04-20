
<%@include file="Masterpage.jsp" %>


<!DOCTYPE html>
<html lang="sv">

        <% 
		java.sql.ResultSet rs2,rs3,rs4,rs5,rs6,rs7,rs8;

        java.sql.PreparedStatement pst2,pst3,pst4,pst5,pst6,pst7,pst8;
		
		pst2 = null;
		pst3 = null;
		pst4 = null;
		pst5 = null;
		pst6 = null;
		pst7 = null;
		pst8 = null;
		
		rs2 = null;
		rs3 = null;
		rs4 = null;
		rs5 = null;
		rs6 = null;
		rs7 = null;
		rs8 = null;
		
		String cid =(String)request.getParameter("id");
        
		String sq2 = "SELECT * FROM book_circle WHERE crcl_cid= ?";
		pst2 = c1.prepareStatement(sq2);
		pst2.setString(1, cid);
		rs2 = pst2.executeQuery();
		
		String sq3 = "SELECT * FROM book_user_circle WHERE ucrl_circle_cid= ?";
		pst3 = c1.prepareStatement(sq3);
		pst3.setString(1, cid);
		rs3 = pst3.executeQuery();

		rs2.next();
		int membAnt = 0;
		while(rs3.next()){
			membAnt++;
		}
		
		String cowner = rs2.getString("crcl_owner_uid");
		
		String sq4 = "SELECT * FROM book_user WHERE user_uid= ?";
		pst4 = c1.prepareStatement(sq4);
		pst4.setString(1, cowner);
		rs4 = pst4.executeQuery();
		
		rs4.next();
		rs3.beforeFirst();
		
		String sq5 = "SELECT * FROM book_user_circle WHERE ucrl_uid= ? AND ucrl_circle_cid= ?";
		pst5 = c1.prepareStatement(sq5);
		pst5.setString(1, un);
		pst5.setString(2, cid);
		rs5 = pst5.executeQuery();
		
		
		String sq6 = "SELECT * FROM book_user INNER JOIN book_user_circle ON book_user.user_uid=book_user_circle.ucrl_uid WHERE ucrl_circle_cid=? ORDER BY ucrl_joined DESC";
		pst6 = c1.prepareStatement(sq6);
		pst6.setString(1, cid);
		rs6 = pst6.executeQuery();
		rs6.next();
		
		String sq7 = "SELECT * FROM book_circle_discussion WHERE cdis_cid = ?";
		pst7 = c1.prepareStatement(sq7);
		pst7.setString(1, cid);
		rs7 = pst7.executeQuery();
		
		String sq8 = "SELECT * FROM book_circle_discussion_comment INNER JOIN book_circle_discussion ON book_circle_discussion_comment.cdic_did=book_circle_discussion.cdis_did WHERE book_circle_discussion.cdis_cid= ? ORDER BY cdic_time DESC";
		pst8 = c1.prepareStatement(sq8);
		pst8.setString(1, cid);
		rs8 = pst8.executeQuery();
			
        %> 

<html>
  <head>
    <title>Cirkelprofilsida</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
   <link href="bootstrap-responsive.css" rel="stylesheet"> 
  </head>
  


      
    
<div class="span10">
 <div class="jumbotron">
        <h2><%= rs2.getString("crcl_name")%></h2>	</div>
<div class="row-fluid">
<div class="row-fluid">   
<div class="span2">
<% if((rs2.getString("crcl_picture")) == null ){ %>
			<img src="img/CROWD.jpg" width="175" border="0">
		<% } else { %>
			<img src="displaycircpic.jsp?cid=<%=rs2.getString("crcl_cid")%>" width="175" border="0">
		<% } %>  
</div>
<div class="span7" style="size:fixed;">

<table class="table table-striped"><tr>

<td width="150"><b>Skapad:</b></td>
<td colspan="2"><% String crcr = rs2.getString("crcl_created"); crcr = crcr.substring(0,10); out.print(crcr); %></td></tr>

<tr>
<td><b>Ägare:</b></td>
<td colspan="2"><a href="otheruser.jsp?id=<%= rs4.getString("user_uid")%>"><%= rs4.getString("user_user_name")%></a></td>
</tr>

<tr>
<td><b>Medlemmar:</b></td>
<td colspan="2"><%= membAnt %></td>
</tr>

<tr><td colspan="3">
<%
if(!rs5.next()){

%>
<a href="followGroup.jsp?cid=<%= cid %>&do=1" class="btn btn-success btn-primary">Gå med</a>
<%}else{%>
<a href="followGroup.jsp?cid=<%= cid %>&do=2" class="btn btn-success btn-primary">Gå ur</a>
<a href="cirdisc.jsp?cid=<%= cid %>" class="btn btn-primary">Diskutera</a>
<%}%>

<% if(rs2.getString("crcl_owner_uid").equals(un)){%>
	<a href="GroupAdmin.jsp?cid=<%= cid %>" class="btn btn-primary">Administrera</a>
<%}%>
</td>
</tr>


</table>




</div></div> 
          
<div class="row-fluid">
<div class="span9">
<table><tr><td width="175"><h3>Presentation</h3></td></tr> </table>
<div class="well"><%= rs2.getString("crcl_info_text")%>


</div>


</div></div>

 <div id="myModal1" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Alla medlemmar</h3>
  </div>
  <div class="modal-body"><ul>
		<%
		rs6.beforeFirst();
		while(rs6.next()){
			%><li><a href="otheruser.jsp?id=<%= rs6.getString("ucrl_uid")%>"><%= rs6.getString("user_user_name") %></a></li><%
		}%>
</ul>
	
  </div>
  
  <div class="modal-footer">
    <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Stäng</button>
	</form>
  </div></div>


<div class="row-fluid">

<h3>Senaste aktivitet</h3>

<div class="span3">

<h4>Medlemmar:</h4>

<ul>
<% 
if(rs6!=null){
	rs6.beforeFirst();
}
if(rs6.next()){
	rs6.beforeFirst();
	int x =0;
	while(rs6.next()){
		%><li><a href="otheruser.jsp?id=<%= rs6.getString("ucrl_uid")%>"><%= rs6.getString("user_user_name") %></a></li><%
		x++;
		if(x==4){
			%>(<a href="#myModal1" data-toggle="modal" >visa fler</a>)<%
			break;
		}
	}
}else{
	%><li>Gruppen har inga medlemmar</li><%
	}
%>
</ul>


</div>
<div class="span3">
<h4>Nya diskussionstrådar:</h4>


<ul>
<%
	if(!rs7.next()){
		%><li>Det finns inga trådar.</li><%
	}else{
	int x = 0;
	rs7.beforeFirst();
		
		while(rs7.next()){	
			String topic = rs7.getString("cdis_topic");
			if(topic.length()>30){
				topic = topic.substring(0, 30) + "...";
			}
			
			%><li><a href="circhat.jsp?did=<%= rs7.getString("cdis_did") %>" ><%= topic %></a></li><%
			
			x++;
		
			if(x==4){
			
				%>(<a href="#myModal1" data-toggle="modal" >visa fler</a>)<%
				break;
			}
		}
	}
%>
</ul>


</div>

<div class="span3">
<h4>Nya diskussionsinlägg:</h4>


<ul><% 
	if(!rs8.next()){
		%><li>Det finns inga inlägg.</li><%
	}else{
	int x = 0;
	rs8.beforeFirst();
		
		while(rs8.next()){	
			String dcomm = rs8.getString("cdic_text");
			if(dcomm.length()>20){
				dcomm = dcomm.substring(0, 20) + "...";
			}
			
			%><li><a href="circhat.jsp?did=<%= rs8.getString("cdis_did") %>" ><%= dcomm %></a> i tråden "<%= rs8.getString("cdis_topic") %>"</li><%
			
			x++;
		
			if(x==4){
			
				%>(<a href="#myModal3" data-toggle="modal" >visa fler</a>)<%
				break;
			}
		}
	}%>
</ul>


</div>

   <div id="myModal2" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Diskussionstrådar:</h3>
  </div>
  <div class="modal-body"><ul>
		<% 
	rs7.beforeFirst();
	if(!rs7.next()){
		%><li>Det finns inga trådar.</li><%
	}else{
	int x = 0;
	rs7.beforeFirst();
		
		while(rs7.next()){	
			String topic = rs7.getString("cdis_topic");
			if(topic.length()>50){
				topic = topic.substring(0, 50) + "...";
			}
			
			%><li><a href="circhat.jsp?did=<%= rs7.getString("cdis_did") %>" ><%= topic %></a></li><%
			
			x++;
		
			if(x==15){
				break;
			}
		}
	}%>
</ul>
	
  </div>
  
  <div class="modal-footer">
    <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Stäng</button>
	</form>
  </div></div>
  
  
     <div id="myModal3" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Diskussionsinlägg:</h3>
  </div>
  <div class="modal-body"><ul>
		<% 
	rs8.beforeFirst();
	if(!rs8.next()){
		%><li>Det finns inga inlägg.</li><%
	}else{
	int x = 0;
	rs8.beforeFirst();
		
		while(rs8.next()){	
			String dcomm = rs8.getString("cdic_text");
			if(dcomm.length()>40){
				dcomm = dcomm.substring(0, 40) + "...";
			}
			
			%><li><a href="circhat.jsp?did=<%= rs8.getString("cdis_did") %>" ><%= dcomm %></a> i tråden "<%= rs8.getString("cdis_topic") %>"</li><%
			
			x++;
		
			if(x==15){
				break;
			}
		}
	}%>
</ul>
	
  </div>
  
  <div class="modal-footer">
    <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Stäng</button>
	</form>
  </div></div>



</div></div>	  
    </div>
  </div>
</div> 
 <hr>

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
		
		if(pst1!=null) pst1.close();
        if(rs1!=null) rs1.close();

        if(c1!=null) c1.close();
		
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
%>
</html>