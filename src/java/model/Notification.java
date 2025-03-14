/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author JIGGER
 */
public class Notification {
    
    private int id;
    private Customer cusId;
    private Staff staffId;
    private NotifyType NotifyType;
    private String description;
    private Timestamp createTime;
    private boolean isRead;

    public Notification() {
    }

    public Notification(int id, Customer cusId, Staff staffId, NotifyType NotifyType, String description, Timestamp createTime, boolean isRead) {
        this.id = id;
        this.cusId = cusId;
        this.staffId = staffId;
        this.NotifyType = NotifyType;
        this.description = description;
        this.createTime = createTime;
        this.isRead = isRead;
    }

    public NotifyType getNotifyType() {
        return NotifyType;
    }

    public void setNotifyType(NotifyType NotifyType) {
        this.NotifyType = NotifyType;
    }  

    public int getId() {
        return id;
    }

    public Customer getCusId() {
        return cusId;
    }

    public Staff getStaffId() {
        return staffId;
    }

    public String getDescription() {
        return description;
    }

    public Timestamp getCreateTime() {
        return createTime;
    }

    public boolean isIsRead() {
        return isRead;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setCusId(Customer cusId) {
        this.cusId = cusId;
    }

    public void setStaffId(Staff staffId) {
        this.staffId = staffId;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    public void setIsRead(boolean isRead) {
        this.isRead = isRead;
    }

    @Override
    public String toString() {
        return "Notification{" + "id=" + id + ", cusId=" + cusId + ", staffId=" + staffId + ", description=" + description + ", createTime=" + createTime + ", isRead=" + isRead + '}';
    }
    
    
}
