import java.io.*;
import java.net.*;

import java.util.Properties;
import javax.mail.AuthenticationFailedException;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.*;
import javax.servlet.http.*;
 
@SuppressWarnings("serial") 
public class EmailServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String un = "";
				Cookie[] cookies = request.getCookies();
				for (int i = 0; i < cookies.length; i++) {
					if (cookies[i].getName().equals("user")){
						un = cookies[i].getValue();	
					}
				}
				
		String err = "/index.jsp?error=1";

        String from = "litter@mylitter.se";
        String recipient = request.getParameter("recipient");
        String subject = "Ny avisering från Litter!";
        String body = request.getParameter("body");
		String redirect = request.getParameter("redirect");
        String login = "svn";
        String password = "P@ssword!";
		String succ = redirect;

		
		
        try {
			if(!un.equals("")){
               Properties props = new Properties();
               props.setProperty("mail.host", "localhost");
               props.setProperty("mail.smtp.port", "25");
               props.setProperty("mail.smtp.auth", "true");
               props.setProperty("mail.smtp.starttls.enable", "true");

               Authenticator auth = new SMTPAuthenticator(login, password);

               Session session = Session.getInstance(props, auth);

               MimeMessage msg = new MimeMessage(session);
               msg.setText(body);
               msg.setSubject(subject);
               msg.setFrom(new InternetAddress(from));
               msg.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
               Transport.send(msg);

			} else {
				throw new IllegalArgumentException("Not logged in!");
			}
         } catch (AuthenticationFailedException ex) {
				request.setAttribute("ErrorMessage", "Authentication failed");
				succ = err;
//              RequestDispatcher dispatcher = request.getRequestDispatcher(err);
//              dispatcher.forward(request, response);
         } catch (AddressException ex) {
				request.setAttribute("ErrorMessage", "Wrong email address");
				succ = err;
//              RequestDispatcher dispatcher = request.getRequestDispatcher(err);
//              dispatcher.forward(request, response);
         } catch (MessagingException ex) {
				request.setAttribute("ErrorMessage", ex.getMessage());
				succ = err;
//              RequestDispatcher dispatcher = request.getRequestDispatcher(err);
//              dispatcher.forward(request, response);
         } catch (IllegalArgumentException ex) {
				request.setAttribute("ErrorMessage", "Not logged in!");
				succ = err;
//              RequestDispatcher dispatcher = request.getRequestDispatcher(err);
//              dispatcher.forward(request, response);
		 }
         // RequestDispatcher dispatcher = request.getRequestDispatcher(succ);
         // dispatcher.forward(request, response);		
		 response.sendRedirect(succ);
	}

    private class SMTPAuthenticator extends Authenticator {

        private PasswordAuthentication authentication;

        public SMTPAuthenticator(String login, String password) {
            authentication = new PasswordAuthentication(login, password);
        }

        protected PasswordAuthentication getPasswordAuthentication() {
            return authentication;
        }
    }

    protected void doGet(HttpServletRequest request, 
                         HttpServletResponse response)
                   throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, 
                          HttpServletResponse response)
                   throws ServletException, IOException {
        processRequest(request, response);
    }
}
