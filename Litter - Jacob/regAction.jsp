<%@ page import="java.util.*" %>
<%@ page import="javax.sql.*;" %>

<%

String uName = request.getParameter("username");
String fName = request.getParameter("firstname");
String sName = request.getParameter("surname");
String eMail = request.getParameter("mail");
String eMail2 = request.getParameter("mail2");
String school = request.getParameter("school");
String pass = request.getParameter("mypassword");
String pass2 = request.getParameter("mypassword2");

//Kontroller som genomförs innan saker och ting läggs in i registret

if(!eMail.equals(eMail2)){
	response.sendRedirect("loadError.jsp?id=10");
}
else if(!pass.equals(pass2)){
	response.sendRedirect("loadError.jsp?id=11");
}
else{


	java.sql.Connection c1 = null;
	java.sql.PreparedStatement pst1, pst2, pst3, pst4;
	pst1 = null;
	pst2 = null;
	pst3 = null;
	pst4 = null;
	
	java.sql.ResultSet rs1;
	rs1 = null;

	DataSource bookbookDB;

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
	
	String sq1 = "SELECT COUNT(*) FROM book_user WHERE user_email= ? OR user_user_name= ?";
	pst1 = c1.prepareStatement(sq1);
	pst1.setString(1, eMail);
	pst1.setString(2, uName);
	rs1 = pst1.executeQuery();
	rs1.next();
	Integer checkCnt = Integer.parseInt(rs1.getString(1));
	
	if(checkCnt>0){
		response.sendRedirect("loadError.jsp?id=6");
	}
	else{
	
		String sq2 = "INSERT INTO book_user (user_email, user_user_name, user_first_name, user_sur_name) VALUES (?,?,?,?)";
			pst2 = c1.prepareStatement(sq2);
			pst2.setString(1, eMail);
			pst2.setString(2, uName);
			pst2.setString(3, fName);
			pst2.setString(4, sName);
			pst2.executeUpdate();

		String sq3= "INSERT INTO book_user_school (usho_uid, usho_school_name) VALUES ((SELECT user_uid FROM book_user WHERE user_user_name = ?), ?)";
			pst3 = c1.prepareStatement(sq3);
			pst3.setString(1, uName);
			pst3.setString(2, school);
			pst3.executeUpdate();

		String sq4 = "INSERT INTO book_user_md5 (md5_uid, md5_pass) VALUES ((SELECT user_uid FROM book_user WHERE user_user_name = ?), MD5(?))";
			pst4 = c1.prepareStatement(sq4);
			pst4.setString(1, uName);
			pst4.setString(2, pass);
			pst4.executeUpdate();


			if(c1!=null) c1.close();
			if(pst1!=null) pst1.close();
			if(pst2!=null) pst2.close();
			if(pst3!=null) pst3.close();
			if(pst4!=null) pst4.close();
			if(rs1!=null) rs1.close();
				
		response.sendRedirect("login.jsp");
		
		}
	}
	%>