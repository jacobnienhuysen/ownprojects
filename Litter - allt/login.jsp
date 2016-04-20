<%@include file="unloggedMaster.jsp" %>

  <head>
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    

	
   <link href="bootstrap-responsive.css" rel="stylesheet"> 
  </head>
      <hr>


      <div class="row-fluid marketing">
	  <h3 class="lead"> Logga in</h3> 
<table border="0" class="main">
<form method="post" action="loginAction.jsp">

<tr><td class="text">Användarnamn: </td>
<td><input type="text" lenght="65" name="UserName"></td>
</tr>
<tr><td class="text">Lösenord: </td>
<td><input type="password" lenght="65" name="Password"></td>
</tr>
<tr><td colspan="2">
<input type="submit" class="btn btn-success" value="Logga in">
</td>
</tr>

<input type="hidden" name="redirect" value="parameters:UserName" />
</form>
<tr height="30" valign="bottom"><td class="text2"><a href="forgotPass.jsp">Glömt lösenord? >></a></td></tr>


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
