import javax.swing.*;
import java.awt.*;
import java.net.URL;

public class PlayerIcon extends JComponent{
	private Image bild;
	int x;
	int y;
	
	public PlayerIcon(String playerChar, int x, int y){
		URL url = getClass().getResource("/pics/" + playerChar + ".gif");
		bild = Toolkit.getDefaultToolkit().getImage(url);
		this.x=x;
		this.y=y;
		setBounds(20,280,x,y);
		setPreferredSize(new Dimension(bild.getWidth(this),bild.getHeight(this)));
	}
	
	protected void paintComponent(Graphics g){
		super.paintComponent(g);
		g.drawImage(bild, 0, 0, x, y, this);
	}
	
	public void movePlayer(int moveChoice){
		
		if(moveChoice == 1 && this.getY()<350){
			this.setLocation(this.getX(), this.getY()+10);
			repaint();
		}
		else if(moveChoice == 2 && this.getX()>20){
			this.setLocation(this.getX()-10, this.getY());
			repaint();
		}
		else if(moveChoice == 3 && this.getX()<500){
			this.setLocation(this.getX()+10, this.getY());
			repaint();
		}
		else if(moveChoice == 4 && this.getY()>170){
			this.setLocation(this.getX(), this.getY()-10);
			repaint();
		}	
	}
}
