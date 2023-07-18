/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author PC
 */
@lombok.Getter
@lombok.Setter
@lombok.NoArgsConstructor
@lombok.AllArgsConstructor

public class Transfer {
    private int id;
    private String fromAccount,toAccount;
    private double amount;
    private Date createdAt;
    private Date deleteAt;
    private boolean transactionType;
    
}
