import javax.swing.BoxLayout;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.ListSelectionModel;
import java.util.ArrayList;

public class VäljDrinkForm extends JPanel{
		JList drinkLista;
		
		public VäljDrinkForm(ArrayList<String> drinkList){
			setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
			
			JPanel rad1 = new JPanel();
			rad1.add(new JLabel("Välj drink för att visa detaljer:"));
			add(rad1);
			
			JPanel rad2 = new JPanel();
			drinkLista = new JList(drinkList.toArray());
			rad2.add(new JScrollPane(drinkLista));
			drinkLista.setLayoutOrientation(JList.VERTICAL);
			drinkLista.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
			drinkLista.setVisibleRowCount(6);
			drinkLista.setFixedCellWidth(200);
			add(rad2);
		}
		
		public String getVald(){
			return drinkLista.getSelectedValue().toString();
		}
	}