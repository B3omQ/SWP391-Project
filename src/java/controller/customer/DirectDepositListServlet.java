package controller.customer;

import dal.DepositRequestDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Customer;
import model.DepositRequest;

public class DirectDepositListServlet extends HttpServlet {
    private final DepositRequestDAO depositRequestDAO = new DepositRequestDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session == null) {
                System.out.println("Session is null");
                response.sendRedirect(request.getContextPath() + "/customer/direct-deposit.jsp");
                return;
            }

            Customer customer = (Customer) session.getAttribute("account");
            if (customer == null) {
                System.out.println("Customer not logged in");
                session.setAttribute("message", "Vui lòng đăng nhập để xem phiếu!");
                response.sendRedirect(request.getContextPath() + "/customer/direct-deposit.jsp");
                return;
            }

            int cusId = customer.getId();
            System.out.println("Fetching deposit requests for CusId: " + cusId);

            // Lấy tham số phân trang
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
            int totalRecords = depositRequestDAO.countDepositRequestsByCusId(cusId);
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
            int offset = (page - 1) * recordsPerPage;

            // Lấy danh sách phiếu yêu cầu với phân trang
            List<DepositRequest> depositRequests = depositRequestDAO.getDepositRequestsByCusIdWithPagination(cusId, offset, recordsPerPage);

            if (depositRequests == null || depositRequests.isEmpty()) {
                System.out.println("No deposit requests found for CusId: " + cusId);
            } else {
                System.out.println("Found " + depositRequests.size() + " deposit requests");
            }

            // Truyền dữ liệu vào request
            request.setAttribute("depositRequests", depositRequests);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("recordsPerPage", recordsPerPage);

            System.out.println("Forwarding to /customer/direct-deposit-list.jsp");
            request.getRequestDispatcher("/customer/direct-deposit-list.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("❌ Error in DirectDepositListServlet.doGet: " + e.getMessage());
            e.printStackTrace();
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.setAttribute("message", "Đã xảy ra lỗi khi lấy danh sách phiếu: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/customer/direct-deposit.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session == null) {
                System.out.println("Session is null in doPost");
                response.sendRedirect(request.getContextPath() + "/customer/direct-deposit.jsp");
                return;
            }

            Customer customer = (Customer) session.getAttribute("account");
            if (customer == null) {
                System.out.println("Customer not logged in in doPost");
                session.setAttribute("message", "Vui lòng đăng nhập!");
                response.sendRedirect(request.getContextPath() + "/customer/direct-deposit.jsp");
                return;
            }

            String action = request.getParameter("action");
            int id = Integer.parseInt(request.getParameter("id"));
            String recordsPerPage = request.getParameter("recordsPerPage");

            if ("cancel".equals(action)) {
                DepositRequest depositRequest = depositRequestDAO.getDepositRequestById(id);
                if (depositRequest == null) {
                    session.setAttribute("message", "Không tìm thấy phiếu yêu cầu!");
                    response.sendRedirect(request.getContextPath() + "/DirectDepositListServlet?recordsPerPage=" + recordsPerPage);
                    return;
                }

                int cusId = customer.getId();
                if (depositRequest.getCusId() != cusId) {
                    session.setAttribute("message", "Bạn không có quyền hủy phiếu này!");
                    response.sendRedirect(request.getContextPath() + "/DirectDepositListServlet?recordsPerPage=" + recordsPerPage);
                    return;
                }

                boolean success = depositRequestDAO.updateDepositRequestStatus(id, DepositRequestDAO.STATUS_CANCEL);
                if (success) {
                    session.setAttribute("message", "Phiếu đã được hủy thành công!");
                } else {
                    session.setAttribute("message", "Không thể hủy phiếu. Vui lòng kiểm tra lại!");
                }
            }

            response.sendRedirect(request.getContextPath() + "/DirectDepositListServlet?recordsPerPage=" + recordsPerPage);
        } catch (Exception e) {
            System.err.println("❌ Error in DirectDepositListServlet.doPost: " + e.getMessage());
            e.printStackTrace();
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.setAttribute("message", "Đã xảy ra lỗi khi hủy phiếu: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/customer/direct-deposit.jsp");
        }
    }
}