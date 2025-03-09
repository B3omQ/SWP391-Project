/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;

/**
 *
 * @author LAPTOP
 */
public class LoanService {

    private int id;
    private String loanServiceName;
    private String description;
    private int duringTime;
    private double onTermRate;
    private double penaltyRate;
    private BigDecimal minimumLoan;
    private BigDecimal maximumLoan;
    private String pendingStatus;

    public LoanService() {
    }

    public LoanService(int id, String loanServiceName, String description, int duringTime, double onTermRate, double penaltyRate, BigDecimal minimumLoan, BigDecimal maximumLoan, String pendingStatus) {
        this.id = id;
        this.loanServiceName = loanServiceName;
        this.description = description;
        this.duringTime = duringTime;
        this.onTermRate = onTermRate;
        this.penaltyRate = penaltyRate;
        this.minimumLoan = minimumLoan;
        this.maximumLoan = maximumLoan;
        this.pendingStatus = pendingStatus;
    }

    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLoanServiceName() {
        return loanServiceName;
    }

    public void setLoanServiceName(String loanServiceName) {
        this.loanServiceName = loanServiceName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getDuringTime() {
        return duringTime;
    }

    public void setDuringTime(int duringTime) {
        this.duringTime = duringTime;
    }

    public double getOnTermRate() {
        return onTermRate;
    }

    public void setOnTermRate(float onTermRate) {
        this.onTermRate = onTermRate;
    }

    public double getPenaltyRate() {
        return penaltyRate;
    }

    public void setPenaltyRate(float penaltyRate) {
        this.penaltyRate = penaltyRate;
    }

    public BigDecimal getMinimumLoan() {
        return minimumLoan;
    }

    public void setMinimumLoan(BigDecimal minimumLoan) {
        this.minimumLoan = minimumLoan;
    }

    public BigDecimal getMaximumLoan() {
        return maximumLoan;
    }

    public void setMaximumLoan(BigDecimal maximumLoan) {
        this.maximumLoan = maximumLoan;
    }

    public String getPendingStatus() {
        return pendingStatus;
    }

    public void setPendingStatus(String pendingStatus) {
        this.pendingStatus = pendingStatus;
    }

    @Override
    public String toString() {
        return "LoanService{" + "id=" + id + ", loanServiceName=" + loanServiceName + ", description=" + description + ", duringTime=" + duringTime + ", onTermRate=" + onTermRate + ", penaltyRate=" + penaltyRate + ", minimumLoan=" + minimumLoan + ", maximumLoan=" + maximumLoan + ", pendingStatus=" + pendingStatus + '}';
    }
    
}
