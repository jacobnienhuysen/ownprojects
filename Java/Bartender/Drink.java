import java.util.ArrayList;

public class Drink {
	
	private ArrayList<Ingrediens> ingrList;
	private String namn;
	private String tillredning;
	private String glastyp;
	private String garnish;
	private boolean testad;
	
	public Drink(String namn, String tillredning, String glastyp, String garnish){
		this.namn=namn;
		this.tillredning=tillredning;
		this.glastyp=glastyp;
		this.garnish=garnish;
		testad=false;
		ingrList = new ArrayList<Ingrediens>();
	}
	
	public void addIngr(Ingrediens ingr){
		ingrList.add(ingr);
	}
	
	public String getNamn(){
		return namn;
	}
	
	public String getTillredning(){
		return tillredning;
	}
	
	public String getGlastyp(){
		return glastyp;
	}
	
	public String getGarnish(){
		if( garnish == null )
			return "ingen";
		else
			return garnish;
	}
	
	public boolean isTestad(){
		return testad;
	}
	
	public String getIngredienser(){
		if(ingrList.isEmpty()){
			return "inga";
		}else{
			String str = "";
			for(int i=0; i<ingrList.size();i++){
				Ingrediens j = ingrList.get(i);
				if(i==(ingrList.size()-1))
					str+=j.getNamn();
				else
					str+=j.getNamn() + ", ";
			}
			return str;
		}
	}
	
	public ArrayList<Ingrediens> getIngrList(){
		return ingrList;
	}
	
	public void setTestad(boolean testad){
		this.testad=testad;
	}
	
	public void setNamn(String namn){
		this.namn=namn;
	}
	
	public void setTillredning(String redn){
		this.tillredning=redn;
	}
	
	public void setGlastyp(String glas){
		this.glastyp=glas;
	}
	
	public void setGarnish(String garn){
		this.garnish=garn;
	}
	
	public String getDrink(){
		return namn + "\nTillredning: " + tillredning + " i ett " + glastyp + "-glas.\nGarnish: " + garnish;
	}
	
	public String toString(){
			return namn;
	}
}
