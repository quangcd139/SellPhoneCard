<%-- 
    Document   : historyDetailForm
    Created on : Jun 23, 2023, 4:35:26 AM
    Author     : PC
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <script>
            function showAnotherForm(event) {

                event.preventDefault(); // Prevent the default link behavior
                var id = $(event.target).data('id'); // Get the ID from the data attribute
                var url = 'detailHistory?detailId=' + id; // Construct the URL
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

                    var originalDate = listCard[0].expirationDate;
                    var parsedDate = new Date(originalDate);

// Formatting the date using Intl.DateTimeFormat
                    var formattedDate = new Intl.DateTimeFormat('en', {day: '2-digit', month: '2-digit', year: 'numeric'}).format(parsedDate);

                    $('#date').text(formattedDate);
                }

            }
        </script>
        <style>
            .blur {
                filter: blur(5px); /* Adjust the blur amount as desired */
                pointer-events: none; /* Prevents the blurred content from receiving pointer events */
            }
            #anotherFormContainer {
                background: #fff;
                width: 900px;
                max-width: calc(100%-32px);
                min-height: 250px;
                position: fixed;
                top: 20%;
                right: 0;
                left: 20%;
                bottom: 0;
                transform: translateY(-100px);
                animation: modalFadeIn ease 0.5s;
                display: none;
                z-index: 9999;
            }
            header.modal-header {
                background-color: #009688;
                height: 70px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 30px;
                color: #fff;
            }
            .modal-close {
                background-color: #009688;
                border: none;
                padding: 16px;
                position: absolute;
                right: 0;
                top: 0;
                color: #fff;
                /*padding: 16px;*/
                cursor: pointer;
                opacity: 0.9;
            }
            .modal-close :hover {
                opacity: 0.8;
            }
            .modal-close i {
                font-size: 15px;
                color:#fff;
            }
            .modal-body {
                padding: 16px;
            }
            .modal-label {
                display: block;
                font-size: 14px;
                margin-bottom: 5px;
            }
            .modal-input {
                border: 1px solid #ccc;
                width: 100%;
                padding: 10px;
                font-size: 14px;
                margin-bottom: 5px;
            }
            .submit{
                background-color: #009688;
                border: none;
                color: #fff;
                width: 100%;
                font-size: 14px;
                text-transform: uppercase;
                padding: 18px;
            }
            .submit :hover {
                cursor: pointer;
                opacity: 0.9;
            }
            table {
                border-collapse: collapse;
                width: 100%;
                margin-top: 40px;
                table-layout: fixed;
                overflow: hidden;
                white-space: nowrap;
            }

            th {
                background-color: #009688;
                color: white;
                font-weight: bold;
                font-size: 16px;
                text-align: center;
                padding: 8px;
                border: 1px solid #ddd;
            }

            td {
                text-align: center;
                padding: 10px;
                border: 1px solid #ddd;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
        </style>

        <div id="overlay"></div>
        <div id="anotherFormContainer">
            <button class="modal-close js-modal-close" onclick="closeForm()">
                <i class="bi bi-x"></i>
            </button>
            <header class="modal-header">
                <i class="modal-heading-icon ti-bag"></i>
                Sell Phone Card
            </header>
            <div class="modal-body" style="overflow-y: scroll;height:500px">
                <form action="buying" method="get">
                    <h1>History Buy</h1>
                    Menh gia
                    <p id="menhGia"></p>
                    Nha mang
                    <p id="nhaMang"></p>
                    Ngày hết hạn cua thẻ
                    <p id="date"></p>
                    <table id="cardTable">
                        <thead>
                            <tr>
                                <td>Card seri</td>
                                <td>Card code</td>
                            </tr>
                            <!--                                                        <tr id="data">
                                                                                    </tr>-->
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </form>
            </div>
        </div>
        <script>
            function closeForm() {
                clearTable();
                var overlay = document.getElementById("overlay");
                var formContainer = document.getElementById("anotherFormContainer");
                overlay.style.display = "none";
                formContainer.style.display = "none";
            }

            function clearTable() {
                var table = document.getElementById("cardTable");
                var rows = table.getElementsByTagName("tr");
                for (var i = 0; i < rows.length; i++) {
                    var cells1 = rows[i].getElementsByTagName("tr");
                    var cells = rows[i].getElementsByTagName("td");
                    for (var j = 0; j < cells.length; j++) {
                        cells[j].textContent = ""; // Clear the text content of each cell
                    }
//                        cells1[i].textContent = "";
                }
            }
        </script>
    </body>
</html>
