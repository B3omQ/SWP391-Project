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
import model.LoanService;

/**
 *
 * @author JIGGER
 */
public class LoanServiceDAO extends DBContext {

    public LoanServiceDAO() {
    }

    public List<LoanService> getAllLoanServiceByStatus(String status, String sortBy, String order) {
        List<LoanService> list = new ArrayList<>();

        String sql = """
         SELECT Id, LoanServiceName, Description, DuringTime, OnTermRate, PenaltyRate, MinimumLoan, MaximumLoan, PendingStatus
         FROM BankingSystem.dbo.LoanService
         WHERE PendingStatus = ?""";

        if ("DuringTime".equalsIgnoreCase(sortBy)) {
            sql += " ORDER BY [DuringTime] " + order;
        } else if ("MinimumLoan".equalsIgnoreCase(sortBy)) {
            sql += " ORDER BY [MinimumLoan] " + order;
        } else {
            sql += " ORDER BY [MaximumLoan] " + order;
        }

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, status);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    LoanService loanService = new LoanService(
                            rs.getInt("Id"),
                            rs.getString("LoanServiceName"),
                            rs.getString("Description"),
                            rs.getInt("DuringTime"),
                            rs.getDouble("OnTermRate"),
                            rs.getDouble("PenaltyRate"),
                            rs.getBigDecimal("MinimumLoan"),
                            rs.getBigDecimal("MaximumLoan"),
                            rs.getString("PendingStatus")
                    );
                    list.add(loanService);
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return list;
    }

    public LoanService getDepServiceById(int id) {
        String sql = """
                     SELECT * 
                     FROM BankingSystem.dbo.LoanService
                     WHERE Id = ?""";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    return new LoanService(
                            rs.getInt("Id"),
                            rs.getString("LoanServiceName"),
                            rs.getString("Description"),
                            rs.getInt("DuringTime"),
                            rs.getDouble("OnTermRate"),
                            rs.getDouble("PenaltyRate"),
                            rs.getBigDecimal("MinimumLoan"),
                            rs.getBigDecimal("MaximumLoan"),
                            rs.getString("PendingStatus")
                    );
                }
            }
        } catch (Exception e) {
        }
        return null;
    }

    public static void main(String[] args) {
        LoanServiceDAO ldao = new LoanServiceDAO();
        List<LoanService> list = ldao.getAllLoanServiceByStatus("Pending", "MaximumLoan", "DESC");
        for (LoanService o : list) {
            System.out.println(o);
        }
    }

    public boolean deleteLoan(int id) {
        String sql = "DELETE FROM LoanService WHERE Id=?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            return st.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return false;
    }

    public void createLoanService(String loanServiceName,
            String description,
            double onTermRate,
            double penaltyRate,
            int duringTime,
            BigDecimal minimumLoan,
            BigDecimal maximumLoan) {

        String sql = """
                     INSERT INTO BankingSystem.dbo.LoanService
                     (LoanServiceName, Description, DuringTime, OnTermRate, PenaltyRate, MinimumLoan, MaximumLoan)
                     VALUES(?, ?, ?, ?, ?, ?, ?);""";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, loanServiceName);
            st.setString(2, description);
            st.setInt(3, duringTime);
            st.setDouble(4, onTermRate);
            st.setDouble(5, penaltyRate);
            st.setBigDecimal(6, minimumLoan);
            st.setBigDecimal(7, maximumLoan);
            int rowsInserted = st.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("Inserted successfully!");
            }
        } catch (Exception e) {
        }
    }

}
