//var $BackImages;
var $currentFiller = "";
var $previousFiller = "";

$(document).ready(function() {
	
	/*
	$BackImages	= new Array();
	
	for(var i=1; i<8; i++){
		var backpic = "images/back" + i + ".jpg";
		$BackImages[i] = backpic;
	}
	*/

	preloadImages("images/profil.JPG","images/back6.JPG");
	

	//initera välkomstanimation, backgrund och meny
	
	var $background	= $('#back'),
	$bgimage = $background.find('#bgimage'),
	$menu = $('#menu'),
	$content = $('#content');
	$splash = $('#splash');
	adjustImageSize($bgimage);
	$splash.fadeOut(3500);
	$bgimage.fadeIn(4000);
	$menu.delay( 2500 ).fadeIn(1000);
	
	//öppna/stäng submenyer
	
	$( "#has-sub" ).click(function() {
		$(".sub").toggle(400);
	});
	
	
	//Ladda innehåll till content-diven och animera öppning/stängning.
	
	$(".clicky").click(function () {
        var content_id = $(this).attr('href'); 
		
		if($('#content').is(':visible')){
			
			$('#content').hide(300);
			$('#contentHolder').css("display", "none");
			$('#lyricHolder').css("display", "none");
			
			if(content_id != $currentFiller){
				$('#content').delay(300).queue(function(n){
					$('#contentHolder').css("display", "block");
					$('#contentHolder').html($(content_id).html());
					n();
				}).show(500);
				$currentFiller = $(this).attr('href');
			}
		}
		
		else{
			$('#lyricHolder').css("display", "none");
			$('#contentHolder').css("display", "block");
			$('#contentHolder').html($(content_id).html());
			$('#content').show(500);
			$currentFiller = $(this).attr('href');
		}
		
		return false;
    });
	
});
	

$( window ).resize(function() {
	
	var $background	= $('#back'),
	$bgimage = $background.find('#bgimage');
	adjustImageSize($bgimage);
	
});


//Förladda bilder
	
preloadImages = function() {
		for (var i = 0; i < arguments.length; i++) {
			$("<img />").attr("src", arguments[i]);
		}
}

//Laddar sångtext

loadLyrics = function($id){
	
	//window.open("song.php?id="+$id, "lyricwindow", "width=500,height=600");
	
	
	
	/* Detta fungerar, men får php-error som måste hanteras
	*/
	var song_url = "song.php?id="+$id;
	$previousFiller = $('#content').html();
	
	/*
	$('#content').load(song_url);
	$('#content').prependTo('<span class="close" id="closeLyric"></span>');
	*/
	
	/*
	
	$('#lyricHolder').load(song_url, function(){
		$(".close").click(function () {
			$('#content').html = $previousFiller;
		});
	});
	
	*/
	
	$('#lcontent').load(song_url, function(){
		$('#lyricHolder').css("display", "block");
		$('#contentHolder').css("display", "none");
		$(".close").click(function () {
			closeLyric();
		});
	});
	
	
}

//Laddar dikt med detaljer i nytt fönster

loadPoem = function($id){
	
	//window.open("poem.php?id="+$id, "poemwindow", "width=500,height=600");
	
	
	
	/* Detta fungerar, men får php-error som måste hanteras
	*/
	var poem_url = "poem.php?id="+$id;
	//$previousFiller = $('#content').html();
	
	/*
	$('#content').load(poem_url);
	$('#content').prepend('<span class="close" id="closeLyric"></span>');
	*/
	
	$('#lcontent').load(poem_url, function(){
		$('#lyricHolder').css("display", "block");
		$('#contentHolder').css("display", "none");
		$(".close").click(function () {
			closeLyric();
		});
	});
	
	
	
	
}

// Stänger text och återgår till förgående vy

closeLyric = function() {
	$('#lyricHolder').css("display", "none");
	$('#contentHolder').css("display", "block");
}


// Skickar mail via formuläret

sendMail = function(){
		
		var data = {
			namn: $('#namn').val(),
			mail: $('#mail').val(),
			mess: $('#mess').val()
		};
		
		$.ajax({
			type:"POST",
			url: "scripts/mailaction.php",
			data: data,
			success: function(){
				alert("Tack för ditt mail!");
			}
		});
		return false;
		
	};

//Justerar bakgrundsbildens storlek och placering när fönstrets storlek ändras.

adjustImageSize	= function($img) {
	var w_w	= $(window).width(),
	w_h	= $(window).height(),
	r_w	= w_h / w_w,
	i_w	= $img.width(),
	i_h	= $img.height(),
	r_i	= i_h / i_w,
	new_w,new_h,
	new_left,new_top;
							
	if(r_w > r_i){
		new_h	= w_h;
		new_w	= w_h / r_i;
	}
	else{
		new_h	= w_w * r_i;
		new_w	= w_w;
	}
							
	$img.css({
		width	: new_w + 'px',
		height	: new_h + 'px',
		left	: (w_w - new_w) / 2 + 'px',
		top		: (w_h - new_h) / 2 + 'px'
	});
}
