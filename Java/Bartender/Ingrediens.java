public class Ingrediens {
	private String namn;
	private double cl;
	
	public Ingrediens(String namn, double cl){
		this.namn=namn;
		this.cl=cl;
	}
	
	public String getNamn(){
		return namn;
	}
	
	public double getCl(){
		return cl;
	}
	
	public void setNamn(String namn){
		this.namn=namn;
	}
	
	public void setCl(double cl){
		this.cl=cl;
	}
	
	public String toSave(){
		if(cl == -1)
			return "&" + namn;
		else
			return cl + " cl&" + namn;
	}
	
	public String toString(){
		if(cl == -1)
			return namn;
		else
			return cl + " cl " + namn;
	}
}
