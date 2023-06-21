package dao;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
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
                        rs.getString("accountId"),
                        rs.getDate("updateAt"));
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
                        rs.getString("accountId"),
                        rs.getDate("updateAt"));
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    void addProduct(Product p,Date expirationDate) {
        String sql = "insert into product (SellPrice,supplier,amount,"
                + "Image,ExpirationDate,Description,createdAt,status)\n"
                + "values(?,?,?,?,?,?,?,?);";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setDouble(1, p.getSellPrice());
            st.setString(2, p.getSupplier());
            st.setInt(3, 0);
            st.setString(4, p.getImage());
            java.sql.Date sqlExpirationDate = new java.sql.Date(expirationDate.getTime());
            st.setDate(5, sqlExpirationDate);
            st.setString(6, p.getDescription());
            st.setDate(7, new java.sql.Date((new Date()).getTime()));
            st.setBoolean(8, p.isStatus());
            st.execute();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    void updateDateProduct(int productId) {
        String sql = "update product \n"
                + "set updateAt=?\n"
                + "where Id=?";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {

            st.setDate(1, new java.sql.Date((new Date()).getTime()));
            st.setInt(2, productId);
            st.execute();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    int getLastId() {
        String sql = "select Id from product order by id desc limit 1";
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

    void updateAmountProduct(int productId, int amount) {
        String sql = "update product \n"
                + "set amount=?\n"
                + "where Id=?";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {

            st.setInt(1, ++amount);
            st.setInt(2, productId);
            st.execute();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    int getAmountById(int productId) {
        String sql = "select amount from product where id = ?";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, productId);
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
//        ProductDAO pd = new ProductDAO();
//        pd.addProduct(new Product(10, "", 20000, 0, "viettel", "viettel_logo.png", new Date(), "quwenqwe", null, null, false, "", null), new Date());
//    }
}
