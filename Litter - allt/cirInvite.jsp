<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*;" %>

<%
	String recipientId = request.getParameter("friend");
	String recipient = "";
	String body = request.getParameter("body");
	String redirect = request.getParameter("redirect");
	
	java.sql.Connection c1 = null;
	
	java.sql.ResultSet rs1;
	java.sql.PreparedStatement pst1;
	
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
	
	String sq1 = "SELECT * FROM book_user WHERE user_uid = "+recipientId+"";

	pst1 = c1.prepareStatement(sq1);
	rs1 = pst1.executeQuery();
	rs1.next();
	
	recipient = rs1.getString("user_email");
	
	if(pst1!=null) pst1.close();
	if(rs1!=null) rs1.close();

	if(c1!=null) c1.close();
	
	response.sendRedirect("EmailServlet?recipient="+recipient+"&body="+body+"&redirect="+redirect+"");
	
%>