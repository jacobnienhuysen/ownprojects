import javax.swing.BoxLayout;
import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

public class NyDrinkForm extends JPanel{
		JTextField namnField = new JTextField(16);
		String [] rednList={"Skakas", "Röres", "Byggs"};
		JComboBox rednField = new JComboBox(rednList);
		String[] glasList={"Highball", "Cocktail", "Old-fashion", "Hurricane"};
		JComboBox glasField = new JComboBox(glasList);
		JTextField garnField = new JTextField(10);
		
		public NyDrinkForm(){
			setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
			
			JPanel rad1 = new JPanel();
			rad1.add(new JLabel("Namn: "));
			rad1.add(namnField);
			add(rad1);
			
			JPanel rad2 = new JPanel();
			rad2.add(new JLabel("Tillredning: "));
			rad2.add(rednField);
			add(rad2);
			
			JPanel rad3 = new JPanel();
			rad3.add(new JLabel("Glastyp: "));
			rad3.add(glasField);
			add(rad3);
			
			JPanel rad4 = new JPanel();
			rad4.add(new JLabel("Garnish: "));
			rad4.add(garnField);
			garnField.setText("ingen");
			add(rad4);
		}
		
		String getNamn(){
			return namnField.getText();
		}
		
		String getRedn(){
			return "<redn>" + rednList[rednField.getSelectedIndex()];
		}
		
		String getGlas(){
			return "<glas>" + glasList[glasField.getSelectedIndex()];
		}
		
		String getGarn(){
			if (garnField.getText().isEmpty()){
				return "<garn>ingen";
			}else{
				return "<garn>" + garnField.getText();
			}
		}
	}