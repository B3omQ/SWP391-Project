/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Customer;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import model.Customer;
import model.Staff;
import util.AccountValidation;

/**
 *
 * @author JIGGER
 */
public class ConsultantDAO extends DBContext {

    public boolean booleanCreateNewAccount(Customer customer) {
        String sql = "INSERT INTO Customer (Username, Password, Image, Email, FirstName, LastName, Gender, Dob, Phone, Address, failAttempts, LockTime, Wallet) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, customer.getUsername());
            stmt.setString(2, customer.getPassword());
            stmt.setString(3, customer.getImage());
            stmt.setString(4, customer.getEmail());
            stmt.setString(5, customer.getFirstname());
            stmt.setString(6, customer.getLastname());
            stmt.setString(7, customer.getGender());
            stmt.setDate(8, java.sql.Date.valueOf(customer.getDob()));
            stmt.setString(9, customer.getPhone());
            stmt.setString(10, customer.getAddress());
            stmt.setInt(11, customer.getFailAttempt());
            if (customer.getLocktime() != null) {
                stmt.setTimestamp(12, java.sql.Timestamp.valueOf(customer.getLocktime()));
            } else {
                stmt.setNull(12, java.sql.Types.TIMESTAMP);
            }
            stmt.setBigDecimal(13, customer.getWallet());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private AccountValidation av = new AccountValidation();

    public static Customer mapResultSetToCustomer(ResultSet rs) throws SQLException {
        return new Customer(
                rs.getInt("Id"),
                rs.getString("Username"),
                rs.getString("Password"),
                rs.getString("Image"),
                rs.getString("Email"),
                rs.getString("FirstName"),
                rs.getString("LastName"),
                rs.getString("Gender"),
                rs.getDate("Dob") != null ? rs.getDate("Dob").toLocalDate() : null,
                rs.getString("Phone"),
                rs.getString("Address"),
                rs.getInt("failAttempts"),
                rs.getTimestamp("lockTime") != null ? rs.getTimestamp("lockTime").toLocalDateTime() : null,
                rs.getBigDecimal("Wallet")
        );
    }

    public void updateCustomer(Customer customer) {
        String sql = "UPDATE Customer SET email = ?, phone = ?, address = ? WHERE id = ?";
        try (PreparedStatement p = connection.prepareStatement(sql)) {

            p.setString(1, customer.getEmail());
            p.setString(2, customer.getPhone());
            p.setString(3, customer.getAddress());
            p.setInt(4, customer.getId());

            p.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateCustomerImage(int customerId, String imagePath) {
        String sql = "UPDATE Customer SET Image = ? WHERE Id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, imagePath);
            ps.setInt(2, customerId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
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

    public boolean deleteStaff(int id) {
        String sql = "DELETE FROM Staff WHERE Id=?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            return st.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return false;
    }

    public void updatePassword(String newPassword, String email) {
        String sql = "UPDATE Customer SET Password = ? WHERE Email = ?";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setString(1, newPassword);
            p.setString(2, email);
            p.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean updateInformation(int id, String address, String firstName, String lastName,
            String username, String phone, String gender,
            String dob, String email, String image) {
        String sql = "UPDATE Customer SET Username = ?, FirstName = ?, LastName = ?, Email = ?, "
                + "Address = ?, Gender = ?, Phone = ?, Dob = ?, [Image] = ? WHERE Id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, firstName);
            stmt.setString(3, lastName);
            stmt.setString(4, email);
            stmt.setString(5, address);
            stmt.setString(6, gender);
            stmt.setString(7, phone);
            stmt.setDate(8, java.sql.Date.valueOf(dob));
            stmt.setString(9, image);
            stmt.setInt(10, id);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public List<Customer> getAllCustomer(int offset, int recordsPerPage, String phone) {
        List<Customer> customerList = new ArrayList<>();
        String sql = """
                     SELECT Id, Username, [Password], [Image], Email, FirstName, LastName, Gender, Dob, Phone, [Address], failAttempts, LockTime, Wallet
                                      FROM [BankingSystem].[dbo].[Customer] 
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
                            rs.getString("Username"),
                            rs.getString("Password"),
                            rs.getString("Image"),
                            rs.getString("Email"),
                            rs.getString("FirstName"),
                            rs.getString("LastName"),
                            rs.getString("Gender"),
                            rs.getDate("Dob") != null ? rs.getDate("Dob").toLocalDate() : null,
                            rs.getString("Phone"),
                            rs.getString("Address"),
                            rs.getInt("failAttempts"),
                            rs.getTimestamp("LockTime") != null ? rs.getTimestamp("LockTime").toLocalDateTime() : null,
                            rs.getBigDecimal("Wallet")
                    );
                    customerList.add(customer);
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return customerList;
    }

    public int totalAccount(String phone) {
    String sql = "SELECT COUNT(*) FROM [dbo].[Customer]";
    
    boolean hasPhone = (phone != null && !phone.trim().isEmpty());

    if (hasPhone) {
        sql += " WHERE Phone = ?";
    }

    int count = 0;

    try (PreparedStatement st = connection.prepareStatement(sql)) {
        if (hasPhone) {
            st.setString(1, phone);
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
    public boolean isDuplicatedPhoneNumber(String phone) {
        String sql = """
                    SELECT 1 FROM [BankingSystem].[dbo].[Customer] 
                    WHERE [Phone] = ? 
                 """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, phone);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ConsultantDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public Customer getCustomerById(int id) {
        String sql = "SELECT * FROM [dbo].[Customer] WHERE Id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCustomer(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Customer getCustomerByEmail(String email) {
        String sql = "SELECT * FROM [dbo].[Customer] WHERE Email = ?";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setString(1, email);
            try (ResultSet rs = p.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCustomer(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updatePasswordByEmail(String email, String password) {
        String sql = "UPDATE [dbo].[Customer] SET Password = ? WHERE Email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String hashedPassword = av.hashPassword(password);
            ps.setString(1, hashedPassword);
            ps.setString(2, email);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void unlockAccount(String email) {
        String sql = "UPDATE Customer SET lock_time = NULL WHERE Email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateInformationStaff(int id, String img, String username, String firstname, String lastname, String gender, LocalDate dob, String phone, String address) {
        String sql = """
                 UPDATE BankingSystem.dbo.Staff
                 SET Username=?, [Image]=?, FirstName=?, LastName=?, Gender=?, Dob=?, Phone=?, Address=? 
                 WHERE Id=?;""";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(2, img);
            st.setString(3, firstname);
            st.setString(4, lastname);
            st.setString(5, gender);  // Fix: Set gender correctly
            st.setDate(6, java.sql.Date.valueOf(dob));  // Fix: Convert LocalDate to java.sql.Date
            st.setString(7, phone);
            st.setString(8, address);
            st.setInt(9, id);  // Fix: Correct index for id parameter
            st.setString(1, username);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ManagerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean updatePasswordByIdStaff(int id, String password) {
        String sql = "UPDATE [dbo].[Staff] SET Password = ? WHERE Id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String hashedPassword = av.hashPassword(password);
            ps.setString(1, hashedPassword);
            ps.setInt(2, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateEmailStaff(int id, String email) {
        String sql = """
                     UPDATE BankingSystem.dbo.Staff 
                     SET Email = ? 
                     WHERE Id = ? 
                     """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            st.setInt(2, id);
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Staff getStaffById(int id) {
        String sql = "SELECT * FROM Staff WHERE Id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new Staff(
                            rs.getInt("Id"),
                            rs.getString("Username"),
                            rs.getString("Password"),
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
}
