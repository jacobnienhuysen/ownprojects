import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
 
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
 
@WebServlet("/PDFuploadServlet")
@MultipartConfig(maxFileSize = 16177215)    // upload file's size up to 16MB
public class PDFUploadDBServlet extends HttpServlet {
     
    // database connection settings
    private String dbURL = "jdbc:mysql://localhost:3306/bookbook";
    private String dbUser = "root";
    private String dbPass = "P@ssw0rd!";
     
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        // gets values of text fields
        //String firstName = request.getParameter("firstName");
        Integer lid = Integer.parseInt(request.getParameter("lid"));
		Integer un = Integer.parseInt(request.getParameter("id"));
         
        InputStream inputStream = null; // input stream of the upload file
         
        // obtains the upload file part in this multipart request
        Part filePart = request.getPart("pdf");
        if (filePart != null) {
            // prints out some information for debugging
            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());
             
            // obtains input stream of the upload file
            inputStream = filePart.getInputStream();
        }
         
        Connection conn = null; // connection to the database
        String message = null;  // message will be sent back to client
         
        try {
            // connects to the database
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
 
            // constructs SQL statement
            //String sql = "INSERT INTO book_blobtest (id, pic) values (?, ?)";
            String sql = "INSERT INTO book_literature_pdf (lit_pdf_document, lit_pdf_lid, lit_pdf_oid) VALUES (?,?,?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            //statement.setString(1, "1");
             
            if (inputStream != null) {
                // fetches input stream of the upload file for the blob column
                //statement.setBlob(2, inputStream);
                statement.setBlob(1, inputStream);
				statement.setInt(2, lid);
				statement.setInt(3, un);
            }
 
            // sends the statement to the database server
            int row = statement.executeUpdate();
            if (row > 0) {
                message = "File uploaded and saved into database";
            }
        } catch (SQLException ex) {
            message = "ERROR: " + ex.getMessage();
            ex.printStackTrace();
        } finally {
            if (conn != null) {
                // closes the database connection
                try {
                    conn.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            // sets the message in request scope
            request.setAttribute("Message", message);
             
            // forwards to the message page
            getServletContext().getRequestDispatcher("/bokprofilsida.jsp?lid="+lid).forward(request, response);
        }
    }
}
