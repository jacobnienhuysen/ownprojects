<%@ page import="java.util.*" %>
<%@ page import="javax.sql.*;" %>

<%java.sql.Connection c1 = null;
java.sql.Statement s1 = null;



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


String did = (String)request.getParameter("did");


String fn = request.getParameter("fn");

if(fn!=null){

String com  = request.getParameter("com");

c1 = bookbookDB.getConnection();
	s1 = c1.createStatement();

	String sq1 = " INSERT INTO book_circle_discussion_comment (cdic_did, cdic_uid, cdic_text) VALUES ('"+did+"', '"+fn+"', '"+com+"')";
	
	s1.executeUpdate(sq1);

    if(c1!=null) c1.close();

response.sendRedirect("activityadd.jsp?id=7&val="+did+"");
}

%> 
