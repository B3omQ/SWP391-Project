/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 *
 * @author LAPTOP
 */
public class LoanServiceUsed {
    private int id;
    private LoanService loanId;
    private Customer cusId;
    private BigDecimal amount;
    private Timestamp startDate;
    private Timestamp endDate;
    private int dateExpiredCount;  // Có thể null
    private BigDecimal debtRepayAmount;    // Có thể null
    private String incomeVertification;
    private String loanStatus;         // Có thể null

    public LoanServiceUsed() {
    }

    public LoanServiceUsed(int id, LoanService loanId, Customer cusId, BigDecimal amount, 
            Timestamp startDate, Timestamp endDate,
            int dateExpiredCount, BigDecimal debtRepayAmount, String loanStatus, String incomeVertification) {
        this.id = id;
        this.loanId = loanId;
        this.cusId = cusId;
        this.amount = amount;
        this.startDate = startDate;
        this.endDate = endDate;
        this.dateExpiredCount = dateExpiredCount;
        this.debtRepayAmount = debtRepayAmount;
        this.loanStatus = loanStatus;
        this.incomeVertification = incomeVertification;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public LoanService getLoanId() {
        return loanId;
    }

    public void setLoanId(LoanService loanId) {
        this.loanId = loanId;
    }

    public Customer getCusId() {
        return cusId;
    }

    public void setCusId(Customer cusId) {
        this.cusId = cusId;
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

    public int getDateExpiredCount() {
        return dateExpiredCount;
    }

    public void setDateExpiredCount(int dateExpiredCount) {
        this.dateExpiredCount = dateExpiredCount;
    }

    public BigDecimal getDebtRepayAmount() {
        return debtRepayAmount;
    }

    public void setDebtRepayAmount(BigDecimal debtRepayAmount) {
        this.debtRepayAmount = debtRepayAmount;
    }

    public String getLoanStatus() {
        return loanStatus;
    }

    public void setLoanStatus(String loanStatus) {
        this.loanStatus = loanStatus;
    }

    public String getIncomeVertification() {
        return incomeVertification;
    }

    public void setIncomeVertification(String incomeVertification) {
        this.incomeVertification = incomeVertification;
    }
        
    
    @Override
    public String toString() {
        return "LoanServiceUsed{" + "id=" + id + ", loanId=" + loanId + ", cusId=" + cusId + ", amount=" + amount + ", startDate=" + startDate + ", endDate=" + endDate + ", dateExpiredCount=" + dateExpiredCount + ", debtRepayAmount=" + debtRepayAmount + ", loanStatus=" + loanStatus + '}';
    }
    
    
}
