/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dal.CustomerDAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.CustomerReview;
import util.DBContext;
import java.sql.ResultSet;
import model.Customer;

/**
 *
 * @author LAPTOP
 */
public class CustomerReviewDAO extends DBContext {

    private CustomerDAO customerDAO = new CustomerDAO();

    public void addReview(int cusId, int rate, String review) {
        String sql = """
                     INSERT INTO CustomerReview (CusId, Rate, Review, CreatedAt) VALUES (?, ?, ?, GETDATE()) 
                     """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, cusId);
            st.setInt(2, rate);
            st.setString(3, review);
            int rowsInserted = st.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("Inserted successfully!");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<CustomerReview> getTop5ReviewsByRate(int rate) throws SQLException {
        List<CustomerReview> reviews = new ArrayList<>();
        String sql = "SELECT TOP 5 Id, CusId, Rate, Review, CreatedAt "
                + "FROM CustomerReview "
                + "WHERE Rate = ? "
                + "ORDER BY CreatedAt DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, rate);
            try (ResultSet resultSet = ps.executeQuery()) {
                while (resultSet.next()) {
                    int customerId = resultSet.getInt("CusId");
                    Customer customer = customerDAO.getCustomerById(customerId);

                    CustomerReview review = new CustomerReview();
                    review.setId(resultSet.getInt("Id"));
                    review.setCustomer(customer);
                    review.setRate(resultSet.getInt("Rate"));
                    review.setReview(resultSet.getString("Review"));
                    review.setCreateAt(resultSet.getTimestamp("CreatedAt"));

                    reviews.add(review);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách đánh giá: " + e.getMessage());
            throw e;
        }

        return reviews;
    }

    public static void main(String[] args) {
        CustomerReviewDAO crdao = new CustomerReviewDAO();
        try {
            List<CustomerReview> xlist = crdao.getTop5ReviewsByRate(5);
            for (CustomerReview o : xlist) {
                System.out.println(o);
            }
        } catch (Exception e) {
        }

    }
    public List<CustomerReview> getAllCustomerReview(int offset, int recordsPerPage, int rate){
        List<CustomerReview> reviewslist = new ArrayList<>();
        String sql = """
                     SELECT Id, CusId, Rate, Review, CreatedAt 
                     FROM CustomerReview 
                     """;
        if(rate != 0){
            sql += "WHERE [rate] = '" + rate + "'";
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
            try(ResultSet rs = st.executeQuery()){
                while(rs.next()){
                    int customerId = rs.getInt("CusId");
                    Customer customer = customerDAO.getCustomerById(customerId);
                    CustomerReview review = new CustomerReview(
                    rs.getInt("Id"),
                    customer,
                    rs.getInt("Rate"),
                    rs.getString("Review"),
                    rs.getTimestamp("CreatedAt")
                    );
                   reviewslist.add(review);
                }
            }
        }catch(SQLException ex){
            System.out.println(ex);
        }
        return reviewslist;
    }
    public int TotalReview(int rate){
        String sql = "SELECT COUNT(*) FROM [dbo].[CustomerReview]";

        boolean hasstatus = (rate != 0);

        if (hasstatus) {
            sql += " WHERE [LoanStatus] = '" + rate + "'";
        }
        int count = 0;
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            if (hasstatus) {
                st.setInt(1, rate);
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
    public boolean deleteReview(int id){
        String sql = """
                     DELETE FROM [dbo].[CustomerReview] WHERE Id = ? 
                     """;
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            return st.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return false;
    }

}
