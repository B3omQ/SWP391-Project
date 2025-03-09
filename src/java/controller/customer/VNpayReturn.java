package controller.customer;

import dal.CustomerDAO;
import dal.DepHistoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Map;
import java.util.TreeMap;
import model.Customer;
import util.VNPayUtils;

public class VNpayReturn extends HttpServlet {
    private static final String VNP_HASH_SECRET = "GN5MEE6Q6ZYG941UUB76FYAA786W6NAX";

    @Override
    public void init() throws ServletException {
        System.out.println("VNpayReturn Servlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("VNpayReturn doGet called with responseCode: " + request.getParameter("vnp_ResponseCode"));

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        Map<String, String> vnp_Params = new TreeMap<>();
        request.getParameterMap().forEach((key, values) -> vnp_Params.put(key, values[0]));

        String responseCode = vnp_Params.get("vnp_ResponseCode");
        String secureHash = vnp_Params.get("vnp_SecureHash");
        String txnRef = vnp_Params.get("vnp_TxnRef");
        String amountStr = vnp_Params.get("vnp_Amount");

        Object accountObj = request.getSession().getAttribute("account");
        if (accountObj == null) {
            request.setAttribute("error", "Phiên đăng nhập không hợp lệ!");
            request.getRequestDispatcher("/customer/error.jsp").forward(request, response);
            return;
        }
        Customer customer = (Customer) accountObj;
        int customerId = customer.getId();

        if (txnRef == null || amountStr == null || secureHash == null) {
            request.setAttribute("error", "Tham số trả về từ VNPay không hợp lệ!");
            request.getRequestDispatcher("/customer/error.jsp").forward(request, response);
            return;
        }

        vnp_Params.remove("vnp_SecureHash");
        vnp_Params.remove("vnp_SecureHashType");

        String queryString = VNPayUtils.getQueryString(vnp_Params);
        String generatedHash = VNPayUtils.hmacSHA512(VNP_HASH_SECRET, queryString);

        if (!generatedHash.equalsIgnoreCase(secureHash)) {
            request.setAttribute("error", "Chữ ký không hợp lệ, giao dịch có thể đã bị thay đổi!");
            request.getRequestDispatcher("/customer/error.jsp").forward(request, response);
            return;
        }

        if ("00".equals(responseCode)) {
            try {
                BigDecimal amount = (BigDecimal) request.getSession().getAttribute("vnpayAmount");
                if (amount == null) {
                    amount = new BigDecimal(amountStr).divide(BigDecimal.valueOf(100), 2, BigDecimal.ROUND_HALF_UP);
                }

                CustomerDAO customerDAO = new CustomerDAO();
                BigDecimal currentBalance = customerDAO.getWalletByCustomerId(customerId);
                BigDecimal newBalance = currentBalance.add(amount);

                boolean updated = customerDAO.updateWallet(customerId, newBalance);
                if (!updated) {
                    request.setAttribute("error", "Không thể cập nhật số dư, vui lòng thử lại!");
                    request.getRequestDispatcher("/customer/error.jsp").forward(request, response);
                    return;
                }

                // Lưu lịch sử nạp tiền vào DepHistory với DSUId = null
                DepHistoryDAO depHistoryDAO = new DepHistoryDAO();
                String description = "Nạp tiền qua VNPay - Mã GD: " + txnRef;
                // Sử dụng null cho DSUId thay vì -1
                boolean historySaved = depHistoryDAO.addDepHistory(null, description, amount);
                if (!historySaved) {
                    System.out.println("❌ Lỗi: Không thể lưu lịch sử nạp tiền cho giao dịch " + txnRef);
                } else {
                    System.out.println("✅ Đã lưu lịch sử nạp tiền: " + description + ", Amount: " + amount);
                }

                Customer updatedCustomer = customerDAO.getCustomerById(customerId);
                request.getSession().setAttribute("account", updatedCustomer);

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