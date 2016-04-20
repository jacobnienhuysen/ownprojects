<%@include file="Masterpage.jsp" %>

<% 
String title = request.getParameter("title");
String author = request.getParameter("author");
String bookYear = request.getParameter("bookYear");
String isbn10 = request.getParameter("isbn10");
String isbn13 = request.getParameter("isbn13");
String category = request.getParameter("cat");
String infoText = request.getParameter("infoText");

//Dessa if-satser kontrollerar om inmatade data är korrekta. Dessa är flyttade från action-filen.

if(bookYear.length()!=4){ 	//om årtalet har fel längd
	response.sendRedirect("loadError.jsp?id=3");
}

else if(isbn10!=null && isbn10!="" && isbn10.length()!=10){		//Om isbn10 har fel längd
	response.sendRedirect("loadError.jsp?id=2");
}

else if(isbn13!=null && isbn13!="" && isbn13.length()!=13){		//Om isbn13 har fel längd
	response.sendRedirect("loadError.jsp?id=2");
}

else if(isbn10==null && isbn13==null || isbn10=="" && isbn13==""){
	response.sendRedirect("loadError.jsp?id=9");
}

String[] authorList = null;
if(author.contains(";")){
	authorList = author.split(";", -1);
}

%>

<!DOCTYPE html>
<html lang="en">


  <head>
    <title>Ladda upp</title>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
    <link href="bootstrap-responsive.css" rel="stylesheet" media="screen">
  </head>
  
   
		  
<div class="span5">
	<div class="jumbotron">
		  
	<p><h2>Ladda upp kurslitteratur</h2></p>
    <form name="laddaupp" action="loadAction.jsp" method="post">
    
    <legend>Förhandsgranska:</legend>
	<table width="400">
	
	<tr><td><b>Titel</b></td></tr>
	<tr valign="top"><td><%= title %><p></td></tr>
	<input type="hidden" value="<%= title %>" id="title" name="title">
	
	<tr><td><b>Författare</b></td></tr>
    <tr valign="top"><td>
	<% 	if(authorList!=null){
			for(int x=0; x<authorList.length; x++){
				out.println(authorList[x]);
				if(x!=authorList.length)
					out.println("<br>");
			}
		}
		else{
			out.println(author);
		}
	%><p></td></tr>
	<input type="hidden" value="<%= author %>" id="author" name="author">
    
	<tr><td><b>Utgivningsår</b></td></tr>
    <tr valign="top"><td><%= bookYear %><p></td></tr>
	<input type="hidden" value="<%= bookYear %>" id="bookYear" name="bookYear">
    
	<%if(isbn10!=null && isbn10!=""){%>
		<tr><td><b>ISBN 10</b></td></tr>
		<tr valign="top"><td><%= isbn10 %><p></td></tr>
		<input type="hidden" value="<%= isbn10 %>" id="isbn10" name="isbn10">
	<%}%>
	
	<%if(isbn13!=null && isbn13!=""){%>
		<tr><td><b>ISBN 13</b></td></tr>
		<tr valign="top"><td><%= isbn13 %><p></td></tr>
		<input type="hidden" value="<%= isbn13 %>" id="isbn13" name="isbn13">
   <%}%>
   
	<tr><td><b>Kategori</b></td></tr>
	<tr valign="top"><td><%= category %><p></td></tr>
	<input type="hidden" value="<%= category %>" id="category" name="category">
   
	<tr><td><b>Baksidestext</b></td></tr>
	<tr><td><%= infoText %><p></td></tr>
	<input type="hidden" value="<%= infoText %>" id="infoText" name="infoText">
	
	<tr height="50" valign="bottom"><td>
    <button type="submit" class="btn btn-success">Ladda upp</button>
    <a href="javascript:history.go(-1)" class="btn btn-primary">Ändra</a>
	</td>
	</tr>
	</table>
	</form>		
    
    </div>





</div>
</div>   
</div>

     
	  
<!-- Le javascript 
================================================== -->
<!-- Placed at the end of the document so the pages load faster --> 
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>

</body>
</html>
