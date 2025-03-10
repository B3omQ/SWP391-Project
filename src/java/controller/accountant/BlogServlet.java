package controller.accountant;

import dal.ArticleDAO;
import model.Article;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

/**
 *
 * @author emkob
 */

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class BlogServlet extends HttpServlet {

    private ArticleDAO articleDAO;
    private static final String UPLOAD_DIR = "assets/images/blogs";

    @Override
    public void init() throws ServletException {
        articleDAO = new ArticleDAO();
        System.out.println("BlogServlet initialized - ArticleDAO created");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("doGet called with action: " + request.getParameter("action"));
        System.out.println("Request URI: " + request.getRequestURI());
        HttpSession session = request.getSession(false);
        System.out.println("Session exists: " + (session != null) + ", StaffId: " + (session != null ? session.getAttribute("staffId") : "null"));

        String action = request.getParameter("action");
        if ("edit".equals(action)) {
            int id;
            try {
                id = Integer.parseInt(request.getParameter("id"));
            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("<p>ID bài viết không hợp lệ.</p>");
                return;
            }
            System.out.println("Fetching article ID: " + id);
            Article article = articleDAO.getArticleById(id);
            System.out.println("Article fetch result: " + (article != null ? "Found - ID=" + article.getId() + ", Title=" + article.getTitle() : "Not Found"));

            if (article != null) {
                request.setAttribute("article", article);
                request.getRequestDispatcher("/accountant/edit-blog.jsp").forward(request, response);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("<p>Không tìm thấy bài viết để chỉnh sửa.</p>");
            }
        } else {
            System.out.println("Fetching all articles...");
            List<Article> articles = articleDAO.getAllArticles();
            System.out.println("Fetched Articles count: " + (articles != null ? articles.size() : "null"));
            if (articles != null && !articles.isEmpty()) {
                for (Article a : articles) {
                    System.out.println("Article: ID=" + a.getId() + ", Title=" + a.getTitle() + ", Category=" + a.getCategory() + ", PublishDate=" + a.getPublishDate());
                }
            } else {
                System.out.println("No articles retrieved from DAO");
            }

            request.setAttribute("articles", articles);
            System.out.println("Forwarding to /accountant/blogs.jsp");
            request.getRequestDispatcher("/accountant/blogs.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        System.out.println("doPost called with action: " + request.getParameter("action"));
        System.out.println("Session exists: " + (session != null));

        if (session == null || session.getAttribute("staffId") == null) {
            System.out.println("Session invalid or staffId not found, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
            return;
        }

        Integer authorId = (Integer) session.getAttribute("staffId");
        System.out.println("Author ID from staffId: " + authorId);

        String action = request.getParameter("action");
        String uploadPath = getServletContext().getRealPath("") + File.separator + "assets/images/blogs";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        System.out.println("Upload path: " + uploadPath);

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            System.out.println("Deleting article ID: " + id);
            articleDAO.deleteArticle(id);
            request.setAttribute("message", "Blog deleted successfully!");
        } else {
            String title = request.getParameter("title");
            String category = request.getParameter("category");
            String description = request.getParameter("description");
            System.out.println("Received data: Title=" + title + ", Category=" + category + ", Description=" + description);

            Part filePart = request.getPart("image");
            String fileName = null;
            String imageUrl = null;

            if (filePart != null && filePart.getSize() > 0) {
                fileName = System.currentTimeMillis() + "_" + extractFileName(filePart);
                filePart.write(uploadPath + File.separator + fileName);
                imageUrl = "/assets/images/blogs/" + fileName;
                System.out.println("Image uploaded: " + imageUrl);
            }

            if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                System.out.println("Updating article ID: " + id);
                Article existingArticle = articleDAO.getArticleById(id);
                if (existingArticle != null) {
                    imageUrl = (imageUrl != null) ? imageUrl : existingArticle.getImageUrl();
                    Article article = new Article(id, title, description, category, existingArticle.getPublishDate(),
                            authorId, imageUrl, existingArticle.getCreatedAt(), new Timestamp(System.currentTimeMillis()));
                    articleDAO.updateArticle(article);
                    request.setAttribute("message", "Blog updated successfully!");
                    System.out.println("Article updated: " + title);
                }
            } else if ("add".equals(action)) {
                System.out.println("Adding new article");
                Article article = new Article(title, description, category, authorId, imageUrl);
                articleDAO.addArticle(article);
                request.setAttribute("message", "Blog added successfully!");
                System.out.println("Article added: " + title);
            }
        }

        List<Article> articles = articleDAO.getAllArticles();
        System.out.println("Post action completed, fetched articles: " + (articles != null ? articles.size() : "null"));
        request.setAttribute("articles", articles);
        request.getRequestDispatcher("/accountant/blogs.jsp").forward(request, response);
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

}
