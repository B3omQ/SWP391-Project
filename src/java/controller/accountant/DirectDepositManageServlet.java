package controller.accountant;

import dal.DepositRequestDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.DepositRequest;

public class DirectDepositManageServlet extends HttpServlet {
    private final DepositRequestDAO depositRequestDAO = new DepositRequestDAO();

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

            // Xóa thông báo sau khi hiển thị
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
                // Chỉ cho phép cập nhật từ ACTIVE sang COMPLETED hoặc CANCEL
                boolean success = depositRequestDAO.updateDepositRequestStatus(id, status);
                session.setAttribute("message", success ? 
                    "Trạng thái phiếu đã được cập nhật thành công!" : 
                    "Cập nhật trạng thái thất bại!");
            }

            // Chuyển hướng và làm mới danh sách
            response.sendRedirect(request.getContextPath() + "/DirectDepositManageServlet");
        } catch (Exception e) {
            System.err.println("Error in doPost: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("error", "Đã xảy ra lỗi khi xử lý: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/DirectDepositManageServlet");
        }
    }
}