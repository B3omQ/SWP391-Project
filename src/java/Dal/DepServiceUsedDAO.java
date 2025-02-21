package dal;

import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import model.DepServiceUsed;
import util.DBContext;

public class DepServiceUsedDAO extends DBContext {
    
    public boolean insert(DepServiceUsed depServiceUsed) {
        String sql = "INSERT INTO DepServiceUsed (DepId, CusId, DepTypeId, Amount, StartDate, EndDate, DepStatus) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, depServiceUsed.getDepId());
            ps.setInt(2, depServiceUsed.getCusId());
            ps.setInt(3, depServiceUsed.getDepTypeId());
            ps.setBigDecimal(4, depServiceUsed.getAmount());
            ps.setTimestamp(5, new Timestamp(depServiceUsed.getStartDate().getTime()));
            
            if (depServiceUsed.getEndDate() != null) {
                ps.setTimestamp(6, new Timestamp(depServiceUsed.getEndDate().getTime()));
            } else {
                ps.setNull(6, java.sql.Types.TIMESTAMP);
            }
            
            ps.setString(7, depServiceUsed.getDepStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<DepServiceUsed> getAll() {
        List<DepServiceUsed> list = new ArrayList<>();
        String sql = "SELECT * FROM DepServiceUsed";
        
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                list.add(mapResultSetToDepServiceUsed(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<DepServiceUsed> getByCustomerId(int customerId) {
        List<DepServiceUsed> list = new ArrayList<>();
        String sql = "SELECT * FROM DepServiceUsed WHERE CusId = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToDepServiceUsed(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public boolean update(DepServiceUsed depServiceUsed) {
        String sql = "UPDATE DepServiceUsed SET DepStatus = ?, EndDate = ? WHERE Id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, depServiceUsed.getDepStatus());
            if (depServiceUsed.getEndDate() != null) {
                ps.setTimestamp(2, new Timestamp(depServiceUsed.getEndDate().getTime()));
            } else {
                ps.setNull(2, java.sql.Types.TIMESTAMP);
            }
            ps.setInt(3, depServiceUsed.getId());
            return ps.executeUpdate() > 0;
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
}
