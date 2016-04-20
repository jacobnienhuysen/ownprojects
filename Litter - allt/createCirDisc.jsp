<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*;" %>

<% 

String cirDisName = request.getParameter("circDisc");
String cid = request.getParameter("cid");

String un = null;
	
	Cookie[] cookies = request.getCookies();
	
	if (cookies != null) {
		for (int i = 0; i < cookies.length; i++) {
			if (cookies[i].getName().equals("user")){
				un = cookies[i].getValue();
			}
		}
	}

	java.sql.Connection c1 = null;
	
	java.sql.Statement s1;
	java.sql.PreparedStatement pst2;
	java.sql.ResultSet rs1;
	
	s1 = null;
	pst2 = null;
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

		s1 = c1.createStatement();
		String sq1 = "INSERT INTO book_circle_discussion (cdis_cid, cdis_topic, cdis_owner_uid) VALUES ('"+cid+"', '"+cirDisName+"', '"+un+"')";
		s1.executeUpdate(sq1);

		String sq2 = "SELECT * FROM book_circle_discussion WHERE cdis_topic='"+cirDisName+"'";
		pst2 = c1.prepareStatement(sq2);
			
		rs1 = pst2.executeQuery();
		rs1.next();
		
		String discId = rs1.getString("cdis_did");
	
	response.sendRedirect("circhat.jsp?did="+discId+"");
	
if(c1!=null) c1.close();

if(rs1!=null) rs1.close();

if(s1!=null) s1.close();
if(pst2!=null) pst2.close();
	
	
	
%>