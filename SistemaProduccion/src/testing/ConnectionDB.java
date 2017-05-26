/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package testing;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ConnectionDB {
    
    private ConnectionDB(){
        initConnection();
    }
    
    public void initConnection(){
        try {
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
            System.out.println("Conectando con la base de datos...");
            this.cn = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:orcl");
            Statement statement = cn.createStatement();
        } catch (Exception e) {
            System.out.println("The exception raised is:" + e);
        }
    }
    
    public static synchronized ConnectionDB getConnection(){
        if(instance == null)
            instance = new ConnectionDB();
        return instance;
    }
    
    public int executeUpdate(String statement) {
        try {
            Statement stm = cn.createStatement();
            stm.executeUpdate(statement);
            return stm.getUpdateCount();
        } catch (SQLException ex) {
            return 0;
        }
    }

    public ResultSet executeQuery(String statement) {
        try {
            Statement stm = cn.createStatement();
            return stm.executeQuery(statement);
        } catch (SQLException ex) {
            int x = 0;
        }
        return null;
    }
    
    public void closeConnection(){
        instance = null;
    }
    
    private static ConnectionDB instance;
    private Connection cn;
}
