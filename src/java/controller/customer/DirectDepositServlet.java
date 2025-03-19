package controller.customer;

import dal.DepositRequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import model.DepositRequest;

import java.io.IOException;
import java.math.BigDecimal;

public class DirectDepositServlet extends HttpServlet {
    private final DepositRequestDAO depositRequestDAO = new DepositRequestDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Customer customer = (Customer) session.getAttribute("account");

        if (customer == null) {
            session.setAttribute("message", "Vui lòng đăng nhập để tạo phiếu yêu cầu!");
            response.sendRedirect(request.getContextPath() + "/customer/direct-deposit.jsp");
            return;
        }

        int cusId = customer.getId();
        String amountStr = request.getParameter("amount");
        String note = request.getParameter("note");

        try {
            String cleanAmountStr = amountStr != null ? amountStr.replace(",", "") : "0";
            if (cleanAmountStr.isEmpty() || Double.parseDouble(cleanAmountStr) < 10000) {
                session.setAttribute("message", "Số tiền không hợp lệ! (Tối thiểu 10,000 VNĐ)");
                response.sendRedirect(request.getContextPath() + "/customer/direct-deposit.jsp");
                return;
            }

            BigDecimal amount = new BigDecimal(cleanAmountStr);
            DepositRequest depositRequest = new DepositRequest();
            depositRequest.setCusId(cusId);
            depositRequest.setAmount(amount);
            depositRequest.setNote(note);

            System.out.println("Attempting to save deposit request: cusId=" + cusId + ", amount=" + amount + ", note=" + note);
            int requestId = depositRequestDAO.addDepositRequest(depositRequest);
            System.out.println("Deposit request result: requestId=" + requestId);

            if (requestId != -1) {
                session.setAttribute("message", "Phiếu yêu cầu đã được tạo thành công!");
                session.setAttribute("requestId", String.valueOf(requestId));
                System.out.println("Success: requestId=" + requestId);
            } else {
                session.setAttribute("message", "Lỗi hệ thống khi lưu phiếu yêu cầu!");
                System.out.println("Failed to save deposit request");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("message", "Số tiền không hợp lệ, vui lòng nhập số!");
            System.out.println("NumberFormatException: " + e.getMessage());
        } catch (Exception e) {
            session.setAttribute("message", "Đã xảy ra lỗi: " + e.getMessage());
            System.out.println("Exception: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/customer/direct-deposit.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/customer/direct-deposit.jsp");
    }
}