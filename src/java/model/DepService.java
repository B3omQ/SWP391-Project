/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;

/**
 *
 * @author JIGGER
 */
public class DepService {
    
    private int id;
    private String depServiceName; 
    private String description;
    private BigDecimal minimumDep;
    private int duringTime;
    private double savingRate;
    private double savingRateMinimum;
    private String reasonReject; 
    private String pendingStatus;

    public DepService() {
    }

    public DepService(int id, String depServiceName, String description, BigDecimal minimumDep, 
                      int duringTime, double savingRate, double savingRateMinimum, 
                      String reasonReject, String pendingStatus) {
        this.id = id;
        this.depServiceName = depServiceName;
        this.description = description;
        this.minimumDep = minimumDep;
        this.duringTime = duringTime;
        this.savingRate = savingRate;
        this.savingRateMinimum = savingRateMinimum;
        this.reasonReject = reasonReject;
        this.pendingStatus = pendingStatus;
    }

    
    
    
    

    public DepService(int id, String description, BigDecimal minimumDep, int duringTime, double savingRate) {
        this.id = id;
        this.description = description;
        this.minimumDep = minimumDep;
        this.duringTime = duringTime;
        this.savingRate = savingRate;
    }

    // Getters và Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDepServiceName() {
        return depServiceName;
    }

    public void setDepServiceName(String depServiceName) {
        this.depServiceName = depServiceName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getMinimumDep() {
        return minimumDep;
    }

    public void setMinimumDep(BigDecimal minimumDep) {
        this.minimumDep = minimumDep;
    }

    public int getDuringTime() {
        return duringTime;
    }

    public void setDuringTime(int duringTime) {
        this.duringTime = duringTime;
    }

    public double getSavingRate() {
        return savingRate;
    }

    public void setSavingRate(double savingRate) {
        this.savingRate = savingRate;
    }

    public double getSavingRateMinimum() {
        return savingRateMinimum;
    }

    public void setSavingRateMinimum(double savingRateMinimum) {
        this.savingRateMinimum = savingRateMinimum;
    }

    public String getReasonReject() {
        return reasonReject;
    }

    public void setReasonReject(String reasonReject) {
        this.reasonReject = reasonReject;
    }

    public String getPendingStatus() {
        return pendingStatus;
    }

    public void setPendingStatus(String pendingStatus) {
        this.pendingStatus = pendingStatus;
    }

    @Override
    public String toString() {
        return "DepService{" + "id=" + id + ", depServiceName=" + depServiceName + 
               ", description=" + description + ", minimumDep=" + minimumDep + 
               ", duringTime=" + duringTime + ", savingRate=" + savingRate + 
               ", savingRateMinimum=" + savingRateMinimum + ", reasonReject=" + reasonReject + 
               ", pendingStatus=" + pendingStatus + '}';
    }
}