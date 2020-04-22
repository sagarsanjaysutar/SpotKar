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
public class getPrice extends HttpServlet {

    private Connection con;
    private PreparedStatement ps;
    private ResultSet pPrice;
    private final String getPriceQuery = "select * from price";

    @Override
    protected void doGet(HttpServletRequest rq, HttpServletResponse rs)
            throws ServletException, IOException {
        PrintWriter out = rs.getWriter();
        int slotQuantity = Integer.valueOf(rq.getParameter("slotQuantity"));
        int slotTimingQuantity = Integer.valueOf(rq.getParameter("slotTimingQuantity"));
        out.print(getFinalPrice(rq, rs, slotQuantity, slotTimingQuantity));
    }

    private Json getFinalPrice(HttpServletRequest rq, HttpServletResponse rs, int slotQuantity, int slotTimingQuantity) throws ServletException, IOException {
        try {
            double spot_price = 0;
            double finalPrice = 0;
            double GST = 0;
            con = connection_class.getConnectionIntance().get_connection(rq, rs);
            ps = con.prepareStatement(getPriceQuery);
            pPrice = ps.executeQuery();
            while (pPrice.next()) {
                System.out.println(pPrice.getString("p_name"));
                if (pPrice.getString("p_name").equals("Spot")) {
                    spot_price = Integer.valueOf(pPrice.getString("p_price"));
                    System.out.println(spot_price);
                } else if (pPrice.getString("p_name").equals("GST")) {
                    GST = Integer.valueOf(pPrice.getString("p_price"));
                    System.out.println(GST);
                }

            }
            con.close();
            finalPrice = spot_price * slotQuantity * slotTimingQuantity;
            finalPrice = finalPrice + (finalPrice*GST)/100;
            Json price = Json.object();
            price.set("spotPrice", String.valueOf(spot_price))
                    .set("GST", String.valueOf(GST))
                    .set("finalPrice", String.valueOf(finalPrice));
            return price;

        } catch (Exception e) {
            System.out.println("Getting Price failed.");
            System.out.println("Error \n." + e);
            String error = "<h3><b>" + e + "</b></h3><br> in getPrice function in searching.java";
            rq.setAttribute("error", error);
            rq.getRequestDispatcher("error.jsp").forward(rq, rs);
        }
        return null;
    }

}
