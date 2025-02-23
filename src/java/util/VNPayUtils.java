package util;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.*;

public class VNPayUtils {

    public static String hmacSHA512(String key, String data) {
        try {
            Mac hmac = Mac.getInstance("HmacSHA512");
            SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
            hmac.init(secretKey);
            byte[] hashBytes = hmac.doFinal(data.getBytes(StandardCharsets.UTF_8));

            StringBuilder hashHex = new StringBuilder();
            for (byte b : hashBytes) {
                hashHex.append(String.format("%02x", b));
            }
            return hashHex.toString();
        } catch (Exception e) {
            throw new RuntimeException("Lỗi mã hóa HMAC-SHA512", e);
        }
    }

    public static String getQueryString(Map<String, String> params) {
        List<String> fieldNames = new ArrayList<>(params.keySet());
        Collections.sort(fieldNames); // Sắp xếp theo thứ tự alphabet

        StringBuilder sb = new StringBuilder();
        for (String fieldName : fieldNames) {
            String value = params.get(fieldName);
            sb.append(fieldName).append("=")
              .append(URLEncoder.encode(value, StandardCharsets.UTF_8)) // Đảm bảo encoding chuẩn
              .append("&");
        }
        if (sb.length() > 0) {
            sb.deleteCharAt(sb.length() - 1); // Xóa ký tự `&` cuối cùng
        }

        return sb.toString();
    }
}
