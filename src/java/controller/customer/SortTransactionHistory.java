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
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class SortTransactionHistory extends HttpServlet {

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

        String sortCriteria = request.getParameter("sort");
        String searchQuery = request.getParameter("s");

        // Lấy danh sách từ session, nếu không có thì lấy mặc định
        List<DepHistory> depHistoryList = (List<DepHistory>) request.getSession().getAttribute("depHistoryList");
        if (depHistoryList == null) {
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                depHistoryList = depHistoryDAO.searchDepHistoryByCustomerId(customer.getId(), searchQuery);
            } else {
                depHistoryList = depHistoryDAO.getDepHistoryByCustomerId(customer.getId());
            }
        }

        // Sắp xếp danh sách nếu có tiêu chí
        if (sortCriteria != null && !sortCriteria.trim().isEmpty()) {
            switch (sortCriteria) {
                case "time_desc":
                    Collections.sort(depHistoryList, Comparator.comparing(DepHistory::getCreatedAt, 
                            Comparator.nullsLast(Comparator.reverseOrder())));
                    break;
                case "time_asc":
                    Collections.sort(depHistoryList, Comparator.comparing(DepHistory::getCreatedAt, 
                            Comparator.nullsLast(Comparator.naturalOrder())));
                    break;
                case "amount_asc":
                    Collections.sort(depHistoryList, Comparator.comparing(DepHistory::getAmount, 
                            Comparator.nullsLast(Comparator.naturalOrder())));
                    break;
                case "amount_desc":
                    Collections.sort(depHistoryList, Comparator.comparing(DepHistory::getAmount, 
                            Comparator.nullsLast(Comparator.reverseOrder())));
                    break;
                case "description_asc":
                    Collections.sort(depHistoryList, Comparator.comparing(DepHistory::getDescription, 
                            Comparator.nullsLast(Comparator.naturalOrder())));
                    break;
                case "description_desc":
                    Collections.sort(depHistoryList, Comparator.comparing(DepHistory::getDescription, 
                            Comparator.nullsLast(Comparator.reverseOrder())));
                    break;
                default:
                    break;
            }
        }

        // Cập nhật danh sách đã sắp xếp vào session
        request.getSession().setAttribute("depHistoryList", depHistoryList);

        // Tạo URL redirect với các tham số
        String redirectUrl = request.getContextPath() + "/customer/Customer.jsp";
        StringBuilder params = new StringBuilder();
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            params.append("s=").append(java.net.URLEncoder.encode(searchQuery, "UTF-8"));
        }
        if (sortCriteria != null && !sortCriteria.trim().isEmpty()) {
            if (params.length() > 0) params.append("&");
            params.append("sort=").append(sortCriteria);
        }
        if (params.length() > 0) {
            redirectUrl += "?" + params.toString();
        }

        response.sendRedirect(redirectUrl);
    }
}