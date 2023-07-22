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
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import model.Account;
import model.Transaction;

/**
 *
 * @author PC
 */
@WebServlet(name = "BuyingServlet", urlPatterns = {"/buying"})
public class BuyingServlet extends HttpServlet {

    private static Queue<Transaction> buyQueue = new LinkedList<>();
    private ScheduledExecutorService executorService;

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
        String notice = "Bạn có muốn tiếp tục mua hàng không ? ";
        int slHang = new ProductDAO().getAmountById(Integer.parseInt(productId));
        if (slHang <= 0) {
            notice = "Sản phẩm hiện tại đã hết hàng";
            request.setAttribute("slHang", 1);
        } else {
            Transaction t1 = Transaction.builder()
                    .accountId(account.getUserName())
                    .buyPrice(giaThe)
                    .buyAmount(soLuongMua)
                    .productId(Integer.parseInt(productId))
                    .description(supplier)
                    .status(false)
                    .build();
            
            synchronized (buyQueue) {
                buyQueue.add(t1);
            }
            //chuyen trang
            response.setStatus(HttpServletResponse.SC_OK);
            //chuyen trang
            response.getWriter().println("Buy request has been added to the queue.");
            //lay tien hien tai cua tai khoan
            account.setMoney(new AccountDAO().getMoney(account.getUserName()));
        }
        // Lên lịch trả kết quả cho người dùng sau 5 giây
        request.setAttribute("notice", notice);
        request.setAttribute("suppliers", l.getAllSupplier());
        request.setAttribute("pId", productId);
        request.setAttribute("listPrice", l.getAllPrice());
        request.getRequestDispatcher("shop.jsp").forward(request, response);
    }

    @Override
    public void init() throws ServletException {
        executorService = Executors.newSingleThreadScheduledExecutor();
        // Tạo một luồng riêng biệt để xử lý hàng đợi
        Thread processingThread = new Thread(() -> {
            while (true) {
                Transaction t;
                synchronized (buyQueue) {
                    // Lấy yêu cầu từ hàng đợi
                    if (buyQueue.isEmpty()) {
                        // Lên lịch kiểm tra xem có yêu cầu nào sau 2 giây
                        executorService.schedule(this::processPendingRequests, 1, TimeUnit.SECONDS);
                        try {
                            buyQueue.wait(); // Chờ đợi khi hàng đợi rỗng
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                        continue; // Tiếp tục vòng lặp
                    }

                    t = buyQueue.poll();
                }

                // Xử lý yêu cầu mua hàng
                processTransaction(t);
            }
        });
        processingThread.start();
    }

    private void processTransaction(Transaction t1) {
        //kiem tra so luong
        TransactionDAO ts = new TransactionDAO();
        int slHang = new ProductDAO().getAmountById(t1.getProductId());
        if (slHang <= 0) {
            t1.setStatus(false);
            ts.addTransaction(t1);
            return;
        }
        // Thực hiện xử lý yêu cầu mua hàng ở đây
        //lay tien cua tai khoan
        AccountDAO ad = new AccountDAO();
        double money = ad.getMoney(t1.getAccountId());
        ad.updateMoney(t1.getAccountId(), t1.getBuyPrice() * t1.getBuyAmount(), money);
//        giảm số lượng thẻ trong product table 
//        và set status = 0 nếu số lượng về 0
        ProductDAO pd = new ProductDAO();
        pd.updateAmount(t1.getBuyAmount(), t1.getProductId());
        t1.setStatus(true);
        int transactionId = ts.addTransaction(t1);
        //đánh dấu thẻ trong Card table (productId,transactionId)
        CardDAO cd = new CardDAO();
        cd.updateStatusCard(t1.getProductId(), transactionId, t1.getBuyAmount());
    }

    private void processPendingRequests() {
        synchronized (buyQueue) {
            if (buyQueue.isEmpty()) {
                System.out.println("No buy requests found after 2 seconds.");
                // Process the pending requests here or take any necessary action
            }
            buyQueue.notifyAll(); // Notify the waiting thread
        }
    }

    @Override
    public void destroy() {
        executorService.shutdown();
    }

}
