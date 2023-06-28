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
import org.apache.poi.poifs.crypt.dsig.services.TSPTimeStampService;

/**
 *
 * @author PC
 */
public class TransactionDAO extends DBContext {

    public int addTransaction(Transaction t) {

        String sql = "iNSERT INTO `swp1`.`transaction` ( "
                + "`BuyPrice`, `BuyAmount`, `createdAt`, `ProductId`,`accountId`,`Description`)\n"
                + " VALUES (?,?,?,?,?,?);";
        try ( PreparedStatement st = connection.prepareStatement(sql
        ,Statement.RETURN_GENERATED_KEYS)) {
            st.setDouble(1, t.getBuyPrice());
            st.setInt(2, t.getBuyAmount());
            Date d = new Date();
            java.sql.Date createdAt = new java.sql.Date(d.getTime());
            st.setDate(3, createdAt);
            st.setInt(4, t.getProductId());
            st.setString(5, t.getAccountId());
            st.setString(6, "The dien thoai " );
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
                        rs.getString("Description")
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
                        rs.getString("Description")
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
                        rs.getString("Description")
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
        String sql = "SELECT * FROM swp1.transaction limit ? offset ?;";
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
        String sql = "SELECT count(*) FROM transaction WHERE accountID = ?";
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

}
