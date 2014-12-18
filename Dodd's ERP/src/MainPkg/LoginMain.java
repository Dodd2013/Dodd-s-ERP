/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package MainPkg;
import DataReadpkg.DataOnly;
import Toolspkg.CheckString;
import Toolspkg.EncoderHandler;
import Toolspkg.SelectAllWhileGetFocusJTF;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPasswordField;
import javax.swing.JTextField;
/**
 *
 * @author Dodd
 */
public class LoginMain {
    /**
     * 登录窗体
     */
    JFrame loginFrame;
    /**
     * id标签，password标签
     */
    JLabel idLabel,passwordLabel;
    /**
     * 输入框
     */
    JTextField idField;
    JPasswordField pasField;
    JButton exitbtn,loginbtn;
    public JLabel msg;
    public LoginMain(){
         //init JFrame
        loginFrame=new JFrame("Dodd's ERP");
        loginFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        loginFrame.setResizable(false);
        loginFrame.setLayout(null);
        loginFrame.setSize(400,300);
        loginFrame.setLocationRelativeTo(null);
        
        //init JLabel
        idLabel=new JLabel("帐号：");
        idLabel.setBounds(95, 35, 120, 50);
        loginFrame.add(idLabel);
        passwordLabel=new JLabel("密码:");
        passwordLabel.setBounds(95, 90, 120, 50);
        loginFrame.add(passwordLabel);
        
        //init JTF
        idField=new JTextField();
        idField.setBounds(145, 45, 120, 30);
        idField.addKeyListener(new KeyAdapter() {
            @Override
            public void keyTyped(KeyEvent e) {
                if(e.getKeyChar()=='\n'){
                    pasField.requestFocus();
                }
            }
});
        
        idField.addFocusListener(new SelectAllWhileGetFocusJTF());
        loginFrame.add(idField);
        pasField=new JPasswordField();
        pasField.setBounds(145, 100, 120, 30);
        pasField.addKeyListener(new KeyAdapter() {
             @Override
             public void keyTyped(KeyEvent e) {
                if(e.getKeyChar()=='\n'){
                    loginbtn.doClick();
                }
            }
});
        pasField.addFocusListener(new SelectAllWhileGetFocusJTF());
        loginFrame.add(pasField);
        
        //init btn
        exitbtn=new JButton("退出");
        exitbtn.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
              System.exit(0);
            }
        });
        exitbtn.setBounds(200, 180, 80, 30);
        loginFrame.add(exitbtn);
        loginbtn=new JButton("登录");
        loginbtn.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
               if(!DataOnly.initCDB){
                   JOptionPane.showMessageDialog(loginFrame, "正在连接数据库，请稍后！");
               }else if(!DataOnly.clientServerOrNot){
                   JOptionPane.showMessageDialog(loginFrame, "正在连接服务器，请稍后！");
               }else{
                    if(idField.getText().equals("")||pasField.getText().equals("")){
                        JOptionPane.showMessageDialog(loginFrame, "密码和帐号不能为空！");
                    }else{
                        if(CheckString.checkStringIsPassWord(pasField.getText())){
                            if(loginIn(idField.getText(), pasField.getText())){
                                DataOnly.loginOrnot=true;
                                DataOnly.loginManName=idField.getText();
                                DataOnly.clientServer.startGetMessage();
                                new InitAll();
                                loginFrame.dispose();
                                //System.out.println("fdsag");
                          }
                        }else{
                            JOptionPane.showMessageDialog(loginFrame, "密码长度不符！（6-16位）");
                        }
                        
                    }
               }
               
            }
        });
        loginbtn.setBounds(100, 180, 80, 30);
        loginFrame.add(loginbtn);
        
       
        //设置显示
        loginFrame.setVisible(true); 
        //连接数据库
        this.fristConDBAndServer();
        
    }
    
    protected boolean loginIn(String id,String password){
        String p=password;
        try {
            password=EncoderHandler.encode("sha1", password);
            PreparedStatement pstmt=DataOnly.conData.con.prepareStatement("select * from usersTB a join employeeTB b on a.emp_id=b.emp_id  where userid= ?");
            ResultSet res;
            pstmt.setString(1, id);
            res =pstmt.executeQuery();
            if(res.next()){
                if(password.equals(res.getString("password")))
                {
                    String msg;
                    DataOnly.clientServer.out.println("LOGIN:id:"+id+";password:"+p+";name:"+res.getString("Name_CN"));
                    DataOnly.clientServer.out.flush();
                    this.msg.setText("等待服务器回应！");
                    msg=DataOnly.clientServer.in.readLine();
                    System.out.println(msg);
                    if(msg.equals("CMD:LoginOK")){
                        DataOnly.loginMan=res.getInt("emp_id");
                        DataOnly.loginManName=res.getString("Name_CN");
                        return true;
                    }else if(msg.equals("CMD:UserIsOnLine")){
                        JOptionPane.showMessageDialog(loginFrame, "用户已经在线！");
                        this.msg.setText("用户已经在线！");
                        return false;
                    }else{
                        return false;
                    }
                }else JOptionPane.showMessageDialog(loginFrame, "密码错误！");
                    
            }else
                JOptionPane.showMessageDialog(loginFrame, "不存在该用户！");
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(loginFrame, ex.getMessage());
        } catch (IOException ex) {
            if(ex.getMessage().equals("Connection reset")){
                JOptionPane.showMessageDialog(loginFrame, "服务器已断开！");
            }
            System.out.println(ex.getMessage());
        }
        return false;
        
    }
    private void fristConDBAndServer(){
        msg=new JLabel("正在连接数据库...");
        msg.setBounds(60, 225, 110, 30);
        loginFrame.add(msg);
        if(InitAll.ConnectedtoDataBase()){
            msg.setText("成功连接数据库！");
        }
        msg.setText("正在连接服务器...");
        if(InitAll.ClientServer()){
            msg.setText("成功连接服务器！");
        }
    }
    
}
