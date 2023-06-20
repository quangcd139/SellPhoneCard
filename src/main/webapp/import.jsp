<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Import Excel</title>
</head>
<body>
    <h1>Import Excel</h1>
     
    <form action="UploadFile" method="post" enctype="multipart/form-data" >
       File to Upload: <input type="file" name="file" accept=".xlsx, .xls">
        <input type="submit" value="Import">
    </form>
    
    <p style="color: red;">tên file có dạng (Tên nhà mạng)_(mệnh giá)</p>
</body>
</html>