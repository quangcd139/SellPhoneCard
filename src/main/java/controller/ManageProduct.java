/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ListBuyOfShopDAO;
import dao.ProductDAO;
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
@WebServlet(name = "ManageProduct", urlPatterns = {"/manageProduct"})
public class ManageProduct extends HttpServlet {

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
            out.println("<title>Servlet manageProduct</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet manageProduct at " + request.getContextPath() + "</h1>");
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
        List<String> prices = new ListBuyOfShopDAO().getAllPrice();
        List<Product> suppliers = new ListBuyOfShopDAO().getAllSupplier();
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

        ProductDAO pd = new ProductDAO();
        int size = pd.getProductCount();
        int soTrang = (size % limit == 0) ? (size / limit) : (size / limit + 1);

        // Kiểm tra xem trang hiện tại có nằm ngoài phạm vi mới không, nếu có thì điều chỉnh lại giá trị của page
        int xpage = 1;
        try {
            xpage = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
        }
        int page = Math.min(soTrang, Math.max(1, xpage));
        
        page = Math.min(soTrang, Math.max(1, page));
        if(page==0){
            page=1;
        }
        int offset = (page - 1) * limit;//-3
        
        List<Product> list = getListByFilter(limit, offset, request, prices, suppliers);
        request.setAttribute("list", list);
        request.setAttribute("prices", prices);
        request.setAttribute("suppliers", suppliers);
        request.setAttribute("soTrang", soTrang);
        request.setAttribute("limit", limit);
        request.setAttribute("page", page);
        request.setAttribute("check", 2);
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
        processRequest(request, response);
    }

    public List<Product> getListByFilter(int limit, int offset, HttpServletRequest request,
            List<String> prices, List<Product> suppliers) {
        List<Product> list = new ArrayList<>();
        ProductDAO td = new ProductDAO();
        List<String> priceFilter = new ArrayList<>();
        List<String> supplierFilter = new ArrayList<>();
        for (String p : prices) {
            if (request.getParameter(p) != null) {
                priceFilter.add(p);
            }
        }
        for (Product s : suppliers) {
            if (request.getParameter(s.getSupplier()) != null) {
                supplierFilter.add(s.getSupplier());
            }
        }
        String name = request.getParameter("pName") != null ? request.getParameter("pName") : "";
        if (priceFilter.size() == 0 && supplierFilter.size() == 0 && name.isEmpty()) {
            list = td.getAllProducts(limit, offset);
        } else {
            list = td.getListFilterProduct(priceFilter, supplierFilter, name, limit, offset);
        }
        request.setAttribute("selectedPrices", priceFilter);
        request.setAttribute("selectedSuppliers", supplierFilter);
        request.setAttribute("name", name);
        return list;
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
