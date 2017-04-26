import javax.swing.*;


public class NyListaForm extends JPanel{
		private JTextField listNamn = new JTextField(20);
		
		public NyListaForm(){
			setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
			
			JPanel rad1 = new JPanel();
				rad1.add(new JLabel("Ange ett namn på listan: "));
			add(rad1);
			
			JPanel rad2 = new JPanel();
				rad2.add(listNamn);
			add(rad2);
		}
		
		public String getNewListName(){
			return listNamn.getText();
		}
	}