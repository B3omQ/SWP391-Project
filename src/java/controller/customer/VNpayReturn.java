package controller.customer;

import dal.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Map;
import java.util.TreeMap;
import model.Customer;
import util.VNPayUtils;

public class VNpayReturn extends HttpServlet {
    private static final String VNP_HASH_SECRET = "GN5MEE6Q6ZYG941UUB76FYAA786W6NAX"; // Secret Key

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // Lấy tham số từ VNPAY
        Map<String, String> vnp_Params = new TreeMap<>();
        request.getParameterMap().forEach((key, values) -> vnp_Params.put(key, values[0]));

        // Lấy thông tin quan trọng
        String responseCode = vnp_Params.get("vnp_ResponseCode");
        String secureHash = vnp_Params.get("vnp_SecureHash");
        String txnRef = vnp_Params.get("vnp_TxnRef");
        String amountStr = vnp_Params.get("vnp_Amount"); 

        Object accountObj = request.getSession().getAttribute("account");
        if (accountObj == null) {
            request.setAttribute("error", "Không tìm thấy tài khoản trong session.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }
        int customerId = ((Customer) accountObj).getId(); 

        // Kiểm tra tham số hợp lệ
        if (txnRef == null || amountStr == null || secureHash == null) {
            request.setAttribute("error", "Tham số không hợp lệ.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Xóa `vnp_SecureHash` trước khi tạo hash
        vnp_Params.remove("vnp_SecureHash");
        vnp_Params.remove("vnp_SecureHashType");

        // Tạo query string chuẩn
        String queryString = VNPayUtils.getQueryString(vnp_Params);

        // Tạo hash để kiểm tra
        String generatedHash = VNPayUtils.hmacSHA512(VNP_HASH_SECRET, queryString);

        // Kiểm tra chữ ký
        if (!generatedHash.equalsIgnoreCase(secureHash)) {
            request.setAttribute("error", "Chữ ký không hợp lệ.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Nếu giao dịch thành công, cập nhật số dư
        if ("00".equals(responseCode)) {
            try {
                BigDecimal amount = new BigDecimal(amountStr).divide(BigDecimal.valueOf(100)); // Chia 100 để có đúng số tiền

                CustomerDAO customerDAO = new CustomerDAO();
                BigDecimal currentBalance = customerDAO.getWalletByCustomerId(customerId);
                BigDecimal newBalance = currentBalance.add(amount);

                boolean updated = customerDAO.updateWallet(customerId, newBalance);
                if (updated) {
                    request.setAttribute("amount", amount);
                    request.setAttribute("newBalance", newBalance);
                    request.getRequestDispatcher("success.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Cập nhật số dư thất bại.");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Giao dịch thất bại! Mã lỗi: " + responseCode);
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}