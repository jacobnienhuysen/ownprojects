import java.awt.*;
import javax.swing.*;

public class Bakgrund extends JPanel{
	private Image bild;

	
	public Bakgrund(){
		setLayout(null);
		bild=Toolkit.getDefaultToolkit().getImage("drink.jpg");
	}
	
	protected void paintComponent(Graphics g){
		super.paintComponent(g);
		g.drawImage(bild,0,0,getWidth(),getHeight(),this);
	}

}
