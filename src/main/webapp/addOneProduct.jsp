



<%-- 
    Document   : dashboard
    Created on : Jun 18, 2023, 3:55:13 PM
    Author     : dell
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="en">

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
        <!-- CSS Just for demo purpose, don't include it in your project -->
        <link href="assets/css/demo.css" rel="stylesheet" />
        <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="Expires" content="0">

        <script>
            showNotification: function (from, align) {
                var type = ['success', 'info', 'warning', 'danger'];
                var color = Math.floor((Math.random() * 4) + 1);
                $.notify({
                    icon: "nc-icon nc-app",
                    message: "Welcome to <b>Sell card phone</b> - an online phone card sales system."
                }, {
                    type: type[color],
                    timer: 8000,
                    placement: {
                        from: from,
                        align: align
                    }
                });
                function logout() {
                    // Clearing the session attribute
                    session.removeAttribute("account");
                    // Redirecting to the login page
                    window.location.href = "logout";
                }
                $(document).ready(function () {
                    // Get the current page URL
                    var url = window.location.href;

                    // If the URL matches the dashboard link, add the "active" class to its <li> element

                });

        </script>
        <script>
                $(document).ready(function () {
                    $('#page-size').change(function () {
                        var page_size = $(this).val();
                        var current_url = window.location.href;

                        // Tạo một đối tượng FormData từ form hiện tại
                        var form_data = new FormData($('#my-form')[0]);

                        // Thêm giá trị limit mới vào FormData
                        form_data.append('sl', page_size);

                        // Sử dụng AJAX để gửi yêu cầu và nhận kết quả từ phía máy chủ
                        $.ajax({
                            url: current_url,
                            type: 'GET',
                            data: form_data,
                            processData: false,
                            contentType: false,
                            success: function (result) {
                                $('#content').html(result);
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                console.log(textStatus, errorThrown);
                            }
                        });
                    });
                });

        </script>
        <style>
            table {
                border-collapse: collapse;
            }

            th,
            td {
                padding: 10px;
                text-align: left;
                border: 1px solid #ddd;
            }

            th {
                background-color: #f2f2f2;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
        </style>
    </head>

    <body>
        <div class="wrapper">
            <div class="sidebar" data-image="assets/img/sidebar-5.jpg">
                <!--
            Tip 1: You can change the color of the sidebar using: data-color="purple | blue | green | orange | red"
    
            Tip 2: you can also add an image using data-image tag
                -->
                <div class="sidebar-wrapper">
                    <div class="logo">
                        <a href="" class="simple-text">
                            Admin sell card
                        </a>
                    </div>
                    <ul class="nav">
                        <li class="nav-item ">
                            <a class="nav-link" href="dashboard.jsp">
                                <i class="nc-icon nc-chart-pie-35"></i>
                                <p>Dashboard</p>
                            </a>
                        </li>
                        <li>
                            <a class="nav-link" href="manageProduct">
                                <i class="nc-icon nc-circle-09"></i>
                                <p>Manage Product</p>
                            </a>
                        </li>
                        <li>
                            <a class="nav-link" href="adminTransaction">
                                <i class="nc-icon nc-notes"></i>
                                <p>Transaction history</p>
                            </a>
                        </li>
                        <li>
                            <a class="nav-link" href="import.jsp">
                                <i class="nc-icon nc-bell-55"></i>
                                <p>Import excel file</p>
                            </a>
                        </li>
                        <li class="nav-item ">
                            <a class="nav-link" href="addNewProduct">
                                <i class="nc-icon nc-chart-pie-35"></i>
                                <p>Add Product</p>
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
                                    <a class="nav-link" href="accountinfor">
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
                <!-- End Navbar -->


                <!-- Content Start -->
                <div class="content">
                    <!-- Table Start -->
                    <div class="container-fluid pt-4 px-4">
                        <div class="row g-4">
                            <div class="col-12">
                                <div class="bg-light rounded h-100 p-4">
                                    <h6 class="mb-4">Add New</h6>
                                    <form action="addNewProduct" method="post" enctype="multipart/form-data">
                                        <table class="table table-bordered" style="width: 100%;">
                                            <thead>
                                                <tr>
                                                    <th scope="col">Product Name</th>
                                                    <th scope="col">Sell Price</th>
                                                    <th scope="col">Image</th>
                                                    <th scope="col">Supplier</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td><input type="text" name="pname" required maxlength="40"></td>
                                                    <td><input type="text" name="pprice" required></td>
                                                    <td><input type="file" name="imageFile" accept=".jpg, .png" required></td>
                                                    <td><input type="text" name="psupplier" required></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="7" align="right">
                                                        <input type="submit" style="background-color: #4bb3fc;" name="result" value="ADD">
                                                        <a href="manageProduct">
                                                            <div type="" style="background-color: #aec2d1;margin-top: 10px;color: black;width: 72px;text-align: center;">Cancel</div>
                                                        </a>
                                                    </td>
                                                </tr>

                                            </tbody>
                                        </table>
                                        <h4>${notice}</h4>
                                    </form>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="bg-light rounded h-100 p-3">
                                    <h6 class="mb-4">Product List</h6>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">Product Name</th>
                                                <th scope="col">Sell Price</th>
                                                <th scope="col">Image</th>
                                                <th scope="col">Supplier</th>
                                                <th scope="col">Expiration Date</th>

                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Table End -->
                </div>
                <!-- Content End -->


                <footer class="footer">
                    <div class="container-fluid">
                        <nav>
                            <ul class="footer-menu">
                                <li>
                                    <a href="#">
                                        Home
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        Company
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        Portfolio
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        Blog
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </footer>
            </div>
        </div>

    </body>
    <!--   Core JS Files   -->
    <script src="assets/js/core/jquery.3.2.1.min.js" type="text/javascript"></script>
    <script src="assets/js/core/popper.min.js" type="text/javascript"></script>
    <script src="assets/js/core/bootstrap.min.js" type="text/javascript"></script>
    <script src="assets/js/plugins/bootstrap-switch.js"></script>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
    <script src="assets/js/plugins/chartist.min.js"></script>
    <script src="assets/js/plugins/bootstrap-notify.js"></script>
    <script src="assets/js/light-bootstrap-dashboard.js" type="text/javascript"></script>
    <script src="assets/js/demo.js"></script>
    <script type="text/javascript">
            $(document).ready(function () {
                // Javascript method's body can be found in assets/js/demos.js
                demo.initDashboardPageCharts();

                demo.showNotification();

            });
    </script>
    <script>
            function showAnotherForm(event) {
                event.preventDefault(); // Prevent the default link behavior
                var id = $(event.target).data('id'); // Get the ID from the data attribute
                var url = 'detailHistory?id=' + id; // Construct the URL
                $.ajax({
                    url: url,
                    type: 'GET',
                    success: function (response) {
                        displayCards(response);
                        console.log(response);
                    },
                    error: function (xhr, status, error) {
                        // Handle any errors that occur during the AJAX request
                        console.error(error);
                    }
                });
                function displayCards(response) {
                    var anotherFormContainer = document.getElementById("anotherFormContainer");
                    anotherFormContainer.style.display = "block";
                    var product = response.product;
                    var listCard = response.listCard;
                    // Display product details

                    // Display card details
                    var table = $('#cardTable');
                    for (var i = 0; i < listCard.length; i++) {
                        var card = listCard[i];
                        var row = $('<tr></tr>');
                        row.append('<td>' + card.seri + '</td>');
                        row.append('<td>' + card.code + '</td>');
                        // Add more table cells for additional card properties
                        table.append(row);
                    }
                    $('#menhGia').text(product.sellPrice);
                    $('#nhaMang').text(product.supplier);
                    $('#date').text(product.expirationDate);
                }
            }

            function saveSelectedOption() {
                var select = document.getElementById('mySelect');
                var selectedOption = select.value;

                // Lưu giá trị vào local storage
                localStorage.setItem('selectedOption', selectedOption);
            }

            // Khôi phục giá trị lựa chọn từ local storage khi tải lại trang
            window.onload = function () {
                var select = document.getElementById('mySelect');
                var selectedOption = localStorage.getItem('selectedOption');

                if (selectedOption) {
                    select.value = selectedOption;
                }
            };
            function submitForm() {
                var form = document.getElementById('myForm');
                form.submit();
            }

    </script>

</html>

