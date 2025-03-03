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
    private String description;
    private BigDecimal minimumDep;
    private int duringTime;
    private double savingRate;
    private double savingRateMinimum;
    private String pendingStatus;

    public DepService() {
        
    }

    public DepService(int id, String description, BigDecimal minimumDep, int duringTime, double savingRate, double savingRateMinimum, String pendingStatus) {
        this.id = id;
        this.description = description;
        this.minimumDep = minimumDep;
        this.duringTime = duringTime;
        this.savingRate = savingRate;
        this.savingRateMinimum = savingRateMinimum;
        this.pendingStatus = pendingStatus;
    }

    public int getId() {
        return id;
    }

    public String getDescription() {
        return description;
    }

    public BigDecimal getMinimumDep() {
        return minimumDep;
    }

    public int getDuringTime() {
        return duringTime;
    }

    public double getSavingRate() {
        return savingRate;
    }

    public double getSavingRateMinimum() {
        return savingRateMinimum;
    }

    public String getPendingStatus() {
        return pendingStatus;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setMinimumDep(BigDecimal minimumDep) {
        this.minimumDep = minimumDep;
    }

    public void setDuringTime(int duringTime) {
        this.duringTime = duringTime;
    }

    public void setSavingRate(double savingRate) {
        this.savingRate = savingRate;
    }

    public void setSavingRateMinimum(double savingRateMinimum) {
        this.savingRateMinimum = savingRateMinimum;
    }

    public void setPendingStatus(String pendingStatus) {
        this.pendingStatus = pendingStatus;
    }

    @Override
    public String toString() {
        return "DepService{" + "id=" + id + ", description=" + description + ", minimumDep=" + minimumDep + ", duringTime=" + duringTime + ", savingRate=" + savingRate + ", savingRateMinimum=" + savingRateMinimum + ", pendingStatus=" + pendingStatus + '}';
    }

    
    
}
