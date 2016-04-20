<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*;" %>

<%
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

	java.sql.Connection c1 = null;
	java.sql.PreparedStatement pst1;
	
	c1 = bookbookDB.getConnection();
	pst1 = null;
	
	String ac = request.getParameter("ac");
	String id = request.getParameter("id");
	Integer idnr = 0;
	
	if(id!=null){
		idnr = Integer.parseInt(id);
	}
	else{
		response.sendRedirect("adminMain.jsp");
	}

	if(ac.equals("us") && id!=null){
		idnr = (idnr/7)-1;
		String sq1 = "DELETE FROM book_user WHERE user_uid= ?";
		pst1 = c1.prepareStatement(sq1);
		pst1.setString(1, ""+idnr);
		pst1.executeUpdate();
		
		if(c1!=null) c1.close();
		if(pst1!=null) pst1.close();
		response.sendRedirect("adminMain.jsp?id=1");
	}
	else if(ac.equals("bo") && id!=null){
		idnr = (idnr/7)-1;
		String sq1 = "DELETE FROM book_literature WHERE lit_lid= ?";
		pst1 = c1.prepareStatement(sq1);
		pst1.setString(1, ""+idnr);
		pst1.executeUpdate();
		
		if(c1!=null) c1.close();
		if(pst1!=null) pst1.close();
		response.sendRedirect("adminMain.jsp?id=2");
	}
	else if(ac.equals("ci") && id!=null){
		idnr = (idnr/7)-1;
		String sq1 = "DELETE FROM book_circle WHERE crcl_cid= ?";
		pst1 = c1.prepareStatement(sq1);
		pst1.setString(1, ""+idnr);
		pst1.executeUpdate();
		
		if(c1!=null) c1.close();
		if(pst1!=null) pst1.close();
		response.sendRedirect("adminMain.jsp?id=3");
	}
	else{
		if(c1!=null) c1.close();
		if(pst1!=null) pst1.close();
		response.sendRedirect("adminMain.jsp");
	}

%>