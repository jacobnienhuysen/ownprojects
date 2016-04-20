<%@include file="Masterpage.jsp" %>

<!DOCTYPE html>
<html>



        <% 

		java.sql.ResultSet rs2,rs3,rs4,rs5,rs6,rs7,rs8,rs9,rs10;
        java.sql.PreparedStatement pst2,pst3,pst4,pst5,pst6,pst7,pst8,pst9,pst10;
		
		String otherUn =(String)request.getParameter("id");

		pst2 = null;
		pst3 = null;
		pst4 = null;
		pst5 = null;
		pst6 = null;
		pst7 = null;
		pst8 = null;
		pst9 = null;
		pst10 = null;
      
		rs2 = null;
		rs3 = null;
		rs4 = null;
		rs5 = null;
		rs6 = null;
		rs8 = null;
		rs7 = null;
		rs9 = null;
		rs10 = null;
        
		
    
		String sq2 = "SELECT * FROM book_user_school WHERE usho_uid='"+otherUn+"'";
		String sq3 = "SELECT * FROM book_school";
		String sq4 = "SELECT * FROM book_user INNER JOIN book_user_follows ON book_user.user_uid=book_user_follows.ufol_uid_followee WHERE ufol_uid_follower='"+otherUn+"' ORDER BY book_user_follows.ufol_start_time DESC";
		String sq5 = "SELECT user_user_name, lidi_text FROM book_user INNER JOIN book_literature_discussion_comment ON user_uid = lidi_uid ORDER BY lidi_time DESC";
		String sq6 = "SELECT * FROM book_user WHERE user_uid='"+otherUn+"'"; 
		String sq7 = "SELECT * FROM book_literature_discussion INNER JOIN book_literature_discussion_comment ON book_literature_discussion.ldis_did=book_literature_discussion_comment.lidi_ldid ORDER BY book_literature_discussion_comment.lidi_time DESC";
		
		String sq9 = "SELECT * FROM book_user_follows WHERE ufol_uid_follower='"+un+"' AND ufol_uid_followee='"+otherUn+"'";
		String sq10 = "SELECT * FROM book_circle_discussion INNER JOIN book_circle_discussion_comment ON book_circle_discussion.cdis_did=book_circle_discussion_comment.cdic_did ORDER BY book_circle_discussion_comment.cdic_time DESC";

       
		pst2 = c1.prepareStatement(sq2);
		pst3 = c1.prepareStatement(sq3);
		pst4 = c1.prepareStatement(sq4);
		pst5 = c1.prepareStatement(sq5);
		pst6 = c1.prepareStatement(sq6);
		pst7 = c1.prepareStatement(sq7);
		pst9 = c1.prepareStatement(sq9);
		pst10 = c1.prepareStatement(sq10);
       
		rs2 = pst2.executeQuery();
		rs3 = pst3.executeQuery();
		rs4 = pst4.executeQuery();
		rs5 = pst5.executeQuery();
		rs6 = pst6.executeQuery();
		rs7 = pst7.executeQuery();
		rs9 = pst9.executeQuery();
		rs10 = pst10.executeQuery();
		
		rs2.next();
		rs6.next();
		
        %> 


  <head>
    <title>Profilsida</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
    <link href="bootstrap-responsive.css" rel="stylesheet" media="screen">
  </head>
  


      
    
<div class="span10">
 <div class="jumbotron">
        <h2><%= rs6.getString("user_user_name")%>'s profil</h2>	</div>
<div class="row-fluid">
<div class="row-fluid">   
<div class="span2">
<% if((rs6.getString("user_picture")) == null ){ %>
			<img src="img/sil.png" width="150" border="0">
		<% } else { %>
			<img src="displayprofilepic.jsp?id=<%=rs6.getString("user_uid")%>"" width="150" border="0">
		<% } %>  
</div>
<div class="span7">

<table class="table table-striped"><tr>
<div class="span2">
<td><b>Namn:</b></td>
<td> <%= rs6.getString("user_first_name")%> <%= rs6.getString("user_sur_name")%> </td></tr>

<tr>
<td><b>Lärosäte:</b></td>
<td><%= rs2.getString("usho_school_name")%></td>
</tr>

<tr>
<td><b>Hemort:</b></td>
<td><%= rs6.getString("user_hometown")%></td>

</tr>
<%
if(!rs9.next() && !otherUn.equals(un)){

%><tr>
<td colspan="2"><a href="followUser.jsp?id=<%= rs6.getString("user_uid")%>&do=1" class="btn btn-success">Följa</a></td>

</tr>
<%}
else if(otherUn.equals(un)){%>
<tr><td colspan="2"></td></tr>


<%}else{%>
<tr>
<td colspan="2"><a href="followUser.jsp?id=<%= rs6.getString("user_uid")%>&do=2" class="btn btn-success">Sluta följa</a></td>

</tr>
<%}%>
</table>




</div></div> </div> 
          
<div class="row-fluid">
<div class="span9">
<table><tr><td width="175"><h3>Presentation</h3></td> <td></td></tr> </table>
<div class="well">
<%= rs6.getString("user_info_text")%>
</div>
</div>
</div>

 <div id="myModal6" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel"><%= rs6.getString("user_user_name")%>'s vänner</h3>
  </div>
  <div class="modal-body"><ul>
		<%
		while(rs4.next()){
			%><li><a href="otheruser.jsp?id=<%= rs4.getString("user_uid")%>"><%= rs4.getString("user_user_name") %></a></li><%
		}%>
</ul>
	
  </div>
  
  <div class="modal-footer">
    <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Stäng</button>
	</form>
  </div></div>
  
  <div id="myModal7" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Bokdiskussioner:</h3>
  </div>
  <div class="modal-body"><ul>
		<% 
		
		int i = 0;
		
		ArrayList<String> litdis = new ArrayList<String>();
		
		while(rs7.next()){	
			
			String litTopic = rs7.getString("ldis_topic");
			
			if(!(litdis.contains(litTopic))){
				
			litdis.add(litTopic);
			
			String sq8 = "SELECT * FROM book_literature WHERE lit_lid ='"+rs7.getString("ldis_lid")+"'";
			
			pst8 = c1.prepareStatement(sq8);
			rs8 = pst8.executeQuery();
			rs8.next();
			
			%><li><a href="litchat.jsp?did=<%= rs7.getString("ldis_did") %>" ><%= litTopic %></a> i <a href="bokprofilsida.jsp?lid=<%= rs7.getString("ldis_lid")%>">  <%= rs8.getString("lit_title") %> </a></li><%
		
			i++;
		
			if(i==10) break;
		    }
			
		}%>
</ul>
	
  </div>
  
  <div class="modal-footer">
    <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Stäng</button>
	</form>
  </div></div>
  
     <div id="myModal8" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Gruppdiskussioner:</h3>
  </div>
  <div class="modal-body"><ul>
		<% 
		
		int i2 = 0;	
		ArrayList<String> cirdis = new ArrayList<String>();

		while(rs10.next()){	

			String cirTopic = rs10.getString("cdis_topic");
			
			if(!(cirdis.contains(cirTopic))){
			cirdis.add(cirTopic);
			
			String sq8 = "SELECT * FROM book_circle WHERE crcl_cid ='"+rs10.getString("cdis_cid")+"'";
			
			pst8 = c1.prepareStatement(sq8);
			rs8 = pst8.executeQuery();
			rs8.next();
			
			%><li><a href="circhat.jsp?did=<%= rs10.getString("cdis_cid") %>" ><%= cirTopic %></a> i <a href="cirkelprofilsida.jsp?cid=<%= rs10.getString("cdis_cid")%>">  <%= rs8.getString("crcl_name") %> </a></li><%
		
			i2++;
		
			if(i2==10) break;
		    }
			
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
<h4>Vänner:</h4>
<ul>
<% 
if(rs4!=null){
	rs4.beforeFirst();
}
if(rs4.next()){
	rs4.beforeFirst();
	int x =0;
	while(rs4.next()){
		%><li><a href="otheruser.jsp?id=<%= rs4.getString("user_uid")%>"><%= rs4.getString("user_user_name") %></a></li><%
		x++;
		if(x==4){
			%>(<a href="#myModal6" data-toggle="modal" >visa fler</a>)<%
			break;
		}
	}
}else{
	%><li> <%= rs6.getString("user_user_name") %> har inga vänner</li><%
	}
%>
</ul></div>
<div class="span3">
<h4>Bokdiskussioner:</h4>
<ul>
<% 
	int x = 0;
	rs7.beforeFirst();
	ArrayList<String> litdis2 = new ArrayList<String>();
		
		while(rs7.next()){	
			
			String litTopic2 = rs7.getString("ldis_topic");
			
			if(!(litdis2.contains(litTopic2))){
				
				litdis2.add(litTopic2);
				
				
			String sq8 = "SELECT * FROM book_literature WHERE lit_lid ='"+rs7.getString("ldis_lid")+"'";
			
			pst8 = c1.prepareStatement(sq8);
			rs8 = pst8.executeQuery();
			rs8.next();
			
				if(litTopic2.length()>30){
					litTopic2 = litTopic2.substring(0, 30) + "...";
				}
			
			%><li><a href="litchat.jsp?did=<%= rs7.getString("ldis_did") %>" ><%= litTopic2 %></a> i <a href="bokprofilsida.jsp?lid=<%= rs7.getString("ldis_lid")%>">  <%= rs8.getString("lit_title") %> </a></li><%
			
			x++;
		
			if(x==4){
			
				%>(<a href="#myModal7" data-toggle="modal" >visa fler</a>)<%
				break;
			}
		}
	}
%>
</ul>
</div>
<div class="span3">
<h4>Gruppdiskussioner:</h4>
<ul><% 
		int z = 0;	
		rs10.beforeFirst();
		
		ArrayList<String> cirdis1 = new ArrayList<String>();

		while(rs10.next()){	

			String cirTopic1 = rs10.getString("cdis_topic");
			
			if(!(cirdis1.contains(cirTopic1))){
			cirdis1.add(cirTopic1);
				
			String sq8 = "SELECT * FROM book_circle WHERE crcl_cid ='"+rs10.getString("cdis_cid")+"'";
			
			pst8 = c1.prepareStatement(sq8);
			rs8 = pst8.executeQuery();
			rs8.next();
			
			%><li><a href="circhat.jsp?did=<%= rs10.getString("cdis_cid") %>" ><%= cirTopic1 %></a> i <a href="cirkelprofilsida.jsp?cid=<%= rs10.getString("cdis_cid")%>">  <%= rs8.getString("crcl_name") %> </a></li><%
		
			z++;
		
			if(z==10) break;
		    }
			
		}%>
</ul>
</div>

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
		
		if(pst10!=null) pst10.close();
        if(rs10!=null) rs10.close();
		
%>
</html>