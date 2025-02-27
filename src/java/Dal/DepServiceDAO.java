package dal;

import model.DepService;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DBContext;

public class DepServiceDAO extends DBContext {

    public List<DepService> getAllDepServices() {
        List<DepService> list = new ArrayList<>();
        String sql = "SELECT * FROM DepService";
        
        try (Statement s = connection.createStatement();
             ResultSet rs = s.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapResultSetToDepService(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public DepService getDepServiceById(int id) {
        String sql = "SELECT * FROM DepService WHERE Id = ?";
        
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setInt(1, id);
            try (ResultSet rs = p.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToDepService(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private DepService mapResultSetToDepService(ResultSet rs) throws SQLException {
        return new DepService(
            rs.getInt("Id"),
            rs.getString("Description"),
            rs.getBigDecimal("MinimumDep"),
            rs.getInt("DuringTime"),
            rs.getBigDecimal("SavingRate")
        );
    }
}
