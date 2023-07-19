/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import jakarta.servlet.http.Part;
import java.io.File;

/**
 *
 * @author dell
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)

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
    private static final String UPLOAD_DIRECTORY = "imageLogo"; // Thư mục lưu trữ ảnh tải lên

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String productName = request.getParameter("pname");
        String t = request.getParameter("pprice");
        String supplier = request.getParameter("psupplier");

        String expireDate = request.getParameter("proexpire");
        try {
            double sellPrice = Double.parseDouble(t);
            ProductDAO pDAO = new ProductDAO();
            Product p = new Product();
            p.setSellPrice(sellPrice);
            p.setSupplier(supplier);
            p.setStatus(false);
            p.setName(productName);

            List<Product> list = new ArrayList<>();
            list = pDAO.getListProduct();
            request.setAttribute("myproc", list);
            String uploadPath = getServletContext().getRealPath("") + UPLOAD_DIRECTORY;
            File uploadDir = new File(uploadPath);
            if (uploadDir.exists()) {
                uploadDir.mkdir();
            }
            Part part = request.getPart("imageFile");
            String fileName = part.getSubmittedFileName();
            
            String appPath = request.getServletContext().getRealPath("");
            appPath = appPath.replace('\\', '/');
            int size = fileName.length();
            fileName = supplier + "_logo." + fileName.substring(size - 3, size);
            String filePath = appPath + "imageLogo/" + fileName;
            part.write(filePath);
            System.out.println(filePath);
            System.out.println(fileName);
            // Tên tệp duy nhất kèm theo dấu thời gian
            
            String imageLink = request.getContextPath() + "/" + UPLOAD_DIRECTORY + "/" + fileName;
            p.setImage(fileName);
            pDAO.insertProduct(p);

            request.setAttribute("notice", "Thêm sản phẩm thành công");
            request.getRequestDispatcher("addOneProduct.jsp").forward(request, response);

        } catch (Exception e) {
            System.out.println(e.fillInStackTrace());
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
