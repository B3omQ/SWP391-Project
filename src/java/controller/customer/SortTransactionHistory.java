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

/**
 *
 * @author emkob
 */
public class SortTransactionHistory extends HttpServlet {

    private DepHistoryDAO depHistoryDAO;

    @Override
    public void init() throws ServletException {
        depHistoryDAO = new DepHistoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra đăng nhập
        Customer customer = (Customer) request.getSession().getAttribute("account");
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Lấy tham số từ request
        String sortCriteria = request.getParameter("sort");
        String searchQuery = request.getParameter("s");

        // Luôn lấy dữ liệu mới từ cơ sở dữ liệu thay vì dựa vào session cũ
        List<DepHistory> depHistoryList;
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            depHistoryList = depHistoryDAO.searchDepHistoryByCustomerId(customer.getId(), searchQuery);
        } else {
            depHistoryList = depHistoryDAO.getDepHistoryByCustomerId(customer.getId());
        }

        // Log để kiểm tra dữ liệu ban đầu
        System.out.println("Before sorting - Total records: " + depHistoryList.size());
        for (DepHistory history : depHistoryList) {
            System.out.println("ID: " + history.getId() + ", CreatedAt: " + history.getCreatedAt() + 
                              ", Amount: " + history.getAmount() + ", Description: " + history.getDescription());
        }

        // Sắp xếp danh sách nếu có tiêu chí sort
        if (sortCriteria != null && !sortCriteria.trim().isEmpty()) {
            switch (sortCriteria) {
                case "time":
                    Collections.sort(depHistoryList, Comparator.comparing(DepHistory::getCreatedAt, 
                            Comparator.nullsLast(Comparator.reverseOrder()))); // Sắp xếp giảm dần để mới nhất lên đầu
                    break;
                case "amount":
                    Collections.sort(depHistoryList, Comparator.comparing(DepHistory::getAmount, 
                            Comparator.nullsLast(Comparator.naturalOrder())));
                    break;
                case "description":
                    Collections.sort(depHistoryList, Comparator.comparing(DepHistory::getDescription, 
                            Comparator.nullsLast(Comparator.naturalOrder())));
                    break;
                default:
                    break;
            }
        }

        // Log để kiểm tra sau khi sắp xếp
        System.out.println("After sorting by " + sortCriteria + " - Total records: " + depHistoryList.size());
        for (DepHistory history : depHistoryList) {
            System.out.println("ID: " + history.getId() + ", CreatedAt: " + history.getCreatedAt() + 
                              ", Amount: " + history.getAmount() + ", Description: " + history.getDescription());
        }

        // Lưu danh sách đã sắp xếp vào session
        request.getSession().setAttribute("depHistoryList", depHistoryList);

        // Tạo URL chuyển hướng với các tham số
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