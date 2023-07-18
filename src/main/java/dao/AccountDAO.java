/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Account;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Product;

/**
 *
 * @author caoqu
 */
public class AccountDAO extends DBContext {

    public List<Account> getAll() {
        List<Account> accounts = new ArrayList<Account>();
        String sql = "SELECT Account, Password, Email, PhoneNumber, Name, RoleID, Money, createdAt, deleteAt, isActive FROM account WHERE RoleID = 2;";
        Connection cnn = (new DBContext()).connection;

        try {
            PreparedStatement ps = cnn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Account user = new Account();

                user.setUserName(rs.getString(1));
                user.setPassword(rs.getString(2));
                user.setEmail(rs.getString(3));
                user.setPhone(rs.getString(4));
                user.setName(rs.getString(5));
                user.setRoleId(rs.getInt(6));
                user.setMoney(rs.getDouble(7));
                user.setCreatedAt(rs.getDate(8));
                user.setDeleteAt(rs.getDate(9));
                user.setActive(rs.getBoolean(10));

                accounts.add(user);
            }

        } catch (SQLException e) {
            e.printStackTrace();

        }

        return accounts;
    }

    public List<Account> listAll() {
        List<Account> list = new ArrayList<>();
        try {

            String strSelect = "select * from account";
            Connection cnn = (new DBContext()).connection;
            PreparedStatement pstm = cnn.prepareStatement(strSelect);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                list.add(new Account(rs.getString(1), rs.getString(2),
                        rs.getString(3), rs.getString(4), rs.getString(5),
                        rs.getInt(6), rs.getDouble(7), rs.getDate(8),
                        rs.getDate(9), rs.getBoolean(10)));
            }
        } catch (Exception e) {
            System.out.println("listAll: " + e.getMessage());
        }

        return list;
    }

    public boolean checkAccount(String account, String password) {
        try {
            String strSelect = "select * from accounts where Account=? and Password=? ";
            Connection cnn = (new DBContext()).connection;
            PreparedStatement pstm = cnn.prepareStatement(strSelect);
            pstm.setString(1, account);
            pstm.setString(2, password);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("listAll: " + e.getMessage());
        }
        return false;
    }

    public void updateProfile(String username, String name, String phoneNumber) {
        try {
            String strSelect = "UPDATE account "
                    + "SET Name = ?, PhoneNumber=? "
                    + "WHERE account=?;";
            Connection cnn = (new DBContext()).connection;
            PreparedStatement pstm = cnn.prepareStatement(strSelect);
            pstm.setString(1, name);
            pstm.setString(2, phoneNumber);
            pstm.setString(3, username);
            pstm.execute();

        } catch (Exception e) {
            System.out.println("updateProfile: " + e.getMessage());
        }
    }

    public void updateNewPass(String acc, String password) {
        try {
            String strSelect = "UPDATE account\n"
                    + "SET Password=? \n"
                    + "WHERE Account=? ;";
            Connection cnn = (new DBContext()).connection;
            PreparedStatement pstm = cnn.prepareStatement(strSelect);
            pstm.setString(1, password);
            pstm.setString(2, acc);
            pstm.execute();
        } catch (Exception e) {
            System.out.println("updateNewPass: " + e.getMessage());
        }
    }

    public Account findAccount(String acc) {
        List<Account> list = listAll();
        for (Account a : list) {
            if (a.getUserName().equals(acc)) {
                return a;
            }
        }
        return null;

//        try {
//            String strSelect = "select * from accounts where username=?";
//            Connection cnn = (new DBContext()).connection;
//            PreparedStatement pstm = cnn.prepareStatement(strSelect);
//            pstm.setString(1, acc);
//            ResultSet rs = pstm.executeQuery();
//            if(rs.next()){
//                return new Account(rs.getString(1), rs.getString(2),
//                        rs.getString(3), rs.getDouble(4), rs.getInt(5),rs.getBoolean(6));
//            }
//        } catch (Exception e) {
//            System.out.println("findAccount: " + e.getMessage());
//        }
    }

    public void updateStatusAccount(String username) {
        try {
            String strSelect = "UPDATE account\n"
                    + "SET isActive = 1\n"
                    + "WHERE account=?;";
            Connection cnn = (new DBContext()).connection;
            PreparedStatement pstm = cnn.prepareStatement(strSelect);
            pstm.setString(1, username);
            pstm.execute();

        } catch (Exception e) {
            System.out.println("updateStatusAccount: " + e.getMessage());
        }
    }

    public void addAccount(Account acc) {
        try {
            String strSelect = "insert into account (Account , Password,email,"
                    + "phoneNumber,name,roleId,money,createdAt,isActive)\n"
                    + "value(?,?,?,?,?,?,?,?,?)";
            Connection cnn = (new DBContext()).connection;
            PreparedStatement pstm = cnn.prepareStatement(strSelect);
            pstm.setString(1, acc.getUserName());
            pstm.setString(2, acc.getPassword());
            pstm.setString(3, acc.getEmail());
            pstm.setString(4, acc.getPhone());
            pstm.setString(5, acc.getName());
            pstm.setInt(6, acc.getRoleId());
            pstm.setDouble(7, acc.getMoney());

            Date d = new Date();
            java.sql.Date createdAt = new java.sql.Date(d.getTime());
            pstm.setDate(8, createdAt);
            pstm.setBoolean(9, acc.isActive());
            pstm.execute();

        } catch (Exception e) {
            System.out.println("addAccount: " + e.getMessage());
        }
    }

    public void updateMoney(String userName, double total, double money) {
        try {
            String strSelect = "UPDATE account\n"
                    + "SET money = ?\n"
                    + "WHERE account=?;";
            Connection cnn = (new DBContext()).connection;
            PreparedStatement pstm = cnn.prepareStatement(strSelect);
            pstm.setDouble(1, money - total);
            pstm.setString(2, userName);
            pstm.execute();

        } catch (Exception e) {
            System.out.println("updateMoney: " + e.getMessage());
        }
    }

    public void transferMoney(String fromAccount, String toAccount, double amount, String type) {
        try {
            Connection cnn = (new DBContext()).connection;
            // Trừ tiền trong tài khoản của admin
            if (type.equals("1")) {
                String updateAdminAccountQuery = "UPDATE account SET Money = Money - ? WHERE Account = ?";
                PreparedStatement updateAdminAccountStmt = cnn.prepareStatement(updateAdminAccountQuery);
                updateAdminAccountStmt.setDouble(1, amount);
                updateAdminAccountStmt.setString(2, fromAccount);
                updateAdminAccountStmt.executeUpdate();
            }
            String updateToAccountQuery = "";
            boolean tType=false;
            // Cộng tiền vào tài khoản đích
            if (type.equals("1")) {
                updateToAccountQuery = "UPDATE account SET Money = Money + ? WHERE Account = ?";
                tType=true;
            } else {
                updateToAccountQuery = "UPDATE account SET Money = Money - ? WHERE Account = ?";
            }
            PreparedStatement updateToAccountStmt = cnn.prepareStatement(updateToAccountQuery);
            updateToAccountStmt.setDouble(1, amount);
            updateToAccountStmt.setString(2, toAccount);
            updateToAccountStmt.executeUpdate();

            // Thêm lịch sử giao dịch vào bảng history-transfers
            String insertTransferHistoryQuery = "INSERT INTO `history-transfers` (FromAccount, ToAccount, Amount,TransactionType, createdAt) VALUES (?, ?, ?, ?, NOW())";
            PreparedStatement insertTransferHistoryStmt = cnn.prepareStatement(insertTransferHistoryQuery);
            insertTransferHistoryStmt.setString(1, fromAccount);
            insertTransferHistoryStmt.setString(2, toAccount);
            insertTransferHistoryStmt.setDouble(3, amount);
            insertTransferHistoryStmt.setBoolean(4, tType);
            insertTransferHistoryStmt.executeUpdate();

            cnn.close();
        } catch (Exception e) {
            System.out.println("transferMoney: " + e.getMessage());
        }
    }

    public double getMoney(String accountId) {
        try {
            String strSelect = "select money from account where account=?";
            Connection cnn = (new DBContext()).connection;
            PreparedStatement pstm = cnn.prepareStatement(strSelect);
            pstm.setString(1, accountId);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                return rs.getDouble("money");
            }
        } catch (Exception e) {
            System.out.println("updateMoney: " + e.getMessage());
        }
        return 0;
    }

    public List<Account> getAccountByRole(int role) {
        List<Account> list = new ArrayList<>();
        try {
            String strSelect = "select * from account where RoleID=?";
            Connection cnn = (new DBContext()).connection;
            PreparedStatement pstm = cnn.prepareStatement(strSelect);
            pstm.setInt(1, role);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                list.add(new Account(rs.getString(1), rs.getString(2),
                        rs.getString(3), rs.getString(4), rs.getString(5),
                        rs.getInt(6), rs.getDouble(7), rs.getDate(8),
                        rs.getDate(9), rs.getBoolean(10)));
            }
        } catch (Exception e) {
            System.out.println("listAll: " + e.getMessage());
        }
        return list;
    }

    public void banAccount(String account, String ban) {
        try {
            String strSelect = "UPDATE account\n"
                    + "SET isActive = ?\n"
                    + "WHERE account=?;";
            Connection cnn = (new DBContext()).connection;
            PreparedStatement pstm = cnn.prepareStatement(strSelect);
            pstm.setInt(1, Integer.parseInt(ban));
            pstm.setString(2, account);
            pstm.execute();

        } catch (Exception e) {
            System.out.println("updateMoney: " + e.getMessage());
        }
    }

    public int getAccountCount() {
        String sql = "SELECT COUNT(*) FROM account ";
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

    public List<Account> getAllAccount(int limit, int offset) {
        List<Account> list = new ArrayList<>();
        String sql = "SELECT * FROM account LIMIT ? OFFSET ?";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, limit);
            st.setInt(2, offset);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Account(rs.getString(1), rs.getString(2),
                        rs.getString(3), rs.getString(4), rs.getString(5),
                        rs.getInt(6), rs.getDouble(7), rs.getDate(8),
                        rs.getDate(9), rs.getBoolean(10)));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

}
