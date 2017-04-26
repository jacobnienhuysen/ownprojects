import java.awt.event.*;

import javax.swing.*;

public class NewGamePrompt extends JPanel{

	private JRadioButton onePlayer, twoPlayers, xSymbol, oSymbol;
	private JLabel kryss = new JLabel(new ImageIcon("bilder/kryss.png"));
	private JLabel rund = new JLabel(new ImageIcon("bilder/ring.png"));
	
	public NewGamePrompt(){
		
		setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
		
		JPanel rad1 = new JPanel();
			rad1.add(onePlayer = new JRadioButton("Spela mot datorn"));
			onePlayer.addActionListener(new ValLyss());
			rad1.add(twoPlayers = new JRadioButton("Två spelare"));
			twoPlayers.addActionListener(new ValLyss());
		add(rad1);
		
		ButtonGroup bg = new ButtonGroup();
			bg.add(onePlayer);
			bg.add(twoPlayers);
		onePlayer.setSelected(true);
		
		JPanel rad2 = new JPanel();
			rad2.add(new JLabel("Välj symbol:"));
		add(rad2);
		
		JPanel rad3 = new JPanel();
			rad3.add(xSymbol = new JRadioButton());
			rad3.add(kryss);
		add(rad3);
		
		JPanel rad4 = new JPanel();
			rad4.add(oSymbol = new JRadioButton());
			rad4.add(rund);
		add(rad4);
		
		ButtonGroup bg2 = new ButtonGroup();
		bg2.add(xSymbol);
		bg2.add(oSymbol);
		xSymbol.setSelected(true);
		
	}
	
	public int getPlayers(){
		if(onePlayer.isSelected())
			return 0;
		else if(twoPlayers.isSelected())
			return 1;
		else
			throw new IllegalArgumentException("Antal spelare har inte valts.");
	}
	
	public int getSymbol(){
		if(xSymbol.isSelected())
			return 1;
		else if(oSymbol.isSelected())
			return -1;
		else
			throw new IllegalArgumentException("Ingen symbol har valts.");
	}
	
	private class ValLyss implements ActionListener{
		public void actionPerformed(ActionEvent eve){
			if(onePlayer.isSelected()){
				oSymbol.setEnabled(true);
				xSymbol.setEnabled(true);
			}
			else{
				oSymbol.setEnabled(false);
				xSymbol.setEnabled(false);
			}
		}
	}
	
}
