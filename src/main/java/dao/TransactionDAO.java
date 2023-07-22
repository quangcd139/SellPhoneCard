/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;
import model.Product;
import dao.ProductDAO;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Transaction;

/**
 *
 * @author PC
 */
public class TransactionDAO extends DBContext {

    public int addTransaction(Transaction t) {

        String sql = "iNSERT INTO `swp1`.`transaction` ( "
                + "`BuyPrice`, `BuyAmount`, `createdAt`, `ProductId`,`accountId`,`Description`, status)\n"
                + " VALUES (?,?,?,?,?,?,?);";
        try ( PreparedStatement st = connection.prepareStatement(sql,
                Statement.RETURN_GENERATED_KEYS)) {
            st.setDouble(1, t.getBuyPrice());
            st.setInt(2, t.getBuyAmount());
            Date d = new Date();
            java.sql.Date createdAtDate = new java.sql.Date(d.getTime()); // Assuming 'd' is a java.util.Date object
// Convert java.sql.Date to java.sql.Timestamp
            java.sql.Timestamp createdAtDateTime = new java.sql.Timestamp(createdAtDate.getTime());
            st.setTimestamp(3, createdAtDateTime);
            st.setInt(4, t.getProductId());
            st.setString(5, t.getAccountId());
            st.setString(6, t.getDescription());
            st.setBoolean(7, t.isStatus());
            st.executeUpdate();

            ResultSet generatedKeys = st.getGeneratedKeys();
            if (generatedKeys.next()) {
                int transactionId = generatedKeys.getInt(1);
                return transactionId;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }
//getTransactionStatus

    public List<Transaction> getTransactionStatus() {
        List<Transaction> list = new ArrayList<>();
        String sql = "select * from transaction where status = 0";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Transaction t = new Transaction(
                        rs.getInt("Id"),
                        rs.getDouble("BuyPrice"),
                        rs.getInt("BuyAmount"),
                        rs.getDate("createdAt"),
                        rs.getString("Description"),
                        rs.getBoolean("status"),
                        rs.getInt("productId")
                );

                list.add(t);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public List<Transaction> getAllByAccount(String account) {
        List<Transaction> list = new ArrayList<>();
        String sql = "select * from transaction where accountId = ?";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, account);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Transaction t = new Transaction(
                        rs.getInt("Id"),
                        rs.getDouble("BuyPrice"),
                        rs.getInt("BuyAmount"),
                        rs.getDate("createdAt"),
                        rs.getString("Description"),
                        rs.getBoolean("status")
                );

                list.add(t);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public Transaction findById(int transactionId) {
        String sql = "select * from transaction where Id = ?";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, transactionId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Transaction t = new Transaction(
                        rs.getInt("Id"),
                        rs.getDouble("BuyPrice"),
                        rs.getInt("BuyAmount"),
                        rs.getDate("createdAt"),
                        rs.getString("Description"), 
                        rs.getBoolean("status")
                );
                return t;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public List<Transaction> getAllByAccount(String account, int limit, int offset) {
        List<Transaction> list = new ArrayList<>();
        String sql = "select * from transaction where accountId = ? \n"
                + "limit ? offset ?;";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, account);
            st.setInt(2, limit);
            st.setInt(3, offset);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Transaction t = new Transaction(
                        rs.getInt("Id"),
                        rs.getDouble("BuyPrice"),
                        rs.getInt("BuyAmount"),
                        rs.getDate("createdAt"),
                        rs.getString("Description"),
                        rs.getBoolean("status")
                );

                list.add(t);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public List<Transaction> getAllTransaction() {
        List<Transaction> list = new ArrayList<>();
        String sql = "select * from transaction";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Transaction t = new Transaction(
                        rs.getInt("Id"),
                        rs.getDouble("BuyPrice"),
                        rs.getInt("BuyAmount"),
                        rs.getDate("createdAt"),
                        rs.getString("Description"),
                        rs.getString("AccountId")
                );
                list.add(t);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public List<Transaction> getAllTransaction(int limit, int offset) {
        List<Transaction> list = new ArrayList<>();
        String sql = "SELECT * FROM swp1.transaction where status !=0 limit ? offset ?;";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, limit);
            st.setInt(2, offset);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Transaction t = new Transaction(
                        rs.getInt("Id"),
                        rs.getDouble("BuyPrice"),
                        rs.getInt("BuyAmount"),
                        rs.getDate("createdAt"),
                        rs.getString("Description"),
                        rs.getString("AccountId")
                );
                list.add(t);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;

    }

    public int getSizeByAccount(String userName) {
        String sql = "SELECT count(*) FROM transaction WHERE accountID = ? and status !=0";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, userName);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public int getSizeTransaction() {
        String sql = "SELECT count(*) FROM transaction";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public List<Transaction> getAllByAccountFilter(String account, int limit, int offset, List<String> priceFilter, List<Product> supplierFilter) {
        List<Transaction> list = new ArrayList<>();
        String price = "";
        for (String s : priceFilter) {
            price += "BuyPrice= " + s + " or ";
        }
        if (!price.isEmpty()) {
            price = price.substring(0, price.length() - 3);
            price = "(" + price;
            price += ") ";
        }

        String supplier = "";
        for (Product p : supplierFilter) {
            supplier += "Supplier= '" + p.getSupplier() + "' or ";
        }
        if (!supplier.isEmpty()) {
            supplier = supplier.substring(0, supplier.length() - 3);
            supplier = "(" + supplier;
            if (!price.isEmpty()) {
                supplier += ") and ";
            } else {
                supplier += ") ";
            }
        }
        String accountId = "";
        if (!account.isEmpty()) {
            if (priceFilter.size() == 0 && supplierFilter.size() == 0) {
                accountId = " where accountId like ? ";
            } else {
                accountId = " where accountId like ? and ";
            }
        }
        String sql = "select t.* from transaction t join product p on t.ProductID=p.Id\n"
                 + accountId +(accountId.isEmpty()?" where ":" ")+ supplier + price;
        System.out.println(sql);
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            int i=1;
            if (!account.isEmpty()) {
                st.setString(i, "%"+account+"%");
                i++;
            }
//            st.setInt(i, limit);
//            st.setInt(i+1, offset);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Transaction t = Transaction.builder()
                    .id(rs.getInt("Id"))
                    .accountId(rs.getString("accountId"))
                    .buyPrice(rs.getDouble("BuyPrice"))
                    .buyAmount(rs.getInt("BuyAmount"))
                    .createdAt(rs.getDate("createdAt"))
                    .description(rs.getString("Description"))
                    .status(rs.getBoolean("status"))
                    .build();

                list.add(t);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public int getTransByAccount(String userName, String id) {
        String sql = "SELECT * FROM swp1.transaction where accountId=? and ProductID=? order by createdAt desc limit 1;";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, userName);
            st.setInt(2, Integer.parseInt(id));
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("Id");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public void updateStatus(boolean status, int id) {
        String sql = "update transaction \n"
                + "set status =?\n"
                + "where Id = ?";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setBoolean(1, status);
            st.setInt(2, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public boolean getStatusById(int x) {
        String sql = "SELECT * FROM swp1.transaction where id = ? limit 1";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getBoolean("status");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

}
