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
        String stripped = html.replaceAll("<[^>]+>", "")
                             .replaceAll(" ", " ")
                             .replaceAll("\\s{2,}", " ")
                             .trim();
        return stripped;
    }

    private String decodeHtmlEntities(String text) {
        if (text == null) return null;
        String decoded = text
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

    private Article mapResultSetToArticle(ResultSet rs) throws SQLException {
        String description = rs.getString("Description");
        if (description != null) {
            description = stripHtml(description); 
            description = decodeHtmlEntities(description); 
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


    public List<Article> getFilteredArticles(String search, String categoryFilter, String sortBy) {
        List<Article> articles = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT Id, Title, Description, Category, PublishDate, AuthorId, ImageUrl, CreatedAt, UpdatedAt " +
            "FROM Articles WHERE 1=1"
        );

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND Title LIKE ?");
        }

        if (categoryFilter != null && !categoryFilter.trim().isEmpty()) {
            sql.append(" AND Category = ?");
        }

        if (sortBy != null && !sortBy.trim().isEmpty()) {
            switch (sortBy) {
                case "publishDate_asc":
                    sql.append(" ORDER BY PublishDate ASC");
                    break;
                case "title_asc":
                    sql.append(" ORDER BY Title ASC");
                    break;
                case "title_desc":
                    sql.append(" ORDER BY Title DESC");
                    break;
                default:
                    sql.append(" ORDER BY PublishDate DESC");
                    break;
            }
        } else {
            sql.append(" ORDER BY PublishDate DESC");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;

            if (search != null && !search.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + search.trim() + "%");
            }

            if (categoryFilter != null && !categoryFilter.trim().isEmpty()) {
                ps.setString(paramIndex++, categoryFilter.trim());
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    articles.add(mapResultSetToArticle(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in getFilteredArticles: " + e.getMessage());
            e.printStackTrace();
        }
        return articles;
    }

    public void addArticle(Article article) {
        String sql = "INSERT INTO Articles (Title, Description, Category, AuthorId, ImageUrl, PublishDate, CreatedAt) " +
                     "VALUES (?, ?, ?, ?, ?, GETDATE(), GETDATE())";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, article.getTitle());
            ps.setString(2, article.getDescription());
            ps.setString(3, article.getCategory());
            ps.setInt(4, article.getAuthorId());
            ps.setString(5, article.getImageUrl());
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("✅ Article added: " + article.getTitle());
            }
        } catch (SQLException e) {
            System.err.println("❌ Error adding article: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void updateArticle(Article article) {
        String sql = "UPDATE Articles SET Title = ?, Description = ?, Category = ?, ImageUrl = ?, UpdatedAt = GETDATE() " +
                     "WHERE Id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, article.getTitle());
            ps.setString(2, article.getDescription());
            ps.setString(3, article.getCategory());
            ps.setString(4, article.getImageUrl());
            ps.setInt(5, article.getId());
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("✅ Article updated: " + article.getTitle());
            } else {
                System.out.println("⚠️ No article updated for ID: " + article.getId());
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
                System.out.println("✅ Article deleted: ID = " + id);
            } else {
                System.out.println("⚠️ No article found to delete for ID: " + id);
            }
        } catch (SQLException e) {
            System.err.println("❌ Error deleting article: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Lấy bài viết theo ID
    public Article getArticleById(int id) {
        String sql = "SELECT Id, Title, Description, Category, PublishDate, AuthorId, ImageUrl, CreatedAt, UpdatedAt " +
                     "FROM Articles WHERE Id = ?";
        Article article = null;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    article = mapResultSetToArticle(rs);
                    System.out.println("✅ Found article: ID = " + id + ", Title = " + article.getTitle());
                } else {
                    System.out.println("⚠️ No article found for ID: " + id);
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Error querying article by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return article;
    }
    public List<Article> getAllArticles() {
    List<Article> articles = new ArrayList<>();
    String sql = "SELECT Id, Title, Description, Category, PublishDate, AuthorId, ImageUrl, CreatedAt, UpdatedAt " +
                 "FROM Articles ORDER BY PublishDate DESC";

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
    public List<Article> getFilteredArticlesWithPagination(String search, String categoryFilter, String sortBy, int offset, int limit) {
        List<Article> articles = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT Id, Title, Description, Category, PublishDate, AuthorId, ImageUrl, CreatedAt, UpdatedAt " +
            "FROM Articles WHERE 1=1"
        );

        // Điều kiện tìm kiếm theo tiêu đề
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND Title LIKE ?");
        }

        // Điều kiện lọc theo thể loại
        if (categoryFilter != null && !categoryFilter.trim().isEmpty()) {
            sql.append(" AND Category = ?");
        }

        // Sắp xếp
        if (sortBy != null && !sortBy.trim().isEmpty()) {
            switch (sortBy) {
                case "publishDate_asc":
                    sql.append(" ORDER BY PublishDate ASC");
                    break;
                case "title_asc":
                    sql.append(" ORDER BY Title ASC");
                    break;
                case "title_desc":
                    sql.append(" ORDER BY Title DESC");
                    break;
                default:
                    sql.append(" ORDER BY PublishDate DESC");
                    break;
            }
        } else {
            sql.append(" ORDER BY PublishDate DESC");
        }

        // Thêm phân trang
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;

            if (search != null && !search.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + search.trim() + "%");
            }

            if (categoryFilter != null && !categoryFilter.trim().isEmpty()) {
                ps.setString(paramIndex++, categoryFilter.trim());
            }

            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex++, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    articles.add(mapResultSetToArticle(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in getFilteredArticlesWithPagination: " + e.getMessage());
            e.printStackTrace();
        }
        return articles;
    }

    // Đếm tổng số bài viết với các bộ lọc
    public int countFilteredArticles(String search, String categoryFilter) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Articles WHERE 1=1");

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND Title LIKE ?");
        }

        if (categoryFilter != null && !categoryFilter.trim().isEmpty()) {
            sql.append(" AND Category = ?");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;

            if (search != null && !search.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + search.trim() + "%");
            }

            if (categoryFilter != null && !categoryFilter.trim().isEmpty()) {
                ps.setString(paramIndex++, categoryFilter.trim());
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in countFilteredArticles: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }
    
    public List<Article> getEarliestArticles() {
    List<Article> articles = new ArrayList<>();
   String sql = "SELECT TOP 3 Id, Title, Description, Category, PublishDate, AuthorId, ImageUrl, CreatedAt, UpdatedAt " +
             "FROM Articles ORDER BY PublishDate ASC";

    try (PreparedStatement ps = connection.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            articles.add(mapResultSetToArticle(rs));
        }
        System.out.println("Found " + articles.size() + " earliest articles.");
    } catch (SQLException e) {
        System.err.println("SQL Error in getEarliestArticles: " + e.getMessage());
        e.printStackTrace();
    }
    return articles;
}
}