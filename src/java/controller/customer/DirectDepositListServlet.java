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
            List<DepositRequest> depositRequests = depositRequestDAO.getDepositRequestByCusId(cusId);

            if (depositRequests == null || depositRequests.isEmpty()) {
                System.out.println("No deposit requests found for CusId: " + cusId);
            } else {
                System.out.println("Found " + depositRequests.size() + " deposit requests");
            }

            request.setAttribute("depositRequests", depositRequests);
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

            if ("cancel".equals(action)) {
                boolean success = depositRequestDAO.updateDepositRequestStatus(id, DepositRequestDAO.STATUS_CANCEL);
                if (success) {
                    session.setAttribute("message", "Phiếu đã được hủy thành công!");
                } else {
                    session.setAttribute("message", "Không thể hủy phiếu. Vui lòng kiểm tra lại!");
                }
            }

            response.sendRedirect(request.getContextPath() + "/DirectDepositListServlet");
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