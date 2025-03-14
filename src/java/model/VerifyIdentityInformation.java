/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author JIGGER
 */
public class VerifyIdentityInformation {

    private int id;
    private Customer cusId;
    private String identityCardNumber;
    private String identityCardFrontSide;
    private String identityCardBackSide;
    private String reasonReject;
    private String portraitPhoto;
    private String pendingStatus;

    public VerifyIdentityInformation(int id, Customer cusId, String identityCardNumber, String identityCardFrontSide, String identityCardBackSide, String reasonReject, String portraitPhoto, String pendingStatus) {
        this.id = id;
        this.cusId = cusId;
        this.identityCardNumber = identityCardNumber;
        this.identityCardFrontSide = identityCardFrontSide;
        this.identityCardBackSide = identityCardBackSide;
        this.reasonReject = reasonReject;
        this.portraitPhoto = portraitPhoto;
        this.pendingStatus = pendingStatus;
    }


    public String getIdentityCardNumber() {
        return identityCardNumber;
    }

    public void setIdentityCardNumber(String identityCardNumber) {
        this.identityCardNumber = identityCardNumber;
    }
    

    public int getId() {
        return id;
    }

    public Customer getCusId() {
        return cusId;
    }

    public String getIdentityCardFrontSide() {
        return identityCardFrontSide;
    }

    public String getIdentityCardBackSide() {
        return identityCardBackSide;
    }

    public String getReasonReject() {
        return reasonReject;
    }

    public String getPortraitPhoto() {
        return portraitPhoto;
    }

    public String getPendingStatus() {
        return pendingStatus;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setCusId(Customer cusId) {
        this.cusId = cusId;
    }

    public void setIdentityCardFrontSide(String identityCardFrontSide) {
        this.identityCardFrontSide = identityCardFrontSide;
    }

    public void setIdentityCardBackSide(String identityCardBackSide) {
        this.identityCardBackSide = identityCardBackSide;
    }

    public void setReasonReject(String reasonReject) {
        this.reasonReject = reasonReject;
    }

    public void setPortraitPhoto(String portraitPhoto) {
        this.portraitPhoto = portraitPhoto;
    }

    public void setPendingStatus(String pendingStatus) {
        this.pendingStatus = pendingStatus;
    }

    @Override
    public String toString() {
        return "VerifyIdentityInformation{" + "id=" + id + ", cusId=" + cusId + ", identityCardNumber=" + identityCardNumber + ", identityCardFrontSide=" + identityCardFrontSide + ", identityCardBackSide=" + identityCardBackSide + ", reasonReject=" + reasonReject + ", portraitPhoto=" + portraitPhoto + ", pendingStatus=" + pendingStatus + '}';
    }


}
