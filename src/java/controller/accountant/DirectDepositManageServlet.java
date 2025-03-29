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
            String pageParam = request.getParameter("page");
            String recordsPerPageParam = request.getParameter("recordsPerPage");

            // Xử lý số bản ghi trên mỗi trang
            int recordsPerPage;
            if (recordsPerPageParam != null && !recordsPerPageParam.trim().isEmpty()) {
                try {
                    recordsPerPage = Integer.parseInt(recordsPerPageParam);
                    if (recordsPerPage != 5 && recordsPerPage != 10 && recordsPerPage != 20 && recordsPerPage != 50) {
                        recordsPerPage = 5; // Giá trị mặc định nếu không hợp lệ
                    }
                } catch (NumberFormatException e) {
                    recordsPerPage = 5; // Giá trị mặc định nếu không parse được
                }
            } else {
                recordsPerPage = 5; // Giá trị mặc định
            }

            // Xử lý phân trang
            int page = (pageParam == null || pageParam.trim().isEmpty()) ? 1 : Integer.parseInt(pageParam);
            int totalRecords = depositRequestDAO.countFilteredDepositRequests(search, statusFilter);
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
            int offset = (page - 1) * recordsPerPage;

            // Lấy danh sách phiếu nạp tiền với phân trang
            List<DepositRequest> depositRequests = depositRequestDAO.getFilteredDepositRequestsWithPagination(search, statusFilter, sortBy, offset, recordsPerPage);
            request.setAttribute("depositRequests", depositRequests);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("recordsPerPage", recordsPerPage);

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
            response.sendRedirect(request.getContextPath() + "auth/template/login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("staff") == null) {
            session.setAttribute("message", "Vui lòng đăng nhập với vai trò nhân viên!");
            response.sendRedirect(request.getContextPath() + "auth/template/login.jsp");
            return;
        }

        try {
            String action = request.getParameter("action");
            int id = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");
            String recordsPerPage = request.getParameter("recordsPerPage");

            if ("update".equals(action)) {
                DepositRequest depositRequest = depositRequestDAO.getDepositRequestById(id);
                if (depositRequest == null) {
                    session.setAttribute("error", "Không tìm thấy phiếu yêu cầu!");
                    response.sendRedirect(request.getContextPath() + "/DirectDepositManageServlet?recordsPerPage=" + recordsPerPage);
                    return;
                }

                boolean statusUpdated = depositRequestDAO.updateDepositRequestStatus(id, status);
                if (statusUpdated) {
                    if ("COMPLETED".equalsIgnoreCase(status)) {
                        int cusId = depositRequest.getCusId();
                        BigDecimal amount = depositRequest.getAmount();

                        BigDecimal currentBalance = customerDAO.getWalletByCustomerId(cusId);
                        if (currentBalance == null) {
                            currentBalance = BigDecimal.ZERO;
                        }

                        BigDecimal newBalance = currentBalance.add(amount);
                        boolean balanceUpdated = customerDAO.updateWallet(cusId, newBalance);
                        if (balanceUpdated) {
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

            response.sendRedirect(request.getContextPath() + "/DirectDepositManageServlet?recordsPerPage=" + recordsPerPage);
        } catch (Exception e) {
            System.err.println("Error in doPost: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("error", "Đã xảy ra lỗi khi xử lý: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/DirectDepositManageServlet");
        }
    }
}