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
import model.Customer;
import model.DepServiceUsed;

public class WithdrawDepositServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String depositIdStr = request.getParameter("depositId");
        int depositId;
        try {
            depositId = Integer.parseInt(depositIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/customer/Termsavings.jsp");
            return;
        }

        Customer customer = (Customer) request.getSession().getAttribute("account");
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
            return;
        }
        int customerId = customer.getId();

        DepServiceUsedDAO depServiceUsedDAO = new DepServiceUsedDAO();
        DepServiceUsed deposit = depServiceUsedDAO.getDepositById(depositId);
        if (deposit == null || deposit.getCusId() != customerId || !"ACTIVE".equalsIgnoreCase(deposit.getDepStatus())) {
            response.sendRedirect(request.getContextPath() + "/customer/Termsavings.jsp");
            return;
        }

        try {
            BigDecimal principal = deposit.getAmount();
            long timeDiffMillis = System.currentTimeMillis() - deposit.getStartDate().getTime();
            long days = timeDiffMillis / (1000 * 60 * 60 * 24);
            BigDecimal interestRate = new BigDecimal("0.05");
            BigDecimal interest = principal.multiply(interestRate).multiply(new BigDecimal(days))
                    .divide(new BigDecimal("365"), 2, BigDecimal.ROUND_HALF_UP);
            BigDecimal totalAmount = principal.add(interest);

            CustomerDAO customerDAO = new CustomerDAO();
            BigDecimal currentBalance = customerDAO.getWalletByCustomerId(customerId);
            BigDecimal newBalance = currentBalance.add(totalAmount);
            boolean updated = customerDAO.updateWallet(customerId, newBalance);
            if (!updated) {
                request.getSession().setAttribute("error", "Không thể cập nhật số dư tài khoản!");
                response.sendRedirect(request.getContextPath() + "/customer/depositDetail.jsp?depositId=" + depositId);
                return;
            }

            boolean statusUpdated = depServiceUsedDAO.updateDepositStatus(depositId, "INACTIVE");
            if (!statusUpdated) {
                request.getSession().setAttribute("error", "Không thể cập nhật trạng thái khoản gửi!");
                response.sendRedirect(request.getContextPath() + "/customer/depositDetail.jsp?depositId=" + depositId);
                return;
            }

            DepHistoryDAO depHistoryDAO = new DepHistoryDAO();
            boolean historySaved = depHistoryDAO.addDepHistory(depositId, "Rút tiền tiết kiệm", principal, interest, totalAmount, customerId);
            if (!historySaved) {
                System.err.println("Failed to save DepHistory for withdrawal: depositId=" + depositId);
            }

            Customer updatedCustomer = customerDAO.getCustomerById(customerId);
            request.getSession().setAttribute("account", updatedCustomer);

            request.getSession().setAttribute("success", "Rút tiền thành công! Số tiền " + totalAmount + " VND đã được chuyển vào tài khoản thanh toán.");
            response.sendRedirect(request.getContextPath() + "/customer/Termsavings.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi khi xử lý rút tiền: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/customer/depositDetail.jsp?depositId=" + depositId);
        }
    }
}