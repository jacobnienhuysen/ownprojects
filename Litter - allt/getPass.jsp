
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%> 
<%@ page import ="javax.naming.InitialContext" %> 
<%@ page import="javax.sql.*;" %>
<%

java.sql.Connection c1 = null;
java.sql.Statement s1 = null;
java.sql.ResultSet rs1 = null;
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

	String m1 = request.getParameter("email");
	String m2 = request.getParameter("email2");

	if(!m1.equals(m2)){
		response.sendRedirect("forgotPass.jsp?id=1");
	}
	else{
		
		c1 = bookbookDB.getConnection();
		String sq1="SELECT * FROM book_user WHERE user_email='"+m1+"'";
		pst1 = c1.prepareStatement(sq1);
		rs1 = pst1.executeQuery();
	
		if(!rs1.next()){
			response.sendRedirect("forgotPass.jsp?id=2");
		}
		else{
			String sid = rs1.getString("user_uid");
			
			//genererar lösen
			int len=8;
			char[] pwd = new char[len];
			int c = 'A';
			int rand = 0;
			for (int i=0; i < 8; i++){
				rand = (int)(Math.random() * 3);
				switch(rand) {
				case 0: c = '0' + (int)(Math.random() * 10); break;
				case 1: c = 'a' + (int)(Math.random() * 26); break;
				case 2: c = 'A' + (int)(Math.random() * 26); break;
				}
				pwd[i] = (char)c;
			}
				String newPass = "";
				for(int x=0;x<pwd.length;x++){
					newPass+=pwd[x];
				}
			//generator slut	
			
			String sq2= "UPDATE book_user_md5 SET md5_pass=MD5('"+newPass+"') WHERE md5_uid='"+sid+"'";
			s1 = c1.createStatement();
			s1.executeUpdate(sq2);
			String body="Här är ditt nya lösenord till Litter!: "+newPass;
			String redirect="forgotPass.jsp?id=3";
			response.sendRedirect("EmailServlet?recipient="+m1+"&body="+body+"&redirect="+redirect+"");
		
		}
		
		pst1.close();
		rs1.close();
		c1.close();
		
	}

%>