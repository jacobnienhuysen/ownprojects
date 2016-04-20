<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*;" %>

<% 

	String user = request.getParameter("uid");
	String circle = request.getParameter("cid");
	
	java.sql.Connection c1 = null;

	java.sql.PreparedStatement pst1;

	pst1 = null;
	
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
	
	String sq1 = "DELETE FROM book_user_circle WHERE ucrl_uid='"+user+"' AND ucrl_circle_cid='"+circle+"'";

	pst1 = c1.prepareStatement(sq1);
	pst1.executeUpdate();

	response.sendRedirect("GroupAdmin.jsp?cid="+circle+"");

if(c1!=null) c1.close();

if(pst1!=null) pst1.close();


%>