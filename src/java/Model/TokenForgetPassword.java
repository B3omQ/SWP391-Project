/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;

/**
 *
 * @author JIGGER
 */
public class TokenForgetPassword {

    private int id;
    private String token;
    private LocalDateTime expirytime;
    private boolean isUsed;
    private int userId;

    public TokenForgetPassword() {
    }

    public TokenForgetPassword(int id, String token, LocalDateTime expirytime, boolean isUsed, int userId) {
        this.id = id;
        this.token = token;
        this.expirytime = expirytime;
        this.isUsed = isUsed;
        this.userId = userId;
    }

    public int getId() {
        return id;
    }

    public String getToken() {
        return token;
    }

    public LocalDateTime getExpirytime() {
        return expirytime;
    }

    public boolean isIsUsed() {
        return isUsed;
    }

    public int getUserId() {
        return userId;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public void setExpirytime(LocalDateTime expirytime) {
        this.expirytime = expirytime;
    }

    public void setIsUsed(boolean isUsed) {
        this.isUsed = isUsed;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "TokenForgetPassword{" + "id=" + id + ", token=" + token + ", expirytime=" + expirytime + ", isUsed=" + isUsed + ", userId=" + userId + '}';
    }

}
