<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">

        <!--Icon Font Stylesheet--> 
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!--     Libraries Stylesheet 
        -->    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style1.css" rel="stylesheet">
        <style>
            .btn {
                background-color: #4CAF50; /* Màu nền của nút */
                border: none; /* Không có đường viền */
                color: white; /* Màu chữ trên nút */
                padding: 10px 20px; /* Kích thước của nút */
                text-align: center; /* Căn giữa văn bản trong nút */
                text-decoration: none;
                display: inline-block;
                font-size: 16px; /* Kích thước chữ trên nút */
                margin: 4px 2px; /* Khoảng cách giữa các nút */
                cursor: pointer; /* Hiển thị con trỏ tay khi di chuột vào nút */
            }

            .btn:hover {
                background-color: #3e8e41; /* Màu nền của nút khi di chuột vào */
            }

        </style>
        <style>
            #formOverlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                display: flex;
                justify-content: center;
                align-items: center;
            }

            #formContainer {
                background-color: #fff;
                padding: 20px;
                position: relative; /* Add this property */
            }

            #closeButton {
                position: absolute;
                top: 10px;
                right: 10px;
                cursor: pointer;
                font-size: 24px; /* Add this property */
            }
            /* Add this CSS to hide the checkbox inputs */
        </style>
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


        </script>
    </head>

    <body>
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
        <%@include file="header.jsp" %>
        <div class="container-xxl position-relative bg-white d-flex p-0">

            <form id="form1" action="myhistorybill" method="get" style="margin-left: 100px;">
                <h5>Lọc theo mệnh giá mua</h5>
                <div class="custom-control custom-checkbox align-items-center justify-content-between mb-3">
                    <input type="checkbox" value="Tất cả giá">Tất cả giá
                    <br>
                    <c:forEach items="${prices}" var="p">
                        <input type="checkbox" id="${p}" name="${p}" value="${p}">${p}<br>
                    </c:forEach>
                </div>
                <h5>Lọc theo ngày mua</h5>
                <div class="custom-control custom-checkbox align-items-center justify-content-between mb-3">
                    <input type="checkbox" class="custom-control-input" checked id="price-all">
                    <label class="custom-control-label" for="price-all">Tất cả ngày</label>

                </div>
                <h5>Lọc theo nhà mạng</h5>
                <div class="custom-control custom-checkbox align-items-center justify-content-between mb-3">
                    <input type="checkbox">Tất cả nhà mạng

                    <c:forEach items="${suppliers}" var="p">
                        <br><input type="checkbox" id="${p.supplier}" name="${p.supplier}" value="${p.supplier}">${p.supplier}
                    </c:forEach>
                </div>
                <input type="submit" value="Lọc">
            </form>

            <!-- Content Start -->
            <div class="content" style="margin-left: 120px;">

                <!-- Table Start -->
                <div class="container-fluid pt-4 px-4">
                    <div class="row g-4">

                        <div class="col-12">
                            <div class="bg-light rounded h-100 p-4">
                                <h6 class="mb-4">My All Bill Have ${requestScope.sizemybill} bills</h6>
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">STT</th>
                                                <th scope="col">Mệnh giá</th>
                                                <th scope="col">Số lượng</th>
                                                <th scope="col">Ngày mua</th>
                                                <th scope="col">Nhà mạng</th>
                                                <th scope="col">Description</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${requestScope.list}" var="db">
                                                <tr>
                                                    <td>${db.id}</td>
                                                    <td>${db.buyPrice}</td>
                                                    <td>${db.buyAmount}</td>
                                                    <td>${db.createdAt}</td>
                                                    <td>${db.description}</td>
                                                    <td><a class="btn btn-primary detail-link" data-id="${db.id}" href="#" onclick="showAnotherForm(event)">Xem chi tiết</a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <%@include file="historyDetailForm.jsp" %>
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
                                        <input type="text" id="page-number" name="page" value="${page}" onkeydown="handlePageNumber(event)">
                                        <span>/</span>
                                        <span>${soTrang}</span>
                                        <input type="hidden" name="sl" value="${limit}">
                                        <a class="${i == page ? 'active' : ''}" href="myhistorybill?page=${i}">${i}</a>
                                    </form>
                                    <!--                                        <input type="submit" value="Áp dụng">-->
                                    <!--<button type="button" >Submit</button>-->

                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <div id="formOverlay">
                <div id="formContainer">
                    <span id="closeButton" onclick="closeForm()">&times;</span>

                    <form action="/your-action-url" method="POST">
                        <c:if test="${status != null}">
                            <c:if test="${status > 0}">
                                <p>Thẻ đã mua thành công</p>
                                <p>${product.supplier}</p>
                                <p>${product.sellPrice}</p>
                                <p>${product.amount}</p>
                                <p>${product.expirationDate}</p>
                                <table style="width: 500px">
                                    <tr>
                                        <th>Seri</th>
                                        <th>Code</th>
                                    </tr>
                                    <c:forEach items="${listCard}" var="c">
                                        <tr>
                                        <td>${c.seri}</td>
                                        <td>${c.code}</td>
                                        </tr>
                                    </c:forEach>
                                </table>

                            </c:if>
                            <c:if test="${status == 0}">
                                <p>Mua thẻ không thành công do hết hàng</p>
                            </c:if>
                        </c:if>

                        <!-- Other form elements or inputs can be added here -->

                    </form>
                </div>
            </div>
        </div>
        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
        <script>
            function closeForm() {
                document.getElementById("formOverlay").style.display = "none";
                function closeForm() {
                    document.getElementById("formOverlay139").style.display = "none";
                    var checkboxes = document.querySelectorAll("#formContainer input[type='checkbox']");
                    checkboxes.forEach(function (checkbox) {
                        checkbox.style.display = "block";
                    });
                }
            }
        </script>
        <%@include file="footer.jsp" %>
        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/chart/chart.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="lib/tempusdominus/js/moment.min.js"></script>
        <script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
        <script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <!-- Template Javascript -->
        <script src="js/main.js"></script>
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

        </script>
    </body>
</html>
