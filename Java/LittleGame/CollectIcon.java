import java.awt.*;
import java.net.URL;

import javax.swing.*;

public class CollectIcon extends JComponent{
	private Image bild;
	private String type;
	
	public CollectIcon(int x, int y, String type){
		this.type=type;
		URL url = getClass().getResource("/pics/" + type + ".gif");
		bild = Toolkit.getDefaultToolkit().getImage(url);
		setBounds(x, y, 32, 32);
		setPreferredSize(new Dimension(32,32));
		setMaximumSize(new Dimension(32,32));
		setMinimumSize(new Dimension(32,32));
	}
	
	protected void paintComponent(Graphics g){
		super.paintComponent(g);
		g.drawImage(bild,0,0, getWidth(),getHeight(),this);
	}

}
