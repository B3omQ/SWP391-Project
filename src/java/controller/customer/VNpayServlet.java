package controller.customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import util.VNPayUtils;

/**
 *
 * @author emkob
 */
public class VNpayServlet extends HttpServlet {
    private static final String VNP_TMN_CODE = "ZEXZKZK8";
    private static final String VNP_HASH_SECRET = "GN5MEE6Q6ZYG941UUB76FYAA786W6NAX";
    private static final String VNP_URL = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
private static final String RETURN_URL = "http://localhost:8080/BankingSystem/VNpayReturn";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        try {
            String amountStr = request.getParameter("amount");
            if (amountStr == null || amountStr.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Số tiền không hợp lệ!");
                return;
            }

            BigDecimal amount = new BigDecimal(amountStr);
            if (amount.compareTo(BigDecimal.ZERO) <= 0) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Số tiền phải lớn hơn 0!");
                return;
            }

            request.getSession().setAttribute("vnpayAmount", amount);

            BigDecimal vnpayAmount = amount.multiply(BigDecimal.valueOf(100));
            String orderId = "" + System.currentTimeMillis();

            Map<String, String> vnp_Params = new HashMap<>();
            vnp_Params.put("vnp_Version", "2.1.0");
            vnp_Params.put("vnp_Command", "pay");
            vnp_Params.put("vnp_TmnCode", VNP_TMN_CODE);
            vnp_Params.put("vnp_Amount", String.valueOf(vnpayAmount));
            vnp_Params.put("vnp_CurrCode", "VND");
            vnp_Params.put("vnp_TxnRef", orderId);
            vnp_Params.put("vnp_OrderInfo", "Nap tien vao tai khoan");
            vnp_Params.put("vnp_OrderType", "topup");
            vnp_Params.put("vnp_Locale", "vn");
            vnp_Params.put("vnp_ReturnUrl", RETURN_URL);
            vnp_Params.put("vnp_IpAddr", request.getRemoteAddr());
            vnp_Params.put("vnp_CreateDate", new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));

            List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
            Collections.sort(fieldNames);
            StringBuilder hashData = new StringBuilder();
            StringBuilder query = new StringBuilder();

            for (String fieldName : fieldNames) {
                String value = vnp_Params.get(fieldName);
                if (value != null && !value.isEmpty()) {
                    hashData.append(fieldName).append('=').append(URLEncoder.encode(value, StandardCharsets.UTF_8));
                    query.append(fieldName).append('=').append(URLEncoder.encode(value, StandardCharsets.UTF_8));
                    if (!fieldName.equals(fieldNames.get(fieldNames.size() - 1))) {
                        hashData.append('&');
                        query.append('&');
                    }
                }
            }

            String secureHash = VNPayUtils.hmacSHA512(VNP_HASH_SECRET, hashData.toString());
            query.append("&vnp_SecureHash=").append(secureHash);

            String paymentUrl = VNP_URL + "?" + query.toString();
            response.sendRedirect(paymentUrl);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Số tiền không đúng định dạng!");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống khi tạo thanh toán!");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý thanh toán VNPay";
    }
}