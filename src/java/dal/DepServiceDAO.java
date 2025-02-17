/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import context.DBContext;
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
                      SELECT Id, Description, MinimumDep, DuringTime, SavingRate, SavingRateMinimum
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
                            rs.getDouble("SavingRateMinimum")
                    );
                    list.add(depService);
                }
            }

        } catch (SQLException e) {
            System.out.println(e);
        }

        return list;
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
                            rs.getDouble("SavingRateMinimum")
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
