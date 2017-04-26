import javax.swing.*;
import java.awt.*;

public class Bricka extends JComponent{

	private boolean ritad = false;
	private int startValue;
	private int value;
	private ImageIcon icon;
	
	public Bricka(int x, int y, int z, ImageIcon i){
		setBounds(x, y, 75, 75);
		setPreferredSize(new Dimension(75, 75));
		setMaximumSize(new Dimension(75, 75));
		setMinimumSize(new Dimension(75,75));
		startValue = z;
		icon = i;
	}
	
	public boolean ritad(){
		return ritad;
	}
	
	public int getValue(){
		return value;
	}
	
	public void rita(int s, ImageIcon i){
		value = s;
		ritad = true;
		icon = i;
	}
	
	public void reset(ImageIcon i){
		ritad = false;
		value = startValue;
		icon = i;
	}
	
	protected void paintComponent(Graphics g){
		super.paintComponent(g);
		g.drawImage(icon.getImage(), 0, 0, getWidth(), getHeight(), this);
	}

}
