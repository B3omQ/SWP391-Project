/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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
import java.io.PrintWriter;
import model.Staff;

public class VerifyingOtp extends HttpServlet {

    private CustomerDAO customerDAO = new CustomerDAO();
    private DepServiceUsedDAO depServiceUsedDAO = new DepServiceUsedDAO();
    private DepHistoryDAO depHistoryDAO = new DepHistoryDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet VerifyingOtp</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerifyingOtp at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userOtp = request.getParameter("otp");
        String generatedOtp = (String) session.getAttribute("otp");
        try {
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
        } catch (Exception e) {
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
        BigDecimal interest = InterestCalculator.calculateInterest(principal, savingRate.doubleValue(), termMonths);
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
