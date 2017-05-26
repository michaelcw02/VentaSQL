/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package testing;

/**
 *
 * @author LAPTOP
 */
public class Test {
    public static void main(String [] args){
        ConnectionDB con = ConnectionDB.getConnection();
        String sql = "insert into PRODUCTOS_TERMINADOS " + "VALUES('%d','%d')";
        sql = String.format(sql,90,900);
        int rs = con.executeUpdate(sql);
        if(rs == 1){
            System.out.println("GG PERROS");
        }else{
            System.out.println("SOMETHING IS WRONG");
        }
    }
}
