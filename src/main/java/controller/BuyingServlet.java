/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AccountDAO;
import dao.CardDAO;
import dao.ListBuyOfShopDAO;
import dao.ProductDAO;
import dao.TransactionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Product;

/**
 *
 * @author PC
 */
@WebServlet(name = "BuyingServlet", urlPatterns = {"/buying"})
public class BuyingServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BuyingServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BuyingServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession sess = request.getSession();
        Account account1 = (Account) sess.getAttribute("account");
        if (account1 == null) {
            response.sendRedirect("login");
            return;
        }
        ListBuyOfShopDAO l = new ListBuyOfShopDAO();
        //get data form home.jsp
        String supplier = request.getParameter("supplier");
        String menhGia = request.getParameter("denomination");
        String quantity = request.getParameter("quantity");
        //chuyen doi du lieu
        double giaThe = Double.parseDouble(menhGia);
        int soLuong = Integer.parseInt(quantity);
        //lay account dang nhap
        Account account = (Account) sess.getAttribute("account");
        //kiem tra tai khoan co du tien mua khong
        double total = (giaThe * soLuong);
        if (account.getMoney() < total) {
            request.setAttribute("suppliers", l.getAllSupplier());
            request.setAttribute("err", "You don't have enough money");
            request.getRequestDispatcher("shop.jsp").forward(request, response);
            return;
        }
        //tru tien cua tai khoan
        AccountDAO ad = new AccountDAO();
        ad.updateMoney(account.getUserName(), total, account.getMoney(),request);
        //lay product duoc mua
        ProductDAO p1 = new ProductDAO();
        Product product = p1.getProductIdBySupplier(supplier,giaThe);
        //thêm vào transaction table
        TransactionDAO ts = new TransactionDAO();
        ts.addTransaction(new Product(supplier, giaThe,
                soLuong, product.getId()),
                account.getUserName());
//        giảm số lượng thẻ trong product table 
//        và set status = 0 nếu số lượng về 0
        ProductDAO p = new ProductDAO();
        p.updateAmount(soLuong, product);
        //đánh dấu thẻ trong Card table (productId,transactionId)
        int transactionId = ts.getLastId();
        CardDAO cd = new CardDAO();
        cd.updateStatusCard(product.getId(), transactionId,
                product.getSellPrice(), soLuong);
        sess.setAttribute("account", account);
        //chuyen trang
        request.setAttribute("suppliers", l.getAllSupplier());
        request.setAttribute("err", "buy sucess");
        request.getRequestDispatcher("shop.jsp").forward(request, response);

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
