/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.AccountDAO;
import dao.ProductDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Hashing;
import model.Product;

/**
 *
 * @author Knagzaoh
 */
@WebServlet(name = "AccountTransferServlet", urlPatterns = {"/AccountTransferServlet"})
public class AccountTransferServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AccountTransferServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AccountTransferServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String slParam = request.getParameter("sl");
        int limit = 3; // Giá trị mặc định cho limit

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        if (account == null) {
            request.getRequestDispatcher("login/login.jsp").forward(request, response);
            return;
        }

        if (slParam != null && !slParam.isEmpty()) {
            try {
                limit = Integer.parseInt(slParam);
                // Lưu giá trị limit mới vào session của người dùng để sử dụng trong các yêu cầu tiếp theo
                session.setAttribute("limit", limit);
            } catch (NumberFormatException e) {
                // Giá trị của limit không hợp lệ, sử dụng giá trị lưu trong session hoặc giá trị mặc định
                Integer sessionLimit = (Integer) session.getAttribute("limit");
                if (sessionLimit != null) {
                    limit = sessionLimit;
                }
            }
        } else {
            // Nếu không có giá trị limit mới được gửi đến, sử dụng giá trị lưu trong session hoặc giá trị mặc định
            Integer sessionLimit = (Integer) session.getAttribute("limit");
            if (sessionLimit != null) {
                limit = sessionLimit;
            }
        }

        AccountDAO ad = new AccountDAO();
        int size = ad.getAccountCount();
        int soTrang = (size % limit == 0) ? (size / limit) : (size / limit + 1);

        // Kiểm tra xem trang hiện tại có nằm ngoài phạm vi mới không, nếu có thì điều chỉnh lại giá trị của page
        int xpage = 1;
        try {
            xpage = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
        }
        int page = Math.min(soTrang, Math.max(1, xpage));
        page = Math.min(soTrang, Math.max(1, page));
        int offset = (page - 1) * limit;

        List<Account> list = ad.getAllAccount(limit, offset);
        request.setAttribute("list", list);
        request.setAttribute("soTrang", soTrang);
        request.setAttribute("limit", limit);
        request.setAttribute("page", page);
        request.setAttribute("check", 4);

        request.getRequestDispatcher("dashboard.jsp").forward(request, response);

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String fromAccount = request.getParameter("fromAccount");
            String toAccount = request.getParameter("toAccount");
            double amount = Double.parseDouble(request.getParameter("amount"));
            String type = request.getParameter("type");
//            String description = request.getParameter("description");           
            AccountDAO dao = new AccountDAO();
            double money = dao.getMoney(toAccount);
            if (type.equals("0")) {
                if (money < amount) {
                    request.getSession().setAttribute("transferFail", false);
                    response.sendRedirect("AccountTransferServlet");
                    return;
                }
            }
            // transfer money
            dao.transferMoney(fromAccount, toAccount, amount, type);
            // redirect to history transfer 
            request.getSession().setAttribute("transferSuccess", true);
            response.sendRedirect("AccountTransferServlet");
            // in ra thong bao
            PrintWriter out = response.getWriter();
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Transfer money successfully');");
        } catch (Exception e) {
            System.out.println("doPost: " + e.getMessage());
            response.sendRedirect("AccountTransferServlet");
        }
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
