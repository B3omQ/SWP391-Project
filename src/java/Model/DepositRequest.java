package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class DepositRequest {
    private int id;
    private int cusId;
    private BigDecimal amount;
    private String note;
    private String status;
    private Timestamp createdAt;
    private String username;

    public DepositRequest() {
    }

    public DepositRequest(int id, int cusId, BigDecimal amount, String note, String status, Timestamp createdAt, String username) {
        this.id = id;
        this.cusId = cusId;
        this.amount = amount;
        this.note = note;
        this.status = status;
        this.createdAt = createdAt;
        this.username = username;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getCusId() { return cusId; }
    public void setCusId(int cusId) { this.cusId = cusId; }
    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }
    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
}