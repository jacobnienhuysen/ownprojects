import java.awt.*;
import java.awt.event.*;
import java.io.*;
import javax.swing.*;
import javax.swing.filechooser.FileNameExtensionFilter;
import java.util.*;

import static javax.swing.JOptionPane.*;


//Huvudklassen
public class Bartender extends JFrame{

	//GUI - komponenter
	JLabel regAntalLabel;
	JMenu liMenu, drMenu, qzMenu, opMenu;
	JMenuItem newDr, newLi, saveLi, loadLi, viewLi, remLi, remDr, viewDr, qzAll, qzSome, omBT, avSlut, testDR;
	JFileChooser saveListChooser, chooseList;
	Bakgrund centerPic;
	
	//Listor
	public ArrayList<String> drinkList = new ArrayList<String>();
	public ArrayList<Ingrediens> ingrList = new ArrayList<Ingrediens>();
	
	//Viktiga variabler
	String currentListName = null;
	String listPath = null;
	boolean listIsOpen = false;
	
	String currentDrinkName = null;
	
	int drinkCount = 0;
	
	
	//Övriga komponenter
	DrinkSpec ds;
	File newFolder = null;
	File saveFile = null;
	
	
	// HUVUDFÖNSTRET BÖRJAR HÄR
	
	public Bartender(){
		super("Bartender Register");
		
		//Kod för utseendehantering
		String look = UIManager.getSystemLookAndFeelClassName();
		try{
			UIManager.setLookAndFeel(look);
			SwingUtilities.updateComponentTreeUI(this);
		}catch(Exception ex){}
		
		//Filväljaren, för att spara listan
		saveListChooser = new JFileChooser(".");
		FileNameExtensionFilter sFilter = new FileNameExtensionFilter("Drinklistor","txt");
		saveListChooser.addChoosableFileFilter(sFilter);
		//saveListChooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
		
		//Filväljaren, för att välja en drinklista
		chooseList = new JFileChooser(".");
		FileNameExtensionFilter filter = new FileNameExtensionFilter("Drinklistor","txt");
		chooseList.addChoosableFileFilter(filter);
		chooseList.setFileSelectionMode(JFileChooser.FILES_ONLY);
		
		//Menylisten
		JMenuBar menuBar = new JMenuBar();
		setJMenuBar(menuBar);
		liMenu = new JMenu("Lista");
		menuBar.add(liMenu);
		drMenu = new JMenu("Drink");
		menuBar.add(drMenu);
		drMenu.setEnabled(false);
		qzMenu = new JMenu("Förhör");
		menuBar.add(qzMenu);
		qzMenu.setEnabled(false);
		opMenu = new JMenu("Alternativ");
		menuBar.add(opMenu);
		
		//Lista-menyn
		liMenu.add(newLi = new JMenuItem("Ny"));
		newLi.addActionListener(new NewListLyss());
		
		liMenu.add(loadLi = new JMenuItem("Ladda"));
		loadLi.addActionListener(new LoadListLyss());
		
		liMenu.add(saveLi = new JMenuItem("Spara"));
		saveLi.addActionListener(new SaveListLyss());
		saveLi.setEnabled(false);
		
		liMenu.add(viewLi = new JMenuItem("Visa"));
		viewLi.addActionListener(new ViewListLyss());
		viewLi.setEnabled(false);
		
		//Drink-menyn
		drMenu.add(newDr = new JMenuItem("Lägg till"));
		newDr.addActionListener(new AddDrinkLyss());
		drMenu.add(viewDr = new JMenuItem("Detaljer"));
		viewDr.addActionListener(new ViewDrinkLyss());
		drMenu.add(remDr = new JMenuItem("Ta bort"));
		
		//Förhör-menyn
		qzMenu.add(qzAll = new JMenuItem("Förhör alla"));
		qzAll.addActionListener(new Quiz());
		qzMenu.add(qzSome = new JMenuItem("Egen lista"));
		//qzSome.addActionListener(new CustomQuizLyss());
		
		//Alternativ-menyn
		opMenu.add(omBT = new JMenuItem("Om"));
		omBT.addActionListener(new OmLyss());
		opMenu.add(avSlut = new JMenuItem("Avsluta"));
		avSlut.addActionListener(new AvsLyss());
		
		//Bakgrundsbilden
		centerPic = new Bakgrund();
		add(centerPic, BorderLayout.CENTER);
		centerPic.setLayout(null);
		
		//Statusfältet
		JPanel soder = new JPanel();
		soder.add(regAntalLabel = new JLabel("Ingen lista öppen."));
		add(soder, BorderLayout.SOUTH);
		
		//Fönsterinställningar
		setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);
		addWindowListener(new WinLyss());
		setSize(600,550); //inställd för att matcha bakgrundsbildens proportioner
		setResizable(false);
		setVisible(true);
		setLocationRelativeTo(null);
	
	}
	
	//SLUT, HUVUDFÖNSTRET
	//===================================================================
	//===================================================================
	
	
	// LYSSNARKLASSER
	
	
	// LISTA-MENYN, LYSSNARE
	
	//Ny lista
	public class NewListLyss implements ActionListener{
		public void actionPerformed(ActionEvent eve){
			if(!listIsOpen){	//Om ingen lista är öppen
				createNewDrinkList();
			}else{	//Om en lista är öppen
				if(showConfirmDialog(Bartender.this,"Vill du spara listan '" + currentListName + "' innan du öppnar en ny?","Fråga",YES_NO_OPTION)==YES_OPTION){
					return;
				}else{
					createNewDrinkList();
				}
			}	
		}
	}
	
	public class SaveListLyss implements ActionListener{
		public void actionPerformed(ActionEvent eve){
			saveDrinkList();
		}
	}
	
	//Ladda lista
	public class LoadListLyss implements ActionListener{
		public void actionPerformed(ActionEvent eve){
			if(!listIsOpen){
				if(!drinkList.isEmpty()){
					drinkList.clear();
				}
				
				int newList=chooseList.showOpenDialog(Bartender.this);
				if(newList!=JFileChooser.APPROVE_OPTION)
					return;
				
				File f = chooseList.getSelectedFile();
				loadCheck(f.getAbsolutePath());
			}
			else{
				if(showConfirmDialog(Bartender.this,"Vill du spara '" + currentListName + "' innan du laddar en ny?","Fråga",YES_NO_OPTION)!=YES_OPTION){
					int newList=chooseList.showOpenDialog(Bartender.this);
					if(newList!=JFileChooser.APPROVE_OPTION)
						return;
					
					File f = chooseList.getSelectedFile();
					loadCheck(f.getAbsolutePath());
				}
				else{
					saveDrinkList();
					int newList=chooseList.showOpenDialog(Bartender.this);
					if(newList!=JFileChooser.APPROVE_OPTION)
						return;
					
					File f = chooseList.getSelectedFile();
					loadCheck(f.getAbsolutePath());
				}
			}
		}
	}
	
	//Visa lista
	public class ViewListLyss implements ActionListener{
		public void actionPerformed(ActionEvent eve){
			if(drinkList.isEmpty()){
				showError("Det finns inga drinkar i den aktuella listan.");
				return;
			}
			else{
				ListWindow listWin = new ListWindow(drinkList, currentListName);
				centerPic.add(listWin);
			}
		}
	}
	
	
	
	//DRINK-LISTAN, LYSSNARE
	
	//Lägg till drink
	public class AddDrinkLyss implements ActionListener{
		public void actionPerformed(ActionEvent eve){
			NyDrinkForm ndf = new NyDrinkForm();
			if(showConfirmDialog(Bartender.this,ndf, "Ny drink",OK_CANCEL_OPTION)==OK_OPTION){
				addDrink(ndf.getNamn(),ndf.getRedn(),ndf.getGlas(),ndf.getGarn());
			}
			else{
				return;
			}
		}
	}
	
	
	//Visa drink (detaljer)
	public class ViewDrinkLyss implements ActionListener{
		public void actionPerformed(ActionEvent eve){
			VäljDrinkForm vdf = new VäljDrinkForm(drinkList);
			if(showConfirmDialog(Bartender.this,vdf,"Välj drink",OK_CANCEL_OPTION)==OK_OPTION){
				currentDrinkName = vdf.getVald();
				getDrinkDetails(currentDrinkName);
				
			}else{
				return;
			}
		}
	}
	
	// QUIZ-MENYN, LYSSNARE
	
	//Quiz
	public class Quiz implements ActionListener{
		public void actionPerformed(ActionEvent eve){
			if(drinkList.isEmpty()){
				showInfo("Det finns inga drinkar att förhöra.");
				return;
			}
			
			QuizWindow qw = new QuizWindow(currentListName, drinkList);
			centerPic.add(qw);
		}
	}
	
	// OM-MENYN, LYSSNARE
	
	public class AvsLyss implements ActionListener{
		public void actionPerformed(ActionEvent eve){
			int qSvar = showConfirmDialog(Bartender.this,"Vill du verkligen avsluta?","Fråga",YES_NO_OPTION);
			if (qSvar==YES_OPTION)
				System.exit(0);
		}
	}
	
	public class OmLyss implements ActionListener{
		public void actionPerformed(ActionEvent eve){
			showMessageDialog(Bartender.this,"Bartender Register 1.0\n© Copyright 2013 Jacob Nienhuysen\nAll rights reserved.","Om",INFORMATION_MESSAGE);
		}
	}
	
	public class WinLyss extends WindowAdapter{
		public void windowClosing(WindowEvent eve){
			int qSvar = showConfirmDialog(Bartender.this,"Vill du verkligen avsluta?","Fråga",YES_NO_OPTION);
			if (qSvar==YES_OPTION)
				System.exit(0);
		}
	}
	
	
	
	//SLUT, LYSSNARKLASSER
	//===================================================================
	//===================================================================
	
	
	
	//VOIDER
	
	//Skapa ny drinklista
	public void createNewDrinkList(){
		String chosenName = "";
		NyListaForm nlf = new NyListaForm();
		drinkList.clear();
		
		for(;;){
			if(showConfirmDialog(Bartender.this,nlf,"Ny lista",OK_CANCEL_OPTION)==OK_OPTION){	//Om man skapar ny lista
				chosenName = nlf.getNewListName();
		
				if(chosenName.equals("") || !chosenName.matches("[a-zA-Z]+")){	//Om inmatat namn är ogiltigt
					showError("Namnet är ogiligt.");
				}
				else{	//Om namnet är giltigt
					break;
				}
				
			}
			else{		//Om man inte vill skapa ny lista
				return;
			}
		}
		
		currentListName = chosenName;
		drinkList.clear();
		Bartender.this.setTitle("Bartender Register - " + currentListName);
		regAntalLabel.setText(currentListName + " - " + drinkList.size() + " drinkar.");
		drMenu.setEnabled(true);
		saveLi.setEnabled(true);
		viewLi.setEnabled(true);
		qzMenu.setEnabled(true);
		listIsOpen = true;
		showMessageDialog(Bartender.this,"Klart!\nDrinklistan '" + currentListName + "' har skapats.\nNu kan du lägga till drinkar.","Klar",INFORMATION_MESSAGE);
	}
	
	//Spara drinklista, inte tidigare sparad
	public void saveDrinkList(){
		saveFile = new File(currentListName);
		saveListChooser.setSelectedFile(saveFile);
		
		for(;;){
			int saveList=saveListChooser.showSaveDialog(Bartender.this);
			if(saveList!=JFileChooser.APPROVE_OPTION){
				return;
			}
			
			newFolder = saveListChooser.getSelectedFile();
			
			if(!saveFile.exists() && !newFolder.exists()){
				newFolder.mkdir();
				
				try{
					Writer fileWriter = new OutputStreamWriter(new FileOutputStream(currentListName + ".txt"), "ISO-8859-1");
					BufferedWriter bWr = new BufferedWriter(fileWriter);
					bWr.write("<drinklist_start>\r\n");
					bWr.write("<name>" + currentListName);
					bWr.write("<count>" + drinkList.size() + "\r\n");
					bWr.write("<drinklist_stop>");
					bWr.close();				
									
					Bartender.this.setTitle("Bartender Register - " + currentListName);
					regAntalLabel.setText(currentListName + " - " + drinkList.size() + " drinkar.");
					
					}catch(FileNotFoundException e){
						showError("Drinklistan kunde inte hittas. " + e.getMessage());
					}catch(IOException e){
						showError("Drinklistan kunde inte skapas. " + e.getMessage());
					}
				return;
			}
			else{
				//om någon av filerna redan finns. Utveckla här!
				return;
			}
		}
	}
	
	
	//Kontrollerar att listfilen är giltig före inladdning
	public void loadCheck(String lPath){
		try{
			Reader fir = new InputStreamReader(new FileInputStream(lPath), "ISO-8859-1");
			BufferedReader buff = new BufferedReader(fir);
			String rad;
			String[] chString = new String[3];
			
			rad = buff.readLine();
				
			for(int s = 0;s<3;s++){
				chString[s] = rad;
				rad = buff.readLine();
			}
			
			buff.close();
			
			if(chString[0].equals("<drinklist_start>") && chString[1].substring(0,6).equals("<name>") && chString[2].substring(0,7).equals("<count>")){
				listPath = lPath;
				loadDrinkList();
			}
			else{
				showError("Ogiltig listfil!");
			}
			
			}catch(FileNotFoundException e){
				showError("Drinklistan kunde inte hittas.\n" + e);
			}catch(IllegalArgumentException e){
				showError("Korrupt eller ogiltig drinklista.\n" + e);
			//}catch(NullPointerException e){
				//showError("Drinklistan kunde inte öppnas1.\n" + e);
			}catch(IOException e){
				showError("Drinklistan kunde inte öppnas.\n" + e);
			}
	}
	
	
	//Ladda drinklista
	public void loadDrinkList(){
		try{
			Reader fir = new InputStreamReader(new FileInputStream(listPath), "ISO-8859-1");
			BufferedReader buff = new BufferedReader(fir);
			String rad;
			
			rad = buff.readLine();
			if(!rad.equals("<drinklist_start>")){
				buff.close();
				throw new IllegalArgumentException();
			}
			else{
				drinkList.clear();
				rad = buff.readLine();
				
				while(rad!=null){
					
					if(rad.substring(0,6).equals("<name>")){
						currentListName = rad.substring(6,rad.length());
					}
					else if(rad.substring(0,7).equals("<count>")){
						drinkCount = Integer.parseInt(rad.substring(7,rad.length()));
					}
					else if(rad.substring(0,3).equals("<d>")){
						rad = rad.substring(3,rad.length());
						drinkList.add(rad);
					}	
					else if(rad.equals("<drinklist_stop>")){
						Bartender.this.setTitle("Bartender Register - " + currentListName);
						regAntalLabel.setText(currentListName + " - " + drinkList.size() + " drinkar.");
						listIsOpen = true;
						showMessageDialog(Bartender.this,"Klart!\nDrinklistan har laddats.","Klar",INFORMATION_MESSAGE);
						buff.close();
						break;
					}
					
					rad = buff.readLine();
				}
			}
			
			}catch(FileNotFoundException e){
				showError("Drinklistan kunde inte hittas.\n" + e);
			}catch(IllegalArgumentException e){
				showError("Korrupt eller ogiltig drinklista.\n" + e);
			}catch(NullPointerException e){
				showError("Drinklistan kunde inte öppnas.\n" + e);
			}catch(IOException e){
				showError("Drinklistan kunde inte öppnas.\n" + e);
			}
		
		drMenu.setEnabled(true);
		viewLi.setEnabled(true);
		qzMenu.setEnabled(true);
	}
	
	
	//Lägg till drink
	
	public void addDrink(String drNamn, String drRedn, String drGlas, String drGarn){
		
		if(drinkList.contains(drNamn)){
			showError("Drink med det namnet finns redan i listan!");
			return;
		}
		else{
			try{
				Writer fileWriter = new OutputStreamWriter(new FileOutputStream(currentListName + "/" + drNamn + ".txt"), "ISO-8859-1");
				BufferedWriter bWr = new BufferedWriter(fileWriter);
				bWr.write("<drink_start>\r\n");
				bWr.write(drRedn + "\r\n");
				bWr.write(drGlas + "\r\n");
				bWr.write(drGarn + "\r\n");

				bWr.write("<drink_stop>");
				bWr.close();
				
				drinkList.add(drNamn);
				drinkCount = drinkList.size();
				regAntalLabel.setText(currentListName + " - " + drinkList.size() + " drinkar.");

				
				Writer fileWriter2 = new OutputStreamWriter(new FileOutputStream(listPath), "ISO-8859-1");
				BufferedWriter bWr2 = new BufferedWriter(fileWriter2);
				bWr2.write("<drinklist_start>\r\n");
				bWr2.write("<name>" + currentListName + "\r\n");
				bWr2.write("<count>" + drinkCount + "\r\n");
				
				for(String str : drinkList){
					bWr2.write("<d>" + str + "\r\n");
				}

				bWr2.write("<drinklist_stop>");
				bWr2.close();				
				
				
				showMessageDialog(Bartender.this,"Klart!\nDrinken har lagts till.","Klar",INFORMATION_MESSAGE);	
				
				getDrinkDetails(drNamn);
				
				
			}catch(FileNotFoundException e){
				showError("Kan inte öppna filen.1 " + e.getMessage());
			}catch(IOException e){
				showError("Kan inte öppna filen.2 " + e.getMessage());
			}	
		}
	}
	
	
	//Läs in drink
	public void getDrinkDetails(String drinkNamn){
		DrinkWindow drinkDet = new DrinkWindow(currentListName, drinkNamn);
		centerPic.add(drinkDet);
	}
	
	//SLUT, VOIDER
	//===================================================================
	//===================================================================	

	
	
	
	//TESTKLASSER - TA BORT DESSA FÖRE RELEASE, ÄVEN EV. BORTKOMMENTERADE ANTECKNINGAR LÄNGST NER!!
	
	public ArrayList<String> getDrinkReg(){
		return drinkList;
	}
	
	//SLUT, TESTKLASSER
	//===================================================================
	//===================================================================	
	
	
	//STANDARDINGREDIENSER
	
	public String[] Standard(int choice){
		final String[] sprit = {"Vodka", "Rom, ljus", "Rom, mörk", "Gin", "Tequila"};
		final String[] likor = {"Advokaat", "Bananlikör", "Cointreau", "Likör 43", "Blå curacau", "Xanté"};
		final String[] garnish = {"Oliv", "Citron", "Lime", "Apelsinskal"};
		final String[] topp = {"Coca-cola", "Sprite", "Sodavatten", "Apelsinjuice", "Ananasjuice", "Tranbärsjuice", "Tomatjuice"};
		final String[] special = {"Grenadin", "Angostura Bitter", "Tabasco", "Worcestershiresås"};
		
		switch(choice){
		case 0:
			return sprit;
		case 1:
			return likor;
		case 2:
			return garnish;
		case 3:
			return topp;
		case 4:
			return special;
		default:
			return null;
		}
	}
	
	//INFOMEDDELANDEKLASS
	
	public void showInfo(String i){
		showMessageDialog(Bartender.this,i,"Meddelande",INFORMATION_MESSAGE);
	}
	
	//SLUT, FELMEDDELANDEKLASS
	//===================================================================
	//===================================================================	
	
	
	//FELMEDDELANDEKLASS
	
	public void showError(String e){
		showMessageDialog(Bartender.this,e,"Fel",ERROR_MESSAGE);
	}
	
	//SLUT, FELMEDDELANDEKLASS
	//===================================================================
	//===================================================================	
	
	
	
	//STATIC-METODEN
	
	public static void main(String[] args){
		new Bartender();
	}
	
	//SLUT, STATIC-METODEN
}

// SLUT, BARTENDER HUVUDKLASS, ALLT NEDANFÖR DENNA RAD SKA TAS BORT.


/*
 * 
 * 
 * 
 * 
 try{
	Writer fileWriter2 = new OutputStreamWriter(new FileOutputStream("drinklist.txt"), "ISO-8859-1");
	BufferedWriter bWr2 = new BufferedWriter(fileWriter2);
	bWr2.write("<drinklist_start>\r\n");
	bWr2.write("<count>" + antalDrinkar + "\r\n");
			
	bWr2.write("<drinklist_stop>");
	bWr2.close();				
				
	showMessageDialog(TestaIf.this,"Klart!\nDrinken har lagts till.","Klar",INFORMATION_MESSAGE);	
				
	}catch(FileNotFoundException e){
		showError("Drinklistan kunde inte skapas. " + e.getMessage());
	}catch(IOException e){
		showError("Drinklistan kunde inte skapas. " + e.getMessage());
	}	


//Klass för förhörsalternativ

public class CustomizeQuiz extends JPanel{
	JList lista = new JList(drinkReg.toArray());
	JCheckBox dNamn, dIngr, dRedn, dGlas;
	public CustomizeQuiz(){
		setLayout(new GridLayout(1,2));
		
		JPanel left = new JPanel();
		left.setLayout(new BoxLayout(left, BoxLayout.Y_AXIS));
		left.setBorder (BorderFactory.createTitledBorder("Välj drinkar: "));
		left.add(new JScrollPane(lista));
		lista.setLayoutOrientation(JList.VERTICAL);
		lista.setSelectionMode(ListSelectionModel.MULTIPLE_INTERVAL_SELECTION);
		lista.setVisibleRowCount(8);
		lista.setFixedCellWidth(150);
		add(left);
		
		JPanel right = new JPanel();
		right.setBorder (BorderFactory.createTitledBorder("Förhör: "));
		right.setLayout(new BoxLayout(right, BoxLayout.Y_AXIS));
		right.add(dNamn = new JCheckBox("Namn"));
		right.add(dIngr = new JCheckBox("Ingredienser"));
		right.add(dRedn = new JCheckBox("Tillredning"));
		right.add(dGlas = new JCheckBox("Glastyper"));
		add(right);
	}
	
	public int[] getValdaDrinkar(){
		return lista.getSelectedIndices();
	}
}

//Slut, klass för förhörsalternativ

*/
