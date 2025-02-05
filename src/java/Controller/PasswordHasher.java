/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.nio.charset.StandardCharsets;
/**
 *
 * @author emkob
 */
public class PasswordHasher {

    // Hàm để hash mật khẩu bằng SHA-256
    public String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes(StandardCharsets.UTF_8)); // Sử dụng UTF-8
            return Base64.getEncoder().encodeToString(hash);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }

    public static void main(String[] args) {
        PasswordHasher hasher = new PasswordHasher();
        String password = "Test@1234";
        String hashedPassword = hasher.hashPassword(password);
        System.out.println("Hashed Password: " + hashedPassword);
    }
}