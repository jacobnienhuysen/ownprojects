<%@include file="unloggedMaster.jsp" %>
<!DOCTYPE html>


<html lang="en">

<%@ page import="java.util.*" %>

        <%@ page import="javax.sql.*;" %>


        <% 

        java.sql.Connection c1;
        java.sql.ResultSet rs1;
        java.sql.PreparedStatement pst1;
		
        DataSource bookbookDB;

        c1 = null;
        pst1 = null;
        rs1 = null;

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
		
        String sq1= "SELECT * FROM book_school";
        pst1 = c1.prepareStatement(sq1);
        rs1 = pst1.executeQuery();
			
        %> 


  <head>
    <meta charset="utf-8">
    <title>Registrera användare</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="bootstrap-responsive.css" rel="stylesheet">
    <style>
      body {
        padding-top: 20px;
        padding-bottom: 40px;
      }

      /* Custom container */
      .container-narrow {
        margin: 0 auto;
        max-width: 700px;
      }
      .container-narrow > hr {
        margin: 30px 0;
      }

      /* Main marketing message and sign up button */
      .jumbotron {
        margin: 60px 0;
        text-align: center;
      }
      .jumbotron h1 {
        font-size: 72px;
        line-height: 1;
      }
      .jumbotron .btn {
        font-size: 21px;
        padding: 14px 24px;
      }

      /* Supporting marketing content */
      .marketing {
        margin: 60px 0;
      }
      .marketing p + h4 {
        margin-top: 28px;
      }
    </style>
    <link href="bootstrap-responsive.css" rel="stylesheet">



  </head>
<body> 
  
 

      <hr>

    

     

      <div class="row-fluid marketing">
 <h3 class="lead"> Ange dina uppgifter</h3> 

<table>
<form name="newuser" action="regAction.jsp" method="post">
<tr>
<td class="text">F&ouml;rnamn:</td>
<td><input name="firstname" type="text" id="firstname" required></td>
</tr>

<tr>
<td class="text">Efternamn:</td>
<td><input name="surname" type="text" id="surname" size="30" required></td>
</tr>

<tr>
<td class="text">Anv&auml;ndarnamn:</td>
<td><input name="username" type="text" id="username" size="30" required></td>
</tr>

<tr>
<td class="text">E-mail:</td>
<td><input name="mail" type="email" id="mail" size="30" required></td>
</tr>

<tr>
<td class="text">Bekr&auml;fta e-mail:</td>
<td><input name="mail2" type="email" id="mail2" size="30" required></td>
</tr>

<tr>
<td class="text">Lärosäte:</td>
<td>
<select name="school" id="school">
	<%
	while( rs1.next() ){
		
	%>
			<option value = "<%= rs1.getString("scho_name") %>"><%= rs1.getString("scho_name") %></option>
	<%
	}
	%>
	</select>
</td>

</tr>

<tr>
<td class="text">V&auml;lj ett l&ouml;senord:</td>
<td><input name="mypassword" type="password" id="mypassword" size="20" required></td>
</tr>

<tr>
<td class="text">Bekr&auml;fta l&ouml;senord:</td>
<td><input name="mypassword2" type="password" id="mypassword2" size="20" required></td>

</tr>
<tr>
<td><br></td></tr>

<tr>
<td colspan="2">
<label class="checkbox">
        <input type="checkbox" name="license" id="license" class="checkbox" required> Jag godkänner <a href="#myModal1" data-toggle="modal" >Användaravtalet</a>
		</label>
</td>
</tr>


<tr><td><input type="submit" value="Skapa konto"></td>
<td><input type="reset" value="Rensa"></td></tr>

</form></table>

</div>

 <div id="myModal1" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Användaravtal</h3>
  </div>
  <div class="modal-body">
<h3>Litter Privacy Policy</h3>
<p>Litter instantly connects people everywhere to what’s most meaningful to them. Any registered user can send a Share, which is a message of 140 characters or less that is public by default and can include other content like photos, videos, and links to other websites.
Tip What you say on Litter may be viewed all around the world instantly.
This Privacy Policy describes how and when Litter collects, uses and shares your information when you use our Services. Litter receives your information through our various websites, SMS, APIs, email notifications, applications, buttons, and widgets (the "Services" or "Litter"). For example, you send us information when you use Litter from our website, post or receive Shares via SMS, or access Litter from an application such as Litter for Mac, Litter for Android or ShareDeck. When using any of our Services you consent to the collection, transfer, manipulation, storage, disclosure and other uses of your information as described in this Privacy Policy. Irrespective of which country you reside in or supply information from, you authorize Litter to use your information in the United States and any other country where Litter operates.
If you have any questions or comments about this Privacy Policy, please contact us at privacy@Litter.com or here.</p>
<h4>Information Collection and Use</h4>
<p>Tip: We collect and use your information below to provide our Services and to measure and improve them over time.
Information Collected Upon Registration: When you create or reconfigure a Litter account, you provide some personal information, such as your name, username, password, and email address. Some of this information, for example, your name and username, is listed publicly on our Services, including on your profile page and in search results. Some Services, such as search, public user profiles and viewing lists, do not require registration.
Additional Information: You may provide us with profile information to make public, such as a short biography, your location, your website, or a picture. You may provide information to customize your account, such as a cell phone number for the delivery of SMS messages. We may use your contact information to send you information about our Services or to market to you. You may use your account settings to unsubscribe from notifications from Litter. You may also unsubscribe by following the instructions contained within the notification or the instructions on our website. We may use your contact information to help others find your Litter account, including through third-party services and client applications. Your account settings control whether others can find you by your email address or cell phone number. You may choose to upload your address book so that we can help you find Litter users you know. We may later suggest people to follow on Litter based on your imported address book contacts, which you can delete from Litter at any time. If you email us, we may keep your message, email address and contact information to respond to your request. If you connect your Litter account to your account on another service in order to cross-post between Litter and that service, the other service may send us your registration or profile information on that service and other information that you authorize. This information enables cross-posting, helps us improve the Services, and is deleted from Litter within a few weeks of your disconnecting from Litter your account on the other service. Learn more here. Providing the additional information described in this section is entirely optional.
Shares, Following, Lists and other Public Information: Our Services are primarily designed to help you share information with the world. Most of the information you provide us is information you are asking us to make public. This includes not only the messages you Share and the metadata provided with Shares, such as when you Shareed, but also the lists you create, the people you follow, the Shares you mark as favorites or ReShare, and many other bits of information that result from your use of the Services. Our default is almost always to make the information you provide public for as long as you do not delete it from Litter, but we generally give you settings to make the information more private if you want. Your public information is broadly and instantly disseminated. For instance, your public user profile information and public Shares may be searchable by search engines and are immediately delivered via SMS and our APIs to a wide range of users and services, with one example being the United States Library of Congress, which archives Shares for historical purposes. When you share information or content like photos, videos, and links via the Services, you should think carefully about what you are making public.
Location Information: You may choose to publish your location in your Shares and in your Litter profile. You may also tell us your location when you set your trend location on Litter.com or enable your computer or mobile device to send us location information. You can set your Share location preferences in your account settings and learn more about this feature here. Learn how to set your mobile location preferenceshere. We may use and store information about your location to provide features of our Services, such as Shareing with your location, and to improve and customize the Services, for example, with more relevant content like local trends, stories, ads, and suggestions for people to follow.
Links: Litter may keep track of how you interact with links across our Services, including our email notifications, third-party services, and client applications, by redirecting clicks or through other means. We do this to help improve our Services, to provide more relevant advertising, and to be able to share aggregate click statistics such as how many times a particular link was clicked on.
Cookies: Like many websites, we use "cookie" technology to collect additional website usage data and to improve our Services, but we do not require cookies for many parts of our Services such as searching and looking at public user profiles or lists. A cookie is a small data file that is transferred to your computer's hard disk. Litter may use both session cookies and persistent cookies to better understand how you interact with our Services, to monitor aggregate usage by our users and web traffic routing on our Services, and to customize and improve our Services. Most Internet browsers automatically accept cookies. You can instruct your browser, by changing its settings, to stop accepting cookies or to prompt you before accepting a cookie from the websites you visit. However, some Services may not function properly if you disable cookies.
Log Data: Our servers automatically record information ("Log Data") created by your use of the Services. Log Data may include information such as your IP address, browser type, operating system, the referring web page, pages visited, location, your mobile carrier, device and application IDs, search terms, and cookie information. We receive Log Data when you interact with our Services, for example, when you visit our websites, sign into our Services, interact with our email notifications, use your Litter account to authenticate to a third-party website or application, or visit a third-party website that includes a Litter button or widget. Litter uses Log Data to provide our Services and to measure, customize, and improve them. If not already done earlier, for example, as provided below for Widget Data, we will either delete Log Data or remove any common account identifiers, such as your username, full IP address, or email address, after 18 months.
Widget Data: We may tailor content for you based on your visits to third-party websites that integrate Litter buttons or widgets. When these websites first load our buttons or widgets for display, we receive Log Data, including the web page you visited and a cookie that identifies your browser ("Widget Data"). After a maximum of 10 days, we start the process of deleting or aggregating Widget Data, which is usually instantaneous but in some cases may take up to a week. While we have the Widget Data, we may use it to tailor content for you, such as suggestions for people to follow on Litter. Tailored content is stored with only your browser cookie ID and is separated from other Widget Data such as page-visit information. This feature is optional and not yet available to all users. If you want, you can suspend it or turn it off, which removes from your browser the unique cookie that enables the feature. Learn more about the feature here. For Shares, Log Data, and other information that we receive from interactions with Litter buttons or widgets, please see the other sections of this Privacy Policy.
Third-Party Service Providers: Litter uses a variety of third-party services to help provide our Services, such as hosting our various blogs and wikis, and to help us understand the use of our Services, such as Google Analytics. These third-party service providers may collect information sent by your browser as part of a web page request, such as cookies or your IP address.</p>
<h4>Information Sharing and Disclosure</h4>
Tip:We do not disclose your private personal information except in the limited circumstances described here.
Your Consent: We may share or disclose your information at your direction, such as when you authorize a third-party web client or application to access your Litter account.
Service Providers: We engage service providers to perform functions and provide services to us in the United States and abroad. We may share your private personal information with such service providers subject to confidentiality obligations consistent with this Privacy Policy, and on the condition that the third parties use your private personal data only on our behalf and pursuant to our instructions.
Law and Harm: Notwithstanding anything to the contrary in this Policy, we may preserve or disclose your information if we believe that it is reasonably necessary to comply with a law, regulation or legal request; to protect the safety of any person; to address fraud, security or technical issues; or to protect Litter's rights or property. However, nothing in this Privacy Policy is intended to limit any legal defenses or objections that you may have to a third party’s, including a government’s, request to disclose your information.
Business Transfers: In the event that Litter is involved in a bankruptcy, merger, acquisition, reorganization or sale of assets, your information may be sold or transferred as part of that transaction. The promises in this Privacy Policy will apply to your information as transferred to the new entity.
Non-Private or Non-Personal Information: We may share or disclose your non-private, aggregated or otherwise non-personal information, such as your public user profile information, public Shares, the people you follow or that follow you, or the number of users who clicked on a particular link (even if only one did).
<h4>Modifying Your Personal Information</h4>
If you are a registered user of our Services, we provide you with tools and account settings to access or modify the personal information you provided to us and associated with your account.
You can also permanently delete your Litter account. If you follow the instructions here, your account will be deactivated and then deleted. When your account is deactivated, it is not viewable on Litter.com. For up to 30 days after deactivation it is still possible to restore your account if it was accidentally or wrongfully deactivated. After 30 days, we begin the process of deleting your account from our systems, which can take up to a week.
Our Policy Towards Children
Our Services are not directed to persons under 13. If you become aware that your child has provided us with personal information without your consent, please contact us at privacy@Litter.com. We do not knowingly collect personal information from children under 13. If we become aware that a child under 13 has provided us with personal information, we take steps to remove such information and terminate the child's account. You can find additional resources for parents and teens here.
EU Safe Harbor Framework
Litter complies with the U.S.-E.U. and U.S.-Swiss Safe Harbor Privacy Principles of notice, choice, onward transfer, security, data integrity, access, and enforcement. To learn more about the Safe Harbor program, and to view our certification, please visit the U.S. Department of Commerce
 website.
<h4>Changes to this Policy</h4>
<p>We may revise this Privacy Policy from time to time. The most current version of the policy will govern our use of your information and will always be at https://Litter.com/privacy. If we make a change to this policy that, in our sole discretion, is material, we will notify you via an @Litter update or email to the email address associated with your account. By continuing to access or use the Services after those changes become effective, you agree to be bound by the revised Privacy Policy.</p>
<b>Effective: May 17, 2012</b>


  </div>
  
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Stäng</button>
  
	</form>
  </div></div>



 <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster --> 
	<script src="js/jquery.min.js"></script>
   
 <script src="js/bootstrap.min.js"></script>
</body>
<%


if(pst1!=null) pst1.close();
if(rs1!=null) rs1.close();
if(c1!=null) c1.close();
%>
</html>