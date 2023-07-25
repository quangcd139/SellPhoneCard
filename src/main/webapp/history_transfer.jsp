<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="dao.AccountDAO" %>
<%@ page import="model.Account" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Transfer Money</title>
    </head>
    <body>
        <h1>Transfer Money</h1>

        <form action="AccountTransferServlet" method="post">
            <label for="fromAccount">Từ tài khoản</label>
            <select name="fromAccount" id="fromAccount">
                <%
                    AccountDAO accountDAO = new AccountDAO();
                    List<Account> adminAccounts = accountDAO.getAccountByRole(1);
                    for (Account account : adminAccounts) {
                %>
                <option value="<%= account.getUserName()%>"><%= account.getUserName()%></option>
                <% }%>


            </select>

            <br><br>

            Tới tài khoản <input type="type" name="toAccount" value="<%=request.getParameter("account")%>" readonly>
            <br><br>
            Loại giao dịch: 
            <select name="type">
                <!--<option value="all">Loại giao địch</option>-->
                <option value="1">Cộng tiền</option>
                <option value="0">Trừ tiền</option>
            </select>
            <br><br>

            <label for="amount">Amount:</label>
            <input type="number" name="amount" id="amount" required max="10000000" min="0">

            <br><br>

            <input type="submit" value="Transfer">
        </form>
    </body>
</html>