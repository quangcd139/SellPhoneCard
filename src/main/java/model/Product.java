/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package model;

import java.util.Date;
import jxl.write.DateTime;

/**
 *
 * @author PC
 */
@lombok.AllArgsConstructor
@lombok.Getter
@lombok.Setter
@lombok.NoArgsConstructor
public class Product {

    private int id;
    private String name;
    private double sellPrice;
    private int amount;
    private String supplier;
    private String image;
    private Date expirationDate;
    private String description;
    private Date createdAt;
    private Date deleteAt;
    private boolean status;
    private Date updateAt;

    
    public Product(String supplier, String image) {
        this.supplier = supplier;
        this.image = image;
    }

    public Product(String supplier, double menhGia, int quantity, int id, boolean status) {
        this.supplier = supplier;
        this.amount = quantity;
        this.sellPrice = menhGia;
        this.id = id;
        this.status = status;
    }

    public Product(String supplier, double menhGia, int quantity, int id) {
        this.supplier = supplier;
        this.amount = quantity;
        this.sellPrice = menhGia;
        this.id = id;
    }
//        Product product = new Product(productName, sellPrice, supplier, image, description, status);

    public Product(String name, double sellPrice, String supplier, String image, String description, boolean status) {
        this.name = name;
        this.sellPrice = sellPrice;
        this.supplier = supplier;
        this.image = image;
        this.description = description;
        this.status = status;
    }

//    public Product(String proname, String proprice, String proamount, String prosupplier, String proexpire) {
//        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
//    }
    
    public Product(String name, double sellPrice, int amount, String supplier, Date expirationDate) {
        this.name = name;
        this.sellPrice = sellPrice;
        this.amount = amount;
        this.supplier = supplier;
        this.expirationDate = expirationDate;
    }

    
    
    
}
