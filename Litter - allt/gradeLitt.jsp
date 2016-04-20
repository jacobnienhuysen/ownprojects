
<%@ page import="java.util.*" %>
<%@ page import="javax.sql.*;" %>
<%

java.sql.Connection c1 = null;
java.sql.ResultSet rs1;
rs1 = null;
java.sql.PreparedStatement pst1, pst2;
pst1 = null;
pst2 = null;


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
	
	Integer newGrade = Integer.parseInt(request.getParameter("rating"));
	
	if(newGrade!=null){
		c1 = bookbookDB.getConnection();
		
		String sq1 = "SELECT COUNT(*) FROM book_literature_grade WHERE lit_gr_uid= ? AND lit_gr_lid= ?";
		pst1 = c1.prepareStatement(sq1);
		pst1.setString(1, fn);
		pst1.setString(2, lid);
		rs1 = pst1.executeQuery();
		rs1.next();
		
		Integer grCnt = Integer.parseInt(rs1.getString(1));
		String sq2 = "";
		
		if(grCnt==0){
			sq2 = "INSERT INTO book_literature_grade (lit_gr_grade, lit_gr_uid, lit_gr_lid) VALUES (?,?,?)";
		}
		else{
			sq2 = "UPDATE book_literature_grade SET lit_gr_grade= ? WHERE lit_gr_uid= ? AND lit_gr_lid= ?";
		}
		pst2 = c1.prepareStatement(sq2);
		pst2.setInt(1, newGrade);
		pst2.setString(2, fn);
		pst2.setString(3, lid);
		pst2.executeUpdate();

		if(c1!=null) c1.close();
		if(rs1!=null) rs1.close();
		if(pst1!=null) pst1.close();
		if(pst2!=null) pst2.close();
		
		response.sendRedirect("bokprofilsida.jsp?lid="+lid);
		
	}
	
	
	if(newGrade == null){
		response.sendRedirect("bokprofilsida.jsp?lid="+lid);
	}
%>
