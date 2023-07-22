<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Chỉnh sửa Products</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ccc;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        td.highlight {
            background-color: #009688;
        }

        input[type="text"], button[type="submit"] {
            padding: 8px;
            border: none;
            border-radius: 4px;
        }

        button[type="submit"] {
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h2>Bảng chỉnh sửa card</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Action</th>
        </tr>
        <tr>
            <td><%=request.getParameter("id")%></td>
            <td>
                <form action="edit" method="POST">
                    <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
                    <input type="text" name="name" value="<%=request.getParameter("name")%>">
            </td>
            <td>
                    <textarea id="id" name="description" rows="5" cols="25"><%=request.getParameter("description")%></textarea>
            </td>
            <td>
                    <button type="submit">Update</button>
                </form>
            </td>
        </tr>
        <!--Thêm các hàng (rows) khác tại đây-->
    </table>

</body>
</html>
