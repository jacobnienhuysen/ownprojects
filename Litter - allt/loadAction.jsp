<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*;" %>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

String title = request.getParameter("title");
String author = request.getParameter("author");
String bookYear = request.getParameter("bookYear");
String isbn10 = request.getParameter("isbn10");
String isbn13 = request.getParameter("isbn13");
String cat = request.getParameter("cat");
String infoText = request.getParameter("infoText");

String newLid = null;
boolean twoIsbn = false;
boolean isbnIs10 = false;

//Författar-hanterare
String[] authorList = null;
if(author.contains(";")){
	authorList = author.split(";", -1);
}


java.sql.Connection c1 = null;

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

java.sql.PreparedStatement pst1, pst2, pst3, pst4, pst5, pst6;
pst1 = null;
pst2 = null;
pst3 = null;
pst4 = null;
pst5 = null;
pst6 = null;

java.sql.ResultSet rs1, rs2, rs3;
rs1 = null;
rs2 = null;
rs3 = null;


	//Den här koden kontrollerar om den inmatade boken redan finns i registret

	String sq1 = "SELECT COUNT(*) FROM book_literature WHERE lit_title= ? AND (lit_isbn10= ? OR lit_isbn13= ?)";
	pst1 = c1.prepareStatement(sq1);
	pst1.setString(1, title);
	pst1.setString(2, isbn10);
	pst1.setString(3, isbn13);
	rs1 = pst1.executeQuery();
	rs1.next();
	
	Integer bokAntal = Integer.parseInt(rs1.getString(1));
	
	if(bokAntal>0){ 	//om det redan finns en bok med inmatad titel och isbn-nummer i registret.
		response.sendRedirect("loadError.jsp?id=1");
	}
	else{	//Lägger till ny bok i registret
		if(twoIsbn){ //Om båda ISBN-numren angivits
			String sq2 = "INSERT INTO book_literature (lit_title, lit_published, lit_isbn10, lit_isbn13, lit_category, lit_info_text) VALUES (?,?,?,?,?,?)";
			pst2 = c1.prepareStatement(sq2);
			pst2.setString(1, title);
			pst2.setString(2, bookYear);
			pst2.setString(3, isbn10);
			pst2.setString(4, isbn13);
			pst2.setString(5, cat);
			pst2.setString(6, infoText);
			pst2.executeUpdate();
			
			String sq3 = "SELECT lit_lid FROM book_literature WHERE lit_title= ? AND lit_isbn10= ? AND lit_isbn13= ?";
			pst3 = c1.prepareStatement(sq3);
			pst3.setString(1, title);
			pst3.setString(2, isbn10);
			pst3.setString(3, isbn13);
			rs2 = pst3.executeQuery();
			rs2.next();
			newLid = rs2.getString("lit_lid");
			
		}
		else if(!twoIsbn && isbnIs10){	//Om enbart isbn10 angivits
			String sq2 = "INSERT INTO book_literature (lit_title, lit_published, lit_isbn10, lit_category, lit_info_text) VALUES (?,?,?,?,?)";
			pst2 = c1.prepareStatement(sq2);
			pst2.setString(1, title);
			pst2.setString(2, bookYear);
			pst2.setString(3, isbn10);
			pst2.setString(4, cat);
			pst2.setString(5, infoText);
			pst2.executeUpdate();
			
			String sq3 = "SELECT lit_lid FROM book_literature WHERE lit_title= ? AND lit_isbn10= ?";
			pst3 = c1.prepareStatement(sq3);
			pst3.setString(1, title);
			pst3.setString(2, isbn10);
			rs2 = pst3.executeQuery();
			rs2.next();
			newLid = rs2.getString("lit_lid");
			
		}else if(!twoIsbn && !isbnIs10){	//Om enbart isbn13 angivits
			String sq2 = "INSERT INTO book_literature (lit_title, lit_published, lit_isbn13, lit_category, lit_info_text) VALUES (?,?,?,?,?)";
			pst2 = c1.prepareStatement(sq2);
			pst2.setString(1, title);
			pst2.setString(2, bookYear);
			pst2.setString(3, isbn13);
			pst2.setString(4, cat);
			pst2.setString(5, infoText);
			pst2.executeUpdate();
			
			String sq3 = "SELECT lit_lid FROM book_literature WHERE lit_title= ? AND lit_isbn13= ?";
			pst3 = c1.prepareStatement(sq3);
			pst3.setString(1, title);
			pst3.setString(2, isbn13);
			rs2 = pst3.executeQuery();
			rs2.next();
			newLid = rs2.getString("lit_lid");
			
		}
		
		//Koden nedan tar hand om författaren
		
		if(authorList==null){			//Om det är en enda författare till boken
			String sq4 = "SELECT COUNT(*) FROM book_author WHERE auth_name= ?";
			pst4 = c1.prepareStatement(sq4);
			pst4.setString(1, author);
			rs3 = pst4.executeQuery();
			rs3.next();

			Integer fjAntal = Integer.parseInt(rs3.getString(1));
			
			if(fjAntal==0){				//Om författaren inte finns i registret
				String sq5 = "INSERT INTO book_author(auth_name) VALUES (?)";
				pst5 = c1.prepareStatement(sq5);
				pst5.setString(1, author);
				pst5.executeUpdate();
			}
	
			//Skapar kopplingen mellan bok och författare
		
			String sq6 = "INSERT INTO book_literature_author (lita_author_name, lita_lid) VALUES (?,?)";
			pst6 = c1.prepareStatement(sq6);
			pst6.setString(1, author);
			pst6.setString(2, newLid);
			pst6.executeUpdate();
		}
		else{	//Om det är fler än en författare till boken
		
			for(int an=0; an<authorList.length;an++){
				String sq4 = "SELECT COUNT(*) FROM book_author WHERE auth_name= ?";
				pst4 = c1.prepareStatement(sq4);
				pst4.setString(1, authorList[an]);
				rs3 = pst4.executeQuery();
				rs3.next();
				
				Integer authCount = Integer.parseInt(rs3.getString(1));
				
				if(authCount==0){		//Om författaren inte finns i registret
					String sq5 = "INSERT INTO book_author(auth_name) VALUES (?)";
					pst5 = c1.prepareStatement(sq5);
					pst5.setString(1, authorList[an]);
					pst5.executeUpdate();
				}
	
		
				//Skapar kopplingen mellan bok och författare
			
				String sq6 = "INSERT INTO book_literature_author (lita_author_name, lita_lid) VALUES (?,?)";
				pst6 = c1.prepareStatement(sq6);
				pst6.setString(1, authorList[an]);
				pst6.setString(2, newLid);
				pst6.executeUpdate();
			
			}

		
		}
		
		if(c1!=null) c1.close();	
		if(rs1!=null) rs1.close();
		if(rs2!=null) rs2.close();
		if(rs3!=null) rs3.close();
		if(pst1!=null) pst1.close();
		if(pst2!=null) pst2.close();
		if(pst3!=null) pst3.close();
		if(pst4!=null) pst4.close();
		if(pst5!=null) pst5.close();
		if(pst6!=null) pst6.close();
		response.sendRedirect("bokprofilsida.jsp?lid="+newLid);
		
	}	

	/*
	//Skickar vidare när allt har lagts till i databasen
	response.sendRedirect("activityadd.jsp?id=1&val="+lid);
	*/


%>