/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.util.List;
import dao.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Card;

/**
 *
 * @author nguye
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
@WebServlet(name = "UploadFile", urlPatterns = {"/UploadFile"})

public class UploadFile extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    // Api to upload file
    // Method: POST
    // Path: /upload
    // Form data:
    // - description: String
    // - file: File ( can be multiple )
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //get sellPrice,supplier
        String supplier = request.getParameter("supplier");
        String sellPrice_raw = request.getParameter("menhGia");

        //check admin choose new supplier or price
        if (!request.getParameter("newSupplier").isEmpty()) {
            supplier = request.getParameter("newSupplier").toLowerCase();
        }
        if (!request.getParameter("customMenhGia").isEmpty()) {
            sellPrice_raw = request.getParameter("customMenhGia").replace(",", "");
        }
        double sellPrice = Double.parseDouble(sellPrice_raw);
        //get file excel name
        String appPath = request.getServletContext().getRealPath("");
        appPath = appPath.replace('\\', '/');
        List<String> fileUrls = UploadHelper.upload(request, supplier);
        if (fileUrls.size() == 0) {
            request.setAttribute("err1", "Sai file import");
        } else {
            //import card
            CardDAO cd = new CardDAO();
            //index = 0 là file ảnh
            String imageName = "";
            int index = 0;
            if (fileUrls.size() == 2) {
                //index = 1 là file excel
                imageName = fileUrls.get(0);
                index = 1;
            }
            List<Card> listErr = cd.ImportExcel(appPath + fileUrls.get(index),
                    sellPrice, supplier, imageName);
            //response list seri error
            if (listErr.size() == 0) {
                request.setAttribute("err", "sucess");
            } else {
                request.setAttribute("listErr", listErr);
            }
        }

        //chuyen trang
        ListBuyOfShopDAO lb = new ListBuyOfShopDAO();
        request.setAttribute("suppliers", lb.getAllSupplier());
        request.setAttribute("prices", lb.getAllPrice());
        request.getRequestDispatcher("import.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
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
        processRequest(request, response);
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
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
