/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package FirstPkg;

import DataBasePkg.ConnectedDatabase;
import DataReadpkg.DataOnly;
import java.awt.BorderLayout;
import java.awt.Toolkit;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JFrame;

/**
 *
 * @author Doddc
 */
public class TestJFrame extends JFrame{
    public TestJFrame(){
        DataOnly.ScreenSize.width=Toolkit.getDefaultToolkit().getScreenSize().width;
        DataOnly.ScreenSize.height=Toolkit.getDefaultToolkit().getScreenSize().height;
        DataOnly.ScreenSize.ren=Toolkit.getDefaultToolkit().getScreenInsets(this.getGraphicsConfiguration()).bottom;
        this.setSize(DataOnly.ScreenSize.width*5/6-50, DataOnly.ScreenSize.height-DataOnly.ScreenSize.ren-40);
        DataOnly.mainFrame=this;
        try {
            DataOnly.conData=new ConnectedDatabase();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(TestJFrame.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(TestJFrame.class.getName()).log(Level.SEVERE, null, ex);
        }
        DataOnly.initCDB=true;
        CompanyPanel p=new CompanyPanel();//Panel
        this.add(p,BorderLayout.CENTER);
        this.setLocationRelativeTo(null);
        this.setVisible(true);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }
    public static void main(String[] args) {
        new TestJFrame();
    }
}
