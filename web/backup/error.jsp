<%-- 
    Document   : error
    Created on : 6 Mar, 2020, 12:17:06 AM
    Author     : Sagar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>

    <head>
        <title>
            SpotKar | A Complete Parking Solution
        </title>

        <link rel="stylesheet" type="text/css" href="Design/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="Design/css/index/custom_css.css">
        <link href="https://fonts.googleapis.com/css?family=Exo:200&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/css/select2.min.css" rel="stylesheet" />


    </head>

    <body>
        <div class="container p-5">
            <div class="jumbotron jbt1 ">
                <h1 class="text-center"><label>SpotKar</label></h1>
                <h6 class="text-center"><label>A complete parking solution.</label> </h6>

                <div class="d-flex justify-content-center align-items-center">
                    <hr class="small_line">
                </div>

                <nav class="navbar navbar-expand-lg  " id='navid'>

                    <!--Hamburger button-->
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarContent"
                            aria-expanded="false">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse justify-content-center" id="navbarContent">
                        <ul class="navbar-nav  ">
                            <li class="nav-item">
                                <a class="nav-link bold">Home</a>
                            </li>

                            <li class="nav-item">
                                <a class="nav-link">About Us</a>
                            </li>

                            <li class="nav-item">
                                <a class="nav-link">Services</a>
                            </li>

                            <li class="nav-item">
                                <a class="nav-link">Contact Us</a>
                            </li>


                        </ul>
                    </div>

                </nav>
            </div>

            <div class="jumbotron jbt2 p-4">
                <div class="pl-details">
                    <h2><label>Opps !!! Error</label></h2>
                    <hr>
                </div>
                <div class="h5">
                    <%
                        String error = "Nothing";
                        error = (String)request.getAttribute("error");
                        
                    %>
                    
                </div>
                    <h5>
                    <%=error%>
                    </h5>
              

            </div>

        <p class="copyright text-center">
            © Copyright 2020 SpotKar - All Rights Reserved
        </p>



        <script type="text/javascript" src="Design/js/jquery-3.4.1.min.js"></script>
        <script type="text/javascript" src="Design/js/popper.js"></script>
        <script type="text/javascript" src="Design/js/bootstrap.js"></script>

    </body>

</html>