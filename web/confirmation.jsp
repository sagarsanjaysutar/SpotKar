<%@page import="mjson.Json"%>
<html>

<head>
    <title>
        SpotKar | A Complete Parking Solution
    </title>

    <link rel="stylesheet" type="text/css" href="Design/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="Design/css/spots/custom_css.css">
<!--    <link href="https://fonts.googleapis.com/css?family=Exo:200&display=swap" rel="stylesheet">-->
    <style>

    </style>
</head>

<body>
    <%
    Json bookingDetails = (Json) request.getAttribute("bookingDetails");
   
    
    
    %>
  
    <div class="container p-3">
            <div class=" jbt1 p-3 ">
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


        <div class="jbt2 p-3">

            <div class="pl-details">
                <h2><%=bookingDetails.at("lotName").asString()%></h2>
                <h5><%=bookingDetails.at("lotCity").asString()%></h5>
                  <div class="pl-details" data-aos="fade-up">
               
            </div>

            </div>
            <hr>
           
                <div class="container">
                    <div class="row">
                        <div class="col-12 col-lg-4">
                            <div class="card bg-secondary">
                                <div class="card-body">
                                    <div class="card-title">
                                        Selected Spots
                                    </div>
                                    <div class="card-text">
                                        <div class="container bg-dark">
                                            <div class="row">
                                                <%for (int i = 0 ; i < bookingDetails.at("selectedSpot").asList().size();i++){%>
                                                <div class="col-2">
                                                    <div class="spt-sm shadow" id="spt-1"></div>
                                                </div>
                                                <%}%>
                                                

                                            </div>
                                        </div>
                                        <p class="pt-3">
                                            <%=bookingDetails.at("selectedSpot").asList().size()%> spots selected.
                                        </p>


                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-lg-4">
                            <div class="card bg-secondary">
                                <div class="card-body">
                                    <div class="card-title">
                                        Available timings
                                    </div>
                                    <div class="card-text p-3  text-center" id="btn_group">
                                        <%
                                            
                                            Json timings = bookingDetails.at("timings");
                                            for(int i = 0; i<timings.asList().size();i++){
                                        %>
                                        <div class="btn btn-block btn-light m-2" id="<%=timings.at(i).at("t_id").asString()%>"><%=timings.at(i).at("start_time").asString()%> - <%=timings.at(i).at("end_time").asString()%></div>
                                        <%}%>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="col-12 col-lg-4">
                            <div class="card bg-secondary">
                                <div class="card-body">
                                    <div class="card-title">
                                        Total
                                    </div>
                                    <div class="card-text  ">
                                        <div class="list-group ">
                                            <div class="list-group-item bg-dark ">
                                                <div class="row">
                                                    <div class="col-6">
                                                        Spot charges:-
                                                    </div>
                                                    <div class="col-6" >
                                                        <div id="spotPrice" class=" text-right">Select Timings</div>
                                                        
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="list-group-item bg-dark ">
                                                <div class="row">
                                                    <div class="col-8 ">
                                                        GST:-
                                                    </div>
                                                    <div class="col-4">
                                                        <div id="GST" class="text-right">-</div>
                                                    </div>
                                                </div>
                                            </div>
                                             <div class="list-group-item bg-dark ">
                                                <div class="row">
                                                    <div class="col-8 ">
                                                        Spot Quantity-
                                                    </div>
                                                    <div class="col-4">
                                                        <div class=" text-right">
                                                        <%=bookingDetails.at("selectedSpot").asList().size()%>
                                                    
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="list-group-item bg-dark ">
                                                <div class="row">
                                                    <div class="col-8">
                                                        Total:-
                                                    </div>
                                                    <div class="col-4">
                                                        <div id="finalPrice" class=" text-right">-</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="d-flex justify-content-center align-items-end p-3 ">
                    <button class="btn btn-outline-light " id="book-btn" onclick="process_selected_spots()">Book and
                        Pay</button>
                </div>
           
           


        </div>

        <div class="jbt3 custom_footer p-3">
            <div class="row">
                <div class="col-12 footer_contact">
                    <div class="footer_contact_content">
                        <strong class="h4">Contact Us</strong><br><br>
                        Email: sutarsagarsanjay@gmail.com <br>
                    </div>
                </div>
            </div>
        </div>

        <hr small="small_line">
        <p class="copyright text-center">
            © Copyright 2020 SpotKar - All Rights Reserved
        </p>
    </div>
    <script type="text/javascript" src="Design/js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="Design/js/popper.js"></script>
    <script type="text/javascript" src="Design/js/bootstrap.js"></script>
    <script>
        var selectedButton_array = new Array();
        var btn_group = document.getElementById("btn_group");
        btn_group.onclick = selectTiming;
       
        
        function selectTiming(e){
            var selectedButton_classes = document.getElementById(e.target.id);            
            var selectedButton_class_array = selectedButton_classes.classList.toString().split(" ");
            
            if(!selectedButton_class_array.includes("selected")){
                selectedButton_classes.classList.add("selected");
                selectedButton_classes.classList.remove("btn-light");
                selectedButton_classes.classList.add("btn-dark"); 
                selectedButton_array.push(e.target.id.toString());
                
                
            }
            if(selectedButton_class_array.includes("selected")){
                selectedButton_classes.classList.remove("selected");
                selectedButton_classes.classList.add("btn-light");
                selectedButton_classes.classList.remove("btn-dark");
                selectedButton_array.splice(selectedButton_array.indexOf(e.target.id.toString()),1);
            }
            console.log(selectedButton_array);
            getPrice(<%=bookingDetails.at("selectedSpot").asList().size()%>,selectedButton_array.length)
            
        }
        function getPrice(slotQuantity,slotTimingQuantity){
            $.ajax({
                
                type : "get",
                data: {
                    slotQuantity: slotQuantity,
                    slotTimingQuantity : slotTimingQuantity
                },
                url : "getPrice",
                
                success : function(res){
                    
                    var getResponse = JSON.parse(res);
                    document.getElementById("spotPrice").innerHTML = getResponse['spotPrice'];
                    document.getElementById("GST").innerHTML = getResponse['GST']+"%";
                    document.getElementById("finalPrice").innerHTML = getResponse['finalPrice']
                },
                error : function(){
                    console.log("Error");
                }
            });            
        }
        
        
    </script>   

</body>