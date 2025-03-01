package controller.customer;

import dal.CustomerDAO;
import dal.DepServiceUsedDAO;
import dal.DepHistoryDAO;
import model.Customer;
import model.DepServiceUsed;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import controller.calculation.InterestCalculator;

public class VerifyingOtp extends HttpServlet {
    private CustomerDAO customerDAO = new CustomerDAO();
    private DepServiceUsedDAO depServiceUsedDAO = new DepServiceUsedDAO();
    private DepHistoryDAO depHistoryDAO = new DepHistoryDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userOtp = request.getParameter("otp");
        String generatedOtp = (String) session.getAttribute("otp");

        if (generatedOtp == null) {
            response.sendRedirect("auth/template/login.jsp");
            return;
        }

        if (userOtp != null && userOtp.equals(generatedOtp)) {
            session.removeAttribute("otp");

            if (session.getAttribute("staff") != null) {
                // Staff không có tiết kiệm, chuyển hướng thẳng
                response.sendRedirect("profile-manager");
            } else {
                // Customer: Xử lý đáo hạn trước khi chuyển hướng
                Customer customer = (Customer) session.getAttribute("account");
                if (customer != null) {
                    processMaturedDeposits(customer, session);
                }
                response.sendRedirect("customer/Customer.jsp");
            }
        } else {
            session.setAttribute("otpError", "Mã OTP không đúng, vui lòng thử lại!");
            response.sendRedirect(request.getContextPath() + "/auth/template/otp.jsp");
        }
    }

    private void processMaturedDeposits(Customer customer, HttpSession session) {
        List<DepServiceUsed> maturedDeposits = depServiceUsedDAO.getDepServiceUsedByCustomerId(customer.getId());
        LocalDateTime now = LocalDateTime.now();
        boolean hasProcessed = false;

        for (DepServiceUsed deposit : maturedDeposits) {
            if ("ACTIVE".equals(deposit.getDepStatus()) && deposit.getEndDate().toLocalDateTime().isBefore(now)) {
                processMaturedDeposit(deposit, customer);
                hasProcessed = true;
            }
        }

        if (hasProcessed) {
            session.setAttribute("success", "Đã tự động xử lý các khoản tiết kiệm đáo hạn!");
        }

        customer.setWallet(customerDAO.getWalletByCustomerId(customer.getId()));
        session.setAttribute("account", customer);
    }

    private void processMaturedDeposit(DepServiceUsed deposit, Customer customer) {
        BigDecimal principal = deposit.getAmount();
        BigDecimal savingRate = depServiceUsedDAO.getSavingRateByDepId(deposit.getDepId());
        int termMonths = calculateTermMonths(deposit.getStartDate(), deposit.getEndDate());
        BigDecimal interest = InterestCalculator.calculateInterest(principal, savingRate, termMonths);
        BigDecimal totalAmount = principal.add(interest);

        String maturityAction = deposit.getMaturityAction() != null ? deposit.getMaturityAction() : "withdrawAll";

        depServiceUsedDAO.updateDepStatus(deposit.getId(), "COMPLETED");

        switch (maturityAction) {
            case "withdrawInterest":
                BigDecimal newBalance = customerDAO.getWalletByCustomerId(customer.getId()).add(interest);
                customerDAO.updateWallet(customer.getId(), newBalance);
                renewDeposit(deposit, principal, customer);
                depHistoryDAO.addDepHistory(deposit.getId(), "Đáo hạn tự động: Rút lãi " + interest + " VND, gửi lại gốc " + principal + " VND");
                break;

            case "renewAll":
                renewDeposit(deposit, totalAmount, customer);
                depHistoryDAO.addDepHistory(deposit.getId(), "Đáo hạn tự động: Gửi lại toàn bộ " + totalAmount + " VND");
                break;

            case "withdrawAll":
                newBalance = customerDAO.getWalletByCustomerId(customer.getId()).add(totalAmount);
                customerDAO.updateWallet(customer.getId(), newBalance);
                depHistoryDAO.addDepHistory(deposit.getId(), "Đáo hạn tự động: Rút toàn bộ " + totalAmount + " VND");
                break;

            default:
                newBalance = customerDAO.getWalletByCustomerId(customer.getId()).add(totalAmount);
                customerDAO.updateWallet(customer.getId(), newBalance);
                depHistoryDAO.addDepHistory(deposit.getId(), "Đáo hạn tự động: Rút toàn bộ (mặc định) " + totalAmount + " VND");
        }
    }

    private void renewDeposit(DepServiceUsed oldDeposit, BigDecimal amount, Customer customer) {
        DepServiceUsed newDep = new DepServiceUsed(
            0, oldDeposit.getDepId(), customer.getId(), oldDeposit.getDepTypeId(),
            amount, Timestamp.valueOf(LocalDateTime.now()),
            Timestamp.valueOf(LocalDateTime.now().plusMonths(calculateTermMonths(oldDeposit.getStartDate(), oldDeposit.getEndDate()))),
            "ACTIVE", oldDeposit.getMaturityAction()
        );
        depServiceUsedDAO.addDepServiceUsed(newDep);
    }

    private int calculateTermMonths(Timestamp start, Timestamp end) {
        LocalDateTime startDate = start.toLocalDateTime();
        LocalDateTime endDate = end.toLocalDateTime();
        return (int) java.time.temporal.ChronoUnit.MONTHS.between(startDate, endDate);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}