package model;

import java.time.LocalDateTime;

public class TokenForgetPassword {
    private int id;
    private String token;
    private LocalDateTime expiryTime;
    private boolean isUsed;
    private int userId;
    private String userType;

    public TokenForgetPassword() {
    }

    public TokenForgetPassword(String token, LocalDateTime expiryTime, boolean isUsed, int userId, String userType) {
        this.token = token;
        this.expiryTime = expiryTime;
        this.isUsed = isUsed;
        this.userId = userId;
        this.userType = userType;
    }

    public TokenForgetPassword(String token, LocalDateTime expiryTime, boolean isUsed, int userId) {
        this.token = token;
        this.expiryTime = expiryTime;
        this.isUsed = isUsed;
        this.userId = userId;
    }

    // Getters và Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getToken() { return token; }
    public void setToken(String token) { this.token = token; }
    public LocalDateTime getExpiryTime() { return expiryTime; }
    public void setExpiryTime(LocalDateTime expiryTime) { this.expiryTime = expiryTime; }
    public boolean isIsUsed() { return isUsed; }
    public void setIsUsed(boolean isUsed) { this.isUsed = isUsed; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getUserType() { return userType; }
    public void setUserType(String userType) { this.userType = userType; }
}
  