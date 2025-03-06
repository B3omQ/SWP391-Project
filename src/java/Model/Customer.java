/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 *
 * @author JIGGER
 */
public class Customer {

    private int id;
    private String username;
    private String password;
    private String image;
    private String email;
    private String firstname;
    private String lastname;
    private String fullname;
    private String gender;
    private LocalDate dob;
    private String phone;
    private String Address;
    private int failAttempt;
    private LocalDateTime locktime;
    private BigDecimal wallet;

    

    public Customer() {
    }

    public Customer(int id, String image, String email, String firstname, String lastname, String gender, LocalDate dob, String phone, String Address) {
        this.id = id;
        this.image = image;
        this.email = email;
        this.firstname = firstname;
        this.lastname = lastname;
        this.gender = gender;
        this.dob = dob;
        this.phone = phone;
        this.Address = Address;
    } 
    public Customer(String username, String password, String email, String firstname, String lastname, String gender, LocalDate dob, String phone, String Address) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.firstname = firstname;
        this.lastname = lastname;
        this.gender = gender;
        this.dob = dob;
        this.phone = phone;
        this.Address = Address;
        this.wallet = BigDecimal.valueOf(50000.00);
    }
    
    
    public Customer(int id, String username, String password, String image, String email, String firstname, String lastname, String gender, LocalDate dob, String phone, String Address, int failAttempt, LocalDateTime locktime, BigDecimal wallet) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.image = image;
        this.email = email;
        this.firstname = firstname;
        this.lastname = lastname;
        this.gender = gender;
        this.dob = dob;
        this.phone = phone;
        this.Address = Address;
        this.failAttempt = failAttempt;
        this.locktime = locktime;
        this.wallet = wallet;
    }
    public Customer(String image,String username, String password, String email, String firstname, String lastname, String gender, LocalDate dob, String phone, String Address) {
        this.image = image;
        this.username = username;
        this.password = password;
        this.email = email;
        this.firstname = firstname;
        this.lastname = lastname;
        this.gender = gender;
        this.dob = dob;
        this.phone = phone;
        this.Address = Address;
        this.wallet = BigDecimal.valueOf(50000.00);
    }

    public String getFullname() {
        return lastname + " " + firstname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }
    
    

    public int getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getImage() {
        return image;
    }

    public String getEmail() {
        return email;
    }

    public String getFirstname() {
        return firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public String getGender() {
        return gender;
    }

    public LocalDate getDob() {
        return dob;
    }

    public String getPhone() {
        return phone;
    }

    public String getAddress() {
        return Address;
    }

    public int getFailAttempt() {
        return failAttempt;
    }

    public LocalDateTime getLocktime() {
        return locktime;
    }

    public BigDecimal getWallet() {
        return wallet;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public void setFailAttempt(int failAttempt) {
        this.failAttempt = failAttempt;
    }

    public void setLocktime(LocalDateTime locktime) {
        this.locktime = locktime;
    }

    public void setWallet(BigDecimal wallet) {
        this.wallet = wallet;
    }

    @Override
    public String toString() {
        return "Customer{" + "id=" + id + ", username=" + username + ", password=" + password + ", image=" + image + ", email=" + email + ", firstname=" + firstname + ", lastname=" + lastname + ", gender=" + gender + ", dob=" + dob + ", phone=" + phone + ", Address=" + Address + ", failAttempt=" + failAttempt + ", locktime=" + locktime + ", wallet=" + wallet + '}';
    }

}
