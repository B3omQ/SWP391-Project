package controller.customer;

import dal.CustomerDAO;
import dal.DepServiceUsedDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.List;
import model.DepServiceUsed;
import model.Customer;

/**
 *
 * @author emkob
 */
public class DepositValidationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Customer customer = (Customer) request.getSession().getAttribute("account");
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
            return;
        }
        int customerId = customer.getId();

        DepServiceUsedDAO depServiceUsedDAO = new DepServiceUsedDAO();
        List<DepServiceUsed> activeDeposits = depServiceUsedDAO.getActiveDepositsByCustomerId(customerId);
        String amountStr = request.getParameter("depositAmount");
        BigDecimal amount;
        CustomerDAO customerDAO = new CustomerDAO();

        try {
            amount = new BigDecimal(amountStr);
            if (amount.compareTo(BigDecimal.ZERO) <= 0) {
                request.getSession().setAttribute("error4", "Số tiền gửi phải lớn hơn 0!");
                response.sendRedirect(request.getContextPath() + "/customer/savemoney.jsp");
                return;
            }

            // Kiểm tra số tiền tối thiểu: 1,000,000 VND
            BigDecimal minimumAmount = new BigDecimal("1000000");
            if (amount.compareTo(minimumAmount) < 0) {
                request.getSession().setAttribute("error4", "Số tiền gửi tối thiểu là 1,000,000 VND!");
                response.sendRedirect(request.getContextPath() + "/customer/savemoney.jsp");
                return;
            }

            // Lấy số dư ví từ database và đồng bộ với session
            BigDecimal walletBalance = customerDAO.getWalletByCustomerId(customerId);
            if (walletBalance == null || amount.compareTo(walletBalance) > 0) {
                request.getSession().setAttribute("error4", "Số tiền gửi không được vượt quá số dư tài khoản");
                response.sendRedirect(request.getContextPath() + "/customer/savemoney.jsp");
                return;
            }

            // Đồng bộ số dư ví vào đối tượng customer trong session
            customer.setWallet(walletBalance);
            request.getSession().setAttribute("account", customer);

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error4", "Số tiền không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/customer/savemoney.jsp");
            return;
        }

        // Nếu vượt qua tất cả kiểm tra, tiếp tục xử lý gửi tiết kiệm
        request.getSession().setAttribute("depositAmount", amount);
        response.sendRedirect(request.getContextPath() + "/Calculation");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}