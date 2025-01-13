package Validation;

import java.util.regex.Pattern;

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
}
