
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%> 
<%@ page import ="javax.naming.InitialContext" %> 
<%@ page import="javax.sql.*;" %>
<%

java.sql.Connection c1 = null;
java.sql.Statement s1 = null;
java.sql.ResultSet rs1,rs2 = null;
java.sql.PreparedStatement pst1,pst2 = null;


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
	
	String sq1 = "SELECT user_uid FROM book_user WHERE user_picture IS NOT NULL";
	String sq2 = "SELECT crcl_cid FROM book_circle WHERE crcl_picture IS NOT NULL"; 
	pst1 = c1.prepareStatement(sq1);
    rs1 = pst1.executeQuery();
	pst2 = c1.prepareStatement(sq2);
    rs2 = pst2.executeQuery();
	
	List<String> pics = new ArrayList<String>();
	while(rs1.next()){
		String newUs ="u";
		newUs+= rs1.getString("user_uid");
		pics.add(newUs);
	}
	
	while(rs2.next()){
		String newCi ="c";
		newCi+= rs2.getString("crcl_cid");
		pics.add(newCi);
	}
	
	Collections.shuffle(pics);
	Collections.shuffle(pics);
	
	%>
	<html>
	<body bgcolor="paper">
	
	<table>
	
	<%
	for(int x=0,y=pics.size()-1;x<8;x++,y--){
		x++;
		%><tr><td><%
		if(pics.get(x).contains("u")){
			String id = pics.get(x).substring(1);
			%><td><a href="otheruser.jsp?id=<%=id%>"><img src="../displayprofilepic.jsp?id=<%=id%>" width="100" border="0"></a></td><%
		}
		if(pics.get(x).contains("c")){
			String id = pics.get(x).substring(1);
			%><td><a href="cirkelprofil.jsp?id=<%=id%>"><img src="../displaycircpic.jsp?cid=<%=id%>" width="100" border="0"></a></td><%
		}
		
		%></td><td><%
		
		if(pics.get(y).contains("u")){
			String id = pics.get(y).substring(1);
			%><td><a href="otheruser.jsp?id=<%=id%>"><img src="../displayprofilepic.jsp?id=<%=id%>" width="100" border="0"></a></td><%
		}
		if(pics.get(y).contains("c")){
			String id = pics.get(y).substring(1);
			%><td><a href="cirkelprofil.jsp?id=<%=id%>"><img src="../displaycircpic.jsp?cid=<%=id%>" width="100" border="0"></a></td><%
		}
		
		
		%></tr><%
		
	}
	
	
	
	pst1.close();
	rs1.close();
	c1.close();
	pst2.close();
	rs2.close();
	%>
	
</body>
</html>