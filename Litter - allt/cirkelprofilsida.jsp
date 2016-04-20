
<%@include file="Masterpage.jsp" %>

<!DOCTYPE html>


        <% 
		java.sql.ResultSet rs2,rs3,rs4,rs5,rs7,rs9,rs10;

        java.sql.PreparedStatement pst2,pst3,pst4,pst5,pst7,pst9,pst10;
		
		pst2 = null;
		pst3 = null;
		pst4 = null;
		pst5 = null;
	
		pst7 = null;
		pst9 = null;
		pst10 = null;

		rs2 = null;
		rs3 = null;
		rs4 = null;	
		rs5 = null;	
		rs7 = null;
		rs9	= null;
		rs10 = null;
        
		String cid = (String)request.getParameter("cid");
		String sq2 = "SELECT * FROM book_user_circle WHERE ucrl_uid='"+un+"'";
		String sq3 = "SELECT * FROM book_circle WHERE crcl_cid='"+cid+"'";
		String sq4 = "SELECT * FROM book_user INNER JOIN book_user_circle ON book_user.user_uid=book_user_circle.ucrl_uid";
		String sq5 = "SELECT * FROM book_user_circle WHERE ucrl_circle_cid='"+cid+"' AND ucrl_uid='"+un+"'";

		pst2 = c1.prepareStatement(sq2);
		pst3 = c1.prepareStatement(sq3);
		pst4 = c1.prepareStatement(sq4);
		pst5 = c1.prepareStatement(sq5);

        
		rs2 = pst2.executeQuery();
		rs3 = pst3.executeQuery();
		rs4 = pst4.executeQuery();	
		rs5 = pst5.executeQuery();
	
		
		rs2.next();
		rs3.next();
		
		/*List<String> member = new ArrayList<String>();
		if(!member.isEmpty()){
			member.clear();
		}
		while(rs4.next()){
			member.add(rs4.getString("user_user_name"));
		}*/
		
			
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
        <h2>Cirkelprofil</h2>	</div>
<div class="row-fluid">
<div class="row-fluid">   
<div class="span2"><a href="cirkelprofilsida.jsp#myModal5" data-toggle="modal">

<table class="table table-striped"><tr>
<div class="span2">
<td><b>Namn:</b></td>
<td><a href="#myModal1" data-toggle="modal"> <%= rs3.getString("crcl_name")%> </a></td></tr>

 </div> 
          
<div class="row-fluid">
<div class="span9">
<table><tr><td width="175"><h3>Presentation</h3></td>  </table>
<div class="well"><%= rs3.getString("crcl_info_text")%>


</div>

  </div></div>
  
 

<a href="cirdisc.jsp?cid=<%= cid %>"&do=1" class="btn btn-success btn-primary">Diskutera</a>

<%
if(!rs5.next()){
%>
<a href="followGroup.jsp?cid=<%= cid %>&do=1" class="btn btn-success btn-primary">Gå med</a>
<%} else{%>
<a href="followGroup.jsp?cid=<%= cid %>&do=2" class="btn btn-success btn-primary">Gå ur</a>
<%}%>

<a href="bookshelf.jsp?lid=<%= cid %>" class="btn btn-primary">Cirkel böcker</a>

</td>
</tr>


 
 <div id="myModal6" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Medlemmar</h3>
  </div>
  <div class="modal-body"><ul>
		<%
		while(rs4.next()){
			%><li><a href="GroupMemberList.jsp?cid=<%= rs4.getString("user_uid")%>"><%= rs4.getString("user_user_name") %></a></li><%
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
		
		if(pst5!=null) pst5.close();
        if(rs5!=null) rs5.close();

		if(pst7!=null) pst7.close();
        if(rs7!=null) rs7.close();
		
		if(pst9!=null) pst9.close();
        if(rs9!=null) rs9.close();
		
		if(pst10!=null) pst10.close();
        if(rs10!=null) rs10.close();

%>
</html>