
<%@ page import="java.util.*" %>
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
	String fn = null;
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals("user")){
					fn = cookies[i].getValue();
				}
			}
		}
		
	String lid = request.getParameter("id");
	String action = request.getParameter("do");

	if(lid!=null && action.equals("1")){
		c1 = bookbookDB.getConnection();
		s1 = c1.createStatement();
		String sq1= "INSERT INTO book_user_literature (ulit_uid, ulit_lid) VALUES ('"+fn+"', '"+lid+"')";
		s1.executeUpdate(sq1);
	

		if(c1!=null) c1.close();
		if(s1!=null) s1.close();
		response.sendRedirect("activityadd.jsp?id=5&val="+lid+"");
		
	}
	
	if(lid!=null && action.equals("2")){
		c1 = bookbookDB.getConnection();
		s1 = c1.createStatement();
		String sq1= "DELETE FROM book_user_literature WHERE ulit_uid='"+fn+"' AND ulit_lid='"+lid+"'";
		s1.executeUpdate(sq1);
	

		if(c1!=null) c1.close();
		if(s1!=null) s1.close();
		response.sendRedirect("bokprofilsida.jsp?lid="+lid);
	}
	
	if(lid == null || action == null){
		response.sendRedirect("bokprofilsida.jsp?lid="+lid);
	}
%>
