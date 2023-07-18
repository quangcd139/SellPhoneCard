/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.ProductDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;

public class EditServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        HttpSession session = request.getSession();
        session.setAttribute("id", id);
        session.setAttribute("name", name);
        session.setAttribute("description", description);

        // Chuyển hướng đến trang chỉnh sửa card
        response.sendRedirect("editProduct.jsp?id=" + id + "&name=" + name + "&description=" + description);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String newName = request.getParameter("name");
        String newDescription = request.getParameter("description");

        // Cập nhật dữ liệu trong cơ sở dữ liệu
        ProductDAO productDAO = new ProductDAO();
        boolean success = productDAO.updateCard(id, newName, newDescription);

        if (success) {
            // Chuyển hướng đến trang thành công
            
            response.sendRedirect("manageProduct");
        } else {
            response.setContentType("text/html;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Error</title>");
                out.println("</head>");
                out.println("<body>");
                out.println("<h1>Failed to update card.</h1>");
                out.println("</body>");
                out.println("</html>");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
