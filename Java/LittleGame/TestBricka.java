import java.awt.*;
import javax.swing.*;

public class TestBricka extends JComponent{
	private boolean visas = false;
	
	public TestBricka(int x, int y){
		setBounds(x, y, 440, 130);
		setPreferredSize(new Dimension(440,130));
		setMaximumSize(new Dimension(440,130));
		setMinimumSize(new Dimension(440,130));
	}
	
	protected void paintComponent(Graphics g){
		super.paintComponent(g);
		g.setColor(Color.GREEN.darker());
		g.fillRect(0, 0, getWidth(), getHeight());
		g.setColor(Color.BLACK);
		g.drawRect(0, 0, getWidth(), getHeight());
	}
	
	//170,280

}
