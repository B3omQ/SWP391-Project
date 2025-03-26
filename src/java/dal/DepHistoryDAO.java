package dal;

import java.math.BigDecimal;
import model.DepHistory;
import java.sql.*;
import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import util.DBContext;

public class DepHistoryDAO extends DBContext {

    /**
     * Thêm một bản ghi lịch sử gửi tiết kiệm
     * @param dsuId ID của DepServiceUsed (có thể null)
     * @param description Mô tả giao dịch
     * @param amount Số tiền (tổng số tiền hoặc số tiền gốc tùy ngữ cảnh)
     * @param cusId ID của khách hàng
     * @return true nếu thêm thành công, false nếu thất bại
     */
    public boolean addDepHistory(Integer dsuId, String description, BigDecimal amount, int cusId) {
        String sql = "INSERT INTO DepHistory (DSUId, Discription, CreatedAt, Amount, CusId) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            if (dsuId != null) {
                p.setInt(1, dsuId);
            } else {
                p.setNull(1, java.sql.Types.INTEGER);
            }
            p.setString(2, description);
            p.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now()));
            if (amount != null) {
                p.setBigDecimal(4, amount);
            } else {
                p.setNull(4, java.sql.Types.DECIMAL);
            }
            p.setInt(5, cusId);
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
     * Thêm một bản ghi lịch sử gửi tiết kiệm với thông tin chi tiết (dành cho đáo hạn)
     * @param dsuId ID của DepServiceUsed
     * @param action Hành động đáo hạn
     * @param principal Số tiền gốc
     * @param interest Lãi suất
     * @param totalAmount Tổng số tiền
     * @param cusId ID của khách hàng
     * @return true nếu thêm thành công, false nếu thất bại
     */
    public boolean addDepHistory(int dsuId, String action, BigDecimal principal, BigDecimal interest, BigDecimal totalAmount, int cusId) {
        DecimalFormat formatter = new DecimalFormat("#,###");
        String formattedTotalAmount = formatter.format(totalAmount);
        String formattedPrincipal = formatter.format(principal);
        String formattedInterest = formatter.format(interest);

        String description = "Đáo hạn tự động: " + action + " " + formattedTotalAmount + " VND " +
                            "(Gốc: " + formattedPrincipal + " VND, Lãi: " + formattedInterest + " VND)";
        
        String sql = "INSERT INTO DepHistory (DSUId, Discription, CreatedAt, Amount, CusId) VALUES (?, ?, ?, ?, ?)";
        
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setInt(1, dsuId);
            p.setString(2, description);
            p.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now()));
            p.setBigDecimal(4, totalAmount);
            p.setInt(5, cusId);
            int affectedRows = p.executeUpdate();
            System.out.println("DepHistory (maturity) added successfully, affected rows: " + affectedRows);
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("❌ Error adding DepHistory (maturity): " + e.getMessage());
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
        String sql = "SELECT Id, DSUId, Discription, CreatedAt, Amount, CusId FROM DepHistory WHERE DSUId = ?";
        
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setInt(1, dsuId);
            try (ResultSet rs = p.executeQuery()) {
                while (rs.next()) {
                    DepHistory history = mapResultSetToDepHistory(rs);
                    historyList.add(history);
                }
            }
        } catch (SQLException e) {
            System.out.println("❌ Error querying DepHistory by DSUId: " + e.getMessage());
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
        String sql = "SELECT Id, DSUId, Discription, CreatedAt, Amount, CusId " +
                     "FROM DepHistory " +
                     "WHERE CusId = ? " +
                     "ORDER BY CreatedAt DESC";
        
        System.out.println("[DEBUG] Querying DepHistory for customerId: " + customerId);
        
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setInt(1, customerId);
            try (ResultSet rs = p.executeQuery()) {
                while (rs.next()) {
                    DepHistory history = mapResultSetToDepHistory(rs);
                    historyList.add(history);
                    System.out.println("[DEBUG] Found record: ID=" + history.getId() + ", Description=" + history.getDescription() + ", Amount=" + history.getAmount());
                }
            }
        } catch (SQLException e) {
            System.out.println("❌ Error querying DepHistory: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println("[DEBUG] Total history records found: " + historyList.size());
        return historyList;
    }
    
    public static void main(String[] args) {
        DepHistoryDAO d = new DepHistoryDAO();
        List<DepHistory> list = d.getDepHistoryByCustomerId(42);
        for(DepHistory o : list) {
            System.out.println(o);}
    }

    /**
     * Lấy danh sách giao dịch nạp tiền theo CustomerId
     * @param customerId ID của khách hàng
     * @return List<DepHistory> chứa danh sách giao dịch nạp tiền, hoặc danh sách rỗng nếu không tìm thấy
     */
    public List<DepHistory> getDepositTransactionsByCustomerId(int customerId) {
        List<DepHistory> depositList = new ArrayList<>();
        String sql = "SELECT Id, DSUId, Discription, CreatedAt, Amount, CusId " +
                     "FROM DepHistory " +
                     "WHERE CusId = ? AND DSUId IS NULL AND Discription LIKE '%Nạp tiền%'";
        
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setInt(1, customerId);
            try (ResultSet rs = p.executeQuery()) {
                while (rs.next()) {
                    DepHistory history = mapResultSetToDepHistory(rs);
                    depositList.add(history);
                }
            }
        } catch (SQLException e) {
            System.out.println("❌ Error querying deposit transactions: " + e.getMessage());
            e.printStackTrace();
        }
        return depositList;
    }

    /**
     * Lấy tất cả lịch sử gửi tiết kiệm
     * @return List<DepHistory> chứa tất cả lịch sử, hoặc danh sách rỗng nếu không có
     */
    public List<DepHistory> getAllDepHistory() {
        List<DepHistory> historyList = new ArrayList<>();
        String sql = "SELECT Id, DSUId, Discription, CreatedAt, Amount, CusId FROM DepHistory";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                DepHistory history = mapResultSetToDepHistory(rs);
                historyList.add(history);
            }
        } catch (SQLException e) {
            System.out.println("❌ Error querying all DepHistory: " + e.getMessage());
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
            System.out.println("❌ Error updating DepHistory: " + e.getMessage());
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
            System.out.println("❌ Error deleting DepHistory: " + e.getMessage());
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
        return new DepHistory(
            rs.getInt("Id"),
            rs.getObject("DSUId") != null ? rs.getInt("DSUId") : null, // Đúng kiểu Integer
            rs.getString("Discription"),
            rs.getBigDecimal("Amount"),
            rs.getTimestamp("CreatedAt"),
            rs.getInt("CusId")
        );
    }

    /**
     * Tìm kiếm lịch sử gửi tiết kiệm theo CustomerId và từ khóa
     * @param customerId ID của khách hàng
     * @param keyword Từ khóa tìm kiếm
     * @return List<DepHistory> chứa danh sách lịch sử, hoặc danh sách rỗng nếu không tìm thấy
     */
    public List<DepHistory> searchDepHistoryByCustomerId(int customerId, String keyword) {
        List<DepHistory> historyList = new ArrayList<>();
        String sql = "SELECT Id, DSUId, Discription, CreatedAt, Amount, CusId " +
                     "FROM DepHistory " +
                     "WHERE CusId = ? " +
                     "AND (Discription LIKE ? OR CAST(Amount AS NVARCHAR(50)) LIKE ?) " +
                     "ORDER BY CreatedAt DESC";
        
        System.out.println("[DEBUG] Searching DepHistory for customerId: " + customerId + " with keyword: " + keyword);
        
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setInt(1, customerId);
            p.setString(2, "%" + keyword + "%");
            p.setString(3, "%" + keyword + "%");
            try (ResultSet rs = p.executeQuery()) {
                while (rs.next()) {
                    DepHistory history = mapResultSetToDepHistory(rs);
                    historyList.add(history);
                    System.out.println("[DEBUG] Found record: ID=" + history.getId() + ", Description=" + history.getDescription() + ", Amount=" + history.getAmount());
                }
            }
        } catch (SQLException e) {
            System.out.println("❌ Error searching DepHistory: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println("[DEBUG] Total history records found: " + historyList.size());
        return historyList;
    }

    /**
     * Tính tổng lợi nhuận tự động theo CustomerId
     * @param customerId ID của khách hàng
     * @return Tổng lợi nhuận tự động, hoặc 0 nếu không có
     */
    public BigDecimal getTotalAutoProfit(int customerId) {
        String sql = "SELECT SUM(Amount) AS TotalAutoProfit " +
                     "FROM DepHistory " +
                     "WHERE CusId = ? AND Discription LIKE '%Sinh%'";
        
        System.out.println("[DEBUG] Calculating TotalAutoProfit for customerId: " + customerId);
        
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setInt(1, customerId);
            try (ResultSet rs = p.executeQuery()) {
                if (rs.next()) {
                    BigDecimal total = rs.getBigDecimal("TotalAutoProfit");
                    System.out.println("[DEBUG] Calculated TotalAutoProfit for customer " + customerId + ": " + (total != null ? total : BigDecimal.ZERO));
                    return total != null ? total : BigDecimal.ZERO;
                }
            }
        } catch (SQLException e) {
            System.out.println("❌ Error getting total auto profit: " + e.getMessage());
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }
      public boolean addManualDeposit(String description, BigDecimal amount, int cusId) {
        String sql = "INSERT INTO DepHistory (DSUId, Discription, CreatedAt, Amount, CusId) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setNull(1, java.sql.Types.INTEGER); 
            p.setString(2, "Gửi tiền thủ công - " + description); 
            p.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now()));
            p.setBigDecimal(4, amount);
            p.setInt(5, cusId);
            int affectedRows = p.executeUpdate();
            System.out.println("[DEBUG] Manual deposit added successfully, affected rows: " + affectedRows);
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("❌ Error adding manual deposit: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}