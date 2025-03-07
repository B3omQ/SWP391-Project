/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.LoanService;
import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author LAPTOP
 */
public class LoanServiceDAO extends DBContext {
    public LoanService getLoanServiceById(int id) {
        String sql = "SELECT * FROM LoanService WHERE Id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new LoanService(
                            rs.getInt("Id"),
                            rs.getString("LoanServiceName"),
                            rs.getString("Description"),
                            rs.getInt("DuringTime"),
                            rs.getFloat("OnTermRate"),
                            rs.getFloat("PenaltyRate"),
                            rs.getBigDecimal("MinimumLoan"),
                            rs.getBigDecimal("MaximumLoan"),
                            rs.getString("PendingStatus")
                    );
                }
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving LoanService: " + e.getMessage());
        }
        return null;
    }
}

