package controller.accountant;

import dal.DepositRequestDAO;
import dal.DepHistoryDAO;
import dal.CustomerDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.List;
import model.DepositRequest;

public class DirectDepositManageServlet extends HttpServlet {
    private final DepositRequestDAO depositRequestDAO = new DepositRequestDAO();
    private final DepHistoryDAO depHistoryDAO = new DepHistoryDAO();
    private final CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("staff") == null) {
            session = request.getSession(true);
            session.setAttribute("message", "Vui lòng đăng nhập với vai trò nhân viên!");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            String search = request.getParameter("search");
            String statusFilter = request.getParameter("statusFilter");
            String sortBy = request.getParameter("sortBy");

            List<DepositRequest> depositRequests = depositRequestDAO.getFilteredDepositRequests(search, statusFilter, sortBy);
            request.setAttribute("depositRequests", depositRequests);

            if (session.getAttribute("message") != null) {
                session.removeAttribute("message");
            }
            if (session.getAttribute("error") != null) {
                session.removeAttribute("error");
            }

            request.getRequestDispatcher("/accountant/direct-deposit-manage.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error in doGet: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("staff") == null) {
            session.setAttribute("message", "Vui lòng đăng nhập với vai trò nhân viên!");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            String action = request.getParameter("action");
            int id = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");

            if ("update".equals(action)) {
                DepositRequest depositRequest = depositRequestDAO.getDepositRequestById(id); // Lấy thông tin phiếu yêu cầu
                if (depositRequest == null) {
                    session.setAttribute("error", "Không tìm thấy phiếu yêu cầu!");
                    response.sendRedirect(request.getContextPath() + "/DirectDepositManageServlet");
                    return;
                }

                // Cập nhật trạng thái phiếu yêu cầu
                boolean statusUpdated = depositRequestDAO.updateDepositRequestStatus(id, status);
                if (statusUpdated) {
                    if ("COMPLETED".equalsIgnoreCase(status)) {
                        // Lấy thông tin khách hàng và số tiền từ phiếu yêu cầu
                        int cusId = depositRequest.getCusId();
                        BigDecimal amount = depositRequest.getAmount();

                        // Lấy số dư hiện tại của khách hàng
                        BigDecimal currentBalance = customerDAO.getWalletByCustomerId(cusId);
                        if (currentBalance == null) {
                            currentBalance = BigDecimal.ZERO; // Nếu không có số dư, khởi tạo bằng 0
                        }

                        // Tính số dư mới
                        BigDecimal newBalance = currentBalance.add(amount);

                        // Cập nhật số dư khách hàng
                        boolean balanceUpdated = customerDAO.updateWallet(cusId, newBalance);
                        if (balanceUpdated) {
                            // Lưu vào lịch sử giao dịch
                            String description = "Nạp tiền từ phiếu yêu cầu #" + id;
                            boolean historySaved = depHistoryDAO.addDepHistory(null, description, amount, cusId);

                            if (historySaved) {
                                session.setAttribute("message", "Xử lý phiếu yêu cầu thành công, số dư và lịch sử đã được cập nhật!");
                            } else {
                                session.setAttribute("error", "Cập nhật số dư thành công nhưng lưu lịch sử thất bại!");
                            }
                        } else {
                            session.setAttribute("error", "Cập nhật số dư khách hàng thất bại!");
                        }
                    } else if ("CANCEL".equalsIgnoreCase(status)) {
                        session.setAttribute("message", "Phiếu yêu cầu đã bị hủy thành công!");
                    } else {
                        session.setAttribute("message", "Trạng thái phiếu đã được cập nhật thành công!");
                    }
                } else {
                    session.setAttribute("error", "Cập nhật trạng thái thất bại!");
                }
            }

            response.sendRedirect(request.getContextPath() + "/DirectDepositManageServlet");
        } catch (Exception e) {
            System.err.println("Error in doPost: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("error", "Đã xảy ra lỗi khi xử lý: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/DirectDepositManageServlet");
        }
    }
}