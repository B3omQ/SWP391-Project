/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author LAPTOP
 */
public class CustomerReview {
    private int id;
    private Customer Cusid;
    private int rate;
    private String review;
    private Timestamp createAt;

    public CustomerReview() {
    }

    public CustomerReview(int id, Customer Cusid, int rate, String review, Timestamp createAt) {
        this.id = id;
        this.Cusid = Cusid;
        this.rate = rate;
        this.review = review;
        this.createAt = createAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Customer getCusid() {
        return Cusid;
    }

    public void setCustomer(Customer customer) {
    this.Cusid = customer;
}

    public int getRate() {
        return rate;
    }

    public void setRate(int rate) {
        this.rate = rate;
    }

    public String getReview() {
        return review;
    }

    public void setReview(String review) {
        this.review = review;
    }

    public Timestamp getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Timestamp createAt) {
        this.createAt = createAt;
    }

    @Override
    public String toString() {
        return "CustomerReview{" + "id=" + id + ", Cusid=" + Cusid + ", rate=" + rate + ", review=" + review + ", createAt=" + createAt + '}';
    }
    
    
}
