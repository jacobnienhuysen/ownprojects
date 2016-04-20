
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

	String id = request.getParameter("id");
	String lb = request.getParameter("lb");

if(id.equals("1") && lb!=null){ //Ändra titeln
	
	String title=request.getParameter("title");
	
	c1 = bookbookDB.getConnection();
	s1 = c1.createStatement();
	String sq1= "UPDATE book_literature SET lit_title ='"+title+"' WHERE lit_lid='"+lb+"'";
	s1.executeUpdate(sq1);
	
	if(s1!=null) s1.close();
    if(c1!=null) c1.close();

	response.sendRedirect("bokprofilsida.jsp?lid="+lb);
}

if(id.equals("2") && lb!=null){ //Ändra författare
	
	String school=request.getParameter("school");
	
	c1 = bookbookDB.getConnection();
	s1 = c1.createStatement();
	String sq1= "UPDATE book_user_school SET usho_school_name ='"+school+"' WHERE usho_uid='"+lb+"'";
	s1.executeUpdate(sq1);
	
	if(s1!=null) s1.close();
    if(c1!=null) c1.close();
	response.sendRedirect("bokprofilsida.jsp?lid="+lb);
}

if(id.equals("3") && lb!=null){ //Ändra år
	
	String year=request.getParameter("year");
	
	c1 = bookbookDB.getConnection();
	s1 = c1.createStatement();
	String sq1= "UPDATE book_literature SET lit_published ='"+year+"' WHERE lit_lid='"+lb+"'";
	s1.executeUpdate(sq1);
	
	if(s1!=null) s1.close();
    if(c1!=null) c1.close();

	response.sendRedirect("bokprofilsida.jsp?lid="+lb);
}

if(id.equals("4") && lb!=null){ //Ändra ISBN
	
	String info=request.getParameter("infotext");
	
	
	c1 = bookbookDB.getConnection();
	s1 = c1.createStatement();
	String sq1= "UPDATE book_user SET user_info_text ='"+info+"' WHERE user_uid='"+lb+"'";
	s1.executeUpdate(sq1);
	
	if(s1!=null) s1.close();
    if(c1!=null) c1.close();

	response.sendRedirect("bokprofilsida.jsp?lid="+lb);
}

%>
