/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author JIGGER
 */
public class NotifyType {
    
    private int id;  //id = 1 - lưu trữ thông báo liên quan đến thông tin định danh,
                      //id = 2 - lưu trữ thông báo liên quan đến thông tin về các gói gửi tiết kiệm
                       //id = 3 - lưu trữ thông báo liên quan đến thông tin về các gói vay
    private String NotifyName;

    public NotifyType() {
    }

    public NotifyType(int id, String NotifyName) {
        this.id = id;
        this.NotifyName = NotifyName;
    }
    
    public NotifyType(int id) {
        this.id = id;
        this.NotifyName = NotifyName;
    }
    

    public int getId() {
        return id;
    }

    public String getNotifyName() {
        return NotifyName;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setNotifyName(String NotifyName) {
        this.NotifyName = NotifyName;
    }

    

    @Override
    public String toString() {
        return "NotifyType{" + "id=" + id + ", NotifyName=" + NotifyName + '}';
    }
    
    
    
}
