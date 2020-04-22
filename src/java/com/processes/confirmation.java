/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.processes;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mjson.Json;

/**
 *
 * @author Sagar
 */
public class confirmation extends HttpServlet {

    Connection con;
    PreparedStatement ps, ps2;
    ResultSet pTimings;
    
   
    String getTimings = "select * from timings";
    Json timings;
    Json timings_obj;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            con = connection_class.getConnectionIntance().get_connection(request, response);
            
            String selected_spots[] = request.getParameter("selected-spt").split(",");
            String lotName = request.getParameter("lotName");
            String lotCity = request.getParameter("lotCity");
            
            Json timings = Json.array();
            timings = getTimings(request,response);
            con.close();            
            Json bookingDetails = Json.object().set("bd_id", "0")
                    .set("selectedSpot", selected_spots)  
                    .set("lotName", lotName)  
                    .set("lotCity", lotCity)  
                    .set("timings", timings);
            
           
            request.setAttribute("bookingDetails", bookingDetails);
            request.getRequestDispatcher("confirmation.jsp").forward(request, response);
            
            

        } catch (Exception e) {
            System.out.println("Confirmation failed.");
            System.out.println("Error \n." + e);
            String error = "<h3><b>" + e + "</b></h3><br> in post function in searching.java";
            request.setAttribute("error", error);
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }

    }

  
    Json getTimings(HttpServletRequest rq, HttpServletResponse rs) throws ServletException, IOException {
        try {
            timings = Json.array();
            timings_obj = Json.object();
            ps2 = con.prepareStatement(getTimings);
            
            pTimings = ps2.executeQuery();           
            
            while (pTimings.next()) {
                timings.add(Json.object().set("t_id", pTimings.getString("t_id"))
                        .set("start_time", pTimings.getString("start_time"))
                        .set("end_time", pTimings.getString("end_time")));
                
            }
            System.out.println(timings.at(1));
            
            return timings;

        } catch (Exception e) {
            System.out.println("Getting Timings failed.");
            System.out.println("Error \n." + e);
            String error = "<h3><b>" + e + "</b></h3><br> in getTimings function in searching.java";
            rq.setAttribute("error", error);
            rq.getRequestDispatcher("error.jsp").forward(rq, rs);
        }
        return null;

    }

    

}
