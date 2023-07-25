
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="model.Card"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page isELIgnored="false" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
        <link rel="icon" type="image/png" href="assets/img/favicon.ico">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title>Admin</title>
        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
        <!--     Fonts and icons     -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
        <!-- CSS Files -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" />
        <link href="assets/css/light-bootstrap-dashboard.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/gson/2.8.8/gson.min.js"></script>
        <!-- CSS Just for demo purpose, don't include it in your project -->
        <link href="assets/css/demo.css" rel="stylesheet" />
        <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="Expires" content="0">
        <style>
            .header{
                background-color: #009688;
                height: 70px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 25px;
                color: #fff;
                margin-bottom: 20px;

            }
            body {
                /*background:url(images/ExcelForBusiness_WEB_1600x900.jpg) no-repeat;*/
                /*                background-attachment:fixed;
                                background-position:center;
                                background-size:cover;
                                -webkit-background-size:cover;
                                -moz-background-size:cover;
                                -o-background-size:cover;
                                font-family: Arial, sans-serif;
                                z-index: 9999;*/
                z-index: 9999;

            }
            h2 {

                text-align: center;

            }

            form {

                margin-top: 150px;
                margin-left: auto;
                margin-right: auto;
                width: 50%;
                border: 2px solid #ccc;

                padding-bottom: 10px;
                border-radius: 5px;
                background-color: #fff;
            }

            input[type="file"] {
                display: block;
                margin: 10px 0;
            }

            p {
                color: #fff;
                text-align: center;
            }
            .submit{
                background-color: #009688;
                border: none;
                color: #fff;
                width: 15%;
                font-size: 14px;
                text-transform: uppercase;
                padding: 10px;
            }
            .submit :hover {
                cursor: pointer;
                opacity: 0.9;
            }
            .network{
                padding: 0 20px;
            }
            .modal {
                display: none;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 50%;
                height: 100%;
                overflow: auto;
            }

            .modal-content {
                background-color: white;
                margin: 0 auto;
                padding: 20px;
                border: 1px solid #888;
                width: 80%;
                max-width: 500px; /* adjust the maximum width as needed */
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                max-height: 80vh; /* set a maximum height for the modal content */
                overflow-y: auto; /* enable vertical scrolling */
            }

            .close {
                color: black;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }

        </style>
        <%
            List<Card> cardList = new ArrayList<Card>();
            if (request.getAttribute("listErr") != null) {
                cardList = (List<Card>) request.getAttribute("listErr");
            }
        %>

    </head>
    <body>
        <script>
            // Define a global variable to hold the product data
            var cardList = [];
            var c = {};
            var x = "null";
            var x1 = "";
            // Function to process the product data
            function processProductData(data) {
                cardList = data;
                if ('<%=request.getAttribute("err")%>' !== "null") {
                    x = "Thẻ đã được thêm <a href='manageProduct'>tại đây</a>";
                    x1 = "Import thành công";
                }
                if ('<%=request.getAttribute("err1")%>' !== "null") {
                    x = "file không đúng định dạng";
                    x1 = "Import Thất bại";
                }

                if (cardList.length != 0) {
                    x1 = "Import thất bại</br></br>Vui lòng kiểm tra lại các seri này";
                    x = "";
                    for (var i = 0; i < cardList.length; i++) {
                        var obj = cardList[i];
                        var seri = obj.seri; // Access the "seri" property of the object
                        x = x + seri + "</br>";
                    }
                }
            }
            processProductData(<%= new Gson().toJson(cardList)%>);
        </script>

        <script>
            window.onload = function () {
                if (x !== "null") {
                    document.getElementById("seriErr").innerHTML = x1;
                    document.getElementById("errorContent").innerHTML = x;
                    // Show the modal
                    var modal = document.getElementById("errorModal");
                    modal.style.display = "block";

                    // Close the modal when the user clicks on the close button
                    var closeButton = document.getElementsByClassName("close")[0];
                    closeButton.onclick = function () {
                        modal.style.display = "none";
                    };
                }

            };
        </script>

        <div id="errorModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <h3 id="seriErr"></h3>
                <p style="color: black;" id="errorContent"></p>
            </div>
        </div>

        <div class="wrapper">
            <div class="sidebar" data-image="assets/img/sidebar-5.jpg">
                <!--
            Tip 1: You can change the color of the sidebar using: data-color="purple | blue | green | orange | red"
    
            Tip 2: you can also add an image using data-image tag
                -->
                <div class="sidebar-wrapper">
                    <div class="logo">
                        <a href="" class="simple-text">
                            Quản trị thẻ
                        </a>
                    </div>
                    <ul class="nav">
                        <li class="nav-item ">
                            <a class="nav-link" href="dashboard.jsp">
                                <i class="nc-icon nc-chart-pie-35"></i>
                                <p>Trang chủ</p>
                            </a>
                        </li>
                        <li>
                            <a class="nav-link" href="manageProduct">
                                <i class="nc-icon nc-circle-09"></i>
                                <p>Quản lý sản phẩm</p>
                            </a>
                        </li>
                        <li>
                            <a class="nav-link" href="adminTransaction">
                                <i class="nc-icon nc-notes"></i>
                                <p>Lịch sử mua hàng</p>
                            </a>
                        </li>

                        <li>
                            <a class="nav-link" href="AccountTransferServlet">
                                <i class="nc-icon nc-bell-55"></i>
                                <p>Quản lý tài khoản</p>
                            </a>
                        </li>
                        
                        <li>
                            <a class="nav-link" href="importServlet">
                                <i class="nc-icon nc-bell-55"></i>
                                <p>Lịch sử giao dịch</p>
                            </a>
                        </li>
                        
                        <li>
                            <a class="nav-link" href="importServlet">
                                <i class="nc-icon nc-bell-55"></i>
                                <p>Thêm thẻ từ file excel</p>
                            </a>
                        </li>

                    </ul>
                </div>
            </div>
            <div class="main-panel">
                <!-- Navbar -->
                <nav class="navbar navbar-expand-lg " color-on-scroll="500">
                    <div class="container-fluid">
                        <a class="navbar-brand" href="dashboard.jsp"> Admin </a>
                        <button href="" class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-bar burger-lines"></span>
                            <span class="navbar-toggler-bar burger-lines"></span>
                            <span class="navbar-toggler-bar burger-lines"></span>
                        </button>
                        <div class="collapse navbar-collapse justify-content-end" id="navigation">
                            <ul class="nav navbar-nav mr-auto">
                                <li class="nav-item">
                                    <a href="#" class="nav-link" data-toggle="dropdown">
                                        <i class="nc-icon nc-palette"></i>
                                        <span class="d-lg-none">Dashboard</span>
                                    </a>
                                </li>
                                <li class="dropdown nav-item">
                                    <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
                                        <i class="nc-icon nc-planet"></i>
                                        <span class="notification">5</span>
                                        <span class="d-lg-none">Notification</span>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <a class="dropdown-item" href="#">Notification 1</a>
                                        <a class="dropdown-item" href="#">Notification 2</a>
                                        <a class="dropdown-item" href="#">Notification 3</a>
                                        <a class="dropdown-item" href="#">Notification 4</a>
                                        <a class="dropdown-item" href="#">Another notification</a>
                                    </ul>
                                </li>
                                <li class="nav-item">
                                    <a href="#" class="nav-link">
                                        <i class="nc-icon nc-zoom-split"></i>
                                        <span class="d-lg-block">&nbsp;Search</span>
                                    </a>
                                </li>
                            </ul>
                            <ul class="navbar-nav ml-auto">
                                <li class="nav-item">
                                    <a class="nav-link" href="#pablo">
                                        <span class="no-icon">Account</span>
                                    </a>
                                </li>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="http://example.com" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <span class="no-icon">Dropdown</span>
                                    </a>
                                    <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                        <a class="dropdown-item" href="#">Action</a>
                                        <a class="dropdown-item" href="#">Another action</a>
                                        <a class="dropdown-item" href="#">Something</a>
                                        <a class="dropdown-item" href="#">Something else here</a>
                                        <div class="divider"></div>
                                        <a class="dropdown-item" href="#">Separated link</a>
                                    </div>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="login">
                                        <span class="no-icon">Log out</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
                <div>
                    <div class="myform">
                        <form action="UploadFile" method="post" enctype="multipart/form-data" onsubmit="return validateForm()" >
                            <header class="header">
                                <h2>Import Excel</h2>
                            </header>
                            <div class="network">
                                Chọn nhà mạng:
                                <select name="supplier" id="supplierSelect" onchange="handleSelectChange('supplierSelect', 'newSupplierInput', 'imageInput')">
                                    <c:forEach items="${suppliers}" var="p">
                                        <option value="${p.supplier}" data-image="${p.image}">${p.supplier}</option>
                                    </c:forEach>
                                    <option value="other">Nhà mạng khác</option>
                                </select>
                                <input type="text" name="newSupplier" id="newSupplierInput" placeholder="Nhà mạng khác" style="display: none;">
                                <input type="file" name="image" id="imageInput" style="display: none;" accept=".png, .jpg">
                                <img id="selectedImage" src="" alt="Selected Image" style="display: none; max-width: 100px; max-height: 100px;">
                                <br/><br/>
                                Chọn mệnh giá
                                <select name="menhGia" id="menhGiaSelect" onchange="handleSelectChange('menhGiaSelect', 'customMenhGiaInput')">
                                    <fmt:setLocale value="en_US" />
                                    <c:forEach items="${prices}" var="p">
                                        <option value="${p}">
                                            <fmt:formatNumber value="${p}" pattern="#,##0" /> VND
                                        </option>
                                    </c:forEach>

                                    <option value="other">Số tiền khác</option>
                                </select>
                                <input type="text" name="customMenhGia" id="customMenhGiaInput" placeholder="Nhập số tiền khác" style="display: none;">

                                <br/><br/>

                                File to Upload: <input type="file" name="file" accept=".xlsx, .xls" required="">
                                <input class="submit" type="submit" value="Import">

                                <h4 style="color: red;">${fileErr}</h4>
                            </div>

                        </form>
                    </div>
                </div>
            </div>



        </div>
        <script>
            function handleSelectChange(selectId, inputId, imageInputId) {
                var selectElement = document.getElementById(selectId);
                var inputElement = document.getElementById(inputId);
                var imageInputElement = document.getElementById(imageInputId);
                var selectedImageElement = document.getElementById("selectedImage");

                var selectedValue = selectElement.value;

                if (selectedValue === "other") {
                    inputElement.style.display = "inline-block";
                    inputElement.setAttribute("required", "required");
                    imageInputElement.setAttribute("required", "required");
                    imageInputElement.style.display = "inline-block";
//                    selectedImageElement.style.display = "inline-block";

                } else {
                    inputElement.style.display = "none";
                    inputElement.removeAttribute("required");
                    imageInputElement.style.display = "none";
//                    selectedImageElement.style.display = "none";

                    var selectedOption = selectElement.options[selectElement.selectedIndex];
                    var selectedImage = selectedOption.getAttribute("data-image");
                    selectedImageElement.src = selectedImage;
                }
            }

            function validateForm() {
                var price = document.getElementById("customMenhGiaInput").value;
                var regex = /^\d{1,3}(,\d{3})*$/;

                if (price.trim() === "") {
                    return true; // Trả về true nếu không có giá trị nhập vào
                }

                if (!regex.test(price)) {
                    alert("Nhập mệnh giá theo format xxx,xxx");
                    return false;
                }
                return true;
            }
        </script>
    </body>
</html>