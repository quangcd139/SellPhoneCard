<%-- 
    Document   : accountmid.jsp
    Created on : Nov 1, 2022, 1:32:53 AM
    Author     : asus
--%>

<%-- Document : account Created on : Oct 30, 2022, 6:18:35 PM Author : asus --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/profile.css" rel="stylesheet">

        <style type="text/css"></style>

        <script>
            function validateForm() {
                var phonex = document.getElementById("phone").value;
                var regex = /^[0-9]+$/;

                if (!regex.test(phonex)) {
                    alert("Dữ liệu không được chứa chữ");
                    return false;
                }
                if (phonex.length !== 10) {
                    alert("So dien thoai phai chua 10 chu so");
                    return false;
                }
                return true;
            }

        </script>
    </head>

    <body>
        <div class="container-fluid">
            <div class="container rounded bg-white mt-5 mb-5">
                <form action="accountinfor" method="post" onsubmit="return validateForm()">
                    <div class="row">
                        <div class="col-md-3 border-right">
                            <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                                <img class="rounded-circle mt-5" width="150px" src="">
                                <div class="col-md-6"><label class="labels" style="text-align: center;">Url Image :</label><input type="text" class="form-control" name="imagex" placeholder="url image" value="">
                                </div>
                                <span class="font-weight-bold"></span>
                                <span class="text-black-50"></span><span> </span>

                            </div>

                        </div>

                        <div class="col-md-5 border-right">

                            <div class="p-3 py-5">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h4 class="text-right">Thông tin cá nhân</h4>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-md-6"><label class="labels">Tên đăng nhập :</label><input type="text" class="form-control" name="acc" readonly value="${sessionScope.account.userName}">
                                    </div>
                                    <div class="col-md-6"><label class="labels">Tên :</label><input type="text" class="form-control" name="name" value="${sessionScope.account.name}">
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <!--                                    <div class="col-md-12"><label class="labels">Age :</label><input type="text" class="form-control" name="agex" placeholder="age" value="" name="">
                                                                        </div>-->
                                    <div class="col-md-12"><label class="labels">Số điện thoại :</label><input type="text" class="form-control" name="phonex" id="phone" placeholder="phone number" value="${sessionScope.account.phone}">
                                    </div>
                                    <!--                                    <div class="col-md-12"><label class="labels">Address :</label><input type="text" class="form-control" name="addressx" placeholder="address" value="">
                                                                        </div>-->

                                </div>

                                <div>
                                    <div style="margin-top: 20px;">
                                        <h5 style="display: inline-block;">Tiền hiện có :</h5> 
                                        <h5 style="color: #ee4d2d;display: inline-block;"><s:formatNumber value="${sessionScope.account.money}" /></h5>
                                        <h5 style="margin-left: 5px;display: inline-block;">VND</h5>
                                    </div>
                                </div>
                                <div class="mt-5 text-center">
                                    <!--                                    <button class="btn btn-primary profile-button" type="button">-->
                                    <input type="submit" value="Lưu">

                                    <!--                                    </button>-->
                                </div>
                            </div>

                        </div>
                </form>
                <div class="col-md-4">
                    <form action="newPass?mode=1" method="post">
                        <div class="p-3 py-5">
                            <div class="d-flex justify-content-between align-items-center experience">
                                <h5>Thay đổi mật khẩu:</h5>
                            </div><br>
                            <div class="col-md-12"><label class="labels">Mật khẩu cũ : </label><input type="password" class="form-control" readonly name="passold" value="${sessionScope.account.password}">

                            </div> <br>
                            <div class="col-md-12"><label class="labels">Mật khẩu mới : </label><input type="text" class="form-control" placeholder="New pass" name="pass">

                            </div><br/>
                            <div class="col-md-12"><label class="labels">Nhập lại mật khẩu mới : </label><input type="text" class="form-control" placeholder="Re-new pass" name="rePass">

                            </div>

                        </div>
                        <label class="labels">${requestScope.succ}</label>
                        <div class="col-md-7" style="float: right;">
                            <input type="submit" value="Lưu">
                        </div>

                    </form>

                </div>
            </div>

        </div>
    </div>
    <script >
        window.onload = function () {
            var successMessage = '<%= request.getAttribute("err1")%>';
            if (successMessage && successMessage !== "null") {
                alert(successMessage);
            }
        };
    </script>
</body>

</html>
