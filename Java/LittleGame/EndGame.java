import java.awt.*;
import javax.swing.*;

public class EndGame extends JPanel{

	private JTextField nameField = new JTextField(10);
	
	public EndGame(int playerPoints){
		setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
		
		JPanel rad1 = new JPanel();
			rad1.add(new JLabel("Spelet är slut! Din poäng blev: " + playerPoints));
		add(rad1);
		
		JPanel rad2 = new JPanel();
			rad2.add(new JLabel("Skriv ditt namn: "));
			rad2.add(nameField);
		add(rad2);
	}
	
	public String getPlayerName(){
		return nameField.getText();
	}

}
