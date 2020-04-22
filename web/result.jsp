<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="mjson.Json"%>
<html>

<head>
    <title>
        SpotKar | Searched Places
    </title>

    <link rel="stylesheet" type="text/css" href="Design/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="Design/css/spots/custom_css.css">
    <!---<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
                <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
                <link href="https://fonts.googleapis.com/css?family=Exo:200&display=swap" rel="stylesheet">
        -->
    <style>
        .fade-out.aos-animate {
            opacity: 0
        }
    </style>
</head>

<body>
     <%
        Json pData = Json.object();
        pData = (Json) request.getAttribute("pData");
        int total_spots = Integer.valueOf(pData.at("pl_total_spots").asString());
        Json pSpaces = Json.array();
        pSpaces =  pData.at("pl_spaces");        
    %>
    <div class="container p-3 ">
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

        <div class=" jbt2 p-3 ">

            <div class="pl-details" data-aos="fade-up">
                <h2>                   
                    <%=pData.at("pl_name").asString()%>           
                </h2>
                <h5> 
                    <%=pData.at("pl_city").asString()%>
                </h5>
            </div>


            <div id="content-placeholder" class="p-0">
                <div class="content fade-up" data-aos="fade-up">
                    <div class="pl-status" id="pl-status">
                        <div class="row">
                            <div class="col-12">
                                <h7>
                                    <%=pData.at("pl_available_spots").asString()%> out of
                                    <%=pData.at("pl_total_spots").asString()%> spots are available.
                                </h7>
                            </div>

                        </div>
                    </div>
                    <div class="custom-container d-flex justify-content-center align-items-center" style="height:100%;">
                        <div class="container ">
                            <div class="row p-0" id="spt-group"></div>
                            <div class="row d-flex justify-content-center align-items-center">
                                <div class=" p-3 ">
                                   <form action="confirmation" method="post" id="form-1">
                                    <button class="btn btn-outline-light disabled " id="book-btn"
                                            onclick="process_selected_spots()" disabled="true">Book and
                                        Pay</button>
                                       <input type="hidden" id="selected-spt" name="selected-spt">
                                       <input type="hidden" id="lotName" name="lotName">
                                       <input type="hidden" id="lotCity" name="lotCity">
                                   </form>
                                </div>
                            </div>
                        </div>
                    </div>



                </div>
            </div>



        </div>

        <div class=" jbt3 custom_footer p-3 ">
            <div class="row">
                <div class="col-12 footer_contact">
                    <div class="footer_contact_content">
                        <strong class="h4">Contact Us</strong><br><br>
                        Email: sutarsagarsanjay@gmail.com <br>
                    </div>
                </div>
            </div>
        </div>


        <p class="copyright text-center">
            © Copyright 2020 SpotKar - All Rights Reserved
        </p>
    </div>
    <script type="text/javascript" src="Design/js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="Design/js/popper.js"></script>
    <script type="text/javascript" src="Design/js/bootstrap.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        var counter = 0; //to determine if button is clicked
        var selected_spots = new Array();
        
        AOS.init();        
        inflateSpots(); 
        document.getElementById("spt-group").onclick = selectSpot; 
        showSpotStatus();
        

        
       

        

       function showSpotStatus(){
           <%
                for(int i = 0; i < pSpaces.asList().size();i++ ){
                    int ps_booked = Integer.valueOf(pSpaces.at(i).at("ps_status").asString());
                    
                    if(ps_booked==1){                      
                   
            %>
                    document.getElementById(<%=pSpaces.at(i).at("ps_id")%>).style.backgroundColor = "#282828";
                    document.getElementById(<%=pSpaces.at(i).at("ps_id")%>).classList.add("booked");   
             <%           
                }
                else if(ps_booked==0){
                %>
                document.getElementById(<%=pSpaces.at(i).at("ps_id")%>).style.backgroundColor = "#606265";
                document.getElementById(<%=pSpaces.at(i).at("ps_id")%>).classList.add("not-booked");
                <%

                    }}

              
           %>
          
       }
       
        
        function selectSpot(e) { //method to change colour of selected spot
            
            var classes = e.target.className;            
            var book_btn = document.getElementById("book-btn");            
            var getClasses  = new Array();
            getClasses = classes.split(" ");
            
            if(getClasses.includes("not-booked")){
            if (classes.includes("spt") && !classes.includes("selected")) { //to select the box and change colour
                console.log(e.target.id+" selected.");    
                document.getElementById(e.target.id).classList.add("selected");                
                selected_spots.push(e.target.id.toString());                
                document.getElementById(e.target.id).style.backgroundColor = "#dcdcdd";                
                counter = counter + 1;
            }
            else if (classes.includes("selected")) { //to deselect the box and change color              
                console.log(e.target.id+" deselected.");
                document.getElementById(e.target.id).classList.remove("selected");
                document.getElementById(e.target.id).style.backgroundColor = "#dcdcdd2c";           
                selected_spots.splice(selected_spots.indexOf(e.target.id),1);
                counter = counter - 1;               
            }            
            
            console.log(selected_spots);
            
            if(counter != 0){
                book_btn.disabled = false;
                book_btn.classList.remove("disabled");
                book_btn.classList.remove("btn-outline-light");
                book_btn.classList.add("btn-light");   
            }
            if(counter == 0){ //disable the book button
                book_btn.disabled = true;
                book_btn.classList.add("disabled");
                book_btn.classList.add("btn-outline-light");
            }
        }
            
        } 
        function inflateSpots(){ //method to display spots based on the data from db.
            var spots = document.getElementById("spots");
            var total_spots = <%=total_spots%>;
            var col = document.createElement("div");
            var spots = document.getElementById("spt-group");
            <%for(int i = 0; i < total_spots;i++){%>
          
                var col = document.createElement("div");
                var spot = document.createElement("div");
                col.classList.add("col-2");
                spot.classList.add("spt");
                spot.classList.add("shadow");               
                spot.id = <%=pSpaces.at(i).at("ps_id")%>;
                col.appendChild(spot);
                spots.appendChild(col);
           <%}%>
        }
        function process_selected_spots(){
            $("input[id=selected-spt]").val(selected_spots);
            $("input[id=lotName]").val(<%=pData.at("pl_name").toString()%>);
            $("input[id=lotCity]").val(<%=pData.at("pl_city").toString()%>);
            document.getElementById("form-1").submit();           
            
        }
       
        
    </script>


</body>


<!--=========Discarded code=========--->
<!----function buten(e) {
        
                    var classes = e.target.className;
                    document.getElementById(e.target.id).classList.add("selected");
                    if (classes.includes("spt") && !classes.includes("selected")) {
                        counter = counter + 1;
                        document.getElementById(e.target.id).style.backgroundColor = "#dcdcdd";
                        document.getElementById(e.target.id).innerHTML = "<h1>" + counter + "</h1>";
                        a.classList.remove("disabled");
                        a.classList.remove("btn-outline-light");
                        a.classList.add("btn-light");
                    } else if (classes.includes("selected")) {
                        counter = counter - 1;
                        document.getElementById(e.target.id).classList.remove("selected");
        
                        document.getElementById(e.target.id).style.backgroundColor = "#dcdcdd2c";
                        document.getElementById(e.target.id).innerHTML = " ";
                    } else {
                        console.log("Error in selecting");
                    }
                    if (counter == 0) {
                        a.classList.add("disabled");
                        a.classList.add("btn-outline-light");
                    }
                    document.getElementById("selected-spt").innerHTML = counter + " Spots Selected";
        
                    console.log(a.classList.length);
        
                }--->