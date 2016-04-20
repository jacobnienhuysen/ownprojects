<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*;" %>

<% 

String discName = request.getParameter("littDisc");
String littId = request.getParameter("lid");

String un = null;
	
	Cookie[] cookies = request.getCookies();
	
	if (cookies != null) {
		for (int i = 0; i < cookies.length; i++) {
			if (cookies[i].getName().equals("user")){
				un = cookies[i].getValue();
			}
		}
	}

	String action = request.getParameter("id");
	String value = request.getParameter("val");
	
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
		String sq1 = "INSERT INTO book_literature_discussion (ldis_lid, ldis_topic, ldis_owner_uid) VALUES ('"+littId+"', '"+discName+"', '"+un+"')";
		s1.executeUpdate(sq1);

		String sq2 = "SELECT * FROM book_literature_discussion WHERE ldis_topic='"+discName+"'";
		pst2 = c1.prepareStatement(sq2);
			
		rs1 = pst2.executeQuery();
		rs1.next();
		
		String discId = rs1.getString("ldis_did");
	
	response.sendRedirect("litchat.jsp?did="+discId+"");
	
if(c1!=null) c1.close();

if(rs1!=null) rs1.close();

if(s1!=null) s1.close();
if(pst2!=null) pst2.close();
	
	
	
%>