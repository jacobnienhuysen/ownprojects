
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

		String un = null;
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals("user")){
					un = cookies[i].getValue();
				}
			}
		}
		
	String cid = request.getParameter("cid");
	String action = request.getParameter("do");

	if(cid!=null && action.equals("1")){
		c1 = bookbookDB.getConnection();
		s1 = c1.createStatement();
		String sq1= "INSERT INTO book_user_circle(ucrl_circle_cid, ucrl_uid) VALUES ('"+cid+"', '"+un+"')";
		s1.executeUpdate(sq1);
	

		if(c1!=null) c1.close();
		if(s1!=null) s1.close();
		
		response.sendRedirect("activityadd.jsp?id=3&val="+cid);
	}
	
	if(cid!=null && action.equals("2")){
		c1 = bookbookDB.getConnection();
		s1 = c1.createStatement();
		String sq1= "DELETE FROM book_user_circle WHERE ucrl_circle_cid='"+cid+"' AND ucrl_uid='"+un+"'";
		s1.executeUpdate(sq1);
	

		if(c1!=null) c1.close();
		if(s1!=null) s1.close();
		
		response.sendRedirect("cirkelprofil.jsp?id="+cid);
	}
	
	if(cid == null || action == null){
		response.sendRedirect("cirkelprofil.jsp?id="+cid);
	}

%>
