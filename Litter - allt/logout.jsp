<%@ page import="java.util.*;" %>


		<%
		
		session.invalidate();
		Cookie myCookie = null;
		Cookie[] cookies = null;
		// Get an array of Cookies associated with this domain
		cookies = request.getCookies();
		for (int i = 0; i < cookies.length; i++) {
			if (cookies [i].getName().equals ("user"))
			{
				myCookie = cookies[i];
				myCookie.setMaxAge(0);
				break;
			}
		} 
		response.sendRedirect("index.jsp");

        %>