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
public class Staff {

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
    private BigDecimal salary;
    private int failAttempt;
    private LocalDateTime locktime;
    private Role roleId;

    public Staff() {
    }

//    public Staff(int id, String password, String image, String email, String firstname, String lastname, String gender, LocalDate dob, String phone, String Address) {
//        this.id = id;
//        this.password = password;
//        this.image = image;
//        this.email = email;
//        this.firstname = firstname;
//        this.lastname = lastname;
//        this.gender = gender;
//        this.dob = dob;
//        this.phone = phone;
//        this.Address = Address;
//    }

    public Staff(int id, String username, String password, String image, String email, String firstname, String lastname, String gender, LocalDate dob, String phone, String Address, Role roleId) {
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
        this.roleId = roleId;
    }  
    
    public Staff(int id, String username, String password, String image, String email, String firstname, String lastname, String gender, LocalDate dob, String phone, String Address, BigDecimal salary, int failAttempt, LocalDateTime locktime, Role roleId) {
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
        this.salary = salary;
        this.failAttempt = failAttempt;
        this.locktime = locktime;
        this.roleId = roleId;
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

    public BigDecimal getSalary() {
        return salary;
    }

    public int getFailAttempt() {
        return failAttempt;
    }

    public LocalDateTime getLocktime() {
        return locktime;
    }

    public Role getRoleId() {
        return roleId;
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

    public void setSalary(BigDecimal salary) {
        this.salary = salary;
    }

    public void setFailAttempt(int failAttempt) {
        this.failAttempt = failAttempt;
    }

    public void setLocktime(LocalDateTime locktime) {
        this.locktime = locktime;
    }

    public void setRoleId(Role roleId) {
        this.roleId = roleId;
    }

    @Override
    public String toString() {
        return "Staff{" + "id=" + id + ", username=" + username + ", password=" + password + ", image=" + image + ", email=" + email + ", firstname=" + firstname + ", lastname=" + lastname + ", gender=" + gender + ", dob=" + dob + ", phone=" + phone + ", Address=" + Address + ", salary=" + salary + ", failAttempt=" + failAttempt + ", locktime=" + locktime + ", roleId=" + roleId + '}';
    }

}
