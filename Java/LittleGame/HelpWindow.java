import java.awt.*;
import javax.swing.*;

public class HelpWindow extends JPanel{

	JTextArea field = new JTextArea();
	
	public HelpWindow(){
		setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
		
		JPanel rad1 = new JPanel();
			rad1.add(new JScrollPane(field));
			field.setEditable(false);
		add(rad1);
	}
}