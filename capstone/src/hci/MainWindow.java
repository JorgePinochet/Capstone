/**
 * Feb 24, 2010
 * MainWindow.java
 */
package hci;

import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.KeyEvent;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;

import javax.swing.JCheckBoxMenuItem;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.JRadioButtonMenuItem;
import javax.swing.JTabbedPane;
import javax.swing.KeyStroke;
import javax.swing.SwingConstants;

/**
 * @author
 * @version 1.0
 */
public class MainWindow extends JFrame implements WindowListener {
	private static final long serialVersionUID = 1992038575171222474L;	
	
	private 	Container			mainPane;
	private 	AccountingWindow 	aw = new AccountingWindow();
	private		ClientWindow 		cw = new ClientWindow();
	private		OrganizationWindow 	ow = new OrganizationWindow();

	/**
	 * Creates the main program window
	 */
	public void createMainWindow() {
		this.setBounds(100, 100, 800, 650);
		this.setTitle("Indus Recreational Facility");
		
		mainPane = this.getContentPane();
		mainPane.setLayout(new BorderLayout(5,5));
		
		JMenuBar menuBar;
		JMenu menu;
		JMenuItem menuItem;

		//Create the menu bar.
		menuBar = new JMenuBar();
		
		//The File menu
		menu = new JMenu("File");
		menu.setMnemonic(KeyEvent.VK_F);
		menuBar.add(menu);
		
		menuItem = new JMenuItem("Exit", KeyEvent.VK_E);
		menuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_E, ActionEvent.ALT_MASK));
		menu.add(menuItem);
		
		//The help menu
		menu = new JMenu("Help");
		menu.setMnemonic(KeyEvent.VK_H);
		menuBar.add(menu);
		
		menuItem = new JMenuItem("Search", KeyEvent.VK_S);
		menuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_S, ActionEvent.ALT_MASK));
		menu.add(menuItem);
		
		menuItem = new JMenuItem("Index", KeyEvent.VK_I);
		menuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_I, ActionEvent.ALT_MASK));
		menu.add(menuItem);
		
		menuItem = new JMenuItem("Contents", KeyEvent.VK_C);
		menuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_C, ActionEvent.ALT_MASK));
		menu.add(menuItem);
		
		this.setJMenuBar(menuBar);
		
		JTabbedPane tabbedPane = new JTabbedPane();
		tabbedPane.addTab("Main", this.createMainPanel());
		tabbedPane.addTab("Accounting", aw);
		tabbedPane.addTab("Clients", cw);
		tabbedPane.addTab("Organization", ow);
		mainPane.add(tabbedPane);

		this.addWindowListener(this);
		this.setVisible(true);
	}
	
	/**
	 * Method that generates the main panel for the main screen
	 * @return a JPanel containing the main screen components
	 */
	private JPanel createMainPanel() {
		JPanel mainPanel = new JPanel();
		
		JLabel mainLabel = new JLabel("Indus Recreactional Facility",SwingConstants.CENTER);
		mainLabel.setFont(new Font("Calibri",Font.BOLD,28));
		mainPanel.add(mainLabel);
		
		return mainPanel;
	}

	/* (non-Javadoc)
	 * @see java.awt.event.WindowListener#windowActivated(java.awt.event.WindowEvent)
	 */
	@Override
	public void windowActivated(WindowEvent e) {
	}

	/* (non-Javadoc)
	 * @see java.awt.event.WindowListener#windowClosed(java.awt.event.WindowEvent)
	 */
	@Override
	public void windowClosed(WindowEvent e) {
	}

	/* (non-Javadoc)
	 * @see java.awt.event.WindowListener#windowClosing(java.awt.event.WindowEvent)
	 */
	@Override
	public void windowClosing(WindowEvent e) {
		cw.close();
		System.exit(0);
	}

	/* (non-Javadoc)
	 * @see java.awt.event.WindowListener#windowDeactivated(java.awt.event.WindowEvent)
	 */
	@Override
	public void windowDeactivated(WindowEvent e) {
	}

	/* (non-Javadoc)
	 * @see java.awt.event.WindowListener#windowDeiconified(java.awt.event.WindowEvent)
	 */
	@Override
	public void windowDeiconified(WindowEvent e) {
	}

	/* (non-Javadoc)
	 * @see java.awt.event.WindowListener#windowIconified(java.awt.event.WindowEvent)
	 */
	@Override
	public void windowIconified(WindowEvent e) {
	}

	/* (non-Javadoc)
	 * @see java.awt.event.WindowListener#windowOpened(java.awt.event.WindowEvent)
	 */
	@Override
	public void windowOpened(WindowEvent e) {
	}

}
