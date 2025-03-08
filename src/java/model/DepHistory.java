package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class DepHistory {
    private int id;
    private int dsuId;
    private String description;
    private BigDecimal amount;
    private Timestamp createdAt;

    // Constructor
    public DepHistory(int id, int dsuId, String description, BigDecimal amount, Timestamp createdAt) {
        this.id = id;
        this.dsuId = dsuId;
        this.description = description;
        this.amount = amount;
        this.createdAt = createdAt;
    }

    // Getter và Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getDsuId() { return dsuId; }
    public void setDsuId(int dsuId) { this.dsuId = dsuId; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}