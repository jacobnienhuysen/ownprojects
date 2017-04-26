import javax.swing.*;
import java.awt.*;
import java.net.URL;

public class Bakground extends JPanel{
	private Image bild;
	
	public Bakground(String filnamn){
		setLayout(null);
		URL url = getClass().getResource("/pics/" + filnamn);
		bild = Toolkit.getDefaultToolkit().getImage(url);
	}
	
	protected void paintComponent(Graphics g){
		super.paintComponent(g);
		g.drawImage(bild,0,0,this);
	}
}