import java.io.*;
import java.util.*;

public class DrinkReader {
	
	public ArrayList<Ingrediens> getIngr(String drNamn, String drPath){
		
		if(checkDrink(drNamn, drPath)){
			double clToAdd = 0;
			
			ArrayList<Ingrediens> ingrList = new ArrayList<Ingrediens>();
			try{
				Reader fir = new InputStreamReader(new FileInputStream(drPath), "ISO-8859-1");
				BufferedReader buff = new BufferedReader(fir);
				
				String rad = buff.readLine();
				
				while(rad!=null){
					
				}
			
			buff.close();
			return ingrList;
			
			}catch(FileNotFoundException e){
				System.err.println("Filen fanns inte.");
			}catch(IllegalArgumentException e){
				System.err.println(e);
			}catch(IOException e){
				System.exit(0);
			}
		}	
		else{
			throw new NoSuchElementException();
		}
	}
	
	public ArrayList<String> getInfo(String drNamn, String drPath){
		if(checkDrink(drNamn, drPath)){
			ArrayList<String> infoList = new ArrayList<String>();
			return infoList;
		}
		else{
			throw new NoSuchElementException();
		}
	}
	
	public boolean writeDrink(String drNamn, String drRedn, String drGlas, String drGarn, ArrayList<Ingrediens> ingrList, String drPath){
		
		return true;
	}
	
	public boolean checkDrink(String drNamn, String drPath){
		
		return true;
	}

}
