import java.awt.*;
import java.awt.event.*;

import javax.swing.*;

import java.util.*;


public class ListWindow extends JInternalFrame{
	
	JTextArea display = new JTextArea(10, 20);
	JButton closeBtn;
	
	public ListWindow(ArrayList<String> drinkList, String listName){
		super("Lista: " + listName, false, true, false, false);
		
		setLayout(new BoxLayout(getContentPane(), BoxLayout.Y_AXIS));
		
		JPanel rad1 = new JPanel();
			rad1.add(new JScrollPane(display));
			display.setEditable(false);
		add(rad1);
		
		display.setText("");
		for(String str : drinkList){
			display.append(str + "\n");
		}
		
		JPanel rad2 = new JPanel();
			rad2.add(closeBtn = new JButton("Stäng"));
			closeBtn.addActionListener(new CloseLyss());
		add(rad2);
		
		this.pack();
		this.setLocation(10,10);
		this.moveToFront();
		this.setVisible(true);
	}
	
	public class CloseLyss implements ActionListener{
		public void actionPerformed(ActionEvent ev){
			ListWindow.this.dispose();
		}
	}
}
