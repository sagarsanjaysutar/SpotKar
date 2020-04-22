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
    <div class="container p-3">
        <div class="jumbotron jbt1 p-3 ">
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

        <div class="jumbotron jbt2 p-3 mt-5">
            <div class="pl-details">
                <h2><label>Where do you want to park today?</label></h2>
                <hr>
            </div>
            <form action="searching" method="post" id="select_form">
                <div class="row p-3 ">

                    <div class="col-12 d-flex justify-content-center align-content-center ">

                        <div class="form-group w-75 p-4 ">


                            <select class="form-control custom-select" id="exampleFormControlSelect1" name="location">

                            </select>
                        </div>

                    </div>
                </div>
            </form>

        </div>

        <div class="jumbotron jbt3 custom_footer p-3 mt-5">
            <div class="row">
                <div class="col-12 footer_contact">
                    <div class="footer_contact_content">
                        <strong class="h4">Contact Us</strong><br><br>
                        Email: sutarsagarsanjay@gmail.com <br>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <p class="copyright text-center" id="copyright">
        � Copyright 2020 SpotKar - All Rights Reserved
    </p>



    <script type="text/javascript" src="Design/js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="Design/js/popper.js"></script>
    <script type="text/javascript" src="Design/js/bootstrap.js"></script>
    <script>
        var city_name = new Array();
        var counter = 1;
        var select = document.getElementById("exampleFormControlSelect1");
        var option = document.createElement('option');
        option.disabled = true;
        option.selected = true;
        option.hidden = true;
        option.innerHTML = "Select location";
        select.appendChild(option);
        select.onchange = function () {
            $('#select_form').submit();
        };

        $(document).ready(function () {

            $('#select_form').click(function () {
                if (counter === 1) {
                    $.ajax({
                        type: "post",
                        url: "city_name",
                        contentType: 'application/json',
                        dataType: 'json',
                        success: function (res) {
                            for (i = 0; i < res.length; i++) {
                                city_name[i] = res[i];
                                console.log(city_name[i]);
                            }
                            inflate_values(city_name);
                        },
                        error: function (textStatus) {
                            console.log("" + textStatus);
                        }
                    });
                    counter = counter + 1;
                }
            });

        });

        function inflate_values(city_name) {
            for (i = select.options.length - 1; i > 1; i--) {
                select.options[i] = null;
            }
            for (i = 0; i < city_name.length; i++) {
                var option2 = document.createElement('option');
                option2.value = city_name[i];
                option2.innerHTML = city_name[i];
                option2.onclick = document.getElementById("select_form").submit;
                select.appendChild(option2);
            }
        }
    </script>
</body>

</html>