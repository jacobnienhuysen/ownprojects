
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%> 
<%@ page import ="javax.naming.InitialContext" %> 
<%@ page import="javax.sql.*;" %>
<%

java.sql.Connection c1 = null;
java.sql.Statement s1 = null;
java.sql.PreparedStatement pst1 = null;


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

	String cid = (String)request.getParameter("cid");
	String fn = (String)request.getParameter("do");

if(fn.equals("1") && cid!=null){
	
	String name=request.getParameter("name");
	
	c1 = bookbookDB.getConnection();
	s1 = c1.createStatement();
	String sq1= "UPDATE book_circle SET crcl_name ='"+name+"' WHERE crcl_cid='"+cid+"'";
	s1.executeUpdate(sq1);
	
	if(s1!=null) s1.close();
    if(c1!=null) c1.close();

response.sendRedirect("cirkelprofil.jsp?id="+cid);
}

if(fn.equals("2") && cid!=null){
	
	String info=request.getParameter("info");
	
	c1 = bookbookDB.getConnection();
	s1 = c1.createStatement();
	String sq1= "UPDATE book_circle SET crcl_info_text ='"+info+"' WHERE crcl_cid='"+cid+"'";
	s1.executeUpdate(sq1);
	
	if(s1!=null) s1.close();
    if(c1!=null) c1.close();

response.sendRedirect("cirkelprofil.jsp?id="+cid);
}





%>
