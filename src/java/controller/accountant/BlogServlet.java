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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @author emkob
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, 
        maxFileSize = 1024 * 1024 * 5, 
        maxRequestSize = 1024 * 1024 * 50) 
public class BlogServlet extends HttpServlet {

    private ArticleDAO articleDAO;
    private static final String UPLOAD_DIR = "assets/images/blogs";

    @Override
    public void init() throws ServletException {
        articleDAO = new ArticleDAO();
        System.out.println("BlogServlet initialized - ArticleDAO created");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
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

                request.setAttribute("articles", articles != null ? articles : new ArrayList<>());
                System.out.println("Forwarding to /accountant/blogs.jsp");
                request.getRequestDispatcher("/accountant/blogs.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.err.println("Error in doGet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
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
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
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
                    fileName = extractFileName(filePart);
                    if (fileName.isEmpty()) {
                        request.setAttribute("error", "Không thể xác định tên file!");
                    } else {
                        String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
                        List<String> allowedExtensions = Arrays.asList("gif", "png", "jpg", "jpeg");
                        long maxFileSize = 5 * 1024 * 1024; // 5MB

                        if (filePart.getSize() > maxFileSize) {
                            request.setAttribute("error", "Kích thước ảnh vượt quá 5MB!");
                        } else if (!allowedExtensions.contains(fileExtension)) {
                            request.setAttribute("error", "Chỉ chấp nhận file GIF, PNG, JPG!");
                        } else {
                            fileName = System.currentTimeMillis() + "_" + fileName;
                            filePart.write(uploadPath + File.separator + fileName);
                            imageUrl = "/" + UPLOAD_DIR + "/" + fileName;
                            System.out.println("Image uploaded: " + imageUrl);
                        }
                    }
                }

                if (request.getAttribute("error") != null) {
                    List<Article> articles = articleDAO.getAllArticles();
                    request.setAttribute("articles", articles != null ? articles : new ArrayList<>());
                    request.getRequestDispatcher("/accountant/blogs.jsp").forward(request, response);
                    return;
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
            request.setAttribute("articles", articles != null ? articles : new ArrayList<>());
            request.getRequestDispatcher("/accountant/blogs.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error in doPost: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống: " + e.getMessage());
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp != null) {
            String[] items = contentDisp.split(";");
            for (String s : items) {
                if (s.trim().startsWith("filename")) {
                    return s.substring(s.indexOf("=") + 2, s.length() - 1);
                }
            }
        }
        return "";
    }
}