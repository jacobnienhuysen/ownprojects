import javax.swing.BoxLayout;
import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

public class ChgFactForm extends JPanel{
		JTextField namnField = new JTextField(16);
		String [] rednList={"Skakas", "Röres", "Byggs"};
		JComboBox rednField = new JComboBox(rednList);
		String[] glasList={"Highball", "Cocktail", "Old-fashion", "Hurricane"};
		JComboBox glasField = new JComboBox(glasList);
		JTextField garnField = new JTextField(10);
		
		public ChgFactForm(String drRedn, String drGlas, String drGarn){
			setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
			
			JPanel rad1 = new JPanel();
			rad1.add(new JLabel("Tillredning: "));
			rad1.add(rednField);
			rednField.setSelectedItem(drRedn);
			add(rad1);
			
			JPanel rad2 = new JPanel();
			rad2.add(new JLabel("Glastyp: "));
			rad2.add(glasField);
			glasField.setSelectedItem(drGlas);
			add(rad2);
			
			JPanel rad3 = new JPanel();
			rad3.add(new JLabel("Garnish: "));
			rad3.add(garnField);
			garnField.setText(drGarn);
			add(rad3);
		}
		
		String getNamn(){
			return namnField.getText();
		}
		
		String getRedn(){
			return rednList[rednField.getSelectedIndex()];
		}
		
		String getGlas(){
			return glasList[glasField.getSelectedIndex()];
		}
		
		String getGarn(){
			if (garnField.getText().isEmpty()){
				return "ingen";
			}else{
				return garnField.getText();
			}
		}
	}