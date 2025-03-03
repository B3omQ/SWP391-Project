/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;

/**
 *
 * @author emkob
 */
public class DepService {
    private int id;
    private String description;
    private BigDecimal minimumDep;
    private Integer duringTime; // Có thể null
    private BigDecimal savingRate; // Có thể null

    public DepService() {
    }

    public DepService(int id, String description, BigDecimal minimumDep, Integer duringTime, BigDecimal savingRate) {
        this.id = id;
        this.description = description;
        this.minimumDep = minimumDep;
        this.duringTime = duringTime;
        this.savingRate = savingRate;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public Integer getDuringTime() {
        return duringTime;
    }

    public void setDuringTime(Integer duringTime) {
        this.duringTime = duringTime;
    }

    public BigDecimal getSavingRate() {
        return savingRate;
    }

    public void setSavingRate(BigDecimal savingRate) {
        this.savingRate = savingRate;
    }

    @Override
    public String toString() {
        return "DepService{" +
                "id=" + id +
                ", description='" + description + '\'' +
                ", minimumDep=" + minimumDep +
                ", duringTime=" + duringTime +
                ", savingRate=" + savingRate +
                '}';
    }
}
