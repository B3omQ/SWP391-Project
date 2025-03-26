package controller.customer;

import dal.DepHistoryDAO;
import model.Customer;
import model.DepHistory;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class TransactionHistoryServlet extends HttpServlet {

    private DepHistoryDAO depHistoryDAO;

    @Override
    public void init() throws ServletException {
        depHistoryDAO = new DepHistoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Customer customer = (Customer) request.getSession().getAttribute("account");
           

            int customerId = customer.getId();
            System.out.println("TransactionHistoryServlet - Customer ID: " + customerId);

            String searchQuery = request.getParameter("s");
            String sortCriteria = request.getParameter("sort");
            String pageParam = request.getParameter("page");
            String recordsPerPageParam = request.getParameter("recordsPerPage");

            int recordsPerPage;
            if (recordsPerPageParam != null && !recordsPerPageParam.trim().isEmpty()) {
                try {
                    recordsPerPage = Integer.parseInt(recordsPerPageParam);
                    if (recordsPerPage != 5 && recordsPerPage != 10 && recordsPerPage != 20 && recordsPerPage != 50) {
                        recordsPerPage = 10; 
                    }
                } catch (NumberFormatException e) {
                    recordsPerPage = 10; 
                }
            } else {
                recordsPerPage = 10; 
            }

            int page = (pageParam == null || pageParam.trim().isEmpty()) ? 1 : Integer.parseInt(pageParam);
            int totalRecords = depHistoryDAO.countDepHistoryByCustomerId(customerId, searchQuery);
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
            int offset = (page - 1) * recordsPerPage;

            List<DepHistory> depHistoryList;
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                depHistoryList = depHistoryDAO.searchDepHistoryByCustomerIdWithPagination(customerId, searchQuery, offset, recordsPerPage);
            } else {
                depHistoryList = depHistoryDAO.getDepHistoryByCustomerIdWithPagination(customerId, offset, recordsPerPage);
            }

            System.out.println("TransactionHistoryServlet - Số giao dịch tìm thấy: " + (depHistoryList != null ? depHistoryList.size() : 0));
            if (depHistoryList != null) {
                for (DepHistory trans : depHistoryList) {
                    System.out.println("Transaction - ID: " + trans.getId() + 
                                      ", CustomerId: " + trans.getCusId() + 
                                      ", Date: " + trans.getCreatedAt() + 
                                      ", Amount: " + trans.getAmount() + 
                                      ", Description: " + trans.getDescription());
                }
            }

            if (sortCriteria != null && !sortCriteria.trim().isEmpty() && depHistoryList != null) {
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
                }
            }

            BigDecimal totalAutoProfit = depHistoryDAO.getTotalAutoProfit(customerId);
            request.setAttribute("totalAutoProfit", totalAutoProfit != null ? totalAutoProfit : BigDecimal.ZERO);

            request.setAttribute("depHistoryList", depHistoryList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("searchQuery", searchQuery);
            request.setAttribute("sortCriteria", sortCriteria);
            request.setAttribute("recordsPerPage", recordsPerPage); // Truyền recordsPerPage để JSP hiển thị giá trị đã chọn

            request.getRequestDispatcher("/customer/Customer.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi tải dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/customer/Customer.jsp").forward(request, response);
        }
    }
}