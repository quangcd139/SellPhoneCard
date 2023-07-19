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
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import model.Account;
import model.Transaction;

/**
 *
 * @author PC
 */
@WebServlet(name = "BuyingServlet", urlPatterns = {"/buying"})
public class BuyingServlet extends HttpServlet {

    private final static ExecutorService executor = Executors.newSingleThreadExecutor();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("shop").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sess = request.getSession();
        Account account = (Account) sess.getAttribute("account");
        if (account == null) {
            request.getRequestDispatcher("login/login.jsp").forward(request, response);
            return;
        }

        ListBuyOfShopDAO l = new ListBuyOfShopDAO();
        //get data form home.jsp
        String supplier = request.getParameter("supplier");
        String menhGia = request.getParameter("denomination");
        String quantity = request.getParameter("quantity");
        String productId = request.getParameter("id");
        //chuyen doi du lieu
        double giaThe = Double.parseDouble(menhGia);
        int soLuongMua = Integer.parseInt(quantity);
        //kiem tra tai khoan co du tien mua khong
        double total = (giaThe * soLuongMua);
        double money = new AccountDAO().getMoney(account.getUserName());
        if (money < total) {
            request.setAttribute("suppliers", l.getAllSupplier());
            request.setAttribute("listPrice", l.getAllPrice());
            request.setAttribute("err", "You don't have enough money");
            request.getRequestDispatcher("shop.jsp").forward(request, response);
            return;
        }

        Transaction t1 = Transaction.builder()
                .accountId(account.getUserName())
                .buyPrice(giaThe)
                .buyAmount(soLuongMua)
                .productId(Integer.parseInt(productId))
                .status(false)
                .build();

        new TransactionDAO().addTransaction(t1);
        executor.execute(new OrderProcessor());
        //chuyen trang
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().println("Buy request has been added to the queue.");
        //lay tien hien tai cua tai khoan
        account.setMoney(new AccountDAO().getMoney(account.getUserName()));
        // Lên lịch trả kết quả cho người dùng sau 5 giây
        request.setAttribute("notice", "Đơn hàng hiện đang được xử lý bấm ok để xem chi tiết");
        request.setAttribute("suppliers", l.getAllSupplier());
        request.setAttribute("pId", productId);
        request.setAttribute("listPrice", l.getAllPrice());
        request.getRequestDispatcher("shop.jsp").forward(request, response);
    }

    public class OrderProcessor implements Runnable {

        public void run() {
            while (true) {
                //lay transaction dang cho xu ly 
                List<Transaction> list = new TransactionDAO().getTransactionStatus();
                for (Transaction t1 : list) {
                    ProductDAO pd = new ProductDAO();
                    int slHang = pd.getAmountById(t1.getProductId());
                    if (slHang <= 0) {
                        continue;
                    }
                    TransactionDAO ts = new TransactionDAO();
                    int transactionId = ts.addTransaction(t1);
                    // Thực hiện xử lý yêu cầu mua hàng ở đây
                    //        giảm số lượng thẻ trong product table 
//        và set status = 0 nếu số lượng về 0
                    pd.updateAmount(t1.getBuyAmount(), t1.getProductId());
                    //đánh dấu thẻ trong Card table (productId,transactionId)
                    CardDAO cd = new CardDAO();
                    cd.updateStatusCard(t1.getProductId(), transactionId, t1.getBuyAmount());
                    boolean status = false;
                    new TransactionDAO().updateStatus(status,t1.getId());
                    //lay tien cua tai khoan
                    AccountDAO ad = new AccountDAO();
                    double money = ad.getMoney(t1.getAccountId());
                    ad.updateMoney(t1.getAccountId(), t1.getBuyPrice() * t1.getBuyAmount(), money);
                }
            }
        }
    }

}
