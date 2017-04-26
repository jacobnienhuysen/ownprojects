import javax.swing.*; 
import static javax.swing.JOptionPane.*;
import java.awt.*;
import java.awt.event.*;
import java.util.*;

public class DrinkSpec extends JDialog{
	
	private String drinkName;
	private JButton CloseB, ChaDB, RemIB, AddIB, ChaIB;
	private JLabel drName;
	private Font f1 = new Font("Titel", Font.BOLD, 18);
	private JList ingrLista;
	private Drink currentDrink;
	
	public DrinkSpec(Drink dr){
		setTitle("Detaljer");
		currentDrink = dr;
		
		//Detaljer
		drinkName=dr.getNamn();
		currentDrink=dr;
		
		//Övre delen av fönstret
		JPanel norr = new JPanel();
		norr.add(drName = new JLabel(drinkName));
		drName.setFont(f1);
		add(norr, BorderLayout.NORTH);
		
		//Innehållspanelen
		JPanel content = new JPanel();
		content.setLayout(new GridLayout(1,2));
		
		///Vänstra halvan av content
		JPanel west = new JPanel();
		west.setLayout(new BoxLayout(west, BoxLayout.Y_AXIS));
		
		west.setBorder(BorderFactory.createTitledBorder("Ingredienser: "));
		
		JPanel vRad2 = new JPanel();
		ingrLista = new JList(dr.getIngrList().toArray());
		vRad2.add(new JScrollPane(ingrLista));
		ingrLista.setLayoutOrientation(JList.VERTICAL);
		ingrLista.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		ingrLista.setVisibleRowCount(6);
		ingrLista.setFixedCellWidth(200);
		west.add(vRad2);
		
		JPanel vRad3 = new JPanel();
		vRad3.add(AddIB = new JButton("Lägg till"));
		vRad3.add(ChaIB = new JButton("Ändra"));
		ChaIB.setEnabled(false);
		vRad3.add(RemIB = new JButton("Ta bort"));
		RemIB.setEnabled(false);
		west.add(vRad3);
		
		content.add(west);
		
		
		//Högra halvan av content
		JPanel east = new JPanel();
		east.setLayout(new BoxLayout(east, BoxLayout.Y_AXIS));
		
		east.setBorder(BorderFactory.createTitledBorder("Tillredning: "));
		
		JPanel eRad1 = new JPanel();
		eRad1.add(new JLabel("Tillredning: " + dr.getTillredning()));
		east.add(eRad1);
		
		JPanel eRad2 = new JPanel();
		eRad2.add(new JLabel("Glastyp: " + dr.getGlastyp()));
		east.add(eRad2);
		
		JPanel eRad3 = new JPanel();
		eRad3.add(new JLabel("Garnish: " + dr.getGarnish()));
		east.add(eRad3);
		
		JPanel eRad4 = new JPanel();
		eRad4.add(ChaDB = new JButton("Ändra"));
		east.add(eRad4, BorderLayout.SOUTH);
		
		content.add(east);
		
		add(content, BorderLayout.CENTER);
		
		//Nedre delen av fönstret
		JPanel south = new JPanel();
		south.setLayout(new FlowLayout(FlowLayout.RIGHT));
		south.add(CloseB = new JButton("Stäng"));
		CloseB.addActionListener(new CloseLyss());
		add(south, BorderLayout.SOUTH);
		
		pack();
		setResizable(false);
		setDefaultCloseOperation(DISPOSE_ON_CLOSE);
		setVisible(true);
	}
	
	//Lyssnarklasser
	
	public class AddIngrediens implements ActionListener{
		public void actionPerformed(ActionEvent eve){
		NyIngrForm nif = new NyIngrForm();
		if (showConfirmDialog(DrinkSpec.this,nif,currentDrink.getNamn(),OK_CANCEL_OPTION)==YES_OPTION){
			currentDrink.addIngr(new Ingrediens(nif.getIngrName(), nif.getCl()));
		}
		else
			return;
		}
	}
	
	public class CloseLyss implements ActionListener{
		public void actionPerformed(ActionEvent eve){
			dispose();
		}
	}

}
