<!DOCTYPE html>
<html>
<body>
<head> <meta http-equiv="content-type" content="text/html;charset=UTF-8">
<link rel="stylesheet" type= "text/css" href="styles.css">
     

 </head>
<%@ page import="java.util.*" %>

        <%@ page import="javax.sql.*;" %>


        <% 


        java.sql.Connection c1;

        java.sql.Statement s1;

        java.sql.ResultSet rs1;

        java.sql.PreparedStatement pst1;

        DataSource bookbookDB;

        Boolean alt;

        String classname;


        c1=null;

        s1=null;

        pst1=null;

        rs1=null;

        alt=false;

        classname="";


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
		
		String un = (String)session.getAttribute("usern");
		
        String sq1= "SELECT * FROM book_user WHERE user_user_name='"+un+"'";
		
        pst1 = c1.prepareStatement(sq1);

        rs1 = pst1.executeQuery();
		rs1.next();

        %> 
<div class="header">
<div class="logo">
<img src="Pics/logo.png" alt="Logo" width="220"  height="60" ></div>
</div>
<div class="container">

<div class="content">
<div class="menu">

<ul id="navlist">
<li id="active"><a href="hemsida.html" id="current">Hem</a></li>
<li><a href="#">Feeds</a></li>
<li><a href="#">Bokhylla</a></li>
<li><a href="#">Bokl&auml;sare</a></li>

</ul>

</div>
<div class="rubrik1"><%= rs1.getString("user_user_name")%>s profilsida</div>



<div class="profilbild">
<img src="Pics/Female Silhouette.png" alt="profileImg" width="220" height="228">
</div>

<div class="userinfo"><table>
<tr>
<td width="100">Namn:</td>
<td><%=rs1.getString("user_first_name")%> <%=rs1.getString("user_sur_name")%></td>
</tr>
<tr>
<td>L&auml;ros&auml;te:</td>
<td></td>
</tr>
</table>
</div>

<div class="rubrik2">Presentation:</div>
<div class="presentation">
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec condimentum magna ut tellus venenatis blandit.
Sed nec aliquam ante. Sed ut arcu risus. Donec aliquam fringilla lorem non feugiat. Phasellus semper lobortis
sapien condimentum interdum. Cras at volutpat leo. Aliquam quis lectus nibh. Etiam ultrices laoreet justo id 
ullamcorper. Vivamus in elementum urna. Praesent et elit eu felis aliquam aliquam. Integer consequat nibh varius
ante porta sit amet vulputate nunc egestas. Aliquam erat volutpat.
</div>
<div class="line">
<img src="Pics/line.png" alt:"line" height="1"width="600"></div>
</div>
<div class="footer" >
Grupp 10 Productions PG</div>
</div>
<%
        if(pst1!=null) pst1.close();

        if(rs1!=null) rs1.close();

        if(c1!=null) c1.close();
        %>
</body>
</html>

