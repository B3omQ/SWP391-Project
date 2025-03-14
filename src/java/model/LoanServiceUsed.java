/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 *
 * @author JIGGER
 */
public class LoanServiceUsed {
    
    private int id;
    private LoanService loanId;
    private Customer cusId;
    private BigDecimal amount;
    private Timestamp startDate;
    private Timestamp endDate;
    private int dateExpiredCount;
    private BigDecimal debtRepayAmount;
    private String incomeVertification;
    private String loanStatus;

    public LoanServiceUsed() {
    }

    public LoanServiceUsed(int id, LoanService loanId, Customer cusId, BigDecimal amount, Timestamp startDate, Timestamp endDate, int dateExpiredCount, BigDecimal debtRepayAmount, String incomeVertification, String loanStatus) {
        this.id = id;
        this.loanId = loanId;
        this.cusId = cusId;
        this.amount = amount;
        this.startDate = startDate;
        this.endDate = endDate;
        this.dateExpiredCount = dateExpiredCount;
        this.debtRepayAmount = debtRepayAmount;
        this.incomeVertification = incomeVertification;
        this.loanStatus = loanStatus;
    }

    public int getId() {
        return id;
    }

    public LoanService getLoanId() {
        return loanId;
    }

    public Customer getCusId() {
        return cusId;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public Timestamp getStartDate() {
        return startDate;
    }

    public Timestamp getEndDate() {
        return endDate;
    }

    public int getDateExpiredCount() {
        return dateExpiredCount;
    }

    public BigDecimal getDebtRepayAmount() {
        return debtRepayAmount;
    }

    public String getIncomeVertification() {
        return incomeVertification;
    }

    public String getLoanStatus() {
        return loanStatus;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setLoanId(LoanService loanId) {
        this.loanId = loanId;
    }

    public void setCusId(Customer cusId) {
        this.cusId = cusId;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    public void setEndDate(Timestamp endDate) {
        this.endDate = endDate;
    }

    public void setDateExpiredCount(int dateExpiredCount) {
        this.dateExpiredCount = dateExpiredCount;
    }

    public void setDebtRepayAmount(BigDecimal debtRepayAmount) {
        this.debtRepayAmount = debtRepayAmount;
    }

    public void setIncomeVertification(String incomeVertification) {
        this.incomeVertification = incomeVertification;
    }

    public void setLoanStatus(String loanStatus) {
        this.loanStatus = loanStatus;
    }

    @Override
    public String toString() {
        return "LoanServiceUsed{" + "id=" + id + ", loanId=" + loanId + ", cusId=" + cusId + ", amount=" + amount + ", startDate=" + startDate + ", endDate=" + endDate + ", dateExpiredCount=" + dateExpiredCount + ", debtRepayAmount=" + debtRepayAmount + ", incomeVertification=" + incomeVertification + ", loanStatus=" + loanStatus + '}';
    }
    
    
    
}
