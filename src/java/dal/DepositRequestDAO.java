package dal;

import model.DepositRequest;
import util.DBContext;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class DepositRequestDAO extends DBContext {

    // Các trạng thái có thể sử dụng
    public static final String STATUS_ACTIVE = "ACTIVE";
    public static final String STATUS_COMPLETED = "COMPLETED";
    public static final String STATUS_CANCEL = "CANCEL";

    public int addDepositRequest(DepositRequest request) {
        String sql = "INSERT INTO deposit_requests (CusId, Amount, Note, Status, CreatedAt) " +
                     "VALUES (?, ?, ?, ?, GETDATE())";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, request.getCusId());
            stmt.setBigDecimal(2, request.getAmount());
            stmt.setString(3, request.getNote());
            stmt.setString(4, STATUS_ACTIVE); // Thay 'Pending' bằng STATUS_ACTIVE

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
            return -1;
        } catch (SQLException e) {
            System.err.println("❌ Error adding deposit request: " + e.getMessage());
            e.printStackTrace();
            return -1;
        }
    }

    // Lấy danh sách các phiếu yêu cầu đang ACTIVE
    public List<DepositRequest> getPendingDepositRequests() {
        List<DepositRequest> list = new ArrayList<>();
        String sql = "SELECT dr.Id, dr.CusId, dr.Amount, dr.Note, dr.Status, dr.CreatedAt, c.Username " +
                     "FROM deposit_requests dr " +
                     "JOIN Customer c ON dr.CusId = c.Id " +
                     "WHERE dr.Status = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, STATUS_ACTIVE); // Thay 'Pending' bằng STATUS_ACTIVE
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToDepositRequest(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Error fetching active deposit requests: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public DepositRequest getDepositRequestById(int id) {
        String sql = "SELECT dr.Id, dr.CusId, dr.Amount, dr.Note, dr.Status, dr.CreatedAt, c.Username " +
                     "FROM deposit_requests dr " +
                     "JOIN Customer c ON dr.CusId = c.Id " +
                     "WHERE dr.Id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToDepositRequest(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Error fetching deposit request by Id " + id + ": " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật trạng thái phiếu (chỉ cho phép cập nhật từ ACTIVE)
    public boolean updateDepositRequestStatus(int id, String status) {
        // Kiểm tra xem status đầu vào có hợp lệ không
        if (!status.equals(STATUS_ACTIVE) && !status.equals(STATUS_COMPLETED) && !status.equals(STATUS_CANCEL)) {
            return false;
        }
        
        String sql = "UPDATE deposit_requests SET Status = ? WHERE Id = ? AND Status = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, id);
            stmt.setString(3, STATUS_ACTIVE); // Chỉ cho phép cập nhật từ trạng thái ACTIVE
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Error updating deposit request status for Id " + id + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public List<DepositRequest> getDepositRequestsByCusId(int cusId) {
        List<DepositRequest> requests = new ArrayList<>();
        String sql = "SELECT dr.Id, dr.CusId, dr.Amount, dr.Note, dr.Status, dr.CreatedAt, c.Username " +
                     "FROM deposit_requests dr " +
                     "JOIN Customer c ON dr.CusId = c.Id " +
                     "WHERE dr.CusId = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, cusId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    requests.add(mapResultSetToDepositRequest(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Error fetching deposit requests for CusId " + cusId + ": " + e.getMessage());
            e.printStackTrace();
        }
        return requests;
    }

    public List<DepositRequest> getFilteredDepositRequests(String search, String statusFilter, String sortBy) {
        List<DepositRequest> requests = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT dr.Id, dr.CusId, dr.Amount, dr.Note, dr.Status, dr.CreatedAt, c.Username " +
                "FROM deposit_requests dr " +
                "JOIN Customer c ON dr.CusId = c.Id " +
                "WHERE 1=1");

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND dr.Id LIKE ?");
        }
        if (statusFilter != null && !statusFilter.trim().isEmpty() && 
            (statusFilter.equals(STATUS_ACTIVE) || statusFilter.equals(STATUS_COMPLETED) || statusFilter.equals(STATUS_CANCEL))) {
            sql.append(" AND dr.Status = ?");
        }

        if ("createdAt_asc".equals(sortBy)) {
            sql.append(" ORDER BY dr.CreatedAt ASC");
        } else {
            sql.append(" ORDER BY dr.CreatedAt DESC");
        }

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (search != null && !search.trim().isEmpty()) {
                stmt.setString(paramIndex++, "%" + search + "%");
            }
            if (statusFilter != null && !statusFilter.trim().isEmpty() && 
                (statusFilter.equals(STATUS_ACTIVE) || statusFilter.equals(STATUS_COMPLETED) || statusFilter.equals(STATUS_CANCEL))) {
                stmt.setString(paramIndex++, statusFilter);
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    requests.add(mapResultSetToDepositRequest(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Error retrieving filtered deposit requests: " + e.getMessage());
            e.printStackTrace();
        }
        return requests;
    }

    private DepositRequest mapResultSetToDepositRequest(ResultSet rs) throws SQLException {
        DepositRequest request = new DepositRequest();
        request.setId(rs.getInt("Id"));
        request.setCusId(rs.getInt("CusId"));
        request.setAmount(rs.getBigDecimal("Amount"));
        request.setNote(rs.getString("Note"));
        request.setStatus(rs.getString("Status"));
        request.setCreatedAt(rs.getTimestamp("CreatedAt"));
        request.setUsername(rs.getString("Username"));
        return request;
    }
}