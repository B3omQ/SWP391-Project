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
        String sql = "INSERT INTO DepositRequest (CusId, Amount, Note, Status, CreatedAt) " +
                     "VALUES (?, ?, ?, ?, GETDATE())";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, request.getCusId());
            stmt.setBigDecimal(2, request.getAmount());
            stmt.setString(3, request.getNote());
            stmt.setString(4, STATUS_ACTIVE);

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

    public List<DepositRequest> getPendingDepositRequests() {
        List<DepositRequest> list = new ArrayList<>();
        String sql = "SELECT dr.Id, dr.CusId, dr.Amount, dr.Note, dr.Status, dr.CreatedAt, c.Username " +
                     "FROM DepositRequest dr " +
                     "JOIN Customer c ON dr.CusId = c.Id " +
                     "WHERE dr.Status = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, STATUS_ACTIVE);
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
                     "FROM DepositRequest dr " +
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

    public boolean updateDepositRequestStatus(int id, String status) {
        if (!status.equals(STATUS_ACTIVE) && !status.equals(STATUS_COMPLETED) && !status.equals(STATUS_CANCEL)) {
            return false;
        }
        
        String sql = "UPDATE DepositRequest SET Status = ? WHERE Id = ? AND Status = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, id);
            stmt.setString(3, STATUS_ACTIVE);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Error updating deposit request status for Id " + id + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public List<DepositRequest> getDepositRequestsByCusId(int cusId) {
        return getDepositRequestsByCusIdWithPagination(cusId, 0, Integer.MAX_VALUE);
    }

    // Lấy danh sách phiếu yêu cầu theo cusId với phân trang
    public List<DepositRequest> getDepositRequestsByCusIdWithPagination(int cusId, int offset, int limit) {
        List<DepositRequest> requests = new ArrayList<>();
        String sql = "SELECT dr.Id, dr.CusId, dr.Amount, dr.Note, dr.Status, dr.CreatedAt, c.Username " +
                     "FROM DepositRequest dr " +
                     "JOIN Customer c ON dr.CusId = c.Id " +
                     "WHERE dr.CusId = ? " +
                     "ORDER BY dr.CreatedAt DESC " +
                     "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, cusId);
            stmt.setInt(2, offset);
            stmt.setInt(3, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    requests.add(mapResultSetToDepositRequest(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Error fetching deposit requests for CusId " + cusId + " with pagination: " + e.getMessage());
            e.printStackTrace();
        }
        return requests;
    }

    // Đếm tổng số phiếu yêu cầu theo cusId
    public int countDepositRequestsByCusId(int cusId) {
        String sql = "SELECT COUNT(*) " +
                     "FROM DepositRequest dr " +
                     "WHERE dr.CusId = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, cusId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Error counting deposit requests for CusId " + cusId + ": " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public List<DepositRequest> getFilteredDepositRequests(String search, String statusFilter, String sortBy) {
        return getFilteredDepositRequestsWithPagination(search, statusFilter, sortBy, 0, Integer.MAX_VALUE);
    }

    public List<DepositRequest> getFilteredDepositRequestsWithPagination(String search, String statusFilter, String sortBy, int offset, int limit) {
        List<DepositRequest> requests = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT dr.Id, dr.CusId, dr.Amount, dr.Note, dr.Status, dr.CreatedAt, c.Username " +
                "FROM DepositRequest dr " +
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

        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (search != null && !search.trim().isEmpty()) {
                stmt.setString(paramIndex++, "%" + search + "%");
            }
            if (statusFilter != null && !statusFilter.trim().isEmpty() && 
                (statusFilter.equals(STATUS_ACTIVE) || statusFilter.equals(STATUS_COMPLETED) || statusFilter.equals(STATUS_CANCEL))) {
                stmt.setString(paramIndex++, statusFilter);
            }
            stmt.setInt(paramIndex++, offset);
            stmt.setInt(paramIndex++, limit);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    requests.add(mapResultSetToDepositRequest(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Error retrieving filtered deposit requests with pagination: " + e.getMessage());
            e.printStackTrace();
        }
        return requests;
    }

    public int countFilteredDepositRequests(String search, String statusFilter) {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) " +
                "FROM DepositRequest dr " +
                "JOIN Customer c ON dr.CusId = c.Id " +
                "WHERE 1=1");

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND dr.Id LIKE ?");
        }
        if (statusFilter != null && !statusFilter.trim().isEmpty() && 
            (statusFilter.equals(STATUS_ACTIVE) || statusFilter.equals(STATUS_COMPLETED) || statusFilter.equals(STATUS_CANCEL))) {
            sql.append(" AND dr.Status = ?");
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
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Error counting filtered deposit requests: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
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