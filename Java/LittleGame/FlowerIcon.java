import java.awt.*;
import javax.swing.*;
import java.net.URL;

public class FlowerIcon extends CollectIcon{
	
	private Image bild;
	private String type;
	
	public FlowerIcon(int x, int y, String type){
		super(x, y, type);
		this.type=type;
		URL url = getClass().getResource("/pics/" + type + ".gif");
		bild = Toolkit.getDefaultToolkit().getImage(url);
	}
	
	public String getType(){
		return type;
	}
}