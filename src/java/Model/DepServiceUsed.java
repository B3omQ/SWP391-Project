package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class DepServiceUsed {
    private int id;
    private int depId;
    private int cusId;
    private int depTypeId;
    private BigDecimal amount;
    private Timestamp startDate;
    private Timestamp endDate;
    private String depStatus;

    public DepServiceUsed() {
    }

    public DepServiceUsed(int id, int depId, int cusId, int depTypeId, BigDecimal amount, Timestamp startDate, Timestamp endDate, String depStatus) {
        this.id = id;
        this.depId = depId;
        this.cusId = cusId;
        this.depTypeId = depTypeId;
        this.amount = amount;
        this.startDate = startDate;
        this.endDate = endDate;
        this.depStatus = depStatus;
    }

    // Getters và Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getDepId() {
        return depId;
    }

    public void setDepId(int depId) {
        this.depId = depId;
    }

    public int getCusId() {
        return cusId;
    }

    public void setCusId(int cusId) {
        this.cusId = cusId;
    }

    public int getDepTypeId() {
        return depTypeId;
    }

    public void setDepTypeId(int depTypeId) {
        this.depTypeId = depTypeId;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public Timestamp getStartDate() {
        return startDate;
    }

    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    public Timestamp getEndDate() {
        return endDate;
    }

    public void setEndDate(Timestamp endDate) {
        this.endDate = endDate;
    }

    public String getDepStatus() {
        return depStatus;
    }

    public void setDepStatus(String depStatus) {
        this.depStatus = depStatus;
    }
}
