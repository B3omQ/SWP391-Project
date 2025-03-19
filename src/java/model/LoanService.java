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
    private String loanTypeRepay;
    private int duringTime;
    private int gracePeriod;   //thời gian ân hạn
    private double onTermRate;  //tỉ lệ lãi suất của ngân hàng khi trong thời gian ưu đãi (ví dụ vay tiền gói 12 tháng thì 6 tháng đầu với lãi suất này)
    private double afterTermRate; //tỉ lệ lãi suất của ngân hàng khi ngoài thời gian ưu đãi (vẫn là gói 12 tháng đó thì 6 tháng sau với lãi suất này)
    private double penaltyRate; //tỉ lệ lãi suất phạt của ngân hàng đối với khách hàng không trả nợ theo đúng định kì
    private BigDecimal minimumLoan;
    private BigDecimal maximumLoan;
    private String pendingStatus;
    private String reasonReject;

    public LoanService() {
    }

    public LoanService(int id, String loanServiceName, String description, String loanTypeRepay, int duringTime, int gracePeriod, double onTermRate, double afterTermRate, double penaltyRate, BigDecimal minimumLoan, BigDecimal maximumLoan, String pendingStatus, String reasonReject) {
        this.id = id;
        this.loanServiceName = loanServiceName;
        this.description = description;
        this.loanTypeRepay = loanTypeRepay;
        this.duringTime = duringTime;
        this.gracePeriod = gracePeriod;
        this.onTermRate = onTermRate;
        this.afterTermRate = afterTermRate;
        this.penaltyRate = penaltyRate;
        this.minimumLoan = minimumLoan;
        this.maximumLoan = maximumLoan;
        this.pendingStatus = pendingStatus;
        this.reasonReject = reasonReject;
    }
    
    

    public String getLoanTypeRepay() {
        return loanTypeRepay;
    }

    public String getReasonReject() {
        return reasonReject;
    }

    public void setLoanTypeRepay(String loanTypeRepay) {
        this.loanTypeRepay = loanTypeRepay;
    }

    public void setReasonReject(String reasonReject) {
        this.reasonReject = reasonReject;
    }

    public int getGracePeriod() {
        return gracePeriod;
    }

    public double getAfterTermRate() {
        return afterTermRate;
    }

    public void setGracePeriod(int gracePeriod) {
        this.gracePeriod = gracePeriod;
    }

    public void setAfterTermRate(double afterTermRate) {
        this.afterTermRate = afterTermRate;
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
