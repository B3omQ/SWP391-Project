package dal;

import model.Article;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import util.DBContext;

/**
 * Data Access Object (DAO) cho bảng Articles, xử lý các thao tác CRUD và truy vấn dữ liệu.
 */
public class ArticleDAO extends DBContext {

    // Phương thức ánh xạ ResultSet sang đối tượng Article
    private static Article mapResultSetToArticle(ResultSet rs) throws SQLException {
        return new Article(
                rs.getInt("Id"),
                rs.getString("Title"),
                rs.getString("Description"),
                rs.getString("Category"),
                rs.getTimestamp("PublishDate"),
                rs.getInt("AuthorId"),
                rs.getString("ImageUrl"),
                rs.getTimestamp("CreatedAt"),
                rs.getTimestamp("UpdatedAt")
        );
    }

    /**
     * Lấy tất cả bài viết từ database.
     * @return List<Article> danh sách các bài viết.
     */
    public List<Article> getAllArticles() {
        List<Article> articles = new ArrayList<>();
        String sql = "SELECT Id, Title, Description, Category, PublishDate, AuthorId, ImageUrl, CreatedAt, UpdatedAt FROM Articles ORDER BY PublishDate DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                articles.add(mapResultSetToArticle(rs));
            }
            System.out.println("✅ Found " + articles.size() + " articles.");
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in getAllArticles: " + e.getMessage());
            e.printStackTrace();
        }
        return articles;
    }

    /**
     * Thêm bài viết mới vào database.
     * @param article Đối tượng Article cần thêm.
     */
    public void addArticle(Article article) {
        String sql = "INSERT INTO Articles (Title, Description, Category, AuthorId, ImageUrl, PublishDate, CreatedAt) VALUES (?, ?, ?, ?, ?, GETDATE(), GETDATE())";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, article.getTitle());
            ps.setString(2, article.getDescription());
            ps.setString(3, article.getCategory());
            ps.setInt(4, article.getAuthorId());
            ps.setString(5, article.getImageUrl());
            ps.executeUpdate();
            System.out.println("✅ Article added successfully: " + article.getTitle());
        } catch (SQLException e) {
            System.err.println("❌ Error adding article: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Cập nhật thông tin bài viết.
     * @param article Đối tượng Article cần cập nhật.
     */
    public void updateArticle(Article article) {
        String sql = "UPDATE Articles SET Title = ?, Description = ?, Category = ?, ImageUrl = ?, UpdatedAt = GETDATE() WHERE Id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, article.getTitle());
            ps.setString(2, article.getDescription());
            ps.setString(3, article.getCategory());
            ps.setString(4, article.getImageUrl());
            ps.setInt(5, article.getId());
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("✅ Article updated successfully: " + article.getTitle());
            } else {
                System.out.println("⚠️ No article updated (ID: " + article.getId() + ")");
            }
        } catch (SQLException e) {
            System.err.println("❌ Error updating article: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Xóa bài viết theo ID.
     * @param id ID của bài viết cần xóa.
     */
    public void deleteArticle(int id) {
        String sql = "DELETE FROM Articles WHERE Id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("✅ Article deleted successfully: ID = " + id);
            } else {
                System.out.println("⚠️ No article found to delete (ID: " + id + ")");
            }
        } catch (SQLException e) {
            System.err.println("❌ Error deleting article: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Lấy bài viết theo ID.
     * @param id ID của bài viết cần lấy.
     * @return Article đối tượng bài viết, hoặc null nếu không tìm thấy.
     */
    public Article getArticleById(int id) {
        String sql = "SELECT Id, Title, Description, Category, PublishDate, AuthorId, ImageUrl, CreatedAt, UpdatedAt FROM Articles WHERE Id = ?";
        Article article = null;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    article = mapResultSetToArticle(rs);
                    System.out.println("✅ Found article by ID: " + id + ", Title: " + article.getTitle());
                } else {
                    System.out.println("⚠️ No article found with ID: " + id);
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Error querying article by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return article;
    }

    public static void main(String[] args) {
        ArticleDAO dao = new ArticleDAO();
        
        // Test getAllArticles()
        List<Article> articles = dao.getAllArticles();
        System.out.println("🔍 Found " + articles.size() + " articles.");
        for (Article a : articles) {
            System.out.println("📝 ID: " + a.getId() + ", Title: " + a.getTitle());
        }
    }
}