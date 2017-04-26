import javax.swing.BoxLayout;
import javax.swing.ButtonGroup;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JTextField;

	public class NewPlayer extends JPanel{
		JRadioButton alt1, alt2, alt3;
		int charX, charY;
		
		public NewPlayer(){
			setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
			
			JPanel rad1 = new JPanel();
				rad1.add(new JLabel("Välj karaktär: "));
			add(rad1);
			
			JPanel rad2 = new JPanel();
				rad2.add(alt1 = new JRadioButton("Ko",true));
				rad2.add(alt2 = new JRadioButton("Gris"));
				rad2.add(alt3 = new JRadioButton("Dammsugare"));
				
				ButtonGroup bg = new ButtonGroup();
				bg.add(alt1);
				bg.add(alt2);
				bg.add(alt3);
			add(rad2);
		}
		
		public String getPlayerChar(){
			if(alt1.isSelected()){
				this.charX = 150;
				this.charY = 150;
				return "cow";
			}
			else if(alt2.isSelected()){
				this.charX = 150;
				this.charY = 129;
				return "pig";
			}
			else if(alt3.isSelected()){
				this.charX = 150;
				this.charY = 150;
				return "vac";
			}
			else
				return null;
		}
		
		public int getCharX(){
			return charX;
		}
		
		public int getCharY(){
			return charY;
		}
	}