/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.processes;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import javax.ejb.Singleton;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Sagar
 */
public class connection_class {

    private static Connection con;
    public static connection_class con_ob = new connection_class(); //obj of Singleton class

    public static connection_class getConnectionIntance() {
        if (con_ob == null) {
            con_ob = new connection_class();
        }
        return con_ob;
    }

    static void set_Connection(HttpServletRequest rq, HttpServletResponse rs) throws ServletException, IOException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pms", "sagar", "D3cpb0n3crus!-!");
            System.out.println("Connected to database successfully.");
        } catch (Exception e) {
            System.out.println("Connection to database failed.");
            System.out.println("Error \n." + e);
            String error = "<h3><b>" + e + "</b></h3><br> in set_Connection function in searching.java";
            rq.setAttribute("error", error);
            rq.getRequestDispatcher("error.jsp").forward(rq, rs);
        }
    }

    public Connection get_connection(HttpServletRequest rq, HttpServletResponse rs) throws ServletException, IOException {
        try{
        set_Connection(rq, rs);
        }
        catch (Exception e) {
            System.out.println("get_Connection() failed.");
            System.out.println("Error \n." + e);
            String error = "<h3><b>" + e + "</b></h3><br> in get_connection function in searching.java";
            rq.setAttribute("error", error);
            rq.getRequestDispatcher("error.jsp").forward(rq, rs);
        }
        return con;
    }

    private connection_class() {    //private method to avoid creating more than one instance using default constructor
    }

}
