import java.awt.*;
import java.net.URL;
import javax.swing.*;

public class FruitIcon extends CollectIcon{
	
	private Image bild;
	private String type;
	
	public FruitIcon(int x, int y, String type){
		super(x,y,type);
		this.type=type;
		URL url = getClass().getResource("/pics/" + type + ".gif");
		bild = Toolkit.getDefaultToolkit().getImage(url);
	}
	
	public String getType(){
		return type;
	}

}
