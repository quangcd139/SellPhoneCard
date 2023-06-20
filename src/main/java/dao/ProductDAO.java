package dao;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;

public class ProductDAO extends DBContext {

    public Product getProductIdBySupplier(String supplier, double sellPrice) {
        String sql = "SELECT * FROM product where supplier = ? and sellprice = ? order by ExpirationDate limit 1";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, supplier);
            st.setDouble(2, sellPrice);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Product p = new Product(
                        rs.getInt("Id"),
                        rs.getString("name"),
                        rs.getDouble("SellPrice"),
                        rs.getInt("Amount"),
                        rs.getString("supplier"),
                        rs.getString("image"),
                        rs.getDate("ExpirationDate"),
                        rs.getString("Description"),
                        rs.getDate("createdAt"),
                        rs.getDate("deleteAt"),
                        rs.getBoolean("status"),
                        rs.getString("accountId"));
                return p;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public void updateAmount(int quantity, Product p) {
        String sql = "";
        if (p.getAmount() == quantity) {
            sql = "UPDATE product\n"
                    + "SET amount=?, status=0 \n"
                    + "WHERE id=?;";
        } else {
            sql = "UPDATE product\n"
                    + "SET amount= ?\n"
                    + "WHERE id=?;";
        }
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, p.getAmount() - quantity);
            st.setInt(2, p.getId());
            st.execute();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public List<Product> getAllProduct() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM product order by ExpirationDate";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("Id"),
                        rs.getString("name"),
                        rs.getDouble("SellPrice"),
                        rs.getInt("Amount"),
                        rs.getString("supplier"),
                        rs.getString("image"),
                        rs.getDate("ExpirationDate"),
                        rs.getString("Description"),
                        rs.getDate("createdAt"),
                        rs.getDate("deleteAt"),
                        rs.getBoolean("status"),
                        rs.getString("accountId"));
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }
}
