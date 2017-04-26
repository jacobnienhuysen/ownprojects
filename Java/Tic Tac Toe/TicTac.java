import javax.swing.*;

import java.awt.*;
import java.awt.event.*;

import static javax.swing.JOptionPane.*;

public class TicTac extends JFrame{
	
	private Bricka[][] brickor;
	private ImageIcon[] bilder = new ImageIcon[3];	//0=blank, 1=kryss, 2=ring
	
	private int symbol;	//1 eller -1
	
	private int currentPlayer = 1;	//1 eller -1
	
	private int turn = 1;	//räknar antalet ritade symboler
	private boolean computerPlayer = false;	//true om spelar mot AI
	
	//GUI-komponenter
	private JLabel playerLabel;
	private JButton newGame;
	private MusLyss ml;
	private AIMusLyss AIml;
	
	private Font font1 = new Font("Arial", Font.BOLD, 26);
	
	public TicTac(){
		super("Tic-Tac-Toe");
		
		bilder[0] = new ImageIcon("bilder/blank.png");
		bilder[1] = new ImageIcon("bilder/kryss.png");
		bilder[2] = new ImageIcon("bilder/ring.png");
		
		JPanel back = new JPanel();
			back.setBackground(Color.GREEN.darker());
			back.setLayout(null);
		add(back, BorderLayout.CENTER);
		
		JPanel plan = new JPanel();
			plan.setSize(245,245);
			plan.setBackground(Color.BLACK);
			plan.setLocation(280, 100);
			
			brickor = new Bricka[3][3];
			
			brickor[0][0] = new Bricka(0,0,3,bilder[0]);
			brickor[0][1] = new Bricka(0,80,2,bilder[0]);
			brickor[0][2] = new Bricka(0,160,3,bilder[0]);
			
			brickor[1][0] = new Bricka(0,0,2,bilder[0]);
			brickor[1][1] = new Bricka(80,80,4,bilder[0]);
			brickor[1][2] = new Bricka(160,160,2,bilder[0]);
			
			brickor[2][0] = new Bricka(0,80,3,bilder[0]);
			brickor[2][1] = new Bricka(80,160,2,bilder[0]);
			brickor[2][2] = new Bricka(160,240,3,bilder[0]);
			
			for(int i=0; i<3; i++){
				for(int j=0; j<3; j++){
					Bricka b = (brickor[i][j]);
					plan.add(b);
				}
			}
			
			
		back.add(plan);
		
		JPanel control = new JPanel();
			control.add(newGame = new JButton("Nytt spel"));
				newGame.addActionListener(new NewGameLyss());
				control.add(playerLabel = new JLabel("\u2190 Klicka där!"));
				playerLabel.setFont(font1);
				newGame.setFont(font1);
		add(control, BorderLayout.SOUTH);
		
		
		
		setDefaultCloseOperation(EXIT_ON_CLOSE);
		setSize(800,600);
		setResizable(false);
		setVisible(true);
		setLocationRelativeTo(null);
	}
	
	public class NewGameLyss implements ActionListener{
		public void actionPerformed(ActionEvent e){
			
			computerPlayer = false;
			currentPlayer = 1;
			
			for(int i=0; i<3; i++){
				for(int j=0; j<3; j++){
					brickor[i][j].reset(bilder[0]);
				}
			}
			
			repaint();
			
			NewGamePrompt ngp = new NewGamePrompt();
			if(showConfirmDialog(null, ngp, "Nytt spel", OK_CANCEL_OPTION) == OK_OPTION){
				
				
				if(ngp.getPlayers() == 0){	//spelar mot datorn
					 
					computerPlayer = true;
					playerLabel.setText("Spelar mot datorn");
					AIml = new AIMusLyss();
					symbol = ngp.getSymbol();
				}
				
				else if(ngp.getPlayers() == 1){	//två spelare
					
					playerLabel.setText("Spelare: 1");
					ml = new MusLyss();
				}
				
				turn = 1;
				
				for(int i=0; i<3; i++){
					for(int j=0; j<3; j++){
						Bricka b = brickor[i][j];
						
						if(computerPlayer){
							b.addMouseListener(AIml);
						}
						else{
							b.addMouseListener(ml);
						}
					}
				}
				
				if(computerPlayer && symbol == -1){
					aiPlayer();
				}
				
			}
		}
	}
	
	public class MusLyss extends MouseAdapter{
		public void mouseClicked(MouseEvent mev){
			Bricka b = (Bricka)mev.getSource();
			
			int temp = 0;
			if(currentPlayer == 1){
				temp = 1;
			}
			else if(currentPlayer == -1){
				temp = 2;
			}
			
			if(!b.ritad()){
				b.rita(currentPlayer, bilder[temp]);
				if(currentPlayer == 1){
					currentPlayer = -1;
					playerLabel.setText("Spelare: 2");
				}
				else{
					currentPlayer = 1;
					playerLabel.setText("Spelare: 1");
				}
				
				turn++;
				
				repaint();
				ritauthela();
				
				int winner = checkIfRow();
				if(winner == 1){
					declareWinner(1);
				}
				else if(winner == -1){
					declareWinner(2);
				}
				else if(turn == 10){
					declareWinner(-1);
				}
				
			}
		}
	}
	
	public class AIMusLyss extends MouseAdapter{
		public void mouseClicked(MouseEvent mev){
			Bricka b = (Bricka)mev.getSource();
			//System.out.println("Spelare " + currentPlayer);
			
			int temp = 0;
			if(currentPlayer == 1){
				temp = 1;
			}
			else if(currentPlayer == -1){
				temp = 2;
			}
			
			if(!b.ritad()){
				b.rita(currentPlayer, bilder[temp]);
				if(currentPlayer == 1){
					currentPlayer = -1;
				}
				else{
					currentPlayer = 1;
				}
				
				turn++;
				
				repaint();
				
				int winner = checkIfRow();
				if(winner == 1){
					declareWinner(1);
				}
				else if(winner == -1){
					declareWinner(2);
				}
				else if(turn == 10){
					declareWinner(-1);
				}
				else{
					aiPlayer();
				}
				
			}
		}
	}
	
	private int checkIfRow(){
		
		if(checkHorizontal() == 1 || checkVertical() == 1 || checkDiagonal() == 1){
			return 1;
		}
		else if(checkHorizontal() == -1 || checkVertical() == -1 || checkDiagonal() == -1){
			return -1;
		}
		else{
			return 0;
		}
	}
	
	private int checkHorizontal(){
		int sum = 0;
		
		for(int x=0; x<3; x++){
			for(int y=0; y<3; y++){
				if(brickor[x][y].ritad())
					sum += brickor[x][y].getValue();
			}
			if(sum == 3){
				return 1;
			}
			else if(sum == -3){
				return -1;
			}
			else{
				sum = 0;
			}
		}
		
		return 0;
	}
	
	private int checkVertical(){
		int sum = 0;
		
		for(int y=0; y<3; y++){
			for(int x=0;x<3;x++){
				if(brickor[x][y].ritad())
					sum += brickor[x][y].getValue();
			}
			if(sum == 3){
				return 1;
			}
			else if(sum == -3){
				return -1;
			}
			else{
				sum = 0;
			}
		}
		
		return 0;
	}
	
	private int checkDiagonal(){
		int sum1 = 0;
		int sum2 = 0;
		
		for(int x=0, y=0; x<3; x++,y++){
			if(brickor[x][y].ritad())
				sum1 += brickor[x][y].getValue();
		}
		
		for(int x=2, y=0; x>-1; x--,y++){
			if(brickor[x][y].ritad())
				sum2 += brickor[x][y].getValue();
		}
		
		if(sum1 == 3 || sum2 == 3){
			return 1;
		}
		else if (sum1 == -3 || sum2 == -3){
			return -1;
		}
		
		return 0;
	}
	
	private void declareWinner(int p){
		
		if(p > 0){
			JOptionPane.showMessageDialog(TicTac.this, "Player " + p + " has won!", "We have a winner!", JOptionPane.INFORMATION_MESSAGE);
		}
		else if(p == -1){
			JOptionPane.showMessageDialog(TicTac.this, "It it a draw!", "Darn", JOptionPane.INFORMATION_MESSAGE);
		}
			for(int i=0; i<3; i++){
				for(int j=0; j<3; j++){
					Bricka br = (brickor[i][j]);
					br.removeMouseListener(ml);
					br.removeMouseListener(AIml);
				}
			}
		
		playerLabel.setText("Spelet slut!");
	}
	
	
	private void aiPlayer(){
		int temp = 0;
		
		if(currentPlayer == 1){
			temp = 1;
		}
		else if(currentPlayer == -1){
			temp = 2;
		}
		
		//best value so far
		int best = 0;
		
		//coords
		int row = -1;
		int col = -1;
		
		for(int x=0; x<3; x++){
			for(int y=0; y<3; y++){
				if(brickor[x][y].getValue() > best){
					best = brickor[x][y].getValue();
					row = x;
					col = y;
				}
			}
		}
		
		switch(calculateRows()){
			case 0: 
				for(int y=0; y<3; y++){
					if(!brickor[0][y].ritad())
						brickor[0][y].rita(currentPlayer, bilder[temp]);
				}
			break;
			case 1:
				for(int y=0; y<3; y++){
					if(!brickor[1][y].ritad())
						brickor[1][y].rita(currentPlayer, bilder[temp]);
				}
			break;
			case 2:
				for(int y=0; y<3; y++){
					if(!brickor[2][y].ritad())
						brickor[2][y].rita(currentPlayer, bilder[temp]);
				}
			break;
			case 3:
				for(int x=0; x<3; x++){
					if(!brickor[x][0].ritad())
						brickor[x][0].rita(currentPlayer, bilder[temp]);
				}
			break;
			case 4:
				for(int x=0; x<3; x++){
					if(!brickor[x][1].ritad())
						brickor[x][1].rita(currentPlayer, bilder[temp]);
				}
			break;
			case 5:
				for(int x=0; x<3; x++){
					if(!brickor[x][2].ritad())
						brickor[x][2].rita(currentPlayer, bilder[temp]);
				}
			break;
			case 6:
				for(int x=0, y=0; x<3; x++,y++){
					if(!brickor[x][y].ritad())
						brickor[x][y].rita(currentPlayer, bilder[temp]);
				}
			break;
			case 7:
				for(int x=2, y=0; x>-1; x--,y++){
					if(!brickor[x][y].ritad())
						brickor[x][y].rita(currentPlayer, bilder[temp]);
				}
			break;
			case -1:
			default:
				throw new IllegalArgumentException("Rad finns inte.");
		
		}
		
		
		/*
		int temp = 0;
		if(currentPlayer == 1){
			temp = 1;
		}
		else if(currentPlayer == -1){
			temp = 2;
		}
		
		brickor[row][col].rita(currentPlayer, bilder[temp]);
		*/
		
		if(currentPlayer == 1){
			currentPlayer = -1;
		}
		else if(currentPlayer == -1){
			currentPlayer = 1;
		}
		turn++;
		
		repaint();
		//ritauthela();
		
		int winner = checkIfRow();
		if(winner == 1){
			declareWinner(1);
		}
		else if(winner == -1){
			declareWinner(2);
		}
		else if(turn == 10){
			declareWinner(-1);
		}
	}
	
	private int calculateRows(){
		
		int[] radVärden = new int[8];
		int tempRad = 0;
		int temp = 0;
		int rad = 0;
		
		//vågrätt
		
		for(int x=0; x<3; x++){
			for(int y=0; y<3; y++){
				if(brickor[x][y].ritad()){
					temp += brickor[x][y].getValue();	
				}
			}
			radVärden[tempRad++] = temp;
			temp = 0;
		}
		
		//vågrätt
		
		for(int y=0; y<3; y++){
			for(int x=0; x<3; x++){
				if(brickor[x][y].ritad()){
					temp += brickor[x][y].getValue();	
				}
			}
			radVärden[tempRad++] = temp;
			temp = 0;
		}
		
		
		//diagonalt
		
		for(int x=0, y=0; x<3; x++,y++){
			if(brickor[x][y].ritad())
				temp += brickor[x][y].getValue();
		}
		radVärden[tempRad++] = temp;
		temp = 0;
		
		for(int x=2, y=0; x>-1; x--,y++){
			if(brickor[x][y].ritad())
				temp += brickor[x][y].getValue();
		}
		radVärden[tempRad] = temp;
		
		for(int x=0; x<8; x++){
			System.out.print(radVärden[x] + ", ");
		}
		
		//vilken rad är motståndaren på väg att vinna i?
		
		if(symbol == 1){
			int minIndex = 0;
			for (int i = 0; i < radVärden.length; i++){
				int newnumber = radVärden[i];
				if ((newnumber < radVärden[minIndex])){
					minIndex = i;
				}
			}
			return minIndex;
		}
		else if(symbol == -1){
			int maxIndex = 0;
			for (int i = 0; i < radVärden.length; i++){
				int newnumber = radVärden[i];
				if ((newnumber > radVärden[maxIndex])){
					maxIndex = i;
				}
			}
			return maxIndex;
		}
		else{
			return -1;
		}
	}
	
	
	private void ritauthela(){
		for(int i=0;i<3;i++){
			for(int j=0;j<3;j++){
				System.out.print(brickor[i][j].getValue() + "  ");
			}
			System.out.println();
			
		}
		System.out.println();
	}
	
	
	public static void main(String[] args){
		
		new TicTac();
		
	}

}

