function run(){

	/* OPTIONS */

	//Scores to be distributed by each jury. Enter scores in descending order, divided with a comma.
	//Limits: at least 3 and not more than songs
	var scoreList = [5,3,1];
	
	//Id:s of the songs to be used in order of appearance
	//Limits: at least 3 and not less than entered scores
	var songIds = [0,11,3,4,5,6,7,8,9,2];
	
	//Use televote? true = yes, false = no
	var useTelevote = false;
	
	//Televote value. Multiplied with single jury score
	var televoteValue = 11;
	
	//Probability for each song to get a higher score, in order of appearance
	//Limits: min = 0.0, max = 1.0. Enter exactly one (1) value for each song
	var weights = [0.004, 0.006, 0.037, 0.005, 0.005, 0.124, 0.067, 0.087, 0.058, 0.607];
	
	
	
	/* DO NOT CHANGE ANYTHING BELOW! */
	
	//Check user inputs
	if(scoreList.length < 3 || songIds.length < 3 || songIds.length < scoreList.length || songIds.length !== weights.length){
		document.write("ERROR. Please check preferences!");
	}
	else{
	
		//List of songs
		var songList = createSongList(songIds);
		
		//Weighted list
		var weightedList = generateWeightedList(weights, songList);
	
		//Options for scoreboard
		var options = {
			scoreList: scoreList,
			songList: songList,
			weightedList: weightedList,
			useTelevote: useTelevote,
			televoteValue: televoteValue
		};
	
		//Generate scoreboard
		var scoreboard = generateScoreboard(options);
		
		//Print running order
		printRunningOrder(songList, scoreboard);
		
		//Pring scoreboard
		printScoreBoard(songList, scoreboard, useTelevote);
		
	}
}


//Fetch data of selected songs and return running order list
function createSongList(songIdList){
	
	//Fetch song data from json file
	var songs = songdata;
	
	//Result list
	var result = [];
	
	//Fetch song titles from json file
	for(var i=0; i<songIdList.length; i++){
		
		var id = songIdList[i];
		
		var song = {
			draw: (i+1),
			title: songs[id].title,
			score: 0
		};
		
		result.push(song);
	};
	
	return result;
}


//Create weighted list for randomized scoreboard
function generateWeightedList(weights, songs) {
	
	//Result list
	var weightedList = [];
	
	//Loop weights
	for(var i=0; i<weights.length; i++){
		var multiples = weights[i] * 100;
	
		for(var j=0; j<multiples; j++){
			weightedList.push(songs[i].draw);
		}
	}
	
	return weightedList;
}


//Generate scoreboard
function generateScoreboard(options){
	
	//Fetch jury data from json file
	var juries = jurydata;
	
	//Reset
	var scoreboard = [];
	
	//Generate scores for each jury
	for(var j=0; j<juries.length; j++){
		var juryvote = generateScore(juries[j].name, options, false);
		scoreboard.push(juryvote);	
	}
	
	//Generate televote if chosen
	if(options.useTelevote){
		var televote = generateScore("Tittare", options, true);
		scoreboard.push(televote);
	}
	
	console.log(scoreboard);
	
	return scoreboard;
}


//Genereate jury/televote
function generateScore(juryname, options, isTelevote){
	
	//Score list
	var votes = [];
	
	//Reset vote list with 'nul points' for each participating song
	for(var i=0; i<options.songList.length; i++){
		votes[i] = 0;
	}
	
	//For each score in scorelist
	for(var i=0; i<options.scoreList.length; i++){
			
		var set = false;
		
		//Run loop until a score is given to a new song
		while(!set){
			
			var random = randomNumber(0, options.weightedList.length-1);
			var randomDraw = options.weightedList[random];
			
			//If value of draw has not been set
			if(votes[randomDraw-1] === 0){
				
				if(isTelevote){
					votes[randomDraw-1] = (options.scoreList[i]*options.televoteValue);
				}
				else{
					votes[randomDraw-1] = options.scoreList[i];
				}
				
				set = true;
			}
		}	
	}
	
	//Create result object
	var result = {
		jury: juryname,
		votes: votes,
		televote: isTelevote
	};
	
	return result;
}


//Randomizer
function randomNumber(min, max) {
	return Math.floor(Math.random() * (max - min + 1)) + min;
}


//Generate html for running order
function printRunningOrder(songList, scoreboard){
	
	var html = "";
	
	//Generate html string
	for(var i=0; i<songList.length; i++){		
		html += '<tr class="song">';
		html += '<td class="draw">' + songList[i].draw + '</td>';
		html += '<td class="title">' + songList[i].title + '</td>';
		
		var score = 0;
		
		//Calculate score for song
		for(var j=0; j<scoreboard.length; j++){
			score += scoreboard[j].votes[i];
		}

		html += '<td class="score">' + score + '</td>';
		html += '</tr>';
	}
	
	//Fill table element with html
	document.getElementById("songs").innerHTML = html;
}


//Generate html for scoreboard
function printScoreBoard(songList, scoreboard, televote){
	
	var html = "";
	var televoteIndex = null;
	
	//Table headers
	html += '<tr class="headers">';
	html += '<th></th>';
	html += '<th>Titel</th>';
	
	for(var i=0; i<scoreboard.length; i++){
		
		var shortName = 
		
		html += '<th class="jury">' + scoreboard[i].jury + '</th>';
	
		if(scoreboard[i].televote){
			televoteIndex = i;
		}
	}
	
	html += '<th class="total">Total</th>';
	html += '<th class="total">Plac.</th>';
	html += '</tr>';
	
	//Rest of scoreboard
	for(var i=0; i<songList.length; i++){
		
		html += '<tr class="song">';
		html += '<td class="draw">' + songList[i].draw + '</td>';
		html += '<td class="title">' + songList[i].title + '</td>'; 
		
		var totalScore = 0;
		
		//Fetch score from each jury
		for(var j=0; j<scoreboard.length; j++){
			
			var points = scoreboard[j].votes[i];
			
			//Print white space if 0 points
			var value = points;
			if(value === 0){
				value = " ";
			}
			
			if(j === televoteIndex && televote){
				html += '<td class="point televote">' + value + '</td>';
			}
			else{
				html += '<td class="point">' + value + '</td>';
			}
			
			totalScore += points;
		}
		
		html += '<td class="score">' + totalScore + '</td>';
		
		html += '</tr>';
	}
	
	document.getElementById("scores").innerHTML = html;
}
















