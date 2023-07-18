/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Account;
import model.Product;

/**
 *
 * @author dell
 */
@WebServlet(name = "AddNewProductServlet", urlPatterns = {"/addNewProduct"})
public class AddNewProductServlet extends HttpServlet {

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
            out.println("<title>Servlet AddNewProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddNewProductServlet at " + request.getContextPath() + "</h1>");
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
        ProductDAO pDAO = new ProductDAO();
        List<Product> list = new ArrayList<>();
        list = pDAO.getListProduct();
        request.setAttribute("myproc", list);
        request.getRequestDispatcher("addOneProduct.jsp").forward(request, response);
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
        
        HttpSession sess = request.getSession();
        Account account = (Account) sess.getAttribute("account");
        if(account==null){
            request.getRequestDispatcher("login/login.jsp").forward(request, response);
            return;
        }
        String productName = request.getParameter("proname");
        String t = request.getParameter("proprice");
        String supplier = request.getParameter("prosupplier");
        String tien = request.getParameter("proamount");
//        String expireDate = request.getParameter("proexpire");
        try {
            int amount = Integer.parseInt(tien);
            double sellPrice = Double.parseDouble(t);
//            Product product = new Product();
//
//            product.setAmount(amount);
//            product.setSellPrice(sellPrice);
//            product.setAccountId(account1.getUserName());
//            product.setSupplier(supplier);
//            product.setName(productName);
            ProductDAO pDAO = new ProductDAO();
            
            Product p = new Product();
            p.setSellPrice(sellPrice);
            p.setAmount(amount);
            p.setSupplier(supplier);
            p.setStatus(false);
//            p.setAccountId(account.getUserName());
            p.setName(productName);
            
            pDAO.insertProduct(p);

            List<Product> list = new ArrayList<>();
            list = pDAO.getListProduct();
            request.setAttribute("myproc", list);
            request.getRequestDispatcher("addOneProduct.jsp").forward(request, response);

        } catch (Exception e) {
        }
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
