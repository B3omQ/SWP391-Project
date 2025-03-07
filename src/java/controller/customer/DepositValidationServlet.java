package controller.customer;

import dal.CustomerDAO;
import dal.DepServiceUsedDAO;
import java.io.IOException;
import java.io.PrintWriter;
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

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DepositValidationServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DepositValidationServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu cần xử lý GET, để trống hoặc redirect
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Customer customer = (Customer) request.getSession().getAttribute("account");
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
            return;
        }
        int customerId = customer.getId();

        // Kiểm tra xem khách hàng đã có khoản gửi tiết kiệm đang hoạt động chưa
        DepServiceUsedDAO depServiceUsedDAO = new DepServiceUsedDAO();
        List<DepServiceUsed> activeDeposits = depServiceUsedDAO.getActiveDepositsByCustomerId(customerId);
        if (!activeDeposits.isEmpty()) {
            request.getSession().setAttribute("error4", "Bạn chỉ được gửi một khoản tiết kiệm tại một thời điểm!");
            response.sendRedirect(request.getContextPath() + "/customer/Termsavings.jsp");
            return;
        }

        // Lấy số tiền gửi từ request
        String amountStr = request.getParameter("depositAmount");
        BigDecimal amount;
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

            // Kiểm tra số dư tài khoản (wallet)
            CustomerDAO customerDAO = new CustomerDAO();
            BigDecimal walletBalance = customerDAO.getWalletByCustomerId(customerId);
            if (walletBalance == null || amount.compareTo(walletBalance) > 0) {
                request.getSession().setAttribute("error4", "Số tiền gửi không được vượt quá số dư tài khoản (" + 
                        (walletBalance != null ? walletBalance.toString() : "0") + " VND)!");
                response.sendRedirect(request.getContextPath() + "/customer/savemoney.jsp");
                return;
            }

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