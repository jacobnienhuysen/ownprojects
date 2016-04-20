<%@include file="Masterpage.jsp" %>
<!DOCTYPE html>
<html>


 
        <% 

		String liid =(String)request.getParameter("lid");
		
        java.sql.Statement s2, s3;
        java.sql.ResultSet rs2, rs3, rs4, rs5, rs6, rs7, rs8, rs9, rs10, rs11, rs12;
        java.sql.PreparedStatement pst2, pst3, pst4, pst5, pst6, pst7, pst8, pst9, pst10, pst11, pst12;

		pst2 = null;
		pst3 = null;
		pst4 = null;
		pst5 = null;
		pst6 = null;
		pst7 = null;
		pst8 = null;
		pst9 = null;
		pst10 = null;
		pst11 = null;
		pst12 = null;

        rs2 = null;
		rs3 = null;
		rs4 = null;
		rs5 = null;
		rs6 = null;
		rs7 = null;
		rs8 = null;
		rs9 = null;
		rs10 = null;
		rs11 = null;
		rs12 = null;

		String sq2 ="SELECT * FROM book_literature WHERE lit_lid= ?";
		pst2 = c1.prepareStatement(sq2);
		pst2.setString(1, liid);
		rs2 = pst2.executeQuery();
		
		String sq3= "SELECT * FROM book_literature_author WHERE lita_lid= ?";
		pst3 = c1.prepareStatement(sq3);
		pst3.setString(1, liid);
		rs3 = pst3.executeQuery();
		
		String sq4= "SELECT * FROM book_user INNER JOIN book_user_literature ON book_user.user_uid=book_user_literature.ulit_uid WHERE book_user_literature.ulit_lid= ?";	
		pst4 = c1.prepareStatement(sq4);
		pst4.setString(1, liid);
		rs4 = pst4.executeQuery();
		
		String sq5 = "SELECT * FROM book_literature_discussion INNER JOIN book_literature_discussion_comment ON book_literature_discussion.ldis_did=book_literature_discussion_comment.lidi_ldid WHERE book_literature_discussion.ldis_lid= ? ORDER BY book_literature_discussion_comment.lidi_time DESC";
		pst5 = c1.prepareStatement(sq5);
		pst5.setString(1, liid);
		rs5 = pst5.executeQuery();
		
		String sq6 = "SELECT * FROM book_literature ORDER BY lit_added DESC";
		pst6 = c1.prepareStatement(sq6);
		rs6 = pst6.executeQuery();
		
		String sq7 ="SELECT COUNT(ulit_uid) AS 'Followees' FROM book_user_literature WHERE ulit_lid= ?";
		pst7 = c1.prepareStatement(sq7);
		pst7.setString(1, liid);
		rs7 = pst7.executeQuery();
		
		String sq8 ="SELECT * FROM book_user_literature WHERE ulit_lid= ? AND ulit_uid= ?";
		pst8 = c1.prepareStatement(sq8);
		pst8.setString(1, liid);
		pst8.setString(2, un);
		rs8 = pst8.executeQuery();
		
		String sq9="SELECT COUNT(*) FROM book_literature_pdf WHERE lit_pdf_oid= ? AND lit_pdf_lid= ?";
		pst9 = c1.prepareStatement(sq9);
		pst9.setString(1, un);
		pst9.setString(2, liid);
		rs9 = pst9.executeQuery();
		
		String sq11 = "SELECT * FROM book_literature_grade WHERE lit_gr_lid= ?";
		pst11 = c1.prepareStatement(sq11);
		pst11.setString(1, liid);
		rs11 = pst11.executeQuery();
		
		String sq12="SELECT lit_gr_grade FROM book_literature_grade WHERE lit_gr_uid= ? AND lit_gr_lid= ?";
		pst12 = c1.prepareStatement(sq12);
		pst12.setString(1, un);
		pst12.setString(2, liid);
		rs12 = pst12.executeQuery();
		
		rs2.next();
		rs7.next();
		rs9.next();
		rs12.next();
		
		//Betyghantering
		Integer gradeCount = 0;
		Double totalGrade = 0.0;
		Double averageGrade = 0.0;
		
		List<Integer> gradeList = new ArrayList<Integer>();
		while(rs11.next()){	//Räknar ut antalet röster
			gradeCount++;
		}
		
		rs11.beforeFirst();
		while(rs11.next()){	//Räknar ut medelbetyget
			totalGrade+=rs11.getInt("lit_gr_grade");
		}
		
		if(gradeCount>0){
			averageGrade = totalGrade/gradeCount;
		}
		
		//Slut betyghantering
		
		Integer radeantal = Integer.parseInt(rs9.getString(1));
		
		List<String> authorList = new ArrayList<String>();
		
		while(rs3.next()){
			authorList.add(rs3.getString("lita_author_name"));
		}
	
        %> 


  <head>
    <title>Bokprofilsida</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
     <link href="bootstrap-responsive.css" rel="stylesheet"/>
  </head>
  
      
<div class="span10">
 <div class="jumbotron">
        <h2><%= rs2.getString("lit_title")%></h2></div>
<div class="row-fluid">
<div class="row-fluid">  
<div class="span2"><a href="profilsida.jsp#myModal5" data-toggle="modal">
<% if((rs2.getString("lit_cover")) == null ){ %>
			<img src="img/Help_book.png" width="175" border="0" alt="Klicka för att ladda upp bokomslag" title="Klicka för att ladda upp bokomslag"><br>Byt omslag
		<% } else { %>
			<img src="displaycover.jsp?id=<%=rs2.getString("lit_lid")%>" width="175" border="0"><br>Byt omslag
		<% } %>  
</a>


</div>
<div class="span7" style="size:fixed;">

<table class="table table-striped" border="0">

<tr>
<td width="100"><b>Författare:</b></td>
<td colspan="2"><%
for(int i=0; i<authorList.size();i++){
	%><%= authorList.get(i).toString() %><%if(i<authorList.size() && i!=authorList.size()){%><br><% }} %></td>
</tr>

<tr>
<td><b>Publicerad:</b></td>
<td colspan="2"><%String year = rs2.getString("lit_published"); year = year.substring(0,4); out.print(year); %></td>
</tr>

<%	if(rs2.getString("lit_isbn10")!=null){%>
<tr>
<td><b>ISBN 10:</b></td>
<td colspan="2"><%= rs2.getString("lit_isbn10") %></td>
</tr>
<%}
	if(rs2.getString("lit_isbn13")!=null){%>
<tr>
<td><b>ISBN 13:</b></td>
<td colspan="2"><%= rs2.getString("lit_isbn13") %></td>
</tr>
<%}%>

<tr>
<td><b>Kategori:</b></td>
<td colspan="2"><%= rs2.getString("lit_category") %></td>
</tr>
	
<tr>
<td><b>Följs av:</b></td>
<td colspan="2"><%= rs7.getString("Followees") %> personer</td>
</tr>

<tr>

<td><b>Betyg:</b></td>
<td><b><%= averageGrade %></b>/5.0 (<%= gradeCount %> röster)</td>
<td>
<form method="post" action="gradeLitt.jsp?id=<%= liid %>">

<select name="rating" id="rating"  width="100" style="width: 100px">
<option selected="true" value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
</select>
<input type="submit" value="Betygsätt"  class="btn btn-small btn-info">
</form>
</td>

</tr>


<tr><td colspan="3">
<%
if(!rs8.next()){

%>
<a href="followLitt.jsp?id=<%= liid %>&do=1" class="btn btn-success btn-primary">Följ</a>
<%}else{%>
<a href="followLitt.jsp?id=<%= liid %>&do=2" class="btn btn-success btn-primary">Sluta följa</a>

<%}
if(radeantal==0){%>
<a href="#myModal6" data-toggle="modal" class="btn btn-primary">Ladda upp PDF</a>
<%}else{%>
<a href="pdfviewer.jsp?lid=<%= liid %>" class="btn btn-primary">Öppna PDF</a>
<%}%>


<a href="#myModal5" data-toggle="modal" class="btn btn-primary">Ladda upp bokomslag</a>
<a href="litdisc.jsp?lid=<%= liid %>" class="btn btn-primary">Diskutera</a>
</td>
</tr>

</table>
</div></div>
 <div class="row-fluid">
<div class="span9">
<h3>Baksidestext</h3>
<div class="well">

<%= rs2.getString("lit_info_text")%>

</div></div></div>


<div class="row-fluid">
<div class="span12">
 
<h3>Senaste aktivitet</h3>

<div class="span3">
<h4>Nya uppladdningar:</h4>
<ul><%
if(rs6.next()){
	Integer x = 0;
	rs6.beforeFirst();
	while(rs6.next()){
		String str = rs6.getString("lit_title");
		String strlid = rs6.getString("lit_lid");
	
		if(str.length()>70){
			str = str.substring(0, 70) + "...";
		}
		%><li><a href="bokprofilsida.jsp?lid=<%= strlid %>"><%= str %></a></li><%		
		x++;
		if(x==4){
			%>(<a href="#myModal1" data-toggle="modal" >visa fler</a>)<%
			break;
		}
	}
}
else{
	%><li>Det finns inga böcker.</li><%
}%>



</ul>
</div>
  
  
 
<div class="span3">
<h4>Aktiva diskussioner:</h4>
<ul>
<%
	Integer y = 0;
	ArrayList<String> litdis1 = new ArrayList<String>();
	
	while(rs5.next()){	
		y++;
		String litTopic1 = rs5.getString("ldis_topic");
		
		if(!(litdis1.contains(litTopic1))){
			litdis1.add(litTopic1);
			String sq10 = "SELECT * FROM book_literature WHERE lit_lid ='"+rs5.getString("ldis_lid")+"'";
			pst10 = c1.prepareStatement(sq10);
			rs10 = pst10.executeQuery();
			rs10.next();
			
			%><li><a href="litchat.jsp?did=<%= rs5.getString("ldis_did") %>" ><%= litTopic1 %></a></li><%
		
			if(y==4){
				%>(<a href="#myModal2" data-toggle="modal" >visa fler</a>)<%
				break;
		    }
		}
	}
		
%>
</ul>
</div>
     



<div class="span3">

<h4>Nya följare:</h4>
<ul>
<% 
rs4.beforeFirst();
	if(!rs4.next()){
		%><li>Ingen följer den här boken.</li><%
	}
	else{
		rs4.beforeFirst();
		Integer z=0;
		while(rs4.next()){
			if(z==5){
				%>(<a href="#myModal3" data-toggle="modal" >visa fler</a>)<%
				break;
			}
			%><li><a href="otheruser.jsp?id=<%= rs4.getString("user_uid")%>"><%= rs4.getString("user_user_name") %></a></li><%
			z++;
		}
	}
%>
</ul>
</div>



  <div id="myModal1" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Nya bokuppladdningar:</h3>
  </div>
  <div class="modal-body"><ul>
		<%
		if(rs6!=null){
			rs6.beforeFirst();
		}
		int j =0;
		while(rs6.next()){
		String str = rs6.getString("lit_title");
		String strlid = rs6.getString("lit_lid");
		
		if(str.length()>70){
			str = str.substring(0, 70) + "...";
		}
		%><li><a href="bokprofilsida.jsp?lid=<%=strlid%>"><%= str %></a></li><%		
		j++;
		if(j==10) break;
		}%>
</ul>
	
  </div>
  
  <div class="modal-footer">
    <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Stäng</button>
	</form>
  </div></div>
  
  <div id="myModal2" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Aktiva diskussioner:</h3>
  </div>
  <div class="modal-body"><ul>
		<% 
		int z = 0;
		
		ArrayList<String> litdis = new ArrayList<String>();
		
		rs5.beforeFirst();
	
		while(rs5.next()){	
			
			String litTopic = rs5.getString("ldis_topic");
			
			if(!(litdis.contains(litTopic))){
				
			litdis.add(litTopic);
			
			String sq10 = "SELECT * FROM book_literature WHERE lit_lid ='"+rs5.getString("ldis_lid")+"'";
			
			pst10 = c1.prepareStatement(sq10);
			rs10 = pst10.executeQuery();
			rs10.next();
			
			%><li><a href="litchat.jsp?did=<%= rs5.getString("ldis_did") %>" ><%= litTopic %></a> <% 
		
			z++;
		
			if(z==10) break;
		    }
			
		}
		
		%>
</ul>
	
  </div>
  
  <div class="modal-footer">
    <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Stäng</button>
	</form>
  </div></div>
  
     <div id="myModal3" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Nya bokföljare:</h3>
  </div>
  <div class="modal-body"><ul>
		<%
		rs4.beforeFirst();
		if(!rs4.next()){
			%><li>Ingen följer den här boken.</li><%
		}else{
			rs4.beforeFirst();
			int i=0;
			while(rs4.next()){
			
			%><li><a href="otheruser.jsp?id=<%= rs4.getString("user_uid")%>"><%= rs4.getString("user_user_name") %></a></li><%
			i++;
			if(i==15) break;
			}
		}%>
</ul>
	
  </div>
 
  
  <div class="modal-footer">
    <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Stäng</button>
	</form>
  </div></div>
  
        <div id="myModal5" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Ladda upp bokomslag</h3>
  </div>
  <div class="modal-body">Välj en bildfil från din hårddisk. Max storlek: 2048 kB.<p>
  <form method="post" action="CoverUploadServlet?uid=<%= rs2.getString("lit_lid")%>" enctype="multipart/form-data">
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
    <h3 id="myModalLabel">Ladda upp PDF-fil</h3>
  </div>
  <div class="modal-body">Välj en PDF-fil från din hårddisk.<p>
  <form method="post" action="PDFUploadServlet?lid=<%= rs2.getString("lit_lid")%>&id=<%=un%>" enctype="multipart/form-data">
	<input type="file" name="pdf" id="pdf" accept="application/pdf" required>
  </div>
  
  <div class="modal-footer">
    <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Stäng</button>
    <button class="btn btn-success" type="submit">Ladda upp</button>
	</form>
  </div></div>
 

</div>	  
    </div></div>
  </div>
</div> 
 <hr>

      <div class="footer">
        <p>&copy; PVT Grupp 10</p>
      </div>  
</div>
	<script src="js/jquery.min.js"></script>
   
 <script src="js/bootstrap.min.js"></script>
<%
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
	 	if(pst12!=null) pst12.close();
		if(rs12!=null) rs12.close();
	 
        if(c1!=null) c1.close();
        %>
</body>
</html>