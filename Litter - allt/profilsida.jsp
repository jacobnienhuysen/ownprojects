
<%@include file="Masterpage.jsp" %>

<%@include file="feedAlert.jsp" %>

<!DOCTYPE html>


        <% 
		java.sql.ResultSet rs2,rs3,rs4,rs7,rs9,rs8,rs10;

        java.sql.PreparedStatement pst2,pst3,pst4,pst7,pst8,pst9,pst10;
		
		pst2 = null;
		pst3 = null;
		pst4 = null;
	
		pst7 = null;
		pst8 = null;
		pst9 = null;
		pst10 = null;

		rs2 = null;
		rs3 = null;
		rs4 = null;	
		rs7 = null;
		rs8 = null;
		rs9	= null;
		rs10 = null;
        
		String sq2 = "SELECT * FROM book_user_school WHERE usho_uid= ?";
		pst2 = c1.prepareStatement(sq2);
		pst2.setString(1, un);
		rs2 = pst2.executeQuery();
		
		String sq3 = "SELECT * FROM book_school";
		pst3 = c1.prepareStatement(sq3);
		rs3 = pst3.executeQuery();
		
		String sq4 = "SELECT * FROM book_user INNER JOIN book_user_follows ON book_user.user_uid=book_user_follows.ufol_uid_followee WHERE ufol_uid_follower= ? ORDER BY book_user_follows.ufol_start_time DESC";
		pst4 = c1.prepareStatement(sq4);
		pst4.setString(1, un);
		rs4 = pst4.executeQuery();
	
		String sq7 = "SELECT * FROM book_literature_discussion INNER JOIN book_literature_discussion_comment ON book_literature_discussion.ldis_did=book_literature_discussion_comment.lidi_ldid ORDER BY book_literature_discussion_comment.lidi_time DESC";
		pst7 = c1.prepareStatement(sq7);
		rs7 = pst7.executeQuery();
		
		String sq10 = "SELECT * FROM book_circle_discussion INNER JOIN book_circle_discussion_comment ON book_circle_discussion.cdis_did=book_circle_discussion_comment.cdic_did ORDER BY book_circle_discussion_comment.cdic_time DESC";
		pst10 = c1.prepareStatement(sq10);
		rs10 = pst10.executeQuery();
		
		rs2.next();
		
		/*List<String> followees = new ArrayList<String>();
		if(!followees.isEmpty()){
			followees.clear();
		}
		while(rs4.next()){
			followees.add(rs4.getString("user_user_name"));
		}*/
		
			
        %> 

<html>
  <head>
    <title>Profilsida</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
   <link href="bootstrap-responsive.css" rel="stylesheet"> 
  </head>
  


      
    
<div class="span10">
 <div class="jumbotron">
        <h2><%= rs1.getString("user_user_name")%>'s profil</h2>	</div>
<div class="row-fluid">
<div class="row-fluid">   
<div class="span2"><a href="profilsida.jsp#myModal5" data-toggle="modal">
<% if((rs1.getString("user_picture")) == null ){ %>
			<img src="img/sil.png" width="175" border="0" alt="Klicka för att ladda upp en profilbild" title="Klicka för att ladda upp en profilbild">
		<% } else { %>
			<img src="displayprofilepic.jsp?id=<%=rs1.getString("user_uid")%>" width="175" border="0" alt="Klicka för att byta profilbild" title="Klicka för att byta profilbild">
		<% } %>  
</a></div>
<div class="span7" style="size:fixed;">

<table class="table table-striped"><tr>

<td><b>Namn:</b></td>
<td><a href="#myModal1" data-toggle="modal"> <%= rs1.getString("user_first_name")%> <%= rs1.getString("user_sur_name")%> </a></td></tr>

<tr>
<td><b>Lärosäte:</b></td>
<td><a href="#myModal2" data-toggle="modal"><%= rs2.getString("usho_school_name")%></a></td>
</tr>

<tr>
<td><b>Hemort:</b></td>
<td><a href="#myModal3" data-toggle="modal"><%= rs1.getString("user_hometown")%> </a></td>
</tr>

<tr>
<td><b>E-mail:</b></td>
<td><a href="#myModal10" data-toggle="modal"><%= rs1.getString("user_email")%> </a></td>
</tr>

<tr><td colspan="2"><a href="#myModal9" class="btn btn-primary" data-toggle="modal" >Byt lösenord</a></td></tr>
</table>




</div></div>
          
<div class="row-fluid">
<div class="span9">
<table><tr><td width="175"><h3>Presentation</h3></td> <td><a href="#myModal4" data-toggle="modal" >Ändra</a></td></tr> </table>
<div class="well"><%= rs1.getString("user_info_text")%>


</div>

 
  
  <div id="myModal1" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Ändra ditt namn</h3>
  </div>
  <div class="modal-body">
  <form action="updateProfile.jsp?id=1&fn=<%= rs1.getString("user_uid")%>" method="post" >
	<table>
	<tr><td>Förnamn:</td><td><input type="text" id="firstname" name="firstname" size="65" value="<%= rs1.getString("user_first_name")%>" required></td></tr>
	<tr><td>Efternamn:</td><td><input type="text" id="surname" name="surname" size="65" value="<%= rs1.getString("user_sur_name")%>"  required></td></tr>
	</table>
  </div>
  
  <div class="modal-footer">
    <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Stäng</button>
    <button class="btn btn-success" type="submit">Spara</button>
	</form>
  </div></div>
  
    <div id="myModal2" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Ändra lärosäte</h3>
  </div>
  <div class="modal-body">
  <form action="updateProfile.jsp?id=2&fn=<%= rs1.getString("user_uid")%>" method="post" >
	<table>
	<tr><td>Lärosäte: </td><td><select name="school" id="school">
	<%
	while( rs3.next() ){
		
	%>
			<option value = "<%= rs3.getString("scho_name") %>"><%= rs3.getString("scho_name") %></option>
	<%
	}
	%>
	</select></td></tr>
	</table>
  </div>
  
  <div class="modal-footer">
    <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Stäng</button>
    <button class="btn btn-success" type="submit">Spara</button>
	</form>
  </div></div>
  
  <div id="myModal3" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Ändra din hemort</h3>
  </div>
  <div class="modal-body">
  <form action="updateProfile.jsp?id=3&fn=<%= rs1.getString("user_uid")%>" method="post" >
	<table>
	<tr><td>Hemort:</td><td><input type="text" id="hometown" name="hometown" size="65" value="<%= rs1.getString("user_hometown")%>" required></td></tr>
	
	
	</table>
  </div>
  
  <div class="modal-footer">
    <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Stäng</button>
    <button class="btn btn-success" type="submit">Spara</button>
	</form>
  </div></div>
  
    <div id="myModal4" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Ändra din presentation</h3>
  </div>
  <div class="modal-body">
  <form action="updateProfile.jsp?id=4&fn=<%= rs1.getString("user_uid")%>" method="post" >
	<textarea rows="10" cols="50" style="width: 95%; height:100%;" id="infotext" name="infotext"><%= rs1.getString("user_info_text")%></textarea>
  </div>
  
  <div class="modal-footer">
    <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Stäng</button>
    <button class="btn btn-success" type="submit">Spara</button>
	</form>
  </div></div>
  
      <div id="myModal5" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Ändra profilbild</h3>
  </div>
  <div class="modal-body">Välj en bildfil från din hårddisk. Max storlek: 2048 kB.<p>
  <form method="post" action="uploadServlet?uid=<%= rs1.getString("user_uid")%>" enctype="multipart/form-data">
	<input type="file" name="photo" id="photo" accept="image/*" required>
  </div>
  
  <div class="modal-footer">
    <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Stäng</button>
    <button class="btn btn-success" type="submit">Ladda upp</button>
	</form>
  </div></div>
  
  
 <div id="myModal6" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Mina vänner</h3>
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
    <h3 id="myModalLabel">Aktuella bokdiskussioner:</h3>
  </div>
  <div class="modal-body"><ul>
		<% 
		
		int i = 0;
		
		ArrayList<String> litdis = new ArrayList<String>();
		
		while(rs7.next()){	
			
			String litTopic = rs7.getString("ldis_topic");
			
			if(!(litdis.contains(litTopic))){
				
			litdis.add(litTopic);
			
			String sq8 = "SELECT * FROM book_literature WHERE lit_lid= ?";
			pst8 = c1.prepareStatement(sq8);
			pst8.setString(1, rs7.getString("ldis_lid"));
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
    <h3 id="myModalLabel">Aktuella Gruppdiskussioner:</h3>
  </div>
  <div class="modal-body"><ul>
		<% 
		
		int i2 = 0;	
		ArrayList<String> cirdis = new ArrayList<String>();

		while(rs10.next()){	

			String cirTopic = rs10.getString("cdis_topic");
			
			if(!(cirdis.contains(cirTopic))){
			cirdis.add(cirTopic);
			
			String sq8 = "SELECT * FROM book_circle WHERE crcl_cid= ?";
			pst8 = c1.prepareStatement(sq8);
			pst8.setString(1, rs10.getString("cdis_cid"));
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
  
      <div id="myModal9" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Byt lösenord</h3>
  </div>
  <div class="modal-body">
  <form action="updateProfile.jsp?id=5&fn=<%= rs1.getString("user_uid")%>" method="post">
	<table>
		<tr>
			<td>Gammalt lösenord: </td>
			<td><input type="password" name="oldp" id="oldp" required></td>
		</tr>
		<tr>
			<td>Nytt lösenord: </td>
			<td><input type="password" name="newp" id="newp" required></td>
		</tr>
		<tr>
			<td>Upprepa nytt lösenord: </td>
			<td><input type="password" name="new2p" id="new2p" required></td>
		</tr>
	</table>
  </div>
  
  <div class="modal-footer">
    <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Stäng</button>
    <button class="btn btn-success" type="submit">Spara</button>
	</form>
  </div></div>
  
  
    <div id="myModal10" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Byt e-mailadress</h3>
  </div>
  <div class="modal-body">
  <form action="updateProfile.jsp?id=6&fn=<%= rs1.getString("user_uid")%>" method="post" >
	<table>
	<tr><td>E-mailadress:</td><td><input type="email" id="em1" name="em1" size="65" value="<%= rs1.getString("user_email")%>" placeholder="email@adress.nu" required></td></tr>
	</table>
  </div>
  
  <div class="modal-footer">
    <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Stäng</button>
    <button class="btn btn-success" type="submit">Spara</button>
	</form>
  </div></div>



</div></div>


<div class="row-fluid">

<h3>Senaste aktivitet</h3>

<div class="span3">

<h4>Följer:</h4>


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
	%><li>Du har inga vänner</li><%
	}
%>
</ul></div>
<div class="span3">
<h4>Nya Bokdiskussioner:</h4>
<ul>
<% 
	int x = 0;
	rs7.beforeFirst();
	ArrayList<String> litdis2 = new ArrayList<String>();
		
		while(rs7.next()){	
			
			String litTopic2 = rs7.getString("ldis_topic");
			
			if(!(litdis2.contains(litTopic2))){
				
				litdis2.add(litTopic2);
				
				
			String sq8 = "SELECT * FROM book_literature WHERE lit_lid= ?";
			pst8 = c1.prepareStatement(sq8);
			pst8.setString(1, rs7.getString("ldis_lid"));
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
</ul></div>

<div class="span3">
<h4>Nya Gruppdiskussioner:</h4>
<ul><% 
		int z = 0;	
		rs10.beforeFirst();
		
		ArrayList<String> cirdis1 = new ArrayList<String>();

		while(rs10.next()){	

			String cirTopic1 = rs10.getString("cdis_topic");
			
			if(!(cirdis1.contains(cirTopic1))){
			cirdis1.add(cirTopic1);
				
			String sq8 = "SELECT * FROM book_circle WHERE crcl_cid= ?";
			pst8 = c1.prepareStatement(sq8);
			pst8.setString(1, rs10.getString("cdis_cid"));
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
		
		if(pst1!=null) pst1.close();
        if(rs1!=null) rs1.close();

        if(c1!=null) c1.close();
		
		if(pst2!=null) pst2.close();
        if(rs2!=null) rs2.close();
		
		if(pst3!=null) pst3.close();
        if(rs3!=null) rs3.close();
		
		if(pst4!=null) pst4.close();
        if(rs4!=null) rs4.close();

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