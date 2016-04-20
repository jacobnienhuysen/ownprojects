<%@include file="unloggedMaster.jsp" %>

  <head>
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    

	
   <link href="bootstrap-responsive.css" rel="stylesheet"> 
  </head>
      <hr>


      <div class="row-fluid marketing">
	  <h3 class="lead"> Glömt lösenordet?</h3> 
<table border="0" class="main">

<tr><td colspan="2" height="100" valign="top">Skriv in e-mailadressen som du använde när du skapade kontot<br>
för att få ett nytt lösenord skickat till dig.<br><br>

<%
String err = (String)request.getParameter("id");
if(err == null){
	%><%
}else if(err.equals("1")){
	%><b class="alert alert-error">Felaktig inmatning.</b><%
}else if(err.equals("2")){
	%><b class="alert alert-error">Det finns ingen registrerad användare med den adressen.</b><%
}else if(err.equals("3")){
	%><b class="alert alert-success">Nytt lösenord skickat.</b><%
}
%>
</td></tr>

<form method="post" action="getPass.jsp">

<tr><td class="text">E-mailadress:</td>
<td><input type="email" lenght="65" name="email" id="email" required></td>
</tr>
<tr><td class="text">Upprepa e-mailadress:</td>
<td><input type="email" lenght="65" name="email2" id="email2" required></td>
</tr>


<tr><td colspan="2">
<input type="submit" class="btn btn-primary" value="Skicka nytt lösenord">
</td>
</tr>
</form>

</table>

        
      

      <hr>

      <div class="footer">
        <p>&copy; PVT Grupp 10</p>
      </div></div>

    </div> <!-- /container -->

 <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster --> 
	<script src="js/jquery.min.js"></script>
   
 <script src="js/bootstrap.min.js"></script>

  </body>
</html>
