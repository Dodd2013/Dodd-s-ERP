/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Toolspkg;

import DataReadpkg.DataOnly;
import MainPkg.InitAll;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.JOptionPane;

/**
 *
 * @author Administrator
 */
public class ToolsClass {

    public static String getServerDateTime(){   //获取服务器时间
        String ans=null;
        if(!DataOnly.initCDB){
            InitAll.ConnectedtoDataBase();
        }
            try {
                ResultSet res=DataOnly.conData.stmt.executeQuery("select getdate()");
                res.next();
                ans=res.getString(1);
            } catch (SQLException ex) {
                JOptionPane.showMessageDialog(null, "查询系统时间出错！\n"+ex.getMessage());
            }
        return ans;
    }
    
    
}
