import java.util.Map.Entry;
import java.util.Random;
import java.util.HashMap;
import java.util.Set;
import java.util.TreeMap;
import java.util.Iterator;

public class PointGenerator {
	public static void main(String[] args){
		
		HashMap<String,TreeMap<Integer,Integer>> scoreboard = new HashMap<String,TreeMap<Integer,Integer>>();
		HashMap<Integer,Integer> totalScore = new HashMap<Integer,Integer>();
		
		Random rand = new Random();
		
		String[] l�nder = {"Island", "�sterrike", "Irland","Turkiet","Malta","Bosnien & Herzegovina", "Portugal", "Kroatien", "Cypern","Tyskland","Ryssland","Spanien", "Israel", "Nederl�nderna", "Storbritannien", "Ukraina", "Grekland", "Norge", "Frankrike","Polen", "Lettland", "Belgien", "Estland", "Rum�nien", "Sverige", "Slovenien"};
		
		int[] po�ng = {1, 2, 3, 4, 5, 6, 7, 8, 10, 12};
		int antal = l�nder.length;
		int r = rand.nextInt(antal);
		

		boolean nullPoints = true;
		int nullCountry = 17;
		int nullCountry2 = 1;
		
		boolean[] delad = new boolean[antal];
		for(int x=0; x<antal; x++){
			delad[x] = false;
		}
		
		int[] pts1 = {1,1,1,2,2,2,3,3,3,3,4};
		
		
		//Delar ut po�ng till tio slumpade l�nder och placerar i lista tillsammans med land som delar ut dem.
		for(int i=0; i<antal; i++){
			TreeMap<Integer,Integer> temp = new TreeMap<Integer,Integer>();
			int step = 0;
			
			while(step<10){
				if(!delad[r] && r != i && r != nullCountry && r != nullCountry2){
					temp.put(r, po�ng[step]);
					delad[r] = true;
					step++;
				}
				r = rand.nextInt(antal);
			}
			scoreboard.put(l�nder[i], temp);
			for(int x=0; x<antal; x++){
				delad[x] = false;
			}
		}
		//System.out.println(scoreboard);
		
		//H�mtar po�ngen fr�n varje land och l�gger samman dem i totalScore.
		for(int x=0;x<antal;x++){
			TreeMap<Integer,Integer> temp = scoreboard.get(l�nder[x]);
			
			for(Entry<Integer, Integer> entry : temp.entrySet()){
				int score = entry.getValue();
				if(totalScore.containsKey(entry.getKey())){
					int tempScore = totalScore.get(entry.getKey());
					totalScore.put(entry.getKey(), tempScore+=score);
				}
				else{
					totalScore.put(entry.getKey(), entry.getValue());
				}
			}
		}
		/*
		for(int y=0; y<antal; y++){
			int score = totalScore.get(y);
			System.out.println(score + "  " + l�nder[y]);
		}
		*/
		
		for(int x=0; x<antal; x++){
			TreeMap<Integer,Integer> temp = scoreboard.get(l�nder[x]);
			
			int draw = 0;
			
			while(draw < antal){
				if(temp.containsKey(draw)){
					if(temp.get(draw)<10){
						System.out.print(temp.get(draw) + "   ");
					}
					else{
						System.out.print(temp.get(draw) + "  ");
					}
					
				}
				else{
					if(draw == x){
						System.out.print("-   ");
					}
					else{
						System.out.print("    ");
					}
				}
				draw++;
			}
			System.out.println(l�nder[x]);
		}
		
		for(int z=0; z<antal; z++){
			if(totalScore.containsKey(z)){
				if(totalScore.get(z)>=100){
					System.out.print(totalScore.get(z) + " ");
				}
				else if(totalScore.get(z)<10){
					System.out.print(totalScore.get(z) + "   ");
				}
				else{
					System.out.print(totalScore.get(z) + "  ");
				}
			}
			else{
				System.out.print("0   ");
			}
		}
		System.out.print("<= Totalt");
	}
}