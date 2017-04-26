import javax.swing.BoxLayout;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;

public class VisaListaForm extends JPanel{
		JTextArea display = new JTextArea(10,20);
		
		public VisaListaForm(){
			setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
			
			JPanel rad1 = new JPanel();
			rad1.add(new JScrollPane(display));
			display.setEditable(false);
			add(rad1);
			
		}
	}