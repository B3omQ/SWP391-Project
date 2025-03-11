package dal;

import model.Article;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import util.DBContext;

public class ArticleDAO extends DBContext {

      private String stripHtml(String html) {
        if (html == null) return null;
        // Loại bỏ thẻ HTML
        String stripped = html.replaceAll("<[^>]+>", "")
                             // Thay ký tự không gian đặc biệt (non-breaking space) bằng khoảng trắng
                             .replaceAll(" ", " ")
                             // Chuẩn hóa khoảng trắng (giữ nguyên nội dung, chỉ xử lý dư thừa)
                             .replaceAll("\\s{2,}", " ")
                             .trim();
        return stripped;
    }

    // Giải mã các HTML entities cơ bản
    private String decodeHtmlEntities(String text) {
        if (text == null) return null;
        String decoded = text
                // Chữ cái có dấu tiếng Việt (bổ sung đầy đủ)
                .replaceAll("&aacute;", "á")
                .replaceAll("&Aacute;", "Á")
                .replaceAll("&agrave;", "à")
                .replaceAll("&Agrave;", "À")
                .replaceAll("&acirc;", "â")
                .replaceAll("&Acirc;", "Â")
                .replaceAll("&atilde;", "ã")
                .replaceAll("&Atilde;", "Ã")
                .replaceAll("&eacute;", "é")
                .replaceAll("&Eacute;", "É")
                .replaceAll("&egrave;", "è")
                .replaceAll("&Egrave;", "È")
                .replaceAll("&ecirc;", "ê")
                .replaceAll("&Ecirc;", "Ê")
                .replaceAll("&iacute;", "í")
                .replaceAll("&Iacute;", "Í")
                .replaceAll("&igrave;", "ì")
                .replaceAll("&Igrave;", "Ì")
                .replaceAll("&oacute;", "ó")
                .replaceAll("&Oacute;", "Ó")
                .replaceAll("&ograve;", "ò")
                .replaceAll("&Ograve;", "Ò")
                .replaceAll("&ocirc;", "ô")
                .replaceAll("&Ocirc;", "Ô")
                .replaceAll("&uacute;", "ú")
                .replaceAll("&Uacute;", "Ú")
                .replaceAll("&ugrave;", "ù")
                .replaceAll("&Ugrave;", "Ù")
                .replaceAll("&yacute;", "ý")
                .replaceAll("&Yacute;", "Ý")
                // Ký tự cơ bản
                .replaceAll("&amp;", "&")
                .replaceAll("&nbsp;", " ")
                .replaceAll("&quot;", "\"")
                .replaceAll("&apos;", "'")
                .replaceAll("&lt;", "<")
                .replaceAll("&gt;", ">")
                // Chuẩn hóa khoảng trắng sau khi decode
                .replaceAll("\\s+", " ")
                .trim();
        return decoded;
    }

    // Phương thức ánh xạ ResultSet sang đối tượng Article
    private Article mapResultSetToArticle(ResultSet rs) throws SQLException {
        String description = rs.getString("Description");
        if (description != null) {
            description = stripHtml(description); // Loại bỏ HTML
            description = decodeHtmlEntities(description); // Giải mã entities
            // Log để debug
            System.out.println("Processed description for ID " + rs.getInt("Id") + ": " + description);
        }
        return new Article(
                rs.getInt("Id"),
                rs.getString("Title"),
                description,
                rs.getString("Category"),
                rs.getTimestamp("PublishDate"),
                rs.getInt("AuthorId"),
                rs.getString("ImageUrl"),
                rs.getTimestamp("CreatedAt"),
                rs.getTimestamp("UpdatedAt")
        );
    }

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

    // Các phương thức khác (addArticle, updateArticle, deleteArticle, getArticleById) giữ nguyên
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
}