
public class Score{
	
	private String playerNamn;
	private int playerPoints;
	private double playerTid;
	
	public Score(String namn, int points){
		playerNamn=namn;
		playerPoints=points;
		//playerTid=tid;
	}
	
	public String getNamn(){
		return playerNamn;
	}
	
	public int getPoints(){
		return playerPoints;
	}
	
	public double getTid(){
		return playerTid;
	}
	
	public void setPoints(int points){
		playerPoints=points;
	}
	
	public void setTid(double tid){
		playerTid=tid;
	}
	
	public String toString(){
		return playerPoints + "p.\t" + playerNamn;
	}

}
