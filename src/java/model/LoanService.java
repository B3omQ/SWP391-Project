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

    public String getLoanServiceName() {
        return loanServiceName;
    }

    public String getDescription() {
        return description;
    }

    public int getDuringTime() {
        return duringTime;
    }

    public double getOnTermRate() {
        return onTermRate;
    }

    public double getPenaltyRate() {
        return penaltyRate;
    }

    public BigDecimal getMinimumLoan() {
        return minimumLoan;
    }

    public BigDecimal getMaximumLoan() {
        return maximumLoan;
    }

    public String getPendingStatus() {
        return pendingStatus;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setLoanServiceName(String loanServiceName) {
        this.loanServiceName = loanServiceName;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setDuringTime(int duringTime) {
        this.duringTime = duringTime;
    }

    public void setOnTermRate(double onTermRate) {
        this.onTermRate = onTermRate;
    }

    public void setPenaltyRate(double penaltyRate) {
        this.penaltyRate = penaltyRate;
    }

    public void setMinimumLoan(BigDecimal minimumLoan) {
        this.minimumLoan = minimumLoan;
    }

    public void setMaximumLoan(BigDecimal maximumLoan) {
        this.maximumLoan = maximumLoan;
    }

    public void setPendingStatus(String pendingStatus) {
        this.pendingStatus = pendingStatus;
    }



    @Override
    public String toString() {
        return "LoanService{" + "id=" + id + ", loanServiceName=" + loanServiceName + ", description=" + description + ", duringTime=" + duringTime + ", onTermRate=" + onTermRate + ", penaltyRate=" + penaltyRate + ", minimumLoan=" + minimumLoan + ", maximumLoan=" + maximumLoan + ", pendingStatus=" + pendingStatus + '}';
    }

}
