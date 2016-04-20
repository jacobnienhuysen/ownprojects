
<!DOCTYPE html>


		<%@ page import="java.util.*" %>
		<%@ page import="java.sql.*" %>
        <%@ page import="javax.sql.*;" %>


        <% 

        java.sql.Connection c1;
		java.sql.PreparedStatement pst1;
		java.sql.ResultSet rs1;
 
		
		String un = null;
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals("user")){
					un = cookies[i].getValue();
				}
			}
		}
		
        DataSource bookbookDB;

        Boolean alt;

        String classname;

        c1 = null;
		pst1 = null;
		rs1 = null;

        javax.naming.Context initCtx = new javax.naming.InitialContext();

        javax.naming.Context envCtx = (javax.naming.Context) initCtx.lookup("java:comp/env");

        bookbookDB = (DataSource) envCtx.lookup("jdbc/bookbookDB");


        try{

            if(bookbookDB == null) {

                javax.naming.Context initCtx1 = new javax.naming.InitialContext();

                javax.naming.Context envCtx1 = (javax.naming.Context) initCtx1.lookup("java:comp/env");

                bookbookDB = (DataSource) envCtx1.lookup("jdbc/bookbookDB");

            }

        }

        catch(Exception e){

            System.out.println("inside the context exception");

            e.printStackTrace();

        }

		
        c1 = bookbookDB.getConnection();
		String sq1= "SELECT * FROM book_user WHERE user_uid= ?";
		pst1 = c1.prepareStatement(sq1);
		pst1.setString(1, un);
		rs1 = pst1.executeQuery();
		rs1.next();
		%>
<html lang="sv">
  <head>

   	<title><%= rs1.getString("user_user_name")%>'s Litter</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	 
   <link href="bootstrap.min.css" rel="stylesheet" media="screen"/>

  </head>
 
  <body>
 
     <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="brand" href="loginLanding.jsp">Litter</a>
          <div class="nav-collapse collapse">
            <p class="navbar-text pull-right">
              Inloggad som <a href="profilsida.jsp" class="navbar-link"><%= rs1.getString("user_user_name")%></a>
            </p>
            <ul class="nav">
			
			
              
			  <li><a href="profilsida.jsp">Profilsida</a></li>
			 
			  
			  <!-- dropdown börjar //-->
			  <li class="dropdown">
			  <a href="#" class="dropdown-toggle" data-toggle="dropdown">Böcker <b class="caret"></b></a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
					<li><a tabindex="-1" href="bookshelf.jsp">Mina böcker</a></li>
					<li><a tabindex="-1" href="bookSearch.jsp">Sök böcker</a></li>
					<li class="divider"></li>
					<li><a tabindex="-1" href="loadLitt.jsp">Ladda upp bok</a></li>
				</ul>
			  </li>
			  
			<!-- dropdown slut //-->
			
			 <!-- dropdown börjar //-->
			  <li class="dropdown">
			  <a href="#" class="dropdown-toggle" data-toggle="dropdown">Personer <b class="caret"></b></a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
					<li><a tabindex="-1" href="friendlist.jsp">Du följer</a></li>
					<li><a tabindex="-1" href="userSearch.jsp">Sök användare</a></li>
					<li class="divider"></li>
					<li><a tabindex="-1" href="chatlist.jsp">Chat</a></li>
				</ul>
			  </li>
			  
			<!-- dropdown slut //-->
			
				<!-- dropdown börjar //-->
			  <li class="dropdown">
			  <a href="#" class="dropdown-toggle" data-toggle="dropdown">Bokcirklar <b class="caret"></b></a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
					<li><a tabindex="-1" href="gruppsida.jsp">Mina cirklar</a></li>
					<li><a tabindex="-1" href="circSearch.jsp">Sök cirklar</a></li>
					<li class="divider"></li>
					<li><a tabindex="-1" href="addgroup.jsp">Skapa cirkel</a></li>
				</ul>
			  </li
			<!-- dropdown slut //-->
			
			<li><a tabindex="-1" href="activityfeed.jsp">Nyhetsfeed</a></li>
			
              <li><a href="logout.jsp">Logga ut</a></li>
            </ul>
          </div>
        </div>
      </div>
    </div>
	<hr>
	

 
<div class="container-fluid">

  <div class="row-fluid">
   