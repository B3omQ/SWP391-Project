package controller.customer;

import dal.CustomerDAO;
import dal.DepHistoryDAO;
import dal.DepServiceUsedDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import model.Customer;
import model.DepServiceUsed;

public class WithdrawDepositServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy depositId từ request
        String depositIdStr = request.getParameter("depositId");
        int depositId;
        try {
            depositId = Integer.parseInt(depositIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/customer/Termsavings.jsp");
            return;
        }

        // Lấy thông tin khách hàng từ session
        Customer customer = (Customer) request.getSession().getAttribute("account");
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
            return;
        }
        int customerId = customer.getId();

        // Lấy thông tin khoản gửi
        DepServiceUsedDAO depServiceUsedDAO = new DepServiceUsedDAO();
        DepServiceUsed deposit = depServiceUsedDAO.getDepositById(depositId);
        if (deposit == null || deposit.getCusId() != customerId || !"ACTIVE".equalsIgnoreCase(deposit.getDepStatus())) {
            response.sendRedirect(request.getContextPath() + "/customer/Termsavings.jsp");
            return;
        }

        // Xử lý rút tiền
        try {
            // Tính toán số tiền rút (tiền gốc + lãi, giả định lãi suất 5%/năm để minh họa)
            BigDecimal principal = deposit.getAmount();
            long timeDiffMillis = System.currentTimeMillis() - deposit.getStartDate().getTime();
            long days = timeDiffMillis / (1000 * 60 * 60 * 24); // Số ngày từ ngày gửi đến hiện tại
            BigDecimal interestRate = new BigDecimal("0.05"); // Lãi suất 5%/năm
            BigDecimal interest = principal.multiply(interestRate).multiply(new BigDecimal(days))
                    .divide(new BigDecimal("365"), 2, BigDecimal.ROUND_HALF_UP); // Lãi = Gốc * Lãi suất * Số ngày / 365
            BigDecimal totalAmount = principal.add(interest);

            // Cộng tiền vào tài khoản thanh toán (wallet)
            CustomerDAO customerDAO = new CustomerDAO();
            BigDecimal currentBalance = customerDAO.getWalletByCustomerId(customerId);
            BigDecimal newBalance = currentBalance.add(totalAmount);
            boolean updated = customerDAO.updateWallet(customerId, newBalance);
            if (!updated) {
                request.getSession().setAttribute("error", "Không thể cập nhật số dư tài khoản!");
                response.sendRedirect(request.getContextPath() + "/customer/depositDetail.jsp?depositId=" + depositId);
                return;
            }

            // Đánh dấu khoản gửi là không hoạt động
            boolean statusUpdated = depServiceUsedDAO.updateDepositStatus(depositId, "INACTIVE");
            if (!statusUpdated) {
                request.getSession().setAttribute("error", "Không thể cập nhật trạng thái khoản gửi!");
                response.sendRedirect(request.getContextPath() + "/customer/depositDetail.jsp?depositId=" + depositId);
                return;
            }

            // Lưu lịch sử giao dịch vào DepHistory (chỉ lưu DSUId và Discription)
            DepHistoryDAO depHistoryDAO = new DepHistoryDAO();
            String description = "Rút tiền tiết kiệm: Gốc " + principal + " VND, Lãi " + interest + " VND, Tổng " + totalAmount + " VND";
            boolean historySaved = depHistoryDAO.addDepHistory(depositId, description);
            if (!historySaved) {
                System.err.println("Failed to save DepHistory for withdrawal: depositId=" + depositId);
            }

            // Cập nhật session với thông tin khách hàng mới
            Customer updatedCustomer = customerDAO.getCustomerById(customerId);
            request.getSession().setAttribute("account", updatedCustomer);

            // Chuyển hướng về trang chính với thông báo thành công
            request.getSession().setAttribute("success", "Rút tiền thành công! Số tiền " + totalAmount + " VND đã được chuyển vào tài khoản thanh toán.");
            response.sendRedirect(request.getContextPath() + "/customer/Termsavings.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi khi xử lý rút tiền: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/customer/depositDetail.jsp?depositId=" + depositId);
        }
    }
}