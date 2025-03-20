/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;


import java.util.Date;

public class Blacklist {
    private int id;
    private int cusId;
    private String reason;
    private Date blacklistDate;

    // Constructor mặc định
    public Blacklist() {}

    // Constructor có tham số
    public Blacklist(int id, int cusId, String reason, Date blacklistDate) {
        this.id = id;
        this.cusId = cusId;
        this.reason = reason;
        this.blacklistDate = blacklistDate;
    }

    // Getter và Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCusId() {
        return cusId;
    }

    public void setCusId(int cusId) {
        this.cusId = cusId;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public Date getBlacklistDate() {
        return blacklistDate;
    }

    public void setBlacklistDate(Date blacklistDate) {
        this.blacklistDate = blacklistDate;
    }

    // Phương thức hiển thị thông tin blacklist (dành cho debug)
    @Override
    public String toString() {
        return "Blacklist{" +
                "id=" + id +
                ", cusId=" + cusId +
                ", reason='" + reason + '\'' +
                ", blacklistDate=" + blacklistDate +
                '}';
    }
}

