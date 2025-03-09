package controller.customer;

import dal.DepHistoryDAO;
import model.Customer;
import model.DepHistory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class SearchTransactionHistory extends HttpServlet {

    private DepHistoryDAO depHistoryDAO;

    @Override
    public void init() throws ServletException {
        depHistoryDAO = new DepHistoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Customer customer = (Customer) request.getSession().getAttribute("account");
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String searchQuery = request.getParameter("s");
        List<DepHistory> depHistoryList;

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            depHistoryList = depHistoryDAO.searchDepHistoryByCustomerId(customer.getId(), searchQuery);
        } else {
            depHistoryList = depHistoryDAO.getDepHistoryByCustomerId(customer.getId());
        }

        // Lưu dữ liệu vào session thay vì request vì redirect sẽ mất request
        request.getSession().setAttribute("depHistoryList", depHistoryList);
        // Redirect về Customer.jsp với tham số s (nếu có)
        String redirectUrl = request.getContextPath() + "/customer/Customer.jsp";
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            redirectUrl += "?s=" + java.net.URLEncoder.encode(searchQuery, "UTF-8");
        }
        response.sendRedirect(redirectUrl);
    }
}