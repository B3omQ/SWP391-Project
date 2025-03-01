package controller.customer;

import dal.CustomerDAO;
import dal.DepHistoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
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

        // Lấy tham số từ VNPay
        Map<String, String> vnp_Params = new TreeMap<>();
        request.getParameterMap().forEach((key, values) -> vnp_Params.put(key, values[0]));

        // Lấy thông tin quan trọng
        String responseCode = vnp_Params.get("vnp_ResponseCode");
        String secureHash = vnp_Params.get("vnp_SecureHash");
        String txnRef = vnp_Params.get("vnp_TxnRef");
        String amountStr = vnp_Params.get("vnp_Amount");

        // Kiểm tra session và lấy customerId
        Object accountObj = request.getSession().getAttribute("account");
        if (accountObj == null) {
            request.setAttribute("error", "Phiên đăng nhập không hợp lệ!");
            request.getRequestDispatcher("/customer/error.jsp").forward(request, response);
            return;
        }
        Customer customer = (Customer) accountObj;
        int customerId = customer.getId();

        // Kiểm tra tham số hợp lệ
        if (txnRef == null || amountStr == null || secureHash == null) {
            request.setAttribute("error", "Tham số trả về từ VNPay không hợp lệ!");
            request.getRequestDispatcher("/customer/error.jsp").forward(request, response);
            return;
        }

        // Xóa secureHash để tạo lại hash kiểm tra
        vnp_Params.remove("vnp_SecureHash");
        vnp_Params.remove("vnp_SecureHashType");

        // Tạo query string và hash kiểm tra
        String queryString = VNPayUtils.getQueryString(vnp_Params);
        String generatedHash = VNPayUtils.hmacSHA512(VNP_HASH_SECRET, queryString);

        // Kiểm tra chữ ký
        if (!generatedHash.equalsIgnoreCase(secureHash)) {
            request.setAttribute("error", "Chữ ký không hợp lệ, giao dịch có thể đã bị thay đổi!");
            request.getRequestDispatcher("/customer/error.jsp").forward(request, response);
            return;
        }

        // Xử lý giao dịch thành công
        if ("00".equals(responseCode)) {
            try {
                // Lấy amount từ session
                BigDecimal amount = (BigDecimal) request.getSession().getAttribute("vnpayAmount");
                if (amount == null) {
                    amount = new BigDecimal(amountStr).divide(BigDecimal.valueOf(100), 2, BigDecimal.ROUND_HALF_UP);
                }

                CustomerDAO customerDAO = new CustomerDAO();
                BigDecimal currentBalance = customerDAO.getWalletByCustomerId(customerId);
                BigDecimal newBalance = currentBalance.add(amount);

                // Cập nhật số dư
                boolean updated = customerDAO.updateWallet(customerId, newBalance);
                if (!updated) {
                    request.setAttribute("error", "Không thể cập nhật số dư, vui lòng thử lại!");
                    request.getRequestDispatcher("/customer/error.jsp").forward(request, response);
                    return;
                }

                // Lưu lịch sử giao dịch
                DepHistoryDAO depHistoryDAO = new DepHistoryDAO();
                String description = "Nạp tiền qua VNPay - Mã GD: " + txnRef + " - Số tiền: " + amount.toString() + " VND";
                depHistoryDAO.addDepHistory(customerId, description); // DSUId = customerId

                // Cập nhật lại session
                Customer updatedCustomer = customerDAO.getCustomerById(customerId);
                request.getSession().setAttribute("account", updatedCustomer);

                // Chuyển hướng đến trang thành công
                request.setAttribute("amount", amount);
                request.setAttribute("newBalance", newBalance);
                request.getRequestDispatcher("/customer/success.jsp").forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Lỗi hệ thống khi xử lý giao dịch: " + e.getMessage());
                request.getRequestDispatcher("/customer/error.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Giao dịch không thành công! Mã lỗi: " + responseCode);
            request.getRequestDispatcher("/customer/error.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý callback từ VNPay";
    }
}