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

    public DepService() {
        
    }

    public DepService(int id, String description, BigDecimal minimumDep, int duringTime, double savingRate, double savingRateMinimum) {
        this.id = id;
        this.description = description;
        this.minimumDep = minimumDep;
        this.duringTime = duringTime;
        this.savingRate = savingRate;
        this.savingRateMinimum = savingRateMinimum;
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
    
    
}
