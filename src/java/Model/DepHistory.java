package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class DepHistory {
    private int id;
    private Integer dsuId; 
    private String description;
    private BigDecimal amount;
    private Timestamp createdAt;
    private int cusId;

    // Constructor đầy đủ
    public DepHistory(int id, Integer dsuId, String description, BigDecimal amount, Timestamp createdAt, int cusId) {
        this.id = id;
        this.dsuId = dsuId;
        this.description = description;
        this.amount = amount;
        this.createdAt = createdAt;
        this.cusId = cusId;
    }

    // Constructor không có cusId (sửa để khớp với tham số)
    public DepHistory(int id, Integer dsuId, String description, BigDecimal amount, Timestamp createdAt) {
        this.id = id;
        this.dsuId = dsuId;
        this.description = description;
        this.amount = amount;
        this.createdAt = createdAt;
    }

    // Constructor mặc định
    public DepHistory() {
    }

    // Getter và Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public Integer getDsuId() { return dsuId; }
    public void setDsuId(Integer dsuId) { this.dsuId = dsuId; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public int getCusId() { return cusId; }
    public void setCusId(int cusId) { this.cusId = cusId; }
}