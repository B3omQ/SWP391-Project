/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Customer;
import model.Role;
import model.Staff;

/**
 *
 * @author JIGGER
 */
public class ManagerDAO extends DBContext {

    public boolean isDuplicatedEmail(String email) {
        String sql = """
                    SELECT 1 FROM [BankingSystem].[dbo].[Customer] 
                    WHERE [Email] = ? 
                 """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ConsultantDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
        public boolean isDuplicatedEmailStaff(String email) {
        String sql = """
                    SELECT 1 FROM [BankingSystem].[dbo].[Staff] 
                    WHERE [Email] = ? 
                 """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ConsultantDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    

    public Role getRole(int roleID) {
        String sql = """
                    SELECT [Id], [Name]
                    FROM [BankingSystem].[dbo].[role]
                    WHERE [Id] = ?
                    """;
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, roleID);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new Role(rs.getInt("Id"), rs.getString("Name"));
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return null;
    }

    public void updateManagerPassword(int id, String newpassword) {
        String sql = """
                 UPDATE BankingSystem.dbo.Staff
                 SET [Password] = ?
                 WHERE Id=?;""";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, newpassword);
            st.setInt(2, id);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ManagerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int countTotalRecords() {
        String sql = """
                        select count(*) from Customer
                        WHERE 1=1
                     """;
        int count = 0;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);

            }
        } catch (SQLException ex) {
            Logger.getLogger(ManagerDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }

        return count;
    }

    public static void main(String[] args) {
        ManagerDAO s = new ManagerDAO();
        String phone = "";
        List<Customer> list = s.getAllCustomer(0, 10, phone);
        for (Customer c : list) {
            System.out.println(c);
        }
    }

    public List<Customer> getAllCustomer(int offset, int recordsPerPage, String phone) {
        List<Customer> customerList = new ArrayList<>();
        String sql = """
                     SELECT Id, [Image], Email, FirstName, LastName, Gender, Dob, Phone, Address
                     FROM BankingSystem.dbo.Customer
                     """;

        if (phone != null && !phone.isEmpty()) {
            sql += " WHERE [Phone] = '" + phone + "'";
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
                    Customer customer = new Customer(
                            rs.getInt("Id"),
                            rs.getString("Image"),
                            rs.getString("Email"),
                            rs.getString("FirstName"),
                            rs.getString("LastName"),
                            rs.getString("Gender"),
                            rs.getDate("Dob").toLocalDate(),
                            rs.getString("Phone"),
                            rs.getString("Address")
                    );
                    customerList.add(customer);
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return customerList;
    }

    public Customer getCustomerById(int id) {
        String sql = "SELECT * FROM Customer WHERE Id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new Customer(
                            rs.getInt("Id"),
                            rs.getString("Image"),
                            rs.getString("Email"),
                            rs.getString("FirstName"),
                            rs.getString("LastName"),
                            rs.getString("Gender"),
                            rs.getDate("Dob").toLocalDate(),
                            rs.getString("Phone"),
                            rs.getString("Address")
                    );
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return null;
    }

    public Staff getStaffById(int id) {
        String sql = "SELECT * FROM Staff WHERE Id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new Staff(
                            rs.getInt("Id"),
                            rs.getString("username"),
                            rs.getString("Password"),
                            rs.getString("Image"),
                            rs.getString("Email"),
                            rs.getString("FirstName"),
                            rs.getString("LastName"),
                            rs.getString("Gender"),
                            rs.getDate("Dob").toLocalDate(),
                            rs.getString("Phone"),
                            rs.getString("Address"),
                            new Role(rs.getInt("RoleId"))
                    );
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return null;
    }

    public void updateInformationCustomer(int id, String img, String email, String firstname, String lastname, String gender, LocalDate dob, String phone, String address) {
        String sql = """
                 UPDATE BankingSystem.dbo.Customer
                 SET [Image]=?, Email=?, FirstName=?, LastName=?, Gender=?, Dob=?, Phone=?, Address=? 
                 WHERE Id=?;""";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, img);
            st.setString(2, email);
            st.setString(3, firstname);
            st.setString(4, lastname);
            st.setString(5, gender);  // Fix: Set gender correctly
            st.setDate(6, java.sql.Date.valueOf(dob));  // Fix: Convert LocalDate to java.sql.Date
            st.setString(7, phone);
            st.setString(8, address);
            st.setInt(9, id);  // Fix: Correct index for id parameter
            st.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(ManagerDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean deleteCustomer(int id) {
        String sql = "DELETE FROM Customer WHERE Id=?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            return st.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return false;
    }

    public void updateInformationStaff(int id, String img, String firstname, String lastname, String gender, LocalDate dob, String phone, String address) {
        String sql = """
                 UPDATE BankingSystem.dbo.Staff
                 SET [Image] = ?, FirstName = ?, LastName = ?, Gender = ?, Dob = ?, Phone = ?, Address = ? 
                 WHERE Id=?;""";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, img);
            st.setString(2, firstname);
            st.setString(3, lastname);
            st.setString(4, gender);  // Fix: Set gender correctly
            st.setDate(5, java.sql.Date.valueOf(dob));  // Fix: Convert LocalDate to java.sql.Date
            st.setString(6, phone);
            st.setString(7, address);
            st.setInt(8, id);  // Fix: Correct index for id parameter
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ManagerDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

}
