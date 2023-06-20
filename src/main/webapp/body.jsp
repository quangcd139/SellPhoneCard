<%-- 
    Document   : header
    Created on : Oct 20, 2022, 4:45:17 AM
    Author     : asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Body Page</title>
        <link href="img/favicon.ico" rel="icon">

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
    </head>

    <body>
        <!-- Carousel Start -->
        <div class="container-fluid mb-3">
            <div class="row px-xl-5">
                <div class="col-lg-8">
                    <div id="header-carousel" class="carousel slide carousel-fade mb-30 mb-lg-0" data-ride="carousel">
                        <ol class="carousel-indicators">
                            <li data-target="#header-carousel" data-slide-to="0" class="active"></li>
                            <li data-target="#header-carousel" data-slide-to="1"></li>
                            <li data-target="#header-carousel" data-slide-to="2"></li>
                        </ol>
                        <div class="carousel-inner">
                            <div class="carousel-item position-relative active" style="height: 400px;">
                                <img class="position-absolute w-100 h-100" src="images/banner_index.jpg" style="object-fit: cover;">
                                <div class="carousel-caption d-flex flex-column align-items-center justify-content-center">
                                    <div class="p-3" style="max-width: 800px;">
                                        <h1 class="display-4 text-white mb-3 animate__animated animate__fadeInDown">Sell Phone Card</h1>
                                        <p class="mx-md-5 px-5 animate__animated animate__bounceIn">Chiết khấu cao dễ dàng, nhanh chóng, thuận tiện.</p>
                                        <a class="btn btn-outline-light py-2 px-4 mt-3 animate__animated animate__fadeInUp" href="shop">Shop Now</a>
                                    </div>
                                </div>
                            </div>
                            <div class="carousel-item position-relative" style="height: 400px;">
                                <img class="position-absolute w-100 h-80" src="images/chiet_khau2.png" style="object-fit: cover;">
                                <div class="carousel-caption d-flex flex-column align-items-center justify-content-center">
                                    <div class="p-3" style="max-width: 700px;">
                                        <h1 class="display-4 text-white mb-3 animate__animated animate__fadeInDown">Viettel</h1>
                                        <p class="mx-md-5 px-5 animate__animated animate__bounceIn">Hãy nói theo cách của bạn </p>
                                        <a class="btn btn-outline-light py-2 px-4 mt-3 animate__animated animate__fadeInUp" href="shop">Shop Now</a>
                                    </div>
                                </div>
                            </div>
                            <div class="carousel-item position-relative" style="height: 400px;">
                                <img class="position-absolute w-100 h-100" src="images/banner2.jpg" style="object-fit: cover;">
                                <div class="carousel-caption d-flex flex-column align-items-center justify-content-center">
                                    <div class="p-3" style="max-width: 800px;">
                                        <h1 class="display-4 text-white mb-3 animate__animated animate__fadeInDown">Vinaphone</h1>
                                        <p class="mx-md-5 px-5 animate__animated animate__bounceIn">Không ngừng vươn xa</p>
                                        <a class="btn btn-outline-light py-2 px-4 mt-3 animate__animated animate__fadeInUp" href="shop">Shop Now</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="product-offer mb-30" style="height: 187px;">
                        <img class="img-fluid" src="images/mua-the-dien-thoai-online-2.jpg" alt="">
                        <div class="offer-text">
                            <h6 class="text-white text-uppercase">Save 20%</h6>
                            <h3 class="text-white mb-3">Special Offer</h3>
                            <a href="" class="btn btn-primary">Shop Now</a>
                        </div>
                    </div>
                    <div class="product-offer mb-30" style="height: 187px;">
                        <img class="img-fluid" src="images/app-kiem-the-cao-1.jpg" alt="">
                        <div class="offer-text">
                            <h6 class="text-white text-uppercase">Save 20%</h6>
                            <h3 class="text-white mb-3">Special Offer</h3>
                            <a href="" class="btn btn-primary">Shop Now</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Carousel End -->


        <!-- Featured Start -->
        <div method="post" action="buying" id="myForm">
            <h1 style="text-align: center">Phone Card Order</h1>
            <h4>Số dư: ${sessionScope.account.money}</h4>
            <div class="container-fluid pt-5">
                <h3>Choose one supplier</h3>
                <div class="row px-xl-5 pb-3">

                    <c:forEach items="${suppliers}" var="s">
                        <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                            <div class="d-flex align-items-center bg-light mb-4" style="padding: 30px;">
                                <h1 class="fa fa-check text-primary m-0 mr-3">
                                    <div class="supplier-btns">
                                        <img src="imageLogo/${s.image}" onclick="selectSupplier('${s.supplier}')"
                                             id="${s.supplier}">
                                        <input type="hidden" id="supplier" name="supplier">
                                    </div>
                                </h1>
                            </div>
                        </div>
                    </c:forEach>

                </div>

                <center>
                    <%@include file="buyCard.jsp" %>
                    <button type="submit" onclick="return validateAndShowForm()">show detail</button><br><br>
                    <h3 id="err">${err}</h3>
                </center>
                <%@include file="detailForm.jsp"%>
                
            </div>
        </div>
        <!-- Featured End -->
        <br><br><br>
        <h2 class="section-title position-relative text-uppercase mx-xl-5 mb-4"><span class="bg-secondary pr-3">Featured Products</span></h2>
        <!-- Offer Start -->

        <div class="container-fluid pt-5 pb-3">
            <div class="row px-xl-5">
                <div class="col-md-6">
                    <div class="product-offer mb-30" style="height: 300px;">
                        <img class="img-fluid" src="images/mua-the-dien-thoai-online-2.jpg" alt="">
                        <div class="offer-text">
                            <h6 class="text-white text-uppercase">Save 20%</h6>
                            <h3 class="text-white mb-3">Special Offer</h3>
                            <a href="" class="btn btn-primary">Shop Now</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="product-offer mb-30" style="height: 300px;">
                        <img class="img-fluid" src="images/app-kiem-the-cao-1.jpg" alt="">
                        <div class="offer-text">
                            <h6 class="text-white text-uppercase">Save 20%</h6>
                            <h3 class="text-white mb-3">Special Offer</h3>
                            <a href="" class="btn btn-primary">Shop Now</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- Vendor Start -->
        <div class="container-fluid py-5">
            <div class="row px-xl-5">
                <div class="col">
                    <div class="owl-carousel vendor-carousel">
                        <div class="bg-light p-4" style="float: left;">
                            <img src="img/vendor-1.jpg" alt="">
                        </div>
                        <div class="bg-light p-4" style="float: left;">
                            <img src="img/vendor-2.jpg" alt="">
                        </div>
                        <div class="bg-light p-4" style="float: left;">
                            <img src="img/vendor-3.jpg" alt="">
                        </div>
                        <div class="bg-light p-4" style="float: left;">
                            <img src="img/vendor-4.jpg" alt="">
                        </div>
                        <div class="bg-light p-4" style="float: left;">
                            <img src="img/vendor-5.jpg" alt="">
                        </div>
                        <div class="bg-light p-4" style="float: left;">
                            <img src="img/vendor-6.jpg" alt="">
                        </div>
                        <div class="bg-light p-4" style="float: left;">
                            <img src="img/vendor-7.jpg" alt="">
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <!-- Vendor End -->
        <!--Back to top-->
        <a href="#" class="btn btn-primary back-to-top" style="display: inline;"><i class="fa fa-angle-double-up"></i></a>
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
