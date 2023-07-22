/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Transfer;

/**
 *
 * @author PC
 */
public class TransferDAO extends DBContext {

    public List<Transfer> getList() {
        List<Transfer> list = new ArrayList<>();
        String sql = "SELECT * FROM swp1.`history-transfers`;";
        Connection cnn = (new DBContext()).connection;
        try {
            PreparedStatement ps = cnn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Transfer t = new Transfer(
                        rs.getInt("id"),
                        rs.getString("FromAccount"),
                        rs.getString("ToAccount"),
                        rs.getDouble("Amount"),
                        rs.getDate("createdAt"),
                        rs.getDate("deleteAt"),
                        rs.getBoolean("TransactionType"));
                list.add(t);
            }

        } catch (SQLException e) {
            e.printStackTrace();

        }

        return list;
    }

    public int getTransferCount() {
        String sql = "SELECT COUNT(*) FROM `history-transfers`;";
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
    
//    public static void main(String[] args) {
//        System.out.println(new TransferDAO().getTransferCount());
//    }

    public List<Transfer> getAllTransfer(int limit, int offset) {
        List<Transfer> list = new ArrayList<>();
        String sql = "SELECT * FROM `history-transfers` LIMIT ? OFFSET ?;";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, limit);
            st.setInt(2, offset);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Transfer t = new Transfer(
                        rs.getInt("id"),
                        rs.getString("FromAccount"),
                        rs.getString("ToAccount"),
                        rs.getDouble("Amount"),
                        rs.getDate("createdAt"),
                        rs.getDate("deleteAt"),
                        rs.getBoolean("TransactionType"));
                list.add(t);
            }

        } catch (SQLException e) {
            e.printStackTrace();

        }

        return list;
    }

}
