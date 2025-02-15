/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.regex.Pattern;

/**
 *
 * @author emkob
 */
public class AccountValidation {

    public AccountValidation() {

    }

    public boolean isValidateImage(String fileName) {
        return fileName != null && fileName.matches(".*\\.(jpg|jpeg|png|gif)$");
    }

    private static final Pattern EMAIL_PATTERN
            = Pattern.compile("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$");

    private static final Pattern PHONE_PATTERN
            = Pattern.compile("^0\\d{9}$");

    public boolean checkMatching(String password, String cPassword) {
        return password.equals(cPassword);
    }

    public boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email).matches();
    }

    public boolean isValidPhone(String phone) {
        return phone != null && PHONE_PATTERN.matcher(phone).matches();
    }

    public boolean isAlphabetic(String input) {
        // Regular expression that matches letters, both uppercase and lowercase, including Vietnamese characters
        String regex = "^[a-zA-ZàáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴÈÉẸẺẼÊỀẾỆỂỄÌÍỊỈĨÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠÙÚỤỦŨƯỪỨỰỬỮỲÝỴỶỸĐ\\s]+$";
        return Pattern.matches(regex, input);
    }

    public boolean isValidImagePath(String filePath) {
        // Lấy phần tên file từ đường dẫn
        String fileName = filePath.substring(filePath.lastIndexOf("/") + 1);

        // Regex kiểm tra định dạng file (.jpg, .jpeg, .png)
        return fileName.matches("(?i)^.*\\.(jpg|jpeg|png)$");
    }

    public boolean isValidPhoneNumber(String phone) {
        return phone != null && phone.matches("^\\d{10,11}$");
    }

    public boolean isValidAddress(String address) {
        return address != null && !address.trim().isEmpty();
    }

    public String normalizeInput(String input) {
        if (input == null) {
            return "";
        }
        String result = input.trim().replaceAll("\\s+", " ");
        if (result.equals(" ")) {
            return "";
        }
        String[] words = result.split(" ");
        StringBuilder capitalized = new StringBuilder();
        for (String word : words) {
            if (word.length() > 0) {
                capitalized.append(Character.toUpperCase(word.charAt(0))).append(word.substring(1).toLowerCase()).append(" ");
            }
        }
        return capitalized.toString().trim();
    }

    public boolean checkHashOfPassword(String password) {
        if (password.length() < 8) {
            return false;
        }
        if (password.contains(" ")) { // Kiểm tra dấu cách
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
            byte[] hash = md.digest(password.getBytes(StandardCharsets.UTF_8)); // Sử dụng UTF-8
            return Base64.getEncoder().encodeToString(hash);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }

    public boolean checkPassword(String password, String hashedPassword) {
        String hashedInput = hashPassword(password);
        return hashedInput.equals(hashedPassword);
    }
}
