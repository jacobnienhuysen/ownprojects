import static javax.swing.JOptionPane.*;

import java.awt.*;
import java.awt.event.*;
import java.util.ArrayList;
import java.io.*;

import javax.swing.*;
import javax.swing.event.*;
import javax.swing.border.*;

public class QuizWindow extends JInternalFrame{
	
	private String totAnt, antQuiz, antRatt, antProc, listNamn;
	private ArrayList<Ingrediens> ingrLista;
	private ArrayList<String> quizLista;
	JButton closeBtn, startQz, startAlt, chgFact;
	JList quizList;
	JLabel ad, adlb, fd, fdlb, ar, arlb, arb, arblb, namn;
	
	public QuizWindow(String listNamn, ArrayList<String> drinkar){
		super("F�rh�r", false, true, false, false);
		
		this.listNamn = listNamn;
		totAnt = drinkar.size() + "";
		antQuiz = "-";
		antRatt = "-";
		antProc = "-";
		
		
		setLayout(new BoxLayout(getContentPane(), BoxLayout.Y_AXIS));
		
		
		JPanel top = new JPanel();
			top.add(namn = new JLabel("F�rh�r"));
			namn.setFont(new Font("Dialog", Font.BOLD, 20));
		add(top);
		
		JPanel mid = new JPanel();
		mid.setLayout(new GridLayout(1,3));
		
			JPanel left = new JPanel();
			left.setBorder(new TitledBorder("Statistik"));
			left.setLayout(new BoxLayout(left, BoxLayout.Y_AXIS));
			
				JPanel rad1 = new JPanel();
				rad1.add(ad = new JLabel("Totalt antal drinkar:"));
				rad1.add(adlb = new JLabel(totAnt));
				left.add(rad1);
			
				JPanel rad2 = new JPanel();
				rad2.add(fd = new JLabel("F�rh�rda drinkar:"));
				rad2.add(fdlb = new JLabel(antQuiz));
				left.add(rad2);
			
				JPanel rad3 = new JPanel();
				rad3.add(ar = new JLabel("Antal r�tt:"));
				rad3.add(arlb = new JLabel(antRatt));
				left.add(rad3);
				
				JPanel rad4 = new JPanel();
				rad4.add(arb = new JLabel("Andel r�tt:"));
				rad4.add(arblb = new JLabel(antProc));
				left.add(rad4);
				
				adlb.setFont(new Font("Dialog", Font.BOLD, 12));
				fdlb.setFont(new Font("Dialog", Font.BOLD, 12));
				arlb.setFont(new Font("Dialog", Font.BOLD, 12));
				arblb.setFont(new Font("Dialog", Font.BOLD, 12));
				
				/*
				JPanel leftBtn = new JPanel();
					leftBtn.add(chgFact = new JButton("�ndra"));
				left.add(leftBtn);
				*/
				
			mid.add(left);
			
			JPanel right = new JPanel();
			right.setBorder(new TitledBorder("V�lj drinkar"));
			right.setLayout(new BoxLayout(right, BoxLayout.Y_AXIS));
			
				quizList = new JList(drinkar.toArray());
				right.add(new JScrollPane(quizList));
				quizList.setLayoutOrientation(JList.VERTICAL);
				quizList.setSelectionMode(ListSelectionModel.MULTIPLE_INTERVAL_SELECTION);
				quizList.setVisibleRowCount(6);
				quizList.setFixedCellWidth(150);
				
				JPanel rightBtn = new JPanel();
				rightBtn.add(startQz = new JButton("F�rh�r alla"));
				rightBtn.add(startAlt = new JButton("F�rh�r valda"));
				right.add(rightBtn);
			mid.add(right);
		add(mid);
		
		JPanel bot = new JPanel();
			bot.add(closeBtn = new JButton("St�ng"));
			closeBtn.addActionListener(new CloseLyss());
		add(bot);
		
		
		this.pack();
		this.setLocation(10,10);
		this.moveToFront();
		this.setVisible(true);
	}
	
	public class CloseLyss implements ActionListener{
		public void actionPerformed(ActionEvent ev){
			
			int[] gr = quizList.getSelectedIndices();
			
			for(int i=0; i<gr.length; i++)
			System.out.println(gr[i]);
			
			
			QuizWindow.this.dispose();
		}
	}
	
	/*
	public void getDrinkDetails(){
		double clToAdd = 0;
		
		try{
			Reader fir = new InputStreamReader(new FileInputStream(drPath), "ISO-8859-1");
			BufferedReader buff = new BufferedReader(fir);
			
			String rad = buff.readLine();
			
			if(!rad.equals("<drink_start>")){
				buff.close();
				throw new IllegalArgumentException("Felaktig drinkfil.");
			}else{
				
				rad = buff.readLine();
				
				while(rad!=null){
					
					
				}
				
				buff.close();
			}
			
			}catch(FileNotFoundException e){
				System.err.println("Filen fanns inte.");
			}catch(IllegalArgumentException e){
				System.err.println(e);
			}catch(IOException e){
				System.exit(0);
			}
		
	}
	*/
	
	
	public void showError(String e){
		showMessageDialog(QuizWindow.this,e,"Fel",ERROR_MESSAGE);
	}
		
}