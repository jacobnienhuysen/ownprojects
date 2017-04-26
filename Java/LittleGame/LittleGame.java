import java.awt.*;
import java.awt.event.*;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.Writer;

import javax.swing.*;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Random;
import static javax.swing.JOptionPane.*;

public class LittleGame extends JFrame{
	
	ArrayList<Score> highScore = new ArrayList<Score>();
	JMenuItem newG, highS, exitG, helpG, aboutG;
	Bakground standardBack;
	String playerChar;
	int charX, charY;
	int iconX, iconY;
	PlayerIcon pie;
	CollectIcon cic;
	JLabel pointWin;
	JLabel timerWin;
	int points = 0;
	int time = 0;
	Timer timer = new Timer(1000, new TimeLyss());
	Timer iconTimer = new Timer(2500, new IconTimeLyss());
	
	JButton testare;
	
	public LittleGame(){
		super("Little Game 2.5.1");
		
		JMenuBar menuBar = new JMenuBar();
		setJMenuBar(menuBar);
		JMenu fileM = new JMenu("Arkiv");
			fileM.add(newG = new JMenuItem("Nytt spel"));
			newG.addActionListener(new NewLyss());
			fileM.add(highS = new JMenuItem("Highscore"));
			highS.addActionListener(new HighScoreLyss());
			fileM.add(exitG = new JMenuItem("Avsluta"));
			exitG.addActionListener(new QuitLyss());
			menuBar.add(fileM);
		
		JMenu helpM = new JMenu("Hjälp");
			helpM.add(helpG = new JMenuItem("Instruktioner"));
			helpG.addActionListener(new HelpLyss());
			helpM.add(aboutG = new JMenuItem("Om LittleGame"));
			aboutG.addActionListener(new OmLyss());
		menuBar.add(helpM);
		
		
		standardBack = new Bakground("background.PNG");
		add(standardBack, BorderLayout.CENTER);
		
		standardBack.add(pointWin = new JLabel("Poäng: " + points));
		pointWin.setBounds(5,3,120,25);
		pointWin.setFont(new Font("Dialog", Font.BOLD, 20));
		
		standardBack.add(timerWin = new JLabel(""));
		timerWin.setBounds(440,65,120,25);
		timerWin.setFont(new Font("Dialog", Font.BOLD, 20));
		
		/*
		JPanel nere = new JPanel();
		nere.add(testare = new JButton("Test"));
		testare.addActionListener(new TestLyss());
		add(nere, BorderLayout.SOUTH);
		*/
	
		setSize(640,480);
		setDefaultCloseOperation(EXIT_ON_CLOSE);
		setResizable(false);
		setVisible(true);
		setLocationRelativeTo(null);
	}
	
	public class NewLyss implements ActionListener{
		public void actionPerformed(ActionEvent eve){
			NewPlayer np = new NewPlayer();
			if(showConfirmDialog(LittleGame.this,np,"Ny spelare",OK_CANCEL_OPTION)!=OK_OPTION){
				return;
			}
			else{
				playerChar = np.getPlayerChar();
				charX = np.getCharX();
				charY = np.getCharY();
				startNewGame();
				iconRandomizer();
			}
		}
	}
	
	public class PlayerCtrlLyss extends KeyAdapter{
		@Override
		public void keyPressed(KeyEvent ke){
			if(ke.getKeyCode() == KeyEvent.VK_DOWN){
				pie.movePlayer(1);
			}
			else if(ke.getKeyCode() == KeyEvent.VK_LEFT){
				pie.movePlayer(2);
			}
			else if(ke.getKeyCode() == KeyEvent.VK_RIGHT){
				pie.movePlayer(3);
			}
			else if(ke.getKeyCode() == KeyEvent.VK_UP){
				pie.movePlayer(4);
			}
		}
	}
	
	public class PlayerLyss extends ComponentAdapter{
		@Override
		public void componentMoved(ComponentEvent eve){
			if((pie.getLocation().getX()+120) < iconX+37 && (pie.getLocation().getX()+120) > iconX-5 && (pie.getLocation().getY()+100) < iconY+37 && (pie.getLocation().getY()+100) > iconY-5){
				if(cic instanceof DemonIcon){
					if(points>0)
						points = 0;
				}
				else if(cic instanceof FruitIcon){
					points+=5;
				}
				else if(cic instanceof BadIcon){
					points-=3;
				}
				else if(cic instanceof FlowerIcon){
					points++;
				}
				else if(cic instanceof ClockIcon){
					if(time>=50){
						time=59;
					}else{
						time+=10;
					}
					timerWin.setText("Tid kvar: " + time);
				}
				
				pointWin.setText("Poäng: " + points);
				standardBack.remove(cic);
				iconRandomizer();
			}
		}
	}

	public class TimeLyss implements ActionListener{
		public void actionPerformed(ActionEvent eve){
			if(time==0){
				timer.stop();
				LittleGame.this.removeKeyListener(new PlayerCtrlLyss());
				pie.removeComponentListener(new PlayerLyss());
				standardBack.remove(pie);
				standardBack.remove(cic);
				iconTimer.stop();
				repaint();
				newG.addActionListener(new NewLyss());
				EndGame eg = new EndGame(points);
				
				if(showConfirmDialog(LittleGame.this,eg,"Spelet slut",OK_CANCEL_OPTION)!=OK_OPTION){
					return;
				}
				else{
					Score ps = new Score(eg.getPlayerName(),points);
					highScore.add(ps);
					saveHighScore();
				}
			}
			else{
				timerWin.setText("Tid kvar: " + --time);
			}
		}
	}
	
	public class IconTimeLyss implements ActionListener{
		public void actionPerformed(ActionEvent eve){
			standardBack.remove(cic);
			repaint();
			iconRandomizer();
		}
	}
	
	public class HighScoreLyss implements ActionListener{
		public void actionPerformed(ActionEvent eve){
			getHighScore();
			//exempelpoäng
			int place = 1;
			HighScoreList hsl = new HighScoreList();
			if(highScore.isEmpty()){
				hsl.HSDisplay.setText("Highscorelistan är tom =(\n");
			}else{
				hsl.HSDisplay.setText("");
				Collections.sort(highScore, new sortHighScore());
				for(Score scr : highScore){
					if(place>10){
						break;
					}
					hsl.HSDisplay.append(place++ + ". " + scr.toString() +"\n");
				}
			}
			showMessageDialog(LittleGame.this,hsl,"Highscore",INFORMATION_MESSAGE);
		}
	}
	
	public class HelpLyss implements ActionListener{
		public void actionPerformed(ActionEvent eve){
			HelpWindow hp = new HelpWindow();
			try{
				Reader fir = new InputStreamReader(new FileInputStream("help.txt"), "UTF8");
				BufferedReader buff = new BufferedReader(fir);
				String rad = buff.readLine();
				
				while(rad != null){
					hp.field.append(rad + "\n");
				    rad = buff.readLine();
				}
			}catch(NumberFormatException e){
				System.err.print(e);
			}catch(FileNotFoundException e){
				System.err.print(e);
				//System.exit(0);
			}catch(IOException e){
				System.err.print(e);
				//System.exit(0);
			}
			showMessageDialog(LittleGame.this,hp,"Instruktioner",INFORMATION_MESSAGE);
		}
	}
	
	public class OmLyss implements ActionListener{
		public void actionPerformed(ActionEvent eve){
			showMessageDialog(LittleGame.this,"LittleGame 2.5.1\n© Copyright 2013 Jacob Nienhuysen\nAll rights reserved.","Om",INFORMATION_MESSAGE);
		}
	}
	
	public class QuitLyss implements ActionListener{
		public void actionPerformed(ActionEvent eve){
			System.exit(0);
		}
	}
	
	public void startNewGame(){
		newG.removeActionListener(new NewLyss());
		time = 45;
		points = 0;
		pie = new PlayerIcon(playerChar,charX,charY);
		standardBack.add(pie);
		LittleGame.this.addKeyListener(new PlayerCtrlLyss());
		pie.addComponentListener(new PlayerLyss());
		timerWin.setText("Tid kvar: " + time);
		timer.start();
		validate();
		repaint();
		
	}
	
	public void iconRandomizer(){
		iconTimer.stop();
		//koordinatslumpare
		Random iX = new Random();
		Random iY = new Random();
		
		int XLow = 170;
		int XHigh = 610;
		iconX = iX.nextInt(XHigh-XLow) + XLow;
		
		int YLow = 280;
		int YHigh= 410;
		iconY = iY.nextInt(YHigh-YLow) + YLow;
		
		//Ikonslumpare
		int randomType = (new Random()).nextInt(10);
		
		if(randomType==0 || randomType==2 || randomType==4 || randomType==6 || randomType==8){ 
			String[] icons = {"flower1", "flower2", "flower3", "flower4", "flower5", "flower6"};
			int randomIcon = (new Random()).nextInt(icons.length);
			cic = new FlowerIcon(iconX,iconY,icons[randomIcon]);
		}
		else if(randomType==1){
			String[] icons = {"apple", "banana"};
			int randomIcon = (new Random()).nextInt(icons.length);
			cic = new FruitIcon(iconX,iconY,icons[randomIcon]);
		}
		else if(randomType==3){
			String[] icons = {"clock"};
			int randomIcon = (new Random()).nextInt(icons.length);
			cic = new ClockIcon(iconX,iconY,icons[randomIcon]);
		}
		else if(randomType==5 || randomType==7){
			String[] icons = {"bomb", "cannabis"};
			int randomIcon = (new Random()).nextInt(icons.length);
			cic = new BadIcon(iconX,iconY,icons[randomIcon]);
		}
		else if(randomType==9){
			String[] icons = {"demon", "vader"};
			int randomIcon = (new Random()).nextInt(icons.length);
			cic = new DemonIcon(iconX,iconY,icons[randomIcon]);
			
		}
		
		standardBack.add(cic);
		iconTimer.start();
		validate();
		repaint();
	}
	
	public void getHighScore(){
		highScore.clear();
		try{
			Reader fir = new InputStreamReader(new FileInputStream("highscore.txt"), "UTF8");
			BufferedReader buff = new BufferedReader(fir);
			String rad = buff.readLine();
			
			while(rad != null){
				int p = Integer.parseInt(rad.substring(rad.indexOf("<")+1,rad.indexOf(">")));
				String n = rad.substring(rad.indexOf(">")+1);
				
				Score sc = new Score(n,p);
			    highScore.add(sc);
			    rad = buff.readLine();
			}
		}catch(NumberFormatException e){
			System.err.print(e);
		}catch(FileNotFoundException e){
			System.err.print(e);
			//System.exit(0);
		}catch(IOException e){
			System.err.print(e);
			//System.exit(0);
		}
	}
	
	public void saveHighScore(){
		try{
			
			Writer fileWriter = new OutputStreamWriter(new FileOutputStream("highscore.txt"), "UTF8");
			BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
			for(Score s : highScore){
				bufferedWriter.write("<" + s.getPoints()+">" + s.getNamn()+"\n");
			}
			bufferedWriter.close();
				
		}catch(FileNotFoundException e){
			System.err.println("Kan inte öppna filen. " + e.getMessage());
		}catch(IOException e){
			System.exit(0);
		}
		
		
	}
	
	public class sortHighScore implements Comparator<Score>{
		public int compare(Score s1, Score s2){
			return s2.getPoints()-s1.getPoints();
		}
	}
	
	
	public static void main(String[] args){
		new LittleGame();
	}
}
