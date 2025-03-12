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
        String search = request.getParameter("search");
        String categoryFilter = request.getParameter("categoryFilter");
        String sortBy = request.getParameter("sortBy");

        System.out.println("Search: " + search);
        System.out.println("Category Filter: " + categoryFilter);
        System.out.println("Sort By: " + sortBy);

        List<Article> articles = articleDAO.getFilteredArticles(search, categoryFilter, sortBy);
        System.out.println("Số lượng bài viết lấy được: " + articles.size());

        request.setAttribute("newsList", articles != null ? articles : new ArrayList<>());
        request.getRequestDispatcher("/public/News.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}