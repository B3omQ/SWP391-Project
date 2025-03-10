/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package dal;

import model.DepServiceUsed;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DBContext;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.DepServiceUsed;
import util.DBContext;

public class DepServiceUsedDAO extends DBContext {

    public List<DepServiceUsed> getDepServiceUsedByCustomerId(int customerId) {
        List<DepServiceUsed> list = new ArrayList<>();
        String sql = "SELECT * FROM DepServiceUsed WHERE CusId = ?"; // Sửa từ Id thành CusId
        
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
        String sql = "INSERT INTO DepServiceUsed (DepId, CusId, DepTypeId, Amount, StartDate, EndDate, DepStatus, MaturityOption) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)"; // Thêm MaturityOption vào SQL

        try (PreparedStatement p = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            p.setInt(1, dsu.getDepId());
            p.setInt(2, dsu.getCusId());
            p.setInt(3, dsu.getDepTypeId());
            p.setBigDecimal(4, dsu.getAmount());
            p.setTimestamp(5, dsu.getStartDate());
            p.setTimestamp(6, dsu.getEndDate());
            p.setString(7, dsu.getDepStatus());
            p.setString(8, dsu.getMaturityAction()); // Lưu giá trị maturityAction vào MaturityOption

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
            rs.getString("DepStatus"),
            rs.getString("MaturityOption") // Ánh xạ MaturityOption từ DB
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
    public int getTermMonthsByDepId(int depId) {
    String sql = "SELECT DuringTime FROM DepService WHERE Id = ?";
    try (PreparedStatement p = connection.prepareStatement(sql)) {
        p.setInt(1, depId);
        try (ResultSet rs = p.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("DuringTime");
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return 0; // Trả về 0 nếu không tìm thấy
}
      public List<DepServiceUsed> getActiveDepositsByCustomerId(int customerId) {
        List<DepServiceUsed> deposits = new ArrayList<>();
        String sql = "SELECT Id, DepId, CusId, DepTypeId, Amount, StartDate, EndDate, DepStatus, MaturityOption " +
                     "FROM DepServiceUsed " +
                     "WHERE CusId = ? AND UPPER(DepStatus) = 'ACTIVE' AND EndDate > GETDATE()";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setInt(1, customerId);
            System.out.println("Executing query for customerId: " + customerId);
            try (ResultSet rs = p.executeQuery()) {
                while (rs.next()) {
                    DepServiceUsed deposit = new DepServiceUsed();
                    deposit.setId(rs.getInt("Id"));
                    deposit.setDepId(rs.getInt("DepId"));
                    deposit.setCusId(rs.getInt("CusId"));
                    deposit.setDepTypeId(rs.getInt("DepTypeId"));
                    deposit.setAmount(rs.getBigDecimal("Amount"));
                    deposit.setStartDate(rs.getTimestamp("StartDate"));
                    deposit.setEndDate(rs.getTimestamp("EndDate"));
                    deposit.setDepStatus(rs.getString("DepStatus"));
                    deposit.setMaturityAction(rs.getString("MaturityOption")); // Sửa ở đây
                    deposits.add(deposit);
                    System.out.println("Found active deposit: Id=" + deposit.getId() + ", Amount=" + deposit.getAmount());
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Error querying active deposits for customerId " + customerId + ": " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println("Found " + deposits.size() + " active deposits for customerId: " + customerId);
        return deposits;
    }
      public DepServiceUsed getDepositById(int depositId) {
        DepServiceUsed deposit = null;
        String sql = "SELECT Id, DepId, CusId, DepTypeId, Amount, StartDate, EndDate, DepStatus, MaturityOption " +
                     "FROM DepServiceUsed WHERE Id = ?";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setInt(1, depositId);
            try (ResultSet rs = p.executeQuery()) {
                if (rs.next()) {
                    deposit = new DepServiceUsed();
                    deposit.setId(rs.getInt("Id"));
                    deposit.setDepId(rs.getInt("DepId"));
                    deposit.setCusId(rs.getInt("CusId"));
                    deposit.setDepTypeId(rs.getInt("DepTypeId"));
                    deposit.setAmount(rs.getBigDecimal("Amount"));
                    deposit.setStartDate(rs.getTimestamp("StartDate"));
                    deposit.setEndDate(rs.getTimestamp("EndDate"));
                    deposit.setDepStatus(rs.getString("DepStatus"));
                    String maturityOption = rs.getString("MaturityOption");
                    deposit.setMaturityAction(maturityOption != null ? maturityOption : "Không xác định");
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Error querying deposit by Id " + depositId + ": " + e.getMessage());
            e.printStackTrace();
        }
        return deposit;
    }
       public boolean updateDepositStatus(int depositId, String status) {
        String sql = "UPDATE DepServiceUsed SET DepStatus = ? WHERE Id = ?";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setString(1, status);
            p.setInt(2, depositId);
            int affectedRows = p.executeUpdate();
            System.out.println("Updated deposit status: Id=" + depositId + ", New Status=" + status + ", Rows=" + affectedRows);
            return affectedRows > 0;
        } catch (SQLException e) {
            System.err.println("❌ Error updating deposit status for Id " + depositId + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
