package dal;

import model.DepServiceUsed;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DBContext;

public class DepServiceUsedDAO extends DBContext {

    public List<DepServiceUsed> getDepServiceUsedByCustomerId(int customerId) {
        List<DepServiceUsed> list = new ArrayList<>();
        String sql = "SELECT * FROM DepServiceUsed WHERE Id = ?";
        
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setInt(1, customerId);
            try (ResultSet rs = p.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToDepServiceUsed(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addDepServiceUsed(DepServiceUsed dsu) {
        String sql = "INSERT INTO DepServiceUsed (DepId, CusId, DepTypeId, Amount, StartDate, EndDate, DepStatus) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement p = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            p.setInt(1, dsu.getDepId());   // ID của bảng DepService
            p.setInt(2, dsu.getCusId());   // ID của bảng Customer
            p.setInt(3, dsu.getDepTypeId()); // ID của bảng DepType
            p.setBigDecimal(4, dsu.getAmount());
            p.setTimestamp(5, dsu.getStartDate());
            p.setTimestamp(6, dsu.getEndDate());
            p.setString(7, dsu.getDepStatus());

            int affectedRows = p.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = p.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        dsu.setId(generatedKeys.getInt(1)); // Gán lại ID mới được tạo
                    }
                }
            }
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateDepStatus(int id, String newStatus) {
        String sql = "UPDATE DepServiceUsed SET DepStatus = ? WHERE Id = ?";
        
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setString(1, newStatus);
            p.setInt(2, id);
            return p.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private DepServiceUsed mapResultSetToDepServiceUsed(ResultSet rs) throws SQLException {
        return new DepServiceUsed(
            rs.getInt("Id"),
            rs.getInt("DepId"),
            rs.getInt("CusId"),
            rs.getInt("DepTypeId"),
            rs.getBigDecimal("Amount"),
            rs.getTimestamp("StartDate"),
            rs.getTimestamp("EndDate"),
            rs.getString("DepStatus")
        );
    }

    public int getDepIdByTerm(int duringTime) {
        String sql = "SELECT Id FROM DepService WHERE DuringTime = ?";
        
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setInt(1, duringTime);
            try (ResultSet rs = p.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("Id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Trả về -1 nếu không tìm thấy
    }

    /**
     * Lấy lãi suất (SavingRate) từ bảng DepService dựa trên DepId
     * @param depId ID của dịch vụ gửi tiết kiệm
     * @return BigDecimal chứa lãi suất, hoặc null nếu không tìm thấy
     */
    public BigDecimal getSavingRateByDepId(int depId) {
        String sql = "SELECT SavingRate FROM DepService WHERE Id = ?";
        
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setInt(1, depId);
            try (ResultSet rs = p.executeQuery()) {
                if (rs.next()) {
                    return rs.getBigDecimal("SavingRate");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy
    }
}