/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ListBuyOfShopDAO;
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
import model.Product;
import model.Transaction;

/**
 *
 * @author PC
 */
    @WebServlet(name = "AdminTransaction", urlPatterns = {"/adminTransaction"})
public class AdminTransaction extends HttpServlet {

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
            out.println("<title>Servlet AdminTransaction</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminTransaction at " + request.getContextPath() + "</h1>");
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
        List<String> prices = new ListBuyOfShopDAO().getAllPrice();
        List<Product> suppliers = new ListBuyOfShopDAO().getAllSupplier();
        int limit = 3;
        HttpSession sess = request.getSession();
        TransactionDAO pd = new TransactionDAO();
        if (slParam != null && !slParam.isEmpty()) {
            try {
                limit = Integer.parseInt(slParam);
                // lưu giá trị limit mới vào session của người dùng để sử dụng trong các yêu cầu tiếp theo
                sess.setAttribute("limit", limit);
            } catch (NumberFormatException e) {
                // giá trị của limit không hợp lệ, sử dụng giá trị lưu trong session hoặc giá trị mặc định
                Integer sessionLimit = (Integer) sess.getAttribute("limit");
                if (sessionLimit != null) {
                    limit = sessionLimit;
                }
            }
        } else {
            // nếu không có giá trị limit mới được gửi đến, sử dụng giá trị lưu trong session hoặc giá trị mặc định
            Integer sessionLimit = (Integer) sess.getAttribute("limit");
            if (sessionLimit != null) {
                limit = sessionLimit;
            }
        }

        int size = pd.getSizeTransaction();
        int soTrang = (size % limit == 0) ? (size / limit) : (size / limit + 1);

        // kiểm tra xem trang hiện tại có nằm ngoài phạm vi mới không, nếu có thì điều chỉnh lại giá trị của page
        int xpage = 1;
        try {
            xpage = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
        }
        int page = Math.min(soTrang, Math.max(1, xpage));
        page = Math.min(soTrang, Math.max(1, page));
        int offset = (page - 1) * limit;
        String accountName = request.getParameter("accountName")!=null?request.getParameter("accountName"):"";
        List<Transaction> list = getListByFilter(accountName, prices, suppliers, limit, offset, request);
        request.setAttribute("list", list);
        request.setAttribute("soTrang", soTrang);
        request.setAttribute("page", page);
        request.setAttribute("limit", limit);
        request.setAttribute("transactions", list);
        request.setAttribute("prices", prices);
        request.setAttribute("suppliers", suppliers);
        request.setAttribute("check", 3);
        
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

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    public List<Transaction> getListByFilter(String accountName, List<String> prices, List<Product> suppliers, int limit, int offset, HttpServletRequest request) {
        TransactionDAO td = new TransactionDAO();
        List<Transaction> list = new ArrayList<>();
        List<String> priceFilter = new ArrayList<>();
        List<Product> supplierFilter = new ArrayList<>();
        for (String p : prices) {
            if (request.getParameter(p) != null) {
                priceFilter.add(p);
            }
        }
        for (Product s : suppliers) {
            if (request.getParameter(s.getSupplier()) != null) {
                supplierFilter.add(s);
            }
        }
        if (priceFilter.size() == 0 && supplierFilter.size() == 0 && accountName.isEmpty()) {
            list = td.getAllTransaction(limit, offset);
        }else{
            request.setAttribute("selectedPrices", prices);
            request.setAttribute("selectedSuppliers", supplierFilter);
            request.setAttribute("accountName", accountName);
            list = td.getAllByAccountFilter(accountName, limit, offset,priceFilter,supplierFilter);
        }

        return list;
    }

}
