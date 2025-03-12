/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import util.DBContext;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.DepService;

/**
 *
 * @author JIGGER
 */
public class DepServiceDAO extends DBContext {

    public List<DepService> getAllDepService() {
        List<DepService> list = new ArrayList<>();

        String sql = """
                      SELECT Id, Description, MinimumDep, DuringTime, SavingRate, SavingRateMinimum, PendingStatus
                     FROM BankingSystem.dbo.DepService""";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    DepService depService = new DepService(
                            rs.getInt("Id"),
                            rs.getString("Description"),
                            rs.getBigDecimal("MinimumDep"),
                            rs.getInt("DuringTime"),
                            rs.getDouble("SavingRate"),
                            rs.getDouble("SavingRateMinimum"),
                            rs.getString("PendingStatus")
                    );
                    list.add(depService);
                }
            }

        } catch (SQLException e) {
            System.out.println(e);
        }

        return list;
    }

    public static void main(String[] args) {
        DepServiceDAO d = new DepServiceDAO();
        List<DepService> list = d.getAllDepServiceByStatus("Pending", "DuringTime", "ASC");
        for (DepService o : list) {
            System.out.println(o);
        }
    }

    public List<DepService> getAllDepServiceByStatus(String status, String sortBy, String order) {
        List<DepService> list = new ArrayList<>();

        String sql = """
         SELECT Id, Description, MinimumDep, DuringTime, SavingRate, SavingRateMinimum, PendingStatus
         FROM BankingSystem.dbo.DepService
         WHERE PendingStatus = ?""";
        
        if ("DuringTime".equalsIgnoreCase(sortBy)) {
            sql += " ORDER BY [DuringTime] " + order;        
        } else {
            sql += " ORDER BY [MinimumDep] " + order;
        }

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, status);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    DepService depService = new DepService(
                            rs.getInt("Id"),
                            rs.getString("Description"),
                            rs.getBigDecimal("MinimumDep"),
                            rs.getInt("DuringTime"),
                            rs.getDouble("SavingRate"),
                            rs.getDouble("SavingRateMinimum"),
                            rs.getString("PendingStatus")
                    );
                    list.add(depService);
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return list;
    }

    public boolean deleteDep(int id) {
        String sql = "DELETE FROM DepService WHERE Id=?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            return st.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return false;
    }

    public DepService getDepServiceById(int id) {
        String sql = """
                     SELECT * 
                     FROM BankingSystem.dbo.DepService
                     WHERE Id = ?""";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    return new DepService(
                            rs.getInt("Id"),
                            rs.getString("Description"),
                            rs.getBigDecimal("MinimumDep"),
                            rs.getInt("DuringTime"),
                            rs.getDouble("SavingRate"),
                            rs.getDouble("SavingRateMinimum"),
                            rs.getString("PendingStatus")
                    );
                }
            }
        } catch (Exception e) {
        }
        return null;
    }

    public void createDepService(String description, BigDecimal minimumDep, int duringTime, double savingRate, double savingRateMinimum) {
        String sql = """
                     INSERT INTO BankingSystem.dbo.DepService
                     (Description, MinimumDep, DuringTime, SavingRate, SavingRateMinimum)
                     VALUES(?, ?, ?, ?, ?); """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, description);
            st.setBigDecimal(2, minimumDep);
            st.setInt(3, duringTime);
            st.setDouble(4, savingRate);
            st.setDouble(5, savingRateMinimum);
            int rowsInserted = st.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("Inserted successfully!");
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
    }
}
