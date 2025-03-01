package dal;

import java.math.BigDecimal;
import model.DepHistory;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DBContext;

public class DepHistoryDAO extends DBContext {

    /**
     * Thêm một bản ghi lịch sử gửi tiết kiệm
     * @param dsuId ID của DepServiceUsed
     * @param description Mô tả giao dịch
     * @return true nếu thêm thành công, false nếu thất bại
     */
    public boolean addDepHistory(int dsuId, String description) {
        String sql = "INSERT INTO DepHistory (DSUId, Discription) VALUES (?, ?)";
        
        System.out.println("Attempting to add DepHistory with DSUId: " + dsuId + ", Description: " + description);
        
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setInt(1, dsuId);
            p.setString(2, description);
            int affectedRows = p.executeUpdate();
            System.out.println("DepHistory added successfully, affected rows: " + affectedRows);
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("❌ Error adding DepHistory: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Lấy danh sách lịch sử gửi tiết kiệm theo DSUId
     * @param dsuId ID của DepServiceUsed
     * @return List<DepHistory> chứa danh sách lịch sử, hoặc danh sách rỗng nếu không tìm thấy
     */
    public List<DepHistory> getDepHistoryByDSUId(int dsuId) {
        List<DepHistory> historyList = new ArrayList<>();
        String sql = "SELECT * FROM DepHistory WHERE DSUId = ?";
        
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setInt(1, dsuId);
            try (ResultSet rs = p.executeQuery()) {
                while (rs.next()) {
                    DepHistory history = mapResultSetToDepHistory(rs);
                    historyList.add(history);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return historyList;
    }

    /**
     * Lấy danh sách lịch sử gửi tiết kiệm theo CustomerId
     * @param customerId ID của khách hàng
     * @return List<DepHistory> chứa danh sách lịch sử, hoặc danh sách rỗng nếu không tìm thấy
     */
    public List<DepHistory> getDepHistoryByCustomerId(int customerId) {
        List<DepHistory> historyList = new ArrayList<>();
        String sql = "SELECT dh.*, dsu.Amount, dsu.StartDate " + // Sử dụng 'Amount' (chữ hoa)
                     "FROM DepHistory dh " +
                     "LEFT JOIN DepServiceUsed dsu ON dh.DSUId = dsu.Id " + // Sử dụng LEFT JOIN để lấy dữ liệu ngay cả khi DepHistory trống
                     "WHERE dsu.CusId = ? OR dh.DSUId IS NULL";
        
        System.out.println("Querying DepHistory for customerId: " + customerId);
        
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setInt(1, customerId);
            try (ResultSet rs = p.executeQuery()) {
                while (rs.next()) {
                    System.out.println("Found history record: Id=" + rs.getInt("Id") + 
                                     ", DSUId=" + rs.getInt("DSUId") + 
                                     ", Amount=" + rs.getBigDecimal("Amount"));
                    DepHistory history = mapResultSetToDepHistory(rs);
                    historyList.add(history);
                }
            }
        } catch (SQLException e) {
            System.out.println("❌ Error querying DepHistory: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println("Total history records found: " + historyList.size());
        return historyList;
    }

    /**
     * Lấy tất cả lịch sử gửi tiết kiệm
     * @return List<DepHistory> chứa tất cả lịch sử, hoặc danh sách rỗng nếu không có
     */
    public List<DepHistory> getAllDepHistory() {
        List<DepHistory> historyList = new ArrayList<>();
        String sql = "SELECT * FROM DepHistory";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                DepHistory history = mapResultSetToDepHistory(rs);
                historyList.add(history);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return historyList;
    }

    /**
     * Cập nhật mô tả của bản ghi lịch sử
     * @param id ID của bản ghi lịch sử
     * @param newDescription Mô tả mới
     * @return true nếu cập nhật thành công, false nếu thất bại
     */
    public boolean updateDepHistoryDescription(int id, String newDescription) {
        String sql = "UPDATE DepHistory SET Discription = ? WHERE Id = ?";
        
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setString(1, newDescription);
            p.setInt(2, id);
            int affectedRows = p.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Xóa một bản ghi lịch sử theo ID
     * @param id ID của bản ghi lịch sử
     * @return true nếu xóa thành công, false nếu thất bại
     */
    public boolean deleteDepHistory(int id) {
        String sql = "DELETE FROM DepHistory WHERE Id = ?";
        
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setInt(1, id);
            int affectedRows = p.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Ánh xạ ResultSet thành đối tượng DepHistory
     * @param rs ResultSet chứa dữ liệu từ database
     * @return DepHistory đối tượng được ánh xạ
     * @throws SQLException nếu có lỗi khi truy xuất dữ liệu
     */
    private DepHistory mapResultSetToDepHistory(ResultSet rs) throws SQLException {
        BigDecimal amount = null;
        try {
            amount = rs.getBigDecimal("Amount"); // Sử dụng 'Amount' (chữ hoa)
        } catch (SQLException e) {
            System.out.println("❌ Cột 'Amount' không tồn tại, sử dụng null: " + e.getMessage());
        }

        return new DepHistory(
            rs.getInt("Id"),
            rs.getInt("DSUId"),
            rs.getString("Discription"),
            amount, // Sử dụng null nếu cột 'Amount' không tồn tại
            rs.getTimestamp("StartDate")
        );
    }
      public boolean addDepHistory(DepHistory history) {
        String sql = "INSERT INTO DepHistory (DSUId, CustomerId, Discription, Amount, CreatedAt) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setInt(1, history.getDsuId());
            p.setInt(2, history.getCustomerId());
            p.setString(3, history.getDescription());
            p.setBigDecimal(4, history.getAmount());
            p.setTimestamp(5, history.getCreatedAt());
            int affectedRows = p.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("❌ Error adding DepHistory: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}