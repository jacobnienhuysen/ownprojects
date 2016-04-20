<html>
<head>
<title>Litter - Login</title>
</head>

    <body>


        <%@ page import="java.util.*" %>

        <%@ page import="javax.sql.*" %>
		
		<%@ page import="java.security.*;" %>

        <%
		
		
		
		String uName=request.getParameter("UserName");
		
		String pass=request.getParameter("Password");
		

        java.sql.Connection c1,c2;

        java.sql.Statement s1,s2;

        java.sql.ResultSet rs1,rs2;

        java.sql.PreparedStatement pst1,pst2;

        DataSource bookbookDB;

        Boolean alt;

        String classname;

        c1=null;

        s1=null;

        pst1=null;

        rs1=null;
		
		c2=null;

        s2=null;

        pst2=null;

        rs2=null;

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
		
        String sq1= "SELECT * FROM book_user WHERE user_user_name='"+uName+"'";
		
		pst1 = c1.prepareStatement(sq1);
        rs1 = pst1.executeQuery();
		
		if(rs1.next()){ //om det inmatade användarnamnet finns i registret
			c2 = bookbookDB.getConnection();
			String usid = rs1.getString("user_uid");
			String sq2 ="SELECT * FROM book_user_md5 WHERE md5_uid='"+usid+"'";
			pst2 = c2.prepareStatement(sq2);
			rs2 = pst2.executeQuery();
			if(rs2.next()){ //om det finns två likadana användarid i båda tabellerna
			
				String passwd = pass;

				MessageDigest alg = MessageDigest.getInstance("MD5");

				alg.reset(); 

				alg.update(passwd.getBytes());

				byte[] digest = alg.digest();

				// Convert the hash from whatever format it's in, to hex format
				// which is the normal way to display and report md5 sums
				// This is done byte by byte, and put into a StringBuffer
				StringBuffer hashedpasswd = new StringBuffer();
				String hx;
				for (int i=0;i<digest.length;i++){
					hx =  Integer.toHexString(0xFF & digest[i]);
					//0x03 is equal to 0x3, but we need 0x03 for our md5sum
					if(hx.length() == 1){hx = "0" + hx;}
					hashedpasswd.append(hx);
				}
			
				String check = hashedpasswd.toString();
			
			
				if(check.equals(rs2.getString("md5_pass"))){
					session.setAttribute("usern", uName);
					%>
					<jsp:forward page="profilsida.jsp"/> //logged-in page
					<%
				}else{
					response.sendRedirect("invalidLogin.jsp"); //error page
				}
			}else{
				response.sendRedirect("invalidLogin.jsp"); //error page 
			}
		}else{
			response.sendRedirect("invalidLogin.jsp"); //error page 
		}



        if(pst1!=null) pst1.close();

        if(rs1!=null) rs1.close();

        if(c1!=null) c1.close();

        %>


    </body>
</html>


