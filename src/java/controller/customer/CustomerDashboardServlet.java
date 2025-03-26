package controller.customer;

import dal.DepHistoryDAO;
import model.Customer;
import model.DepHistory;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class CustomerDashboardServlet extends HttpServlet {

    private final DepHistoryDAO depHistoryDAO = new DepHistoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Lấy customerId từ đối tượng Customer trong session
        Customer customer = (Customer) session.getAttribute("account");
        int customerId = customer.getId();

        // Lấy danh sách giao dịch
        List<DepHistory> transactions = depHistoryDAO.getDepHistoryByCustomerId(customerId);

        // Log để kiểm tra dữ liệu
        System.out.println("Số giao dịch tìm thấy: " + (transactions != null ? transactions.size() : 0));
        if (transactions != null) {
            for (DepHistory trans : transactions) {
                System.out.println("Transaction - ID: " + trans.getId() + 
                                  ", CustomerId: " + trans.getCusId() + 
                                  ", Date: " + trans.getCreatedAt() + 
                                  ", Amount: " + trans.getAmount() + 
                                  ", Description: " + trans.getDescription());
            }
        }

        // Lưu danh sách giao dịch với tên "depHistoryList" để đồng bộ với JSP
        request.setAttribute("depHistoryList", transactions);

        // Forward đến Customer.jsp
        request.getRequestDispatcher("/customer/Customer.jsp").forward(request, response);
    }
}