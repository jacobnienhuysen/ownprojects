<%@include file="Masterpage.jsp" %>
<!DOCTYPE html>
<html lang="en">



		<%
		java.sql.PreparedStatement pst2,pst3,pst4,pst5;
		java.sql.ResultSet rs2,rs3,rs4,rs5;
		
		pst2 = null;
		pst3 = null;
		pst4 = null;
		pst5 = null;
		
		rs2 = null;
		rs3 = null;
		rs4 = null;
		rs5 = null;
		
		
		String sq2 = "SELECT * FROM book_literature INNER JOIN book_literature_pdf ON book_literature.lit_lid=book_literature_pdf.lit_pdf_lid WHERE book_literature_pdf.lit_pdf_oid= ?";
		pst2 = c1.prepareStatement(sq2);
		pst2.setString(1, un);
		rs2 = pst2.executeQuery();
		
		String sq4 = "SELECT * FROM book_literature INNER JOIN book_user_literature ON book_literature.lit_lid=book_user_literature.ulit_lid JOIN book_user ON book_user_literature.ulit_uid=book_user.user_uid WHERE book_user.user_uid= ?";
		pst4 = c1.prepareStatement(sq4);
		pst4.setString(1, un);
		rs4 = pst4.executeQuery();
		

		
		
		
		

        %> 


  <head>
    <title>Litter</title>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
    <link href="bootstrap-responsive.css" rel="stylesheet" media="screen">
  </head>
  
    
		  
<div class="span7">
	<div class="jumbotron">
	<h2>Mina böcker</h2> 
		
<legend>PDF-böcker</legend>
<div class="well well-small">
<table class="table table-striped" border="0">
<%if(rs2.next()){
	rs2.beforeFirst();
	while(rs2.next()){%>
		
		<!-- Bok börjar //-->
		<%
		String sq3 = "SELECT * FROM book_literature_author WHERE lita_lid = ?";
		pst3 = c1.prepareStatement(sq3);
		pst3.setString(1, rs2.getString("book_literature.lit_lid"));
		rs3 = pst3.executeQuery();
		
		List<String> authorList = new ArrayList<String>();
		if(authorList.size()>0) authorList.clear();
		
		while(rs3.next()){
			authorList.add(rs3.getString("lita_author_name"));
		}
		rs3.close();
		pst3.close();
		
		%>
		
		<tr>
		<td align="center" rowspan="2">
		<% if((rs2.getString("lit_cover")) == null ){ %>
			<img src="img/Help_book.png" width="100" border="0" alt="<%= rs2.getString("lit_title")%> - Omslag saknas" title="<%= rs2.getString("lit_title")%> - Omslag saknas">
		<% } else { %>
			<img src="displaycover.jsp?id=<%=rs2.getString("lit_lid")%>" width="100" border="0" alt="<%= rs2.getString("lit_title")%>" title="<%= rs2.getString("lit_title")%>">
		<% } %>  
		</td>
		
		<td><b><a href="bokprofilsida.jsp?lid=<%=rs2.getString("lit_lid")%>"><%= rs2.getString("lit_title")%></b></a><br>
		<i><%for(int i=0; i<authorList.size();i++){
			out.println(authorList.get(i));
			if(i<authorList.size() && i!=authorList.size()){%><br><% }} %>
		</i></td>
		</tr>
		
		<tr>
		<td>
			<a href="pdfviewer.jsp?lid=<%= rs2.getString("lit_lid") %>" class="btn btn-small btn-primary">Öppna PDF</a>
			<a href="litdisc.jsp?lid=<%= rs2.getString("lit_lid") %>" class="btn btn-small btn-primary">Diskutera</a>
		</td>
		</tr>
		<!-- Bok slutar //-->
	<%}
	}else{%>	
	<b>Du har inte laddat upp några PDF:er</b>
	<%}%>	
</table>
</div>

<legend>Favoritmarkerade</legend>
<div class="well well-small">

<table class="table table-striped" border="0">
<%if(rs4.next()){
	rs4.beforeFirst();
	while(rs4.next()){%>
	
				<!-- Bok börjar //-->
		<%
		String sq5 = "SELECT * FROM book_literature_author WHERE lita_lid = ?";
		pst5 = c1.prepareStatement(sq5);
		pst5.setString(1, rs4.getString("book_literature.lit_lid"));
		rs5 = pst5.executeQuery();
		
		//String[] authorList;
		List<String> authorList2 = new ArrayList<String>();
		if(authorList2.size()>0) authorList2.clear();
		
		while(rs5.next()){
			authorList2.add(rs5.getString("lita_author_name"));
		}
		rs5.close();
		pst5.close();
		%>
		
		<tr>
		<td align="center" rowspan="2">
		<% if((rs4.getString("lit_cover")) == null ){ %>
			<img src="img/Help_book.png" width="100" border="0" alt="<%= rs4.getString("lit_title")%> - Omslag saknas" title="<%= rs4.getString("lit_title")%> - Omslag saknas">
		<% } else { %>
			<img src="displaycover.jsp?id=<%=rs4.getString("lit_lid")%>" width="100" border="0" alt="<%= rs4.getString("lit_title")%>" title="<%= rs4.getString("lit_title")%>">
		<% } %>  
		</td>
		
		<td><b><a href="bokprofilsida.jsp?lid=<%=rs4.getString("lit_lid")%>"><%= rs4.getString("lit_title")%></b></a><br>
		<i><%for(int i=0; i<authorList2.size();i++){
			out.println(authorList2.get(i));
			if(i<authorList2.size() && i!=authorList2.size()){%><br><% }} %>
		</i></td>
		</tr>
		
		<tr>
		<td>
			<a href="litdisc.jsp?lid=<%= rs4.getString("lit_lid") %>" class="btn btn-small btn-primary">Diskutera</a>
		</td>
		</tr>
		<!-- Bok slutar //-->
		

	<%}
	}else{%>	
	<b>Du har inte favoritmarkerat några böcker.</b>
	<%}%>
</table>
</div>

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

if(pst4!=null) pst4.close();
if(rs4!=null) rs4.close();

if(pst5!=null) pst5.close();
if(rs5!=null) rs5.close();

if(c1!=null) c1.close();
%>
