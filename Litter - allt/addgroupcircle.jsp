<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*;"%>
<%

String cowner = (String)request.getParameter("id");
String cinfo = request.getParameter("info");
String cname = request.getParameter("name");

java.sql.Connection c1;
c1 = null;

java.sql.Statement s1,s2,s3,s4;
s1 = null;
s2 = null;


java.sql.ResultSet rs1,rs2,rs3,rs4;
rs1 = null;


java.sql.PreparedStatement pst1,pst2,pst3,pst4;
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

String sq1 = "INSERT INTO book_circle (crcl_name, crcl_info_text, crcl_owner_uid) VALUES ('"+cname+"', '"+cinfo+"', '"+cowner+"')";
s1 = c1.createStatement();
s1.executeUpdate(sq1);

String sq2 ="SELECT crcl_cid FROM book_circle WHERE crcl_name='"+cname+"'";
pst1 = c1.prepareStatement(sq2);
rs1 = pst1.executeQuery();
rs1.next();
String cid = rs1.getString("crcl_cid");

String sq3 = "INSERT INTO book_user_circle (ucrl_uid, ucrl_circle_cid) VALUES ('"+cowner+"', '"+cid+"')";
s2 = c1.createStatement();
s2.executeUpdate(sq3);

response.sendRedirect("cirkelprofil.jsp?id="+cid+"");

if(c1!=null) c1.close();
if(s1!=null) s1.close();
if(rs1!=null) rs1.close();
if(pst1!=null) pst1.close();
if(s2!=null) s2.close();



%>