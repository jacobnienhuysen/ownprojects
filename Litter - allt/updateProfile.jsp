
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
		<%@ page import="java.security.*" %>
<%@ page import ="javax.naming.InitialContext" %> 
<%@ page import="javax.sql.*;" %>
<%

java.sql.Connection c1 = null;
java.sql.PreparedStatement pst1 = null;
java.sql.ResultSet rs1 = null;

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
	String fn = request.getParameter("fn");

if(id.equals("1") && fn!=null){
	
	String firstName=request.getParameter("firstname");
	String surName=request.getParameter("surname");
	
	c1 = bookbookDB.getConnection();

	String sq1= "UPDATE book_user SET user_first_name = ?, user_sur_name= ? WHERE user_uid= ?";
	pst1 = c1.prepareStatement(sq1);
	pst1.setString(1, firstName);
	pst1.setString(2, surName);
	pst1.setString(3, fn);
	pst1.executeUpdate();
	
	if(pst1!=null) pst1.close();
    if(c1!=null) c1.close();

response.sendRedirect("profilsida.jsp");
}

if(id.equals("2") && fn!=null){
	
	String school=request.getParameter("school");
	
	c1 = bookbookDB.getConnection();

	String sq1= "UPDATE book_user_school SET usho_school_name = ? WHERE usho_uid= ?";
	pst1 = c1.prepareStatement(sq1);
	pst1.setString(1, school);
	pst1.setString(2, fn);
	pst1.executeUpdate();
	
	if(pst1!=null) pst1.close();
    if(c1!=null) c1.close();
	response.sendRedirect("activityadd.jsp?id=2&val="+school+"");
}

if(id.equals("3") && fn!=null){
	
	String htown=request.getParameter("hometown");
	
	c1 = bookbookDB.getConnection();

	String sq1= "UPDATE book_user SET user_hometown = ? WHERE user_uid= ?";
	pst1 = c1.prepareStatement(sq1);
	pst1.setString(1, htown);
	pst1.setString(2, fn);
	pst1.executeUpdate();
	
	if(pst1!=null) pst1.close();
    if(c1!=null) c1.close();

response.sendRedirect("profilsida.jsp");
}

if(id.equals("4") && fn!=null){
	
	String info=request.getParameter("infotext");
	
	
	c1 = bookbookDB.getConnection();
	
	String sq1= "UPDATE book_user SET user_info_text = ? WHERE user_uid= ?";
	pst1 = c1.prepareStatement(sq1);
	pst1.setString(1, info);
	pst1.setString(2, fn);
	pst1.executeUpdate();
	
	if(pst1!=null) pst1.close();
    if(c1!=null) c1.close();

response.sendRedirect("profilsida.jsp");
}

if(id.equals("5") && fn!=null){

c1 = bookbookDB.getConnection();
String check ="";	
String oldp = request.getParameter("oldp");
String newp = request.getParameter("newp");
String new2p = request.getParameter("new2p");

	if(!newp.equals(new2p)){
		response.sendRedirect("loadError.jsp?id=7");
	}
	else{
		String usid = fn;
		String sq1 ="SELECT * FROM book_user_md5 WHERE md5_uid= ?";
		pst1 = c1.prepareStatement(sq1);
		pst1.setString(1, usid);
		rs1 = pst1.executeQuery();
		if(rs1.next()){ //om det finns två likadana användarid i båda tabellerna
				
			String passwd = oldp;

			MessageDigest alg = MessageDigest.getInstance("MD5");

			alg.reset(); 

			alg.update(passwd.getBytes());

			byte[] digest = alg.digest();

			// Convert the hash from whatever format it's in, to hex format
			// which is the normal way to display and report md5 sums
			// This is done byte by byte, and put into a StringBuffer
			StringBuffer hashedpasswd = new StringBuffer();
			String hx;
			for (int i=0;i<digest.length;i++){
			hx =  Integer.toHexString(0xFF & digest[i]);
			//0x03 is equal to 0x3, but we need 0x03 for our md5sum
			if(hx.length() == 1){hx = "0" + hx;}
				hashedpasswd.append(hx);
			}
					
			check = hashedpasswd.toString();
		}
		
		if(check.equals(rs1.getString("md5_pass"))){ //om man har matat in korrekt gammalt lösenord
			String sq2= "UPDATE book_user_md5 SET md5_pass=MD5(?) WHERE md5_uid= (?)";
		
			pst1 = c1.prepareStatement(sq2);
			pst1.setString(1, new2p);
			pst1.setString(2, usid);
			pst1.executeUpdate();
			response.sendRedirect("profilsida.jsp");
		
		}
		else{ //om gammalt lösenord inte stämmer.
			response.sendRedirect("loadError.jsp?id=8");
		}	
	}
	
	

	
	
	if(c1!=null) c1.close();
	if(pst1!=null) pst1.close();
	if(rs1!=null) rs1.close();

	
}

if(id.equals("6") && fn!=null){
	
	c1 = bookbookDB.getConnection();
	
	String e1=request.getParameter("em1");
	
	String sq1= "UPDATE book_user SET user_email = ? WHERE user_uid= ?";
	pst1 = c1.prepareStatement(sq1);
	pst1.setString(1, e1);
	pst1.setString(2, fn);
	pst1.executeUpdate();
		
	if(pst1!=null) pst1.close();
	if(c1!=null) c1.close();

	response.sendRedirect("profilsida.jsp");
	}
	

%>
