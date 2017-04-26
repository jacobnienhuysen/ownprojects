import java.awt.FlowLayout;

import javax.swing.BoxLayout;
import javax.swing.JPanel;
import javax.swing.JTextArea;

public class HighScoreList extends JPanel{
		JTextArea HSDisplay = new JTextArea();
		//JButton closeHs, clearHs;
		
		public HighScoreList(){
			setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
			
			JPanel rad1 = new JPanel();
			rad1.add(HSDisplay);
			rad1.setLayout(new FlowLayout(FlowLayout.LEFT));
			HSDisplay.setOpaque(false);
			HSDisplay.setEditable(false);
			add(rad1);
		}
	}