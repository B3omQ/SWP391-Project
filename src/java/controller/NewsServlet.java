package controller;

import dal.ArticleDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Article;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class NewsServlet extends HttpServlet {

    private ArticleDAO articleDAO;

    @Override
    public void init() throws ServletException {
        articleDAO = new ArticleDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Lấy tham số từ request
        String search = request.getParameter("search");
        String categoryFilter = request.getParameter("categoryFilter");
        String sortBy = request.getParameter("sortBy");
        String pageParam = request.getParameter("page");
        String recordsPerPageParam = request.getParameter("recordsPerPage");

        System.out.println("Search: " + search);
        System.out.println("Category Filter: " + categoryFilter);
        System.out.println("Sort By: " + sortBy);
        System.out.println("Page: " + pageParam);
        System.out.println("Records Per Page: " + recordsPerPageParam);

        // Xử lý số bản ghi trên mỗi trang
        int recordsPerPage;
        if (recordsPerPageParam != null && !recordsPerPageParam.trim().isEmpty()) {
            try {
                recordsPerPage = Integer.parseInt(recordsPerPageParam);
                // Đảm bảo recordsPerPage nằm trong khoảng hợp lệ
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
        int totalRecords = articleDAO.countFilteredArticles(search, categoryFilter);
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
        int offset = (page - 1) * recordsPerPage;

        // Lấy danh sách bài viết với phân trang
        List<Article> articles = articleDAO.getFilteredArticlesWithPagination(search, categoryFilter, sortBy, offset, recordsPerPage);
        System.out.println("Số lượng bài viết lấy được: " + articles.size());

        // Truyền dữ liệu vào request
        request.setAttribute("newsList", articles != null ? articles : new ArrayList<>());
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("recordsPerPage", recordsPerPage);

        request.getRequestDispatcher("/public/News.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}