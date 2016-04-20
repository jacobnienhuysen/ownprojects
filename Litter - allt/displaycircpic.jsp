		<%@ page import="java.util.*" %>
        <%@ page import="javax.sql.*" %>
		<%@ page import="java.sql.*"%>
		<%@ page import="java.io.*"%>

        <% 
        java.sql.Connection c1;
        java.sql.Statement s1;
        java.sql.ResultSet rs1;
        java.sql.PreparedStatement pst1;

        DataSource bookbookDB;

        Boolean alt;
        String classname;

		c1 = null;
        s1 =null;
        pst1 = null;
        rs1 = null;
		
		Blob image = null;
		byte[ ] imgData = null;
		
        alt=false;
        classname="";

        javax.naming.Context initCtx = new javax.naming.InitialContext();
        javax.naming.Context envCtx = (javax.naming.Context) initCtx.lookup("java:comp/env");
        bookbookDB = (DataSource) envCtx.lookup("jdbc/bookbookDB");

        try{
            if(bookbookDB == null) {
                javax.naming.Context initCtx1 = new javax.naming.InitialContext();
                javax.naming.Context envCtx1 = (javax.naming.Context) initCtx1.lookup("java:comp/env");
                bookbookDB = (DataSource) envCtx1.lookup("jdbc/bookbookDB");
            }
        }catch(Exception e){

            System.out.println("inside the context exception");
            e.printStackTrace();
        }
        
		c1 = bookbookDB.getConnection();
		
		String cid = (String)request.getParameter("cid");
		String sq1= "SELECT crcl_picture FROM book_circle WHERE crcl_cid='"+cid+"'";
		
        pst1 = c1.prepareStatement(sq1);
        rs1 = pst1.executeQuery();
		rs1.next();
			
			image = rs1.getBlob(1);
			imgData = image.getBytes(1,(int)image.length());

			response.setContentType("image/gif");
			
			OutputStream o = response.getOutputStream();
			
			o.write(imgData); 
			o.flush();
			o.close();		

		if(pst1!=null) pst1.close();
        if(rs1!=null) rs1.close();
        if(c1!=null) c1.close();
	
%>