/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author LAPTOP
 */
import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.LoanServiceUsed;
import java.util.ArrayList;
import java.util.List;
import model.Customer;
import model.LoanService;

public class LoanServiceUsedDAO extends DBContext {

    private LoanServiceDAO loanServiceDAO = new LoanServiceDAO();
    private CustomerDAO customerDAO = new CustomerDAO();

    public List<LoanServiceUsed> getLoanServiceUsedByStatus(int offset, int recordsPerPage, String status) {
        List<LoanServiceUsed> loanList = new ArrayList<>();
        String sql = """
                 SELECT Id, LoanId, CusId, Amount, StartDate, EndDate, DateExpiredCount, DebtRepayAmount, LoanStatus, IncomeVertification 
                 FROM [BankingSystem].[dbo].[LoanServiceUsed] 
                 """;

        if (status != null && !status.isEmpty()) {
            sql += " WHERE [LoanStatus] = '" + status + "'";
        }

        String pagination = """
                ORDER BY Id
                OFFSET ? ROWS
                FETCH NEXT ? ROWS ONLY;
                """;

        sql += pagination;

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, offset);
            st.setInt(2, recordsPerPage);

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    int loanServiceId = rs.getInt("LoanId");
                    LoanService loanService = loanServiceDAO.getLoanServiceById(loanServiceId);
                    int customerId = rs.getInt("CusId");
                    Customer customer = customerDAO.getCustomerById(customerId);
                    LoanServiceUsed loan = new LoanServiceUsed(
                            rs.getInt("Id"),
                            loanService,
                            customer,
                            rs.getBigDecimal("Amount"),
                            rs.getTimestamp("StartDate"),
                            rs.getTimestamp("EndDate"),
                            rs.getInt("DateExpiredCount"),
                            rs.getBigDecimal("DebtRepayAmount"),
                            rs.getString("IncomeVertification"),
                            rs.getString("LoanStatus")
                    );
                    loanList.add(loan);
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return loanList;
    }

    public int totalLoanServiceUsed(String status) {
        String sql = "SELECT COUNT(*) FROM [dbo].[LoanServiceUsed]";

        boolean hasstatus = (status != null && !status.trim().isEmpty());

        if (hasstatus) {
            sql += " WHERE [LoanStatus] = '" + status + "'";
        }

        int count = 0;

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            if (hasstatus) {
                st.setString(1, status);
            }

            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (SQLException ex) {
            System.out.println("SQL Error: " + ex.getMessage());
        }

        return count;
    }

    public boolean updateLoanServiceUsedStatus(int id, String newStatus) {
        String sql = """
                 UPDATE [BankingSystem].[dbo].[LoanServiceUsed] 
                 SET LoanStatus = ? 
                 WHERE Id = ?
                 """;

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, newStatus);
            st.setInt(2, id);

            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return false;
    }

    public void updateLoanServiceUsedStatusAndDate(int loanId, String status) {
        String sql = "UPDATE LoanServiceUsed SET LoanStatus = ?, StartDate = GETDATE() WHERE Id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, status);
            st.setInt(2, loanId);
            st.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

}
