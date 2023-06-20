<%-- 
    Document   : detailForm
    Created on : Jun 18, 2023, 6:41:32 PM
    Author     : PC
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Product" %>
<%@page import="java.util.List" %>
<%@page import="dao.ListBuyOfShopDAO" %>
<%@page import="com.google.gson.Gson" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css"/>
        <%
            ListBuyOfShopDAO l = new ListBuyOfShopDAO();
            List<Product> productList = l.getAllProduct();
        %>

        <script>
            // Define a global variable to hold the product data
            var productList = [];
            var p = {};
            // Function to process the product data
            function processProductData(data) {
                productList = data;
            }
            processProductData(<%= new Gson().toJson(productList)%>);
        </script>

    </head>
    <body>
        <style>
            /* CSS for the overlapping form container */
            #anotherFormContainer {
                position: fixed;
                top: 50%;
                left: 50%;
                width: 700px;

                transform: translate(-50%, -50%);
                background-color: rgba(255, 255, 255, 0.9);
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
                display: none;
                backdrop-filter: blur(8px);
                z-index: 9999;
            }

            /* CSS for the overlay */
            #overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                display: none;
                z-index: 9998;
            }
            .blur {
                filter: blur(5px); /* Adjust the blur amount as desired */
                pointer-events: none; /* Prevents the blurred content from receiving pointer events */
            }
        </style>

        <div id="overlay"></div>
        <div id="anotherFormContainer">
            <button style="float: right" id="closeButton" onclick="closeForm()"><i  class="bi bi-x-circle-fill"></i></button>
            <form action="buying" method="get">
                <h2>Detail information</h2>
                <label for="nhaMang">Nhà mạng:</label>
                <input type="text" id="nhaMang" name="supplier" readonly><br>

                <label for="menhGia">Mệnh giá:</label>
                <input type="text" id="menhGia" name="denomination" readonly><br>

                <label for="soLuong">Số lượng:</label>
                <input type="text" id="soLuong" name="quantity" readonly><br>

                <label for="mieuTa">Miêu tả:</label>

                <input type="text" id="mieuTa" value="" readonly><br>
                <label for="hetHan">Ngày hết hạn:</label> 
                <input type="text" id="hetHan" value="" readonly><br>

                <input type="submit" value="Buy">
            </form>
        </div>

        <script>

            function showAnotherForm() {
                var anotherFormContainer = document.getElementById("anotherFormContainer");
                anotherFormContainer.style.display = "block";
                var supplierInput = document.getElementById("supplier");
                var newSupplier = document.getElementById("nhaMang");
                newSupplier.value = supplierInput.value;

                var denominationInput = document.getElementById("denomination");
                var newDenomination = document.getElementById("menhGia");
                var supplierInputValue = supplierInput.value;
                newDenomination.value = denominationInput.value;

                var description;
                var expirationDate;
                for (var i = 0; i < productList.length; i++) {
                    var obj = productList[i];
                    for (var key in obj) {
                        var sellPrice = obj["sellPrice"];
                        var supplier = obj["supplier"];
                        if (sellPrice == denominationInput.value && supplier == supplierInputValue) {
                            description = obj["description"];
                            expirationDate = obj["expirationDate"];
                        }
                    }
                }

                var quantityInput = document.getElementById("quantity");
                var newQuantity = document.getElementById("soLuong");
                newQuantity.value = quantityInput.value;

                var description1 = document.getElementById("mieuTa");
                description1.value = description;
                var hetHan = document.getElementById("hetHan");
                hetHan.value = expirationDate;

            }
            function validateForm() {
                var selectedSupplier = document.getElementById('supplier').value;
                if (selectedSupplier === '') {
                    alert('Chọn nhà mạng trước khi submit.');
                    return false;
                }
                var selectedDenomination = document.getElementById('denomination').value;
                if (selectedDenomination === '') {
                    alert('Chọn mệnh giá trước khi submit.');
                    return false;
                }
                var quantity = document.getElementById('quantity').value;
                if (quantity === '') {
                    alert('Chọn số lượng trước khi submit.');
                    return false;
                }

                return true;
            }
            function checkStatus() {
                var supplierInput = document.getElementById("supplier").value;
                var denominationInput = document.getElementById("denomination").value;
                var quantityInput = document.getElementById("quantity").value;
                outerLoop:for (var i = 0; i < productList.length; i++) {
                    var obj = productList[i];
                    for (var key in obj) {
                        var sellPrice = obj["sellPrice"];
                        var supplier = obj["supplier"];
                        var expirationDate = obj["expirationDate"];
                        var amount = obj["amount"];
                        var status = obj["status"];
                        var check=false;
                        if (sellPrice == denominationInput && supplier == supplierInput) {
                            if (quantityInput >= amount) {
                                if (amount == 0) {
                                    alert("san pham het hang");
                                } else {
                                    alert("so luong hang trong kho chi con " + amount +
                                            "vui long nhap lai");
                                }
                                return false;
                            }
                            check=true;
                            break outerLoop;
                        }
                    }
                }
                if(check==false){
                    alert("san pham chua co trong kho");
                    return false;
                }
                return true;
            }
            function validateAndShowForm() {
                var checkStat = checkStatus();
                var isValid = validateForm();
                if (isValid && checkStat) {
                    showAnotherForm();
                }
                return isValid;
            }

            function closeForm() {
                var overlay = document.getElementById("overlay");
                var formContainer = document.getElementById("anotherFormContainer");
                overlay.style.display = "none";
                formContainer.style.display = "none";
            }



        </script>
    </body>
</html>
