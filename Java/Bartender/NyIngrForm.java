import javax.swing.*;

public class NyIngrForm extends JPanel{
		//String [] ingrList={"Vodka", "Rom", "Gin", "Tequila", "Cointreau", "Jack Daniels", "Likör 43", "mjölk", "Grenadin", "Coca-cola", "Sprite"};
		//JComboBox ingrAlt = new JComboBox(ingrList);
		JTextField ingrField = new JTextField(10);
		JTextField clField = new JTextField(2);
		JRadioButton ingrListBtn, ingrFieldBtn;
		
		
		public NyIngrForm(){
			setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
			
			JPanel rad1 = new JPanel();
				rad1.add(new JLabel("Ange ingrediens:"));
			add(rad1);
			
			JPanel rad2 = new JPanel();
				rad2.add(ingrField);
				//ingrAlt.setEditable(true);
				rad2.add(clField);
				rad2.add(new JLabel(" cl."));
			add(rad2);
		}
	
		
		public String getIngrName(){
			return ingrField.getText();
		}
		
		public double getCl(){
			try{
				return Double.parseDouble(clField.getText());
			}catch(NumberFormatException e){
				return -1;
			}
		}
	}