/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Utility;

import pojos.Stock;

/**
 *
 * @author YakaMiya
 */
public class sessionCartItems implements java.io.Serializable{

    private Stock stock;
    private int qty;

    public sessionCartItems(Stock stock, int qty) {
        this.stock = stock;
        this.qty = qty;
    }

    public Stock getStock() {
        return stock;
    }

    public void setStock(Stock stock) {
        this.stock = stock;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

}
