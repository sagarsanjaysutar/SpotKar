package com.processes;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import mjson.Json;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class showParkingLot extends HttpServlet {

    Connection con;
    Statement st = null;
    PreparedStatement ps, ps2 = null;
    ResultSet pLot, pSpace = null;

    List<String> city_name = new ArrayList<String>();
    String city_name_json = null;

    String getParkingLotInfo = "select * from parking_lot where pl_cid = (select c_id from city where city_name = ?)";
    String getParkingSpaceInfo = "select * from parking_space where pl_id = ?";

    Json pData;

    @Override
    protected void doPost(HttpServletRequest rq, HttpServletResponse rs) throws ServletException, IOException {

        connect_to_db(rq, rs);
        display_result(rq, rs);

    }

    void display_result(HttpServletRequest rq, HttpServletResponse rs) throws ServletException, IOException {
        try {
            PrintWriter out = rs.getWriter();
            String city_name = rq.getParameter("location");

            CharSequence illegal_char = "-._~:/?#[]@!$&'()*+,;=";
            if (city_name.contains(illegal_char)) {
                throw new Exception();
            }

            ps = con.prepareStatement(getParkingLotInfo);
            ps.setString(1, city_name);
            pLot = ps.executeQuery();

            while (pLot.next()) {
                pData = Json.object().set("pl_id", pLot.getString("pl_id"))
                        .set("pl_name", pLot.getString("pl_name"))
                        .set("pl_cid", pLot.getString("pl_cid"))
                        .set("pl_available_spots", pLot.getString("pl_available_spots"))
                        .set("pl_total_spots", pLot.getString("pl_total_spots"))
                        .set("pl_city", city_name)
                        .set("pl_spaces", getpSpace(pLot.getString("pl_id")));
            }
            

           

            rq.setAttribute("pData", pData);
            rq.getRequestDispatcher("result.jsp").forward(rq, rs);
            con.close();

        } catch (Exception e) {
            System.out.println("Search failed.");
            System.out.println("Error \n." + e);
            String error = "<h3><b>" + e + "</b></h3><br> in display_result function in searching.java";
            rq.setAttribute("error", error);
            rq.getRequestDispatcher("error.jsp").forward(rq, rs);

        }
    }

    Json getpSpace(String pl_id) throws SQLException {
        Json pSpaceObj = null;
        Json pSpaceArray = Json.array();
        ps2 = con.prepareStatement(getParkingSpaceInfo);
        ps2.setString(1, pl_id);
        pSpace = ps2.executeQuery();
        while (pSpace.next()) {
            pSpaceObj = Json.object().set("ps_id", pSpace.getString("ps_id"))
                    .set("ps_status", pSpace.getString("ps_status"))
                    .set("parking_slot", pSpace.getString("time_slot"));
            pSpaceArray.add(pSpaceObj);

        }

        return pSpaceArray;
    }

    void connect_to_db(HttpServletRequest rq, HttpServletResponse rs) throws ServletException, IOException {
        try {

            con = connection_class.getConnectionIntance().get_connection(rq, rs);
            System.out.println("Connected to database successfully.");
        } catch (Exception e) {
            System.out.println("Connection to database failed.");
            System.out.println("Error \n." + e);
            String error = "<h3><b>" + e + "</b></h3><br> in connect_to_db function in searching.java";
            rq.setAttribute("error", error);
            rq.getRequestDispatcher("error.jsp").forward(rq, rs);

        }
    }
}

/*=======================Discarded code============================*/
//    //method used to define the HTML code needed to be inflated
//    String return_view(int v_id){
//        switch(v_id){
//            case 0:
//                String initial_code = "  <div class=\"content fade-out\" data-aos=\"fade-left\" data-aos-duration=\"1000\">\n" +
//"                    <div class=\"pl-status\" id=\"pl-status\">\n" +
//"                        <div class=\"row\">\n" +
//"                            <div class=\"col-4\">\n" +
//"                                <h7>\n" +
//"                                    Status :-2 out of 5 spots are available.\n" +
//"                                </h7>\n" +
//"                            </div>\n" +
//"                            <div class=\"col-4 text-center\">\n" +
//"                                <h7 id=\"selected-spt\">\n" +
//"                                </h7>\n" +
//"                            </div>\n" +
//"                            <div class=\"col-4\">\n" +
//"                                <h7>\n" +
//"                                    Status :-2 out of 5 spots are available.\n" +
//"                                </h7>\n" +
//"                            </div>\n" +
//"                        </div>\n" +
//"                    </div>\n" +
//"                    <div class=\"container d-flex justify-content-center align-items-cente\">\n" +
//"                        <div class=\"row d-flex justify-content-center align-items-center\" id=\"spt-group\">\n" +
//"\n" +
//"                            <div class=\"col-6  col-lg-3\">\n" +
//"                                <div class=\"spt shadow\" id=\"spt-1\"></div>\n" +
//"                            </div>\n" +
//"                            <div class=\"col-6  col-lg-3 \">\n" +
//"                                <div class=\"spt shadow\" id=\"spt-2\"></div>\n" +
//"                            </div>\n" +
//"                            <div class=\"col-6  col-lg-3 \">\n" +
//"                                <div class=\"spt shadow\" id=\"spt-3\"></div>\n" +
//"                            </div>\n" +
//"\n" +
//"                            <div class=\"col-6 col-lg-3 \">\n" +
//"                                <div class=\"spt shadow\" id=\"spt-4\"></div>\n" +
//"                            </div>\n" +
//"                        </div>\n" +
//"\n" +
//"\n" +
//"                    </div>\n" +
//"                    <div class=\"d-flex justify-content-center align-items-end p-3 \">\n" +
//"                        <button class=\"btn btn-outline-light \" id=\"book-btn\" onclick=\"process_selected_spots()\">Book and\n" +
//"                            Pay</button>\n" +
//"                    </div>\n" +
//"                </div> ";
//                return initial_code;
//                
//            case 1:
//                 String booking_confirmation = "      <div class=\"content \" data-aos=\"fade-left\" data-aos-duration=\"1000\">\n" +
//"                <div class=\"container\" data-aos=\"fade-in\">\n" +
//"                    <div class=\"row\">\n" +
//"                        <div class=\"col-12 col-lg-4 m-0 p-0\">                            \n" +
//"                            <div class=\"card \" style=\"background-color:#42033d;\">\n" +
//"                                <div class=\"card-body\">\n" +
//"                                    <div class=\"card-title\">\n" +
//"                                        Selected Spots\n" +
//"                                    </div>\n" +
//"                                    <div class=\"card-text\">\n" +
//"                                        <div class=\"container bg-dark\">\n" +
//"                                            <div class=\"row\">\n" +
//"                                                <div class=\"col-6  col-lg-3\">\n" +
//"                                                    <div class=\"spt-sm shadow\" id=\"spt-1\"></div>\n" +
//"                                                </div>\n" +
//"                                                <div class=\"col-6  col-lg-3\">\n" +
//"                                                    <div class=\"spt-sm shadow\" id=\"spt-1\"></div>\n" +
//"                                                </div>\n" +
//"\n" +
//"                                            </div>\n" +
//"                                        </div>\n" +
//"                                        <p class=\"\">\n" +
//"                                            Spots no 1 and 2 are selected.\n" +
//"                                        </p>\n" +
//"                                        \n" +
//"\n" +
//"                                    </div>\n" +
//"                                </div>\n" +
//"                            </div>\n" +
//"                        </div>\n" +
//"                        <div class=\"col-12 col-lg-4 m-0 p-0\">\n" +
//"                            <div class=\"card  \" style=\"background-color:#854798;\">\n" +
//"                                <div class=\"card-body\">\n" +
//"                                <div class=\"card-title\">\n" +
//"                                    Available timings\n" +
//"                                </div>\n" +
//"                                <div class=\"card-text p-3  \">\n" +
//"                                   \n" +
//"                                        <div class=\"btn btn-primary\">1.30am</div>\n" +
//"                                        <div class=\"btn btn-secondary\">1.30am</div>\n" +
//"                                        <div class=\"btn btn-dark\">1.30am</div>\n" +
//"                                        <div class=\"btn btn-light\">1.30am</div>\n" +
//"                                        <div class=\"btn btn-info\">1.30am</div>\n" +
//"                                        <div class=\"btn btn-danger\">1.30am</div>\n" +
//"                                        <div class=\"btn btn-warning\">1.30am</div>\n" +
//"\n" +
//"\n" +
//"                                </div>\n" +
//"                            </div>\n" +
//"                            </div>\n" +
//"                            \n" +
//"                        </div>\n" +
//"                        <div class=\"col-12 col-lg-4 m-0 p-0\">\n" +
//"                            <div class=\"card \" style=\"background-color:#680e4b;\">\n" +
//"                                <div class=\"card-body\">\n" +
//"                                    <div class=\"card-title\">\n" +
//"                                        Total\n" +
//"                                    </div>\n" +
//"                                    <div class=\"card-text  \">\n" +
//"                                        <div class=\"list-group  \">\n" +
//"                                            <div class=\"list-group-item bg-dark active\">\n" +
//"                                                <div class=\"row\">\n" +
//"                                                    <div class=\"col-8\">\n" +
//"                                                        Spot charges:-\n" +
//"                                                    </div>\n" +
//"                                                    <div class=\"col-4\">\n" +
//"                                                        1200/-\n" +
//"                                                    </div>\n" +
//"                                                </div>\n" +
//"                                            </div>\n" +
//"                                            <div class=\"list-group-item bg-dark \">\n" +
//"                                                <div class=\"row\">\n" +
//"                                                    <div class=\"col-8 \">\n" +
//"                                                        GST:-\n" +
//"                                                    </div>\n" +
//"                                                    <div class=\"col-4\">\n" +
//"                                                        1200/-\n" +
//"                                                    </div>\n" +
//"                                                </div>\n" +
//"                                            </div>\n" +
//"                                            <div class=\"list-group-item bg-dark \">\n" +
//"                                                <div class=\"row\">\n" +
//"                                                    <div class=\"col-8\">\n" +
//"                                                       Total:-\n" +
//"                                                    </div>\n" +
//"                                                    <div class=\"col-4\">\n" +
//"                                                        1200/-\n" +
//"                                                    </div>\n" +
//"                                                </div>\n" +
//"                                            </div>\n" +
//"                                        </div>\n" +
//"                                    </div>\n" +
//"                                </div>\n" +
//"                            </div>\n" +
//"                        </div>\n" +
//"                    </div>\n" +
//"                </div>\n" +
//"                <div class=\"d-flex justify-content-center align-items-end p-3 \">\n" +
//"                    <button class=\"btn btn-outline-light \" id=\"book-btn\" onclick=\"process_selected_spots()\">Book and\n" +
//"                        Pay</button>\n" +
//"                </div>\n" +
//"            </div>\n" +
//"      ";
//                return booking_confirmation;
//                
//            default:
//                break;
//        }
//        return "No such view defined";       
//    }
//    //method used to inflate the HTML code 
//    void inflate_view(HttpServletRequest rq, HttpServletResponse rs) throws IOException{
//        PrintWriter out = rs.getWriter();  
//        String content_placeholder = rq.getParameter("content-placeholder");
//        if(content_placeholder.equals("initial_code")){            
//            out.print(return_view(0));        
//        }
//        else if(content_placeholder.equals("booking_confirmation")){
//            out.print(return_view(1));  
//        }
//        else{
//            out.print("Error in inflating");  
//        }  
//       
//    }
// 
//   void search_spots(HttpServletRequest rq, HttpServletResponse rs) throws ServletException, IOException {
//        PrintWriter out = rs.getWriter();
//        System.out.println("Search Spot called");
//
//        try {
//           
//            city_name.clear();
//            ps = con.prepareStatement(getCities_query);
//            ResultSet loc_rs = ps.executeQuery();
//            while (loc_rs.next()) {
//                System.out.println(loc_rs.getString("city_name"));
//                city_name.add(loc_rs.getString("city_name"));
//                city_name_json = new Gson().toJson(city_name);

/* Map<String, Map<String, String>> location = new HashMap<String, Map<String, String>>();
    Map innerMap = new HashMap();
    String pl_id;
innerMap.put("pl_id", pLot.getString("pl_id"));
                innerMap.put("pl_name", pLot.getString("pl_name"));
                innerMap.put("pl_cid", pLot.getString("pl_cid"));
                innerMap.put("pl_available_spots", pLot.getString("pl_available_spots"));
                innerMap.put("pl_total_spots", pLot.getString("pl_total_spots"));
                innerMap.put("pl_city", city_name);
                location.put("p_id", innerMap);*/
//            }
//
//            out.print("---" + city_name_json);
//
//        } catch (Exception e) {
//            System.out.println("Searching failed.");
//            System.out.println("Error \n." + e);
//            String error = "<h3><b>" + e + "</b></h3><br> in search_spots function in searching.java";
//            rq.setAttribute("error", error);
//            rq.getRequestDispatcher("error.jsp").forward(rq, rs);
//        }
//        
//    }
