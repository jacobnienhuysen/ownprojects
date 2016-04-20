<%@include file="Masterpage.jsp" %>

<!DOCTYPE html>
<html lang="sv">

        <% 
        java.sql.ResultSet rs2,rs3;
        java.sql.PreparedStatement pst2,pst3;

		pst2 = null;
		pst3 = null;

		rs2 = null;
		rs3 = null;
		
		String frB = (String)request.getParameter("t");
		String ch = (String)request.getParameter("ch");
		String search = (String)request.getParameter("search");
		String cat = (String)request.getParameter("cat");
		String lookFor = "";
		String sq2 = "";
		
		if(ch!=null){
			if(ch.equals("title")){
				lookFor = (String)request.getParameter("search");
				sq2 = "SELECT * FROM book_literature WHERE lit_title LIKE ? ORDER BY lit_title";
				pst2 = c1.prepareStatement(sq2);
				pst2.setString(1, "%" + lookFor + "%");
				rs2 = pst2.executeQuery();
			}
			else if(ch.equals("author")){
				lookFor = (String)request.getParameter("search");
				sq2 = "SELECT * FROM book_literature INNER JOIN book_literature_author ON book_literature.lit_lid=book_literature_author.lita_lid WHERE lita_author_name LIKE ? ORDER BY book_literature.lit_title";
				pst2 = c1.prepareStatement(sq2);
				pst2.setString(1, "%" + lookFor + "%");
				rs2 = pst2.executeQuery();
			}
			else if(ch.equals("category")){
				lookFor = (String)request.getParameter("cat");
				sq2 = "SELECT * FROM book_literature WHERE lit_category LIKE ? ORDER BY lit_title";
				pst2 = c1.prepareStatement(sq2);
				pst2.setString(1, "%" + lookFor + "%");
				rs2 = pst2.executeQuery();
			}
		}
		else{
			response.sendRedirect("bookList.jsp");
		}
		
		Integer startAtBook = 0;
		Integer shownCnt = 0;
		
		if(frB!=null){
			startAtBook = Integer.parseInt(frB);
		}

        %> 


  <head>
    <title>Sök böcker</title>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
    <link href="bootstrap-responsive.css" rel="stylesheet" media="screen">
  </head>
  
		  
<div class="span8">
		<div class="jumbotron">
			<h2>Sökresultat</h2> 
		</div>
<div class="well well-small">

<table class="table table-striped">


<%
	if(rs2.next()){
		rs2.beforeFirst();
		
		for(int y=0;y<startAtBook;y++){
			rs2.next();
		}
		while(rs2.next()){
		
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
<!-- Bok börjar //-->
<tr>
	<td width="130"><img src="<%if(rs2.getString("lit_cover")==null){ out.print("img/Help_book.png"); } else { out.print("displaycover.jsp?id="+rs2.getString("lit_lid")); } %>" width="90"></td>
	<td><a href="bokprofilsida.jsp?lid=<%=rs2.getString("lit_lid")%>"> <b><%= rs2.getString("lit_title") %> </a></b><br>
	<i> <% for(int i=0; i<authorList.size();i++){
			out.println(authorList.get(i));
			if(i<authorList.size() && i!=authorList.size()){%><br><% }}%></i>
			<br>
			<b>Kategori:</b> <i><%= rs2.getString("lit_category") %></i>
			
			</td>
</tr>


<!-- Bok slutar //-->
<% 	shownCnt++;
	if(shownCnt==5)
		break;
}
}else{
	%><tr><td><h5>Det finns inga böcker som matchar dina kriterier.</h5></td></tr><%
}%>	




<!-- Visningsalternativ //-->

<tr>

<td colspan="2" class="text-center">
<a href="bookSearch.jsp">< Ny sökning</a>
<%if(startAtBook>1){%>
<a href="searchResult.jsp?search=<%=search%>&ch=<%=ch%>&cat=<%=cat%>&t=<%=startAtBook-5%>">Bakåt</a>  <%}%>
<b><%= startAtBook+1 %> - <%= startAtBook+5 %></b>
<%if(rs2.next()){%><a href="searchResult.jsp?search=<%=search%>&ch=<%=ch%>&cat=<%=cat%>&t=<%= startAtBook+5 %>">Framåt</a><%}%>
</td>
</tr>

</table>

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

if(c1!=null) c1.close();
%>
