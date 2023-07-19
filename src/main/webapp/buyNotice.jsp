<%-- 
    Document   : buyNotice
    Created on : Jul 19, 2023, 1:57:19 PM
    Author     : caoqu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your JSP Page</title>
    <style>
        /* CSS to overlay the form */
        .overlay1 {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent background */
            display: none; /* Hide initially */
            z-index: 9999; /* Make sure it's on top of other elements */
        }

        .overlay-form1 {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            width: 300px;
            border-radius: 5px;
        }

        .close-button1 {
            position: absolute;
            top: 10px;
            right: 10px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="overlay1" id="overlay1">
        <div class="overlay-form">
            <span class="close-button1" onclick="closeOverlay()">X</span> <!-- Close button -->
            <!-- Your form fields and data here -->
            <form>
                quang
            </form>
        </div>
    </div>

    <!-- JavaScript to show/hide the overlay and handle close button click -->
    <script>
        function closeOverlay() {
            var overlay = document.getElementById("overlay1");
            overlay.style.display = "none"; // Hide the overlay
        }

        window.onload = function() {
            var overlay = document.getElementById("overlay1");
            var Message = '<%= request.getAttribute("status")%>';
            <%-- Check if xValue is not empty --%>
            if (Message) {
                overlay.style.display = "block"; // Show the overlay
            }
        };
    </script>
</body>
</html>

