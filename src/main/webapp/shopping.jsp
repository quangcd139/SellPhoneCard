<%-- 
    Document   : shopping
    Created on : Oct 20, 2022, 5:23:16 AM
    Author     : asus
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!-- Favicon -->

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
        <link href="css/logoCard.css" rel="stylesheet">
        <script type="text/javascript">
            function selectSupplier(supplierId) {
                var supplierImages = document.querySelectorAll('.supplier-btns img');
                var selectedImage = document.getElementById(supplierId);
                // Remove 'selected' class from all images
                supplierImages.forEach(function (img) {
                    img.classList.remove('selected');
                });
                selectedImage.classList.add('selected');
                // Set the supplier value in the hidden input field
                document.getElementById('supplier').value = supplierId;
            }
        </script>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f2f2f2;
                padding: 20px;
            }

            h1 {
                color: #333;
            }

            form {
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .supplier-btns {
                margin-bottom: 10px;
            }

            .supplier-btns img {
                margin-right: 10px;
                width: 150px;
                height: 150px;
                border-radius: 4px;
                cursor: pointer;
            }

            .selected {
                border: 2px solid #4caf50;
            }

            label {
                display: block;
                margin-bottom: 10px;
                font-weight: bold;
            }

            button[type="submit"] {
                padding: 10px 20px;
                background-color: #4caf50;
                color: #fff;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <!-- Shop Start -->
        <div class="container-fluid">
            <div class="row px-xl-5">
                <!-- Shop Sidebar Start -->
                <div class="col-lg-3 col-md-4">
                    <!-- Price Start -->
                    <div class="bg-light p-4 mb-30">

                    </div>
                </div>
                <!-- Shop Sidebar End -->


                <!-- Shop Product Start -->
                <div class="col-lg-9 col-md-8">
                    <div class="row pb-3">
                        <div class="col-12 pb-1">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <div>
                                    <button class="btn btn-sm btn-light"><i class="fa fa-th-large"></i></button>
                                    <button class="btn btn-sm btn-light ml-2"><i class="fa fa-bars"></i></button>
                                </div>
                            </div>
                        </div>
                        <h3>Money: <fmt:formatNumber value="${sessionScope.account.money}" pattern="#,##0" /> VND</h3>


                        <div class="row px-xl-5 pb-3">

                            <c:forEach items="${suppliers}" var="s">
                                <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                                    <div class="d-flex align-items-center mb-4" style="padding: 30px;">
                                        <h1 class=" text-primary m-0 mr-3">
                                            <div class="supplier-btns">
                                                <img src="imageLogo/${s.image}" onclick="selectSupplier('${s.supplier}')"
                                                     id="${s.supplier}">
                                                <input type="hidden" id="supplier" name="supplier">
                                            </div>
                                        </h1>
                                    </div>
                                </div>
                            </c:forEach>
                            <center style="margin-left:250px;">
                                <%@include file="buyCard.jsp" %>
                                <button type="submit" onclick="return validateAndShowForm()">show detail</button><br><br>
                                <script>
                                    var err = <%=request.getAttribute("err")%>
                                    if (err !== null) {
                                        alert(err);
                                    }
                                </script>
                            </center>
                        </div>

                        <%@include file="detailForm.jsp"%>

                    </div>
                </div>
                <!-- Shop Product End -->
            </div>
        </div>
        <!-- Shop End -->

        <!-- Back to Top -->
        <a href="#" class="btn btn-primary back-to-top"><i class="fa fa-angle-double-up"></i></a>

        <script>
            window.onload = function () {
                var Message = '<%= request.getAttribute("notice")%>';
                var pId = '<%= request.getAttribute("pId")%>';
                var check = '<%= request.getAttribute("slHang")%>';
                if (Message !== "null") {
                    if (check !== "null" && check) {
                        alert(Message);
                    } else {
                        var confirmed = false;
                        setTimeout(function () {
                            confirmed = confirm(Message);
                            if (!confirmed) {
                                window.location.href = 'myhistorybill?id=' + pId;
                            }
                        }, 1500); // Delay of 2 seconds (2000 milliseconds)
                    }
                }
            };


        </script>

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Contact Javascript File -->
        <script src="mail/jqBootstrapValidation.min.js"></script>
        <script src="mail/contact.js"></script>

        <!-- Template Javascript -->
        <script src="js/main.js"></script>
    </body>

</html>