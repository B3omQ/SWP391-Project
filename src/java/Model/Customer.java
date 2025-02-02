package Model;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.LocalDate;

public class Customer {

    private int id;
    private String username;
    private String password;
    private String email;
    private String firstName;
    private String lastName;
    private String phone;
    private String address;
    private BigDecimal wallet; // Đổi sang kiểu BigDecimal để lưu số tiền
    private int failedAttempts; // Số lần nhập sai mật khẩu
    private LocalDateTime lockTime; // Thời gian khóa tài khoản
    private String gender; // Giới tính
    private LocalDate dob; // Ngày sinh

    // Constructor không tham số
    public Customer() {
    }

    // Constructor với tất cả các tham số
    public Customer(int id, String username, String password, String email, 
                    String firstName, String lastName, String phone, String address, 
                    BigDecimal wallet, int failedAttempts, LocalDateTime lockTime, 
                    String gender, LocalDate dob) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.phone = phone;
        this.address = address;
        this.wallet = wallet;
        this.failedAttempts = failedAttempts;
        this.lockTime = lockTime;
        this.gender = gender;
        this.dob = dob;
    }

    // Getters và Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public BigDecimal getWallet() {
        return wallet;
    }

    public void setWallet(BigDecimal wallet) {
        this.wallet = wallet;
    }

    public int getFailedAttempts() {
        return failedAttempts;
    }

    public void setFailedAttempts(int failedAttempts) {
        this.failedAttempts = failedAttempts;
    }

    public LocalDateTime getLockTime() {
        return lockTime;
    }

    public void setLockTime(LocalDateTime lockTime) {
        this.lockTime = lockTime;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public LocalDate getDob() {
        return dob;
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }
}
