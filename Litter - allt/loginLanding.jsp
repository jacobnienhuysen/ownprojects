<%@include file="Masterpage.jsp" %>


  <head>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta http-equiv="cache-control" content="no-cache"> <!-- tells browser not to cache -->
	<meta http-equiv="expires" content="0"> <!-- says that the cache expires 'now' -->
	<meta http-equiv="pragma" content="no-cache">
	
    <link href="bootstrap-responsive.css" rel="stylesheet">
	 <style>

    /* GLOBAL STYLES
    -------------------------------------------------- */
    /* Padding below the footer and lighter body text */

    body {
      padding-bottom: 40px;
      color: #FFFFFF;
    }



 

    /* CUSTOMIZE THE CAROUSEL
    -------------------------------------------------- */

    /* Carousel base class */
    .carousel {
      margin-bottom: 60px;
    }

    .carousel .container {
      position: relative;
      z-index: 9;
    }

    .carousel-control {
      height: 80px;
      margin-top: 0;
      font-size: 120px;
      text-shadow: 0 1px 1px rgba(0,0,0,.4);
      background-color: transparent;
      border: 0;
      z-index: 10;
    }

    .carousel .item {
      height: 500px;
    }
    .carousel img {
      position: absolute;
      top: 0;
      left: 0;
      min-width: 100%;
      height: 500px;
    }

    .carousel-caption {
      background-color: transparent;
      position: static;
      max-width: 550px;
      padding: 0 20px;
      margin-top: 200px;
    }
    .carousel-caption h1,
    .carousel-caption .lead {
      margin: 0;
      line-height: 1.25;
      color: #000;
      text-shadow: 0 1px 1px rgba(0,0,0,.4);
    }
    .carousel-caption .btn {
      margin-top: 10px;
    }



    /* MARKETING CONTENT
    -------------------------------------------------- */

    /* Center align the text within the three columns below the carousel */
    .marketing .span4 {
      text-align: center;
    }
    .marketing h2 {
      font-weight: normal;
    }
    .marketing .span4 p {
      margin-left: 10px;
      margin-right: 10px;
    }


    /* Featurettes
    ------------------------- */

    .featurette-divider {
      margin: 80px 0; /* Space out the Bootstrap <hr> more */
    }
    .featurette {
      padding-top: 120px; /* Vertically center images part 1: add padding above and below text. */
      overflow: hidden; /* Vertically center images part 2: clear their floats. */
    }
    .featurette-image {
      margin-top: -120px; /* Vertically center images part 3: negative margin up the image the same amount of the padding to center it. */
    }

    /* Give some space on the sides of the floated elements so text doesn't run right into it. */
    .featurette-image.pull-left {
      margin-right: 40px;
    }
    .featurette-image.pull-right {
      margin-left: 40px;
    }

    /* Thin out the marketing headings */
    .featurette-heading {
      font-size: 50px;
      font-weight: 300;
      line-height: 1;
      letter-spacing: -1px;
    }



    /* RESPONSIVE CSS
    -------------------------------------------------- */

    @media (max-width: 979px) {

      .container.navbar-wrapper {
        margin-bottom: 0;
        width: auto;
      }
      .navbar-inner {
        border-radius: 0;
        margin: -20px 0;
      }

      .carousel .item {
        height: 500px;
      }
      .carousel img {
        width: auto;
        height: 400px;
      }

      .featurette {
        height: auto;
        padding: 0;
      }
      .featurette-image.pull-left,
      .featurette-image.pull-right {
        display: block;
        float: none;
        max-width: 40%;
        margin: 0 auto 20px;
      }
    }


    @media (max-width: 767px) {

      .navbar-inner {
        margin: -20px;
      }

      .carousel {
        margin-left: -20px;
        margin-right: -20px;
      }
      .carousel .container {

      }
      .carousel .item {
        height: 300px;
      }
      .carousel img {
        height: 300px;
      }
      .carousel-caption {
        width: 65%;
        padding: 0 70px;
        margin-top: 100px;
      }
      .carousel-caption h1 {
        font-size: 30px;
      }
      .carousel-caption .lead,
      .carousel-caption .btn {
        font-size: 18px;
      }

      .marketing .span4 + .span4 {
        margin-top: 20px;
      }

      .featurette-heading {
        font-size: 30px;
      }
      .featurette .lead {
        font-size: 18px;
        line-height: 1.5;
      }

    }
    </style>
  </head>
  

<div style="background-image:url(img/class.png);">

	<hr>
<div id="myCarousel" class="carousel slide">
      <div class="carousel-inner">
        <div class="item active" style="background-image:url(img/striped1.jpg);">
          
          <div class="container">
            <div class="carousel-caption">
              <h1>Berätta om dig själv</h1>
            
			  </p>
              <h4><a href="profilsida.jsp">Gå till din profil</a></h4>
            </div>
          </div>
        </div>
        <div class="item" style="background-image:url(img/calc.jpg);">
       
          <div class="container">
            <div class="carousel-caption" >
              <h1>Håll koll på dina grupper</h1>
              
             <h4> <a href="gruppsida.jsp">Gå till dina grupper</a></h4>
            </div>
          </div>
        </div>
        <div class="item" style="background-image:url(img/striped1.jpg);">
          
          <div class="container" >
            <div class="carousel-caption" >
              <h1> Läs och dela med dig</h1>
             
              <h4><a href="booklist.jsp">Gå till dina böcker</a></h4>
            </div>
          </div>
        </div>
      </div>
      <a class="left carousel-control" href="#myCarousel" data-slide="prev">&lsaquo;</a>
      <a class="right carousel-control" href="#myCarousel" data-slide="next">&rsaquo;</a>
    </div><!-- /.carousel -->
  <div class="container marketing">

      <!-- Three columns of text below the carousel -->
      <div class="row">
        <div class="span4">
         
          <h2>Personer</h2>
          <p>Sök efter vänner, kursare, bekanta, likasinnade eller helt enkelt intressanta människor. Det är våra användare som skapar Plugg. Socialt</p>
          <p><a class="btn" href="userSearch.jsp">Sök användare</a></p>
        </div><!-- /.span4 -->
        <div class="span4">
         
          <h2>Böcker</h2>
          <p>Du behöver äga böcker för att läsa böcker på Litter. Läs andra användares diskussioner och betyg för att avgöra vilka böcker som är intressanta för dig.</p>
          <p><a class="btn" href="bookSearch.jsp">Sök böcker</a></p>
        </div><!-- /.span4 -->
        <div class="span4">
          
          <h2>Cirklar</h2>
          <p>Gå med i en studiecirkel för att få ut maximalt från din Litter-upplevelse! Skapa egna eller leta upp en som passar dig och dina intressen.</p>
          <p><a class="btn" href="groupSearch.jsp">Sök Cirklar</a></p>
        </div><!-- /.span4 -->
      </div><!-- /.row -->

<br><br>
</div>
 <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster --> 
	<script src="js/jquery.min.js"></script>
   
 <script src="js/bootstrap.min.js"></script>
</body>

</html>