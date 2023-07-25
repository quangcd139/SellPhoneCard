<%-- 
    Document   : dashboard
    Created on : Jun 18, 2023, 3:55:13 PM
    Author     : dell
--%>

<%@page import="model.Product"%>
<%@page import="model.Card"%>
<%@page import="java.util.List"%>
<%@page import="model.CustomResponse"%>
<%@page import="com.google.gson.Gson"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
            .form-container {
                /*max-width: 300px;*/
                margin: 0 auto;
                border: 2px solid #ccc;
                padding: 10px;
                margin-bottom: 20px;
                border-radius: 10px;
            }

            h5 {
                margin-top: 10px;
                margin-bottom: 5px
            }

            .custom-control {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 10px;
            }

            .custom-checkbox input[type="checkbox"] {
                margin-right: 5px;
            }

            .custom-checkbox label {
                margin-left: 5px;
            }

            .custom-checkbox input[type="text"] {
                width: 100%;
                padding: 5px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            input[type="submit"] {
                display: block;
                width: 100%;
                padding: 10px;
                background-color: #009688;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            input[typesubmit"]:hover {
            background-color: #45a049;
            }
        </style>
    </head>

    <body>
        <%-- Check if the transfer was successful and display the success message --%>
        <% boolean transferSuccess = Boolean.TRUE.equals(session.getAttribute("transferSuccess"));
            boolean transferFail = Boolean.FALSE.equals(session.getAttribute("transferFail"));
        %>
        <% if (transferSuccess) { %>
        <script type="text/javascript">
                alert("Transfer money successfully!");
        </script>
        <%-- Clear the session attribute to prevent showing the message on subsequent requests --%>
        <% session.removeAttribute("transferSuccess"); %>
        <%}else if(transferFail){%>
        <script type="text/javascript">
                alert("Transfer money failed");
        </script> 
        <% session.removeAttribute("transferFail"); %>
        <%}%>
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
                            <a class="nav-link" href="historyTranfer">
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


                <div class="content">
                    <c:if test="${check==4}">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th scope="col">Tên tài khoản</th>
                                    <th scope="col">Email</th>
                                    <th scope="col">Số điện thoại</th>
                                    <th scope="col">Tiền</th>
                                    <th scope="col">Ngày tạo</th>
                                    <th scope="col">Trạng thái</th>
                                    <th scope="col">Hành động</th>
                                    <th scope="col">Cấm</th>
                                    <th scope="col">Gỡ cấm</th>

                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${list}" var="user">
                                    <tr>
                                        <td scope="row">${user.userName}</td>
                                        <td>${user.email}</td>
                                        <td>${user.phone}</td>
                                        <td>${user.money}
                                        <td>${user.createdAt}</td>
                                        <td>${user.isActive()}</td>
                                        <td>
                                            <button class="btn btn-success"><a href="history_transfer.jsp?account=${user.userName}" >Cộng/trừ tiền</a></button>
                                        </td>
                                        <td>
                                            <button class="btn btn-success"><a href="ban?account=${user.userName}&ban=0" >Cấm</a></button>
                                        </td>
                                        <td><button class="btn btn-success"><a href="ban?account=${user.userName}&ban=1" >Gỡ cấm</a></button></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <form method="GET" id="pageSizeForm" onchange="submitForm()">
                            <label for="page-size">Hiển thị:</label>
                            <select id="page-size" name="sl">
                                <option value="3" ${limit == 3 ? 'selected' : ''}>3</option>
                                <option value="5" ${limit == 5 ? 'selected' : ''}>5</option>
                                <option value="10" ${limit == 10 ? 'selected' : ''}>10</option>
                            </select>
                        </form>


                        <form method="GET" id="pageNumberForm" onchange="submitForm()">
                            <label for="page-number">Trang:</label>
                            <input type="text" id="page-number" name="page" value="${page}" oninput="handlePageNumber(event)">
                            <span>/</span>
                            <span>${soTrang}</span>
                            <input type="hidden" name="sl" value="${limit}">

                            <a class="${i == page ? 'active' : ''}" href="AccountTransferServlet?page=${i}">${i}</a>


                        </form>
                    </c:if>

                    <c:if test="${check==5}">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th scope="col">Id</th>
                                    <th scope="col">Từ tài khoản</th>
                                    <th scope="col">Tới tài khoản</th>
                                    <th scope="col">Tiền</th>
                                    <th scope="col">Ngày tạo</th>
                                    <th scope="col">Loại giao dịch</th>

                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${list}" var="user">
                                    <tr>
                                        <td scope="row">${user.id}</td>
                                        <td>${user.fromAccount}</td>
                                        <td>${user.toAccount}</td>
                                        <td>${user.amount}
                                        <td>${user.createdAt}</td>
                                        <c:if test="${user.transactionType==true}">
                                            <td>+</td>
                                        </c:if>
                                        <c:if test="${user.transactionType==false}">
                                            <td>-</td>
                                        </c:if>

                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <form method="GET" id="pageSizeForm" onchange="submitForm()">
                            <label for="page-size">Hiển thị:</label>
                            <select id="page-size" name="sl">
                                <option value="3" ${limit == 3 ? 'selected' : ''}>3</option>
                                <option value="5" ${limit == 5 ? 'selected' : ''}>5</option>
                                <option value="10" ${limit == 10 ? 'selected' : ''}>10</option>
                            </select>
                        </form>



                        <form method="GET" id="pageNumberForm" onchange="submitForm()">
                            <label for="page-number">Trang:</label>
                            <input type="text" id="page-number" name="page" value="${page}" oninput="handlePageNumber(event)">
                            <span>/</span>
                            <span>${soTrang}</span>
                            <input type="hidden" name="sl" value="${limit}">

                            <a class="${i == page ? 'active' : ''}" href="AccountTransferServlet?page=${i}">${i}</a>


                        </form>
                    </c:if>

                    <c:if test="${check==2}">
                        <div class="form-container">
                            <form action="manageProduct" method="get">
                                <h5>Lọc theo mệnh giá mua</h5>
                                <hr  width="100%" align="center" />
                                <div class="custom-control custom-checkbox align-items-center justify-content-between mb-3">
                                    <input type="checkbox" value="Tất cả giá" checked>Tất cả giá
                                    <c:forEach items="${prices}" var="p">
                                        <input type="checkbox" id="${p}" name="${p}" value="${p}" 
                                               <c:if test="${selectedPrices.contains(p)}">checked</c:if>
                                                   >
                                               <label for="${p}">${p}</label>
                                    </c:forEach>

                                </div>
                                <h5>Lọc theo nhà mạng</h5>
                                <hr  width="100%" align="center" />
                                <div class="custom-control custom-checkbox align-items-center justify-content-between mb-3">
                                    <input type="checkbox" value="Tất cả giá" checked>Tất cả nhà mạng
                                    <c:forEach items="${suppliers}" var="p">
                                        <br>
                                        <input type="checkbox" id="${p.supplier}" name="${p.supplier}" value="${p.supplier}" 
                                               <c:if test="${selectedSuppliers.contains(p.supplier)}">checked</c:if>
                                                   >
                                               <label for="${p.supplier}">${p.supplier}</label>
                                    </c:forEach>
                                </div>

                                <h5>Lọc theo tên sản phẩm</h5>
                                <div class="custom-control custom-checkbox align-items-center justify-content-between mb-3">
                                    <input type="text" name="pName" value="${name}">

                                </div>
                                <input type="submit" value="Lọc">
                            </form>
                        </div>
                        <table border="1">
                            <th>STT</th>
                            <th>Tên</th>
                            <th>Mệnh giá</th>
                            <th>Số lượng</th>
                            <th>Nhà mạng</th>
                            <th>Mô tả</th>
                            <th>Ngày bắt đầu bán</th>
                            <th>Xem chi tiết</th>
                            <th>Chỉnh sửa </th>
                                <c:forEach items="${list}" var="p">
                                <tr>
                                    <td>${p.id}</td>
                                    <td>${p.name}</td>
                                    <td><fmt:formatNumber value="${p.sellPrice}" pattern="#,##0" /></td>
                                    <td>${p.amount}</td>
                                    <td>${p.supplier}</td>
                                    <td>${p.description}</td>
                                    <td>${p.createdAt}</td>
                                    <td><a href="editProduct.jsp?id=${p.id}&name=${p.name}&description=${p.description}">Chỉnh sửa</a></td>
                                </tr>
                            </c:forEach>
                        </table>
                        <form method="GET" id="pageSizeForm" onchange="submitForm()">
                            <label for="page-size">Hiển thị:</label>
                            <select id="page-size" name="sl">
                                <option value="3" ${limit == 3 ? 'selected' : ''}>3</option>
                                <option value="5" ${limit == 5 ? 'selected' : ''}>5</option>
                                <option value="10" ${limit == 10 ? 'selected' : ''}>10</option>
                            </select>
                        </form>
                        <form method="GET" id="pageNumberForm" onchange="submitForm()">
                            <label for="page-number">Trang:</label>
                            <input type="text" id="page-number" name="page" value="${page}" oninput="return handlePageNumber(event)">
                            <span>/</span>
                            <span>${soTrang}</span>
                            <input type="hidden" name="sl" value="${limit}">

                            <a class="${i == page ? 'active' : ''}" href="manageProduct?page=${i}">${i}</a><br>
                            <!--<a href="addOneProduct.jsp">Thêm sản phẩm </a>-->

                        </c:if>
                        <c:if test="${check==3}">
                            <div class="form-container">
                                <form action="adminTransaction" method="get">
                                    <h5>Lọc theo mệnh giá mua</h5>
                                    <hr  width="100%" align="center" />

                                    <div class="custom-control custom-checkbox align-items-center justify-content-between mb-3">
                                        <input type="checkbox" value="Tất cả giá" checked>Tất cả giá
                                        <c:forEach items="${prices}" var="p">
                                            <input type="checkbox" id="${p}" name="${p}" value="${p}">${p}
                                        </c:forEach>
                                    </div>
                                    <h5>Lọc theo nhà mạng</h5>
                                    <hr  width="100%" align="center" />

                                    <div class="custom-control custom-checkbox align-items-center justify-content-between mb-3">
                                        <input type="checkbox" checked>Tất cả nhà mạng

                                        <c:forEach items="${suppliers}" var="p">
                                            <br><input type="checkbox" id="${p.supplier}" name="${p.supplier}" value="${p.supplier}">${p.supplier}
                                        </c:forEach>
                                    </div>

                                    <h5>Lọc tên tài khoản</h5>
                                    <div class="custom-control custom-checkbox align-items-center justify-content-between mb-3">
                                        <input type="text" name="accountName" value="${accountName}">

                                    </div>
                                    <input type="submit" value="Lọc">
                                </form>
                            </div>

                            <table border="1">
                                <th>id</th>
                                <th>buyPrice</th>
                                <th>buyAmount</th>
                                <th>createdAt</th>
                                <th>description</th>
                                <th>accountId</th>
                                <th>Details</th>
                                    <c:forEach items="${transactions}" var="p">
                                    <tr>
                                        <td>${p.id}</td>
                                        <td>${p.buyPrice}</td>
                                        <td>${p.buyAmount}</td>
                                        <td>${p.createdAt}</td>
                                        <td>${p.description}</td>
                                        <td>${p.accountId}</td>
                                        <td><a class="btn btn-primary detail-link" data-id="${p.id}" href="#" onclick="showAnotherForm(event)">Xem chi tiết</a></td>

                                    </tr>
                                </c:forEach>           
                            </table>
                            <form method="GET" id="pageSizeForm" onchange="submitForm()">
                                <label for="page-size">Hiển thị:</label>
                                <select id="page-size" name="sl">
                                    <option value="3" ${limit == 3 ? 'selected' : ''}>3</option>
                                    <option value="5" ${limit == 5 ? 'selected' : ''}>5</option>
                                    <option value="10" ${limit == 10 ? 'selected' : ''}>10</option>
                                </select>
                            </form>



                            <form method="GET" id="pageNumberForm" onchange="submitForm()">
                                <label for="page-number">Trang:</label>
                                <input type="text" id="page-number" name="page" value="${page}" oninput="handlePageNumber(event)">
                                <span>/</span>
                                <span>${soTrang}</span>
                                <input type="hidden" name="sl" value="${limit}">

                                <a class="${i == page ? 'active' : ''}" href="adminTransaction?page=${i}">${i}</a>


                            </form>
                            <%@include file="historyDetailForm.jsp" %>
                        </c:if>

                        <c:if test="${check==1}">
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="card ">
                                            <div class="card-header ">
                                                <h4 class="card-title">Email Statistics</h4>
                                                <p class="card-category">Last Campaign Performance</p>
                                            </div>
                                            <div class="card-body ">
                                                <div id="chartPreferences" class="ct-chart ct-perfect-fourth"></div>
                                                <div class="legend">
                                                    <i class="fa fa-circle text-info"></i> Open
                                                    <i class="fa fa-circle text-danger"></i> Bounce
                                                    <i class="fa fa-circle text-warning"></i> Unsubscribe
                                                </div>
                                                <hr>
                                                <div class="stats">
                                                    <i class="fa fa-clock-o"></i> Campaign sent 2 days ago
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="card ">
                                            <div class="card-header ">
                                                <h4 class="card-title">Users Behavior</h4>
                                                <p class="card-category">24 Hours performance</p>
                                            </div>
                                            <div class="card-body ">
                                                <div id="chartHours" class="ct-chart"></div>
                                            </div>
                                            <div class="card-footer ">
                                                <div class="legend">
                                                    <i class="fa fa-circle text-info"></i> Open
                                                    <i class="fa fa-circle text-danger"></i> Click
                                                    <i class="fa fa-circle text-warning"></i> Click Second Time
                                                </div>
                                                <hr>
                                                <div class="stats">
                                                    <i class="fa fa-history"></i> Updated 3 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="card ">
                                            <div class="card-header ">
                                                <h4 class="card-title">2023 Sale Card</h4>
                                                <p class="card-category">All products </p>
                                            </div>
                                            <div class="card-body ">
                                                <div id="chartActivity" class="ct-chart"></div>
                                            </div>
                                            <div class="card-footer ">
                                                <div class="legend">
                                                    <i class="fa fa-circle text-info"></i> Viettel
                                                    <i class="fa fa-circle text-danger"></i> Mobiphone
                                                </div>
                                                <hr>
                                                <div class="stats">
                                                    <i class="fa fa-check"></i> Data information certified
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="card  card-tasks">
                                            <div class="card-header ">
                                                <h4 class="card-title">Tasks</h4>
                                                <p class="card-category">Backend development</p>
                                            </div>
                                            <div class="card-body ">
                                                <div class="table-full-width">
                                                    <table class="table">
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    <div class="form-check">
                                                                        <label class="form-check-label">
                                                                            <input class="form-check-input" type="checkbox" value="">
                                                                            <span class="form-check-sign"></span>
                                                                        </label>
                                                                    </div>
                                                                </td>
                                                                <td>Sign contract for "What are conference organizers afraid of?"</td>
                                                                <td class="td-actions text-right">
                                                                    <button type="button" rel="tooltip" title="Edit Task" class="btn btn-info btn-simple btn-link">
                                                                        <i class="fa fa-edit"></i>
                                                                    </button>
                                                                    <button type="button" rel="tooltip" title="Remove" class="btn btn-danger btn-simple btn-link">
                                                                        <i class="fa fa-times"></i>
                                                                    </button>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <div class="form-check">
                                                                        <label class="form-check-label">
                                                                            <input class="form-check-input" type="checkbox" value="" checked>
                                                                            <span class="form-check-sign"></span>
                                                                        </label>
                                                                    </div>
                                                                </td>
                                                                <td>Lines From Great Russian Literature? Or E-mails From My Boss?</td>
                                                                <td class="td-actions text-right">
                                                                    <button type="button" rel="tooltip" title="Edit Task" class="btn btn-info btn-simple btn-link">
                                                                        <i class="fa fa-edit"></i>
                                                                    </button>
                                                                    <button type="button" rel="tooltip" title="Remove" class="btn btn-danger btn-simple btn-link">
                                                                        <i class="fa fa-times"></i>
                                                                    </button>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <div class="form-check">
                                                                        <label class="form-check-label">
                                                                            <input class="form-check-input" type="checkbox" value="" checked>
                                                                            <span class="form-check-sign"></span>
                                                                        </label>
                                                                    </div>
                                                                </td>
                                                                <td>Flooded: One year later, assessing what was lost and what was found when a ravaging rain swept through metro Detroit
                                                                </td>
                                                                <td class="td-actions text-right">
                                                                    <button type="button" rel="tooltip" title="Edit Task" class="btn btn-info btn-simple btn-link">
                                                                        <i class="fa fa-edit"></i>
                                                                    </button>
                                                                    <button type="button" rel="tooltip" title="Remove" class="btn btn-danger btn-simple btn-link">
                                                                        <i class="fa fa-times"></i>
                                                                    </button>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <div class="form-check">
                                                                        <label class="form-check-label">
                                                                            <input class="form-check-input" type="checkbox" checked>
                                                                            <span class="form-check-sign"></span>
                                                                        </label>
                                                                    </div>
                                                                </td>
                                                                <td>Create 4 Invisible User Experiences you Never Knew About</td>
                                                                <td class="td-actions text-right">
                                                                    <button type="button" rel="tooltip" title="Edit Task" class="btn btn-info btn-simple btn-link">
                                                                        <i class="fa fa-edit"></i>
                                                                    </button>
                                                                    <button type="button" rel="tooltip" title="Remove" class="btn btn-danger btn-simple btn-link">
                                                                        <i class="fa fa-times"></i>
                                                                    </button>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <div class="form-check">
                                                                        <label class="form-check-label">
                                                                            <input class="form-check-input" type="checkbox" value="">
                                                                            <span class="form-check-sign"></span>
                                                                        </label>
                                                                    </div>
                                                                </td>
                                                                <td>Read "Following makes Medium better"</td>
                                                                <td class="td-actions text-right">
                                                                    <button type="button" rel="tooltip" title="Edit Task" class="btn btn-info btn-simple btn-link">
                                                                        <i class="fa fa-edit"></i>
                                                                    </button>
                                                                    <button type="button" rel="tooltip" title="Remove" class="btn btn-danger btn-simple btn-link">
                                                                        <i class="fa fa-times"></i>
                                                                    </button>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <div class="form-check">
                                                                        <label class="form-check-label">
                                                                            <input class="form-check-input" type="checkbox" value="" disabled>
                                                                            <span class="form-check-sign"></span>
                                                                        </label>
                                                                    </div>
                                                                </td>
                                                                <td>Unfollow 5 enemies from twitter</td>
                                                                <td class="td-actions text-right">
                                                                    <button type="button" rel="tooltip" title="Edit Task" class="btn btn-info btn-simple btn-link">
                                                                        <i class="fa fa-edit"></i>
                                                                    </button>
                                                                    <button type="button" rel="tooltip" title="Remove" class="btn btn-danger btn-simple btn-link">
                                                                        <i class="fa fa-times"></i>
                                                                    </button>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <div class="card-footer ">
                                                <hr>
                                                <div class="stats">
                                                    <i class="now-ui-icons loader_refresh spin"></i> Updated 3 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                </div>
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

            if (pageNumberValue) {
                document.getElementById("page-number").value = pageNumberValue;
            }

            function submitForm() {
                document.getElementById("pageSizeForm").submit();
                document.getElementById("pageNumberForm").submit;
                localStorage.setItem('pageNumber', pageNumber);
            }

            if (pageNumberValue1) {
                document.getElementById("page-number1").value = pageNumberValue1;
            }
            function submitForm1() {
                document.getElementById("pageSizeForm1").submit();
                document.getElementById("pageNumberForm1").submit;
                localStorage.setItem('pageNumber1', pageNumber1);
            }



            function handlePageNumber(event) {
                const pageNumberInput = document.getElementById('page-number');
                let pageNumber = parseInt(pageNumberInput.value);
                const maxPage = parseInt('${soTrang}');

                if (isNaN(pageNumber) || pageNumber < 1) {
                    pageNumber = 1;
                } else if (pageNumber > maxPage) {
                    pageNumber = maxPage;
                }

                pageNumberInput.value = pageNumber;
            }
            ;

            function handlePageNumber1(event) {
                const pageNumberInput1 = document.getElementById('page-number1');
                let pageNumber1 = parseInt(pageNumberInput1.value);
                const maxPage = parseInt('${soTrang}');

                if (isNaN(pageNumber1) || pageNumber1 < 1) {
                    pageNumber1 = 1;
                } else if (pageNumber1 > maxPage) {
                    pageNumber1 = maxPage;
                }

                pageNumberInput1.value = pageNumber1;
            }


    </script>

</html>

