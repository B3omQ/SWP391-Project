package model;

import java.math.BigDecimal;
import java.util.Date;

public class DepServiceUsed {
    private int id;
    private int depId;
    private int cusId;
    private int depTypeId;
    private BigDecimal amount;
    private Date startDate;
    private Date endDate;
    private String depStatus;

    public DepServiceUsed() {
    }

    public DepServiceUsed(int id, int depId, int cusId, int depTypeId, BigDecimal amount, Date startDate, Date endDate, String depStatus) {
        this.id = id;
        this.depId = depId;
        this.cusId = cusId;
        this.depTypeId = depTypeId;
        this.amount = amount;
        this.startDate = startDate;
        this.endDate = endDate;
        this.depStatus = depStatus;
    }

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

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getDepStatus() {
        return depStatus;
    }

    public void setDepStatus(String depStatus) {
        this.depStatus = depStatus;
    }

    @Override
    public String toString() {
        return "DepServiceUsed{" +
                "id=" + id +
                ", depId=" + depId +
                ", cusId=" + cusId +
                ", depTypeId=" + depTypeId +
                ", amount=" + amount +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", depStatus='" + depStatus + '\'' +
                '}';
    }
}
