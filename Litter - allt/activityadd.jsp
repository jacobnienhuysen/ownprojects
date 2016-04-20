<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*;" %>

<% 
	
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
	
	java.sql.Statement s1,s2,s3,s4,s5,s6,s7;
	java.sql.ResultSet rs1;
	java.sql.PreparedStatement pst1;
	
	s1 = null;
	s2 = null;
	s3 = null;
	s4 = null;
	s5 = null;
	s6 = null;
	s7 = null;
	
	rs1 = null;
	
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

	if(action.equals("1")){ //kod för uppladning av bok

		s1 = c1.createStatement();
		String sq1 = "INSERT INTO book_feed (feed_uid, feed_book_upload) VALUES ("+un+", "+value+")";
		s1.executeUpdate(sq1);
		
		response.sendRedirect("bokprofilsida.jsp?lid="+value+"");
	
	}
	
	if(action.equals("2")){ //kod för att anv bytt skola
	
		String ps1 = "SELECT * FROM book_user_school WHERE usho_uid = '"+un+"'"; 
		
		pst1 = c1.prepareStatement(ps1);
		rs1 = pst1.executeQuery();
		rs1.next();
	
		s2 = c1.createStatement();
		String school = rs1.getString("usho_school_name");
		String sq2 = "INSERT INTO book_feed (feed_uid, feed_school_change) VALUES ("+un+", '"+school+"')";
		s2.executeUpdate(sq2);
		
		response.sendRedirect("profilsida.jsp?");
	}	
	
	if(action.equals("3")){ //kod för att anv gått med i cirkel

		s3 = c1.createStatement();
		String sq3 = "INSERT INTO book_feed (feed_uid, feed_circle_join) VALUES ("+un+", "+value+")";
		s3.executeUpdate(sq3);
		
		response.sendRedirect("cirkelprofil.jsp?id="+value+"");
	}	
	
	if(action.equals("4")){ //kod för att anv börjat följa en annan anv

		s4 = c1.createStatement();
		String sq4 = "INSERT INTO book_feed (feed_uid, feed_user_follow) VALUES ("+un+", "+value+")";
		s4.executeUpdate(sq4);
		
		response.sendRedirect("otheruser.jsp?id="+value+"");
	}
	
	if(action.equals("5")){ //kod för att anv börjat följa en bok

		s5 = c1.createStatement();
		String sq5 = "INSERT INTO book_feed (feed_uid, feed_book_follow) VALUES ("+un+", "+value+")";
		s5.executeUpdate(sq5);
		
		response.sendRedirect("bokprofilsida.jsp?lid="+value+"");
	}
	
	if(action.equals("6")){ //kod för att anv chattat om en bok

		s6 = c1.createStatement();
		String sq6 = "INSERT INTO book_feed (feed_uid, feed_book_chat) VALUES ("+un+", "+value+")";
		s6.executeUpdate(sq6);
		
		response.sendRedirect("litchat.jsp?did="+value+"");
	}
	
	if(action.equals("7")){ //kod för att anv chattat i en cirkel

		s7 = c1.createStatement();
		String sq7 = "INSERT INTO book_feed (feed_uid, feed_circle_chat) VALUES ("+un+", "+value+")";
		s7.executeUpdate(sq7);
		
		response.sendRedirect("circhat.jsp?did="+value+"");
	}


if(c1!=null) c1.close();

if(rs1!=null) rs1.close();

if(pst1!=null) pst1.close();

if(s1!=null) s1.close();
if(s2!=null) s2.close();
if(s3!=null) s3.close();
if(s4!=null) s4.close();	
if(s5!=null) s5.close();
if(s6!=null) s6.close();
if(s7!=null) s7.close();
%>