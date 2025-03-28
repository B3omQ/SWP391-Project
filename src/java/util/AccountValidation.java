package util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.time.LocalDate;
import java.time.Period;
import java.util.Base64;
import java.util.regex.Pattern;

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
        String regex = "^[a-zA-ZàáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴÈÉẸẺẼÊỀẾỆỂỄÌÍỊỈĨÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠÙÚỤỦŨƯỪỨỰỬỮỲÝỴỶỸĐ\\s]+$";
        return Pattern.matches(regex, input);
    }

    public boolean isValidImagePath(String filePath) {
        String fileName = filePath.substring(filePath.lastIndexOf("/") + 1);
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
        if (password.contains(" ")) {
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
            byte[] hash = md.digest(password.getBytes(StandardCharsets.UTF_8));
            return Base64.getEncoder().encodeToString(hash);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }

    public boolean checkPassword(String password, String hashedPassword) {
        String hashedInput = hashPassword(password);
        return hashedInput.equals(hashedPassword);
    }

    public String generateRandomPassword(int length) {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder();

        for (int i = 0; i < length; i++) {
            password.append(characters.charAt(random.nextInt(characters.length())));
        }
        return password.toString();
    }

    public static boolean isPositiveInteger(String str) {
        try {
            int num = Integer.parseInt(str);
            return num > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    // Thêm các phương thức validation mới
    public boolean isValidName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return false;
        }
        return isAlphabetic(name) && name.length() <= 50;
    }

    public boolean isValidGender(String gender) {
        return gender != null && (gender.equals("Nam") || gender.equals("Nữ") || gender.equals("Khác"));
    }

    public boolean isValidDateOfBirth(LocalDate dob) {
        if (dob == null) {
            return false;
        }
        LocalDate today = LocalDate.now();
        int age = Period.between(dob, today).getYears();
        return age >= 18;
    }
}