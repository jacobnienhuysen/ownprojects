import static javax.swing.JOptionPane.*;

import java.awt.*;
import java.awt.event.*;
import java.util.ArrayList;
import java.io.*;

import javax.swing.*;
import javax.swing.event.*;
import javax.swing.border.*;

public class DrinkWindow extends JInternalFrame{
	
	private String drNamn, drRedn, drGlas, drGarn, drPath;
	private ArrayList<Ingrediens> ingrLista = new ArrayList<Ingrediens>();
	JButton closeBtn, chgFact, addIngr, chgIngr, delIngr;
	JList ingrList;
	JLabel rl, gl, ol, rlb, glb, olb, namn;
	
	public DrinkWindow(String listNamn, String drNamn){
		super(drNamn, false, true, false, false);
		
		drPath = listNamn + "/" + drNamn + ".txt";
		getDrinkDetails();
		
		setLayout(new BoxLayout(getContentPane(), BoxLayout.Y_AXIS));
		
		
		JPanel top = new JPanel();
			top.add(namn = new JLabel(drNamn));
			namn.setFont(new Font("Dialog", Font.BOLD, 20));
		add(top);
		
		JPanel mid = new JPanel();
		mid.setLayout(new GridLayout(1,3));
		
			JPanel left = new JPanel(new FlowLayout(FlowLayout.LEFT));
			left.setBorder(new TitledBorder("Fakta"));
			left.setLayout(new BoxLayout(left, BoxLayout.Y_AXIS));
			
				JPanel rad1 = new JPanel();
				rad1.add(rl = new JLabel("Tillredning:"));
				rad1.add(rlb = new JLabel(drRedn));
				left.add(rad1);
			
				JPanel rad2 = new JPanel();
				rad2.add(gl = new JLabel("Glas:"));
				rad2.add(glb = new JLabel(drGlas));
				left.add(rad2);
			
				JPanel rad3 = new JPanel();
				rad3.add(ol = new JLabel("Garnish:"));
				rad3.add(olb = new JLabel(drGarn));
				left.add(rad3);
				
				rl.setFont(new Font("Dialog", Font.BOLD, 12));
				gl.setFont(new Font("Dialog", Font.BOLD, 12));
				ol.setFont(new Font("Dialog", Font.BOLD, 12));
				
				JPanel leftBtn = new JPanel();
					leftBtn.add(chgFact = new JButton("Ändra"));
					chgFact.addActionListener(new chgFactLyss());
				left.add(leftBtn);
				
			mid.add(left);
			
			JPanel right = new JPanel();
			right.setBorder(new TitledBorder("Ingredienser"));
			right.setLayout(new BoxLayout(right, BoxLayout.Y_AXIS));
			
				ingrList = new JList(ingrLista.toArray());
				right.add(new JScrollPane(ingrList));
				ingrList.setLayoutOrientation(JList.VERTICAL);
				ingrList.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
				ingrList.setVisibleRowCount(6);
				ingrList.setFixedCellWidth(150);
				
				ingrList.addListSelectionListener(new listLyss());
				
				JPanel rightBtns = new JPanel();
					rightBtns.add(addIngr = new JButton("Lägg till"));
					addIngr.addActionListener(new addIngrLyss());
					rightBtns.add(chgIngr = new JButton("Ändra"));
					chgIngr.setEnabled(false);
					chgIngr.addActionListener(new chgIngrLyss());
					rightBtns.add(delIngr = new JButton("Ta bort"));
					delIngr.setEnabled(false);
					delIngr.addActionListener(new remIngrLyss());
				
				right.add(rightBtns);
			mid.add(right);
		add(mid);
		
		JPanel bot = new JPanel();
			bot.add(closeBtn = new JButton("OK"));
			closeBtn.addActionListener(new closeLyss());
		add(bot);
		
		
		this.pack();
		this.setLocation(10,10);
		this.moveToFront();
		this.setVisible(true);
	}
	
	public class listLyss implements ListSelectionListener{
		public void valueChanged(ListSelectionEvent ev){
			chgIngr.setEnabled(true);
			delIngr.setEnabled(true);
		}
	}
	
	public class closeLyss implements ActionListener{
		public void actionPerformed(ActionEvent ev){
			saveDrinkDetails();
			DrinkWindow.this.dispose();
		}
	}
	
	public class chgFactLyss implements ActionListener{
		public void actionPerformed(ActionEvent ev){
			ChgFactForm cff = new ChgFactForm(drRedn, drGlas, drGarn);
			if(showConfirmDialog(DrinkWindow.this,cff,drNamn,OK_CANCEL_OPTION)==OK_OPTION){
				drRedn = cff.getRedn();
				drGlas = cff.getGlas();
				drGarn = cff.getGarn();
				rlb.setText(drRedn);
				glb.setText(drGlas);
				olb.setText(drGarn);
				closeBtn.setText("Spara och stäng");
				
			}
			else{
				return;
			}
		}
	}
	
	public class addIngrLyss implements ActionListener{
		public void actionPerformed(ActionEvent ev){
			NyIngrForm nif = new NyIngrForm();
			if(showConfirmDialog(DrinkWindow.this,nif,"Ny ingrediens",OK_CANCEL_OPTION)==OK_OPTION){
				ingrLista.add(new Ingrediens(nif.getIngrName(), nif.getCl()));
				ingrList.setListData(ingrLista.toArray());
				closeBtn.setText("Spara och stäng");
			}
			else
				return;
		}
	}
	
	public class chgIngrLyss implements ActionListener{
		public void actionPerformed(ActionEvent ev){
			int selectedIngr = ingrList.getSelectedIndex();
			ChgIngrForm cif = new ChgIngrForm(ingrLista.get(selectedIngr));
			if(showConfirmDialog(DrinkWindow.this,cif,"Ändra ingrediens",OK_CANCEL_OPTION)==OK_OPTION){
				ingrLista.get(selectedIngr).setNamn(cif.getIngrName());
				try{
					ingrLista.get(selectedIngr).setCl(cif.getCl());
				}catch(NumberFormatException e){
					ingrLista.get(selectedIngr).setCl(-1);
				}
				ingrList.setListData(ingrLista.toArray());
				closeBtn.setText("Spara och stäng");
			}
			else
				return;
		}
	}
	
	public class remIngrLyss implements ActionListener{
		public void actionPerformed(ActionEvent ev){
			int selectedIngr = ingrList.getSelectedIndex();
			if(showConfirmDialog(DrinkWindow.this,"Vill du ta bort '" + ingrLista.get(selectedIngr) + "'?","Ta bort ingrediens",YES_NO_OPTION)==YES_OPTION){
				ingrLista.remove(selectedIngr);
				ingrList.setListData(ingrLista.toArray());
				closeBtn.setText("Spara och stäng");
			}
			else
				return;
		}
	}
	
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
					
					if(rad.substring(0,6).equals("<redn>")){
						drRedn = rad.substring(6,rad.length());
						
					}
					else if(rad.substring(0,6).equals("<glas>")){
						drGlas = rad.substring(6,rad.length());
						
					}
					else if(rad.substring(0,6).equals("<garn>")){
						drGarn = rad.substring(6,rad.length());
						
					}
					else if(rad.substring(0,3).equals("<i>")){
						rad = rad.substring(3,rad.length());
						String[] i = rad.split("&");
						
						if(i[0].length()>0){
							try{
								rad = i[0].substring(0,i[0].length()-2);
								clToAdd = Double.parseDouble(rad);
							}catch(NumberFormatException e){
								clToAdd = -1;
							}
						}
						else
							clToAdd = -1;
						
						ingrLista.add(new Ingrediens(i[1],clToAdd));
					}
					
					rad = buff.readLine();
					
					if(rad.equals("<drink_stop>")){
						buff.close();
						break;
					}
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
	
	public void saveDrinkDetails(){
		try{
			Writer fileWriter = new OutputStreamWriter(new FileOutputStream(drPath), "ISO-8859-1");
			BufferedWriter bWr = new BufferedWriter(fileWriter);
			bWr.write("<drink_start>\r\n");
			bWr.write("<redn>" + drRedn + "\r\n");
			bWr.write("<glas>" + drGlas + "\r\n");
			bWr.write("<garn>" + drGarn + "\r\n");
			
			for(Ingrediens i : ingrLista){
				bWr.write("<i>" + i.toSave() + "\r\n");
			}
			
			bWr.write("<drink_stop>");
			bWr.close();
			
			
		}catch(FileNotFoundException e){
			showError("Kan inte öppna filen.1 " + e.getMessage());
		}catch(IOException e){
			showError("Kan inte öppna filen.2 " + e.getMessage());
		}	
	}
	
	public void showError(String e){
		showMessageDialog(DrinkWindow.this,e,"Fel",ERROR_MESSAGE);
	}
		
}