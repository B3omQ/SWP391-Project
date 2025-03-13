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
import util.AccountValidation;
import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, 
        maxFileSize = 1024 * 1024 * 5, 
        maxRequestSize = 1024 * 1024 * 50)
public class BlogServlet extends HttpServlet {

    private ArticleDAO articleDAO;
    private AccountValidation validator;
    private static final String UPLOAD_DIR = "assets/images/blogs";

    @Override
    public void init() throws ServletException {
        articleDAO = new ArticleDAO();
        validator = new AccountValidation();
        System.out.println("BlogServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("staffId") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "edit":
                int id = Integer.parseInt(request.getParameter("id"));
                Article article = articleDAO.getArticleById(id);
                if (article != null) {
                    request.setAttribute("article", article);
                    request.getRequestDispatcher("/accountant/edit-blog.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Không tìm thấy bài viết để chỉnh sửa");
                    listArticles(request, response);
                }
                break;
            case "list":
            default:
                listArticles(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("staffId") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
            return;
        }

        Integer authorId = (Integer) session.getAttribute("staffId");
        String action = request.getParameter("action");
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            boolean created = uploadDir.mkdirs();
            if (!created) {
                System.err.println("Failed to create upload directory: " + uploadPath);
            }
        }

        switch (action) {
            case "add":
                addArticle(request, response, authorId, uploadPath);
                break;
            case "update":
                updateArticle(request, response, authorId, uploadPath);
                break;
            case "delete":
                deleteArticle(request, response);
                break;
            default:
                listArticles(request, response);
                break;
        }
    }

    private void listArticles(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String search = request.getParameter("search");
        String categoryFilter = request.getParameter("categoryFilter");
        String sortBy = request.getParameter("sortBy");

        List<Article> articles = articleDAO.getFilteredArticles(search, categoryFilter, sortBy);
        request.setAttribute("articles", articles != null ? articles : new ArrayList<>());
        request.getRequestDispatcher("/accountant/blogs.jsp").forward(request, response);
    }

    private void addArticle(HttpServletRequest request, HttpServletResponse response, Integer authorId, String uploadPath) 
            throws ServletException, IOException {
        String title = request.getParameter("title");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        Part filePart = request.getPart("image");

        // Validate dữ liệu không được để trống
        if (title == null || title.trim().isEmpty()) {
            request.setAttribute("error", "Tiêu đề không được để trống!");
            listArticles(request, response);
            return;
        }
        if (category == null || category.trim().isEmpty()) {
            request.setAttribute("error", "Thể loại không được để trống!");
            listArticles(request, response);
            return;
        }
        if (description == null || description.trim().isEmpty()) {
            request.setAttribute("error", "Mô tả không được để trống!");
            listArticles(request, response);
            return;
        }

        // Chuẩn hóa dữ liệu bằng normalizeInput
        title = validator.normalizeInput(title);
        description = validator.normalizeInput(description);

        // Validate ảnh (nếu có)
        String imageUrl = null;
        if (filePart != null && filePart.getSize() > 0) {
            imageUrl = uploadImage(filePart, uploadPath);
            if (imageUrl == null) {
                request.setAttribute("error", "Lỗi khi upload ảnh! Chỉ chấp nhận JPG, PNG dưới 5MB.");
                listArticles(request, response);
                return;
            }
        } else {
            request.setAttribute("error", "Hình ảnh không được để trống khi thêm blog!");
            listArticles(request, response);
            return;
        }

        Article article = new Article(title, description, category, authorId, imageUrl);
        articleDAO.addArticle(article);
        request.setAttribute("message", "Thêm blog thành công!");
        listArticles(request, response);
    }

    private void updateArticle(HttpServletRequest request, HttpServletResponse response, Integer authorId, String uploadPath) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        Part filePart = request.getPart("image");

        // Validate dữ liệu không được để trống
        if (title == null || title.trim().isEmpty()) {
            request.setAttribute("error", "Tiêu đề không được để trống!");
            listArticles(request, response);
            return;
        }
        if (category == null || category.trim().isEmpty()) {
            request.setAttribute("error", "Thể loại không được để trống!");
            listArticles(request, response);
            return;
        }
        if (description == null || description.trim().isEmpty()) {
            request.setAttribute("error", "Mô tả không được để trống!");
            listArticles(request, response);
            return;
        }

        // Chuẩn hóa dữ liệu
        title = validator.normalizeInput(title);
        description = validator.normalizeInput(description);

        Article existingArticle = articleDAO.getArticleById(id);
        if (existingArticle == null) {
            request.setAttribute("error", "Không tìm thấy bài viết để cập nhật");
            listArticles(request, response);
            return;
        }

        // Validate và upload ảnh (nếu có)
        String imageUrl = existingArticle.getImageUrl();
        if (filePart != null && filePart.getSize() > 0) {
            imageUrl = uploadImage(filePart, uploadPath);
            if (imageUrl == null) {
                request.setAttribute("error", "Lỗi khi upload ảnh! Chỉ chấp nhận JPG, PNG dưới 5MB.");
                listArticles(request, response);
                return;
            }
        }

        Article article = new Article(
            id, 
            title, 
            description, 
            category, 
            existingArticle.getPublishDate(),
            authorId, 
            imageUrl, 
            existingArticle.getCreatedAt(), 
            new Timestamp(System.currentTimeMillis())
        );
        articleDAO.updateArticle(article);
        request.setAttribute("message", "Cập nhật blog thành công!");
        listArticles(request, response);
    }

    private void deleteArticle(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Article article = articleDAO.getArticleById(id);
        if (article != null) {
            articleDAO.deleteArticle(id);
            request.setAttribute("message", "Xóa blog thành công!");
        } else {
            request.setAttribute("error", "Không tìm thấy bài viết để xóa");
        }
        listArticles(request, response);
    }

    private String uploadImage(Part filePart, String uploadPath) throws IOException {
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = extractFileName(filePart);
            if (!fileName.isEmpty()) {
                String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
                List<String> allowedExtensions = Arrays.asList("jpg", "jpeg", "png");
                long maxFileSize = 5 * 1024 * 1024; // 5MB

                if (!allowedExtensions.contains(fileExtension)) {
                    System.err.println("Invalid file extension: " + fileExtension);
                    return null;
                }
                if (filePart.getSize() > maxFileSize) {
                    System.err.println("File size exceeds limit: " + filePart.getSize());
                    return null;
                }

                fileName = System.currentTimeMillis() + "_" + fileName;
                String fullPath = uploadPath + File.separator + fileName;
                filePart.write(fullPath);
                System.out.println("Image uploaded to: " + fullPath);
                return "/" + UPLOAD_DIR + "/" + fileName;
            }
        }
        return null;
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp != null) {
            for (String s : contentDisp.split(";")) {
                if (s.trim().startsWith("filename")) {
                    return s.substring(s.indexOf("=") + 2, s.length() - 1);
                }
            }
        }
        return "";
    }
}