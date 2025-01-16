package Validation;

import java.util.regex.Pattern;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class AccountValidation {

    public String checkRole(String role) {
        if (role.equals("customer")) {
            return "customer";
        }
        if (role.equals("staff")) {
            return "staff";
        }
        return "admin";
    }

    public boolean checkMatching(String password, String cPassword) {
        return password.equals(cPassword);
    }

    public boolean checkHashOfPassword(String password) {
        if (password.length() < 8) {
            return false;
        }

        boolean hasUppercase = Pattern.compile("[A-Z]").matcher(password).find();

        boolean hasLowercase = Pattern.compile("[a-z]").matcher(password).find();

        boolean hasDigit = Pattern.compile("[0-9]").matcher(password).find();

        boolean hasSpecialChar = Pattern.compile("[@#$%^&+=!~(){}\\[\\]\\-]").matcher(password).find();

        return hasUppercase && hasLowercase && hasDigit && hasSpecialChar;
    }

    public String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            return Base64.getEncoder().encodeToString(hash);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error");
        }
    }

    public boolean checkPassword(String password, String hashedPassword) {
        String hashedInput = hashPassword(password);
        return hashedInput.equals(hashedPassword);
    }
}
