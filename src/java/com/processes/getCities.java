package com.processes;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mjson.Json;

/**
 *
 * @author Sagar
 */
public class getCities extends HttpServlet{

    private Connection con;
    private PreparedStatement ps;
    String getCities_query = "select city_name from city;";
    List<String> city_name = new ArrayList<String>();
    String city_name_json = null;

    public static void main(String args[]){
    
    }
    protected void doPost(HttpServletRequest rq, HttpServletResponse rs)
            throws ServletException, IOException {
        try {
            getCityNames(rq, rs);
        } catch (Exception e) {
            System.out.println("doPost() failed.");
            System.out.println("Error \n." + e);
            String error = "<h3><b>" + e + "</b></h3><br> in doPost() function in city_name.java";
            rq.setAttribute("error", error);
            rq.getRequestDispatcher("error.jsp").forward(rq, rs);
        }

    }

    List getCityNames(HttpServletRequest rq, HttpServletResponse rs) throws ServletException, IOException {
        PrintWriter out = rs.getWriter();
        System.out.println("Search Spot called");

        try {
            Json pCity = Json.array();
            city_name.clear();
            con = connection_class.getConnectionIntance().get_connection(rq, rs);
            ps = con.prepareStatement(getCities_query);
            ResultSet loc_rs = ps.executeQuery();
            while (loc_rs.next()) {
                
                pCity.add(loc_rs.getString("city_name"));
            }
            
           
            out.print(pCity.toString());
            con.close();

        } catch (Exception e) {
            System.out.println("Searching failed.");
            System.out.println("Error \n." + e);
            String error = "<h3><b>" + e + "</b></h3><br> in search_spots function in city_name.java";
            rq.setAttribute("error", error);
            rq.getRequestDispatcher("error.jsp").forward(rq, rs);
        }
        return city_name;

    }
}
