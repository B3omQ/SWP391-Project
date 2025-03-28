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
                    session.setAttribute("error", "Không tìm thấy bài viết để chỉnh sửa");
                    response.sendRedirect(request.getContextPath() + "/BlogServlet?action=list");
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
        String pageParam = request.getParameter("page");
        String recordsPerPageParam = request.getParameter("recordsPerPage");

        System.out.println("Search: " + search);
        System.out.println("Category Filter: " + categoryFilter);
        System.out.println("Sort By: " + sortBy);
        System.out.println("Page: " + pageParam);
        System.out.println("Records Per Page: " + recordsPerPageParam);

        int recordsPerPage;
        if (recordsPerPageParam != null && !recordsPerPageParam.trim().isEmpty()) {
            try {
                recordsPerPage = Integer.parseInt(recordsPerPageParam);
                if (recordsPerPage != 5 && recordsPerPage != 10 && recordsPerPage != 20 && recordsPerPage != 50) {
                    recordsPerPage = 5;
                }
            } catch (NumberFormatException e) {
                recordsPerPage = 5;
            }
        } else {
            recordsPerPage = 5;
        }

        int page = (pageParam == null || pageParam.trim().isEmpty()) ? 1 : Integer.parseInt(pageParam);
        int totalRecords = articleDAO.countFilteredArticles(search, categoryFilter);
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
        int offset = (page - 1) * recordsPerPage;

        List<Article> articles = articleDAO.getFilteredArticlesWithPagination(search, categoryFilter, sortBy, offset, recordsPerPage);
        System.out.println("Số lượng bài viết lấy được: " + articles.size());

        request.setAttribute("articles", articles != null ? articles : new ArrayList<>());
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("recordsPerPage", recordsPerPage);

        request.getRequestDispatcher("/accountant/blogs.jsp").forward(request, response);
    }

    private void addArticle(HttpServletRequest request, HttpServletResponse response, Integer authorId, String uploadPath) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String title = request.getParameter("title");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        Part filePart = request.getPart("image");

        if (title == null || title.trim().isEmpty()) {
            session.setAttribute("error", "Tiêu đề không được để trống!");
            response.sendRedirect(request.getContextPath() + "/BlogServlet?action=list");
            return;
        }
        if (category == null || category.trim().isEmpty()) {
            session.setAttribute("error", "Thể loại không được để trống!");
            response.sendRedirect(request.getContextPath() + "/BlogServlet?action=list");
            return;
        }
        if (description == null || description.trim().isEmpty()) {
            session.setAttribute("error", "Mô tả không được để trống!");
            response.sendRedirect(request.getContextPath() + "/BlogServlet?action=list");
            return;
        }

        title = validator.normalizeInput(title);
        description = validator.normalizeInput(description);

        String imageUrl = null;
        if (filePart != null && filePart.getSize() > 0) {
            imageUrl = uploadImage(filePart, uploadPath);
            if (imageUrl == null) {
                session.setAttribute("error", "Lỗi khi upload ảnh! Chỉ chấp nhận JPG, PNG dưới 5MB.");
                response.sendRedirect(request.getContextPath() + "/BlogServlet?action=list");
                return;
            }
        } else {
            session.setAttribute("error", "Hình ảnh không được để trống khi thêm blog!");
            response.sendRedirect(request.getContextPath() + "/BlogServlet?action=list");
            return;
        }

        Article article = new Article(title, description, category, authorId, imageUrl);
        articleDAO.addArticle(article);
        session.setAttribute("message", "Thêm blog thành công!");
        response.sendRedirect(request.getContextPath() + "/BlogServlet?action=list");
    }

    private void updateArticle(HttpServletRequest request, HttpServletResponse response, Integer authorId, String uploadPath) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        Part filePart = request.getPart("image");

        if (title == null || title.trim().isEmpty()) {
            session.setAttribute("error", "Tiêu đề không được để trống!");
            response.sendRedirect(request.getContextPath() + "/BlogServlet?action=list");
            return;
        }
        if (category == null || category.trim().isEmpty()) {
            session.setAttribute("error", "Thể loại không được để trống!");
            response.sendRedirect(request.getContextPath() + "/BlogServlet?action=list");
            return;
        }
        if (description == null || description.trim().isEmpty()) {
            session.setAttribute("error", "Mô tả không được để trống!");
            response.sendRedirect(request.getContextPath() + "/BlogServlet?action=list");
            return;
        }

        title = validator.normalizeInput(title);
        description = validator.normalizeInput(description);

        Article existingArticle = articleDAO.getArticleById(id);
        if (existingArticle == null) {
            session.setAttribute("error", "Không tìm thấy bài viết để cập nhật");
            response.sendRedirect(request.getContextPath() + "/BlogServlet?action=list");
            return;
        }

        String imageUrl = existingArticle.getImageUrl();
        if (filePart != null && filePart.getSize() > 0) {
            imageUrl = uploadImage(filePart, uploadPath);
            if (imageUrl == null) {
                session.setAttribute("error", "Lỗi khi upload ảnh! Chỉ chấp nhận JPG, PNG dưới 5MB.");
                response.sendRedirect(request.getContextPath() + "/BlogServlet?action=list");
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
        session.setAttribute("message", "Cập nhật blog thành công!");
        response.sendRedirect(request.getContextPath() + "/BlogServlet?action=list");
    }

    private void deleteArticle(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int id = Integer.parseInt(request.getParameter("id"));
        Article article = articleDAO.getArticleById(id);
        if (article != null) {
            articleDAO.deleteArticle(id);
            session.setAttribute("message", "Xóa blog thành công!");
        } else {
            session.setAttribute("error", "Không tìm thấy bài viết để xóa");
        }
        response.sendRedirect(request.getContextPath() + "/BlogServlet?action=list");
    }

    private String uploadImage(Part filePart, String uploadPath) throws IOException {
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = extractFileName(filePart);
            if (!fileName.isEmpty()) {
                String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
                List<String> allowedExtensions = Arrays.asList("jpg", "jpeg", "png");
                long maxFileSize = 5 * 1024 * 1024;

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