<%@ include file="Masterpage.jsp"%>
<!DOCTYPE html>
<html>


<% 		String lid = (String)request.getParameter("lid");
		/*
        java.sql.ResultSet rs2;

        java.sql.PreparedStatement pst2;

		pst2 = null;

		rs2 = null;
		
		String sq2 = "SELECT book_literature.lit_document FROM book_literature, book_user_literature WHERE book_literature.lit_lid='"+lid+"' AND book_user_literature.ulit_uid='"+un+"' AND book_user_literature.ulit_lid='"+lid+"'";
		String pdfPath = "";
		
		pst2 = c1.prepareStatement(sq2);

		rs2 = pst2.executeQuery();
		
		if(rs2.next()){
			pdfPath = rs2.getString("lit_document");
		}
		else{
			response.sendRedirect("loadError.jsp?id=4");
		}
		*/
%> 



 <head>
    <title>Profilsida</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
    <link href="bootstrap.min.css" rel="stylesheet" media="screen">
 
  </head>
  
 
	  <div class="span8" style="height:100%">
	  
 <div>
    <button id="prev" onclick="goPrevious()" class="btn btn-primary">Bak&aring;t</button>
    <button id="next" onclick="goNext()" class="btn btn-primary">Fram&aring;t</button>
    &nbsp; &nbsp;
    <span>Sida: <span id="page_num"></span> / <span id="page_count"></span></span>
  </div>
  
	  
	  </div>
	  
	  <div>
    <canvas id="the-canvas" style="border:1px solid black;"></canvas>
  </div>
 <hr>

      <div class="footer">
        <p>&copy; PVT Grupp 10</p>
      </div>  
</div>


 <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster --> 
      
  <script type="text/javascript" src="js/pdf.js"></script>
  <script type="text/javascript">
    //
    // NOTE: 
    // Modifying the URL below to another server will likely *NOT* work. Because of browser
    // security restrictions, we have to use a file server with special headers
    // (CORS) - most servers don't support cross-origin browser requests.
    //
    var url = 'displayPDF.jsp?lid=<%=lid%>';

    //
    // Disable workers to avoid yet another cross-origin issue (workers need the URL of
    // the script to be loaded, and currently do not allow cross-origin scripts)
    //
    PDFJS.disableWorker = true;

    var pdfDoc = null,
        pageNum = 1,
        scale = 1,
        canvas = document.getElementById('the-canvas'),
        ctx = canvas.getContext('2d');

    //
    // Get page info from document, resize canvas accordingly, and render page
    //
    function renderPage(num) {
      // Using promise to fetch the page
      pdfDoc.getPage(num).then(function(page) {
        var viewport = page.getViewport(scale);
        canvas.height = viewport.height;
        canvas.width = viewport.width;

        // Render PDF page into canvas context
        var renderContext = {
          canvasContext: ctx,
          viewport: viewport
        };
        page.render(renderContext);
      });

      // Update page counters
      document.getElementById('page_num').textContent = pageNum;
      document.getElementById('page_count').textContent = pdfDoc.numPages;
    }

    //
    // Go to previous page
    //
    function goPrevious() {
      if (pageNum <= 1)
        return;
      pageNum--;
      renderPage(pageNum);
    }

    //
    // Go to next page
    //
    function goNext() {
      if (pageNum >= pdfDoc.numPages)
        return;
      pageNum++;
      renderPage(pageNum);
    }

    //
    // Asynchronously download PDF as an ArrayBuffer
    //
    PDFJS.getDocument(url).then(function getPdfHelloWorld(_pdfDoc) {
      pdfDoc = _pdfDoc;
      renderPage(pageNum);
    });
  </script>  
	<script src="js/jquery.min.js"></script>
   
 <script src="js/bootstrap.min.js"></script>
</body>

</html>