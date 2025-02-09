/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Customer;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import model.Customer;
import util.AccountValidation;

/**
 *
 * @author JIGGER
 */
public class CustomerDAO extends DBContext {

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
        rs.getInt("failed_attempts"),
        rs.getTimestamp("lock_time") != null ? rs.getTimestamp("lock_time").toLocalDateTime() : null,
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

    public Customer login(String email, String password) {
    if (isAccountLocked(email)) {
        return null; 
    }

    String sql = "SELECT * FROM [dbo].[Customer] WHERE Email = ?";
    try (PreparedStatement p = connection.prepareStatement(sql)) {
        p.setString(1, email);
        try (ResultSet rs = p.executeQuery()) {
            if (rs.next()) {
                if (av.checkPassword(password, rs.getString("Password"))) {
                    resetFailedLogin(email);
                    return mapResultSetToCustomer(rs);
                }
                increaseFailedLogin(email);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
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
 public boolean isAccountLocked(String email) {
        String sql = "SELECT failed_attempts, lock_time FROM Customer WHERE Email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int failedAttempts = rs.getInt("failed_attempts");
                    Timestamp lockTime = rs.getTimestamp("lock_time");

                    if (lockTime != null) {
                        long elapsedTime = System.currentTimeMillis() - lockTime.getTime();
                        if (elapsedTime < 10 * 60 * 1000) {
                            return true;
                        } else {
                            unlockAccount(email);
                        }
                    }

                    if (failedAttempts >= 6 && lockTime == null) {
                        lockAccount(email);
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void deleteAccount(int id) {
        String sql = """
                     DELETE FROM [dbo].[Customer] 
                     WHERE [Id] = ? 
                     """;
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setInt(1, id);


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
            String dob, String email) {
        String sql = "UPDATE Customer SET Username = ?, FirstName = ?, LastName = ?, Email = ?, "
                + "Address = ?, Gender = ?, Phone = ?, Dob = ? WHERE Id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, firstName);
            stmt.setString(3, lastName);
            stmt.setString(4, email);
            stmt.setString(5, address);
            stmt.setString(6, gender);
            stmt.setString(7, phone);
            stmt.setString(8, dob);
            stmt.setInt(9, id);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public List<Customer> getCustomerList(int offset, int recordsPerPage) {
        List<Customer> customerList = new ArrayList<>();
        String sql = """
                 SELECT Id, Username, [Password], [Image], Email, FirstName, LastName, Gender, Dob, Phone, [Address], failAttempts, LockTime, Wallet
                 FROM [BankingSystem].[dbo].[Customer] 
                 ORDER BY Id
                 OFFSET ? ROWS
                 FETCH NEXT ? ROWS ONLY
                 """;

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            // Set pagination parameters
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
            System.err.println("SQL Error: " + ex.getMessage());
        }

        return customerList;
    }

    public int totalAccount() {
        String sql = """
                 SELECT COUNT(*) 
                 FROM [dbo].[Customer] 
                 WHERE 1=1
                 """;
        int count = 0;

        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
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
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
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

  public void increaseFailedLogin(String email) {
        String sql = "UPDATE Customer SET failed_attempts = failed_attempts + 1 WHERE Email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (getFailedAttempts(email) >= 6) {
            lockAccount(email);
        }
    }

    public void resetFailedLogin(String email) {
        String sql = "UPDATE Customer SET failed_attempts = 0, lock_time = NULL WHERE Email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

  public void lockAccount(String email) {
        String sql = "UPDATE Customer SET lock_time = ? WHERE Email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
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


      public int getFailedAttempts(String email) {
        String sql = "SELECT failed_attempts FROM Customer WHERE Email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("failed_attempts");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
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
}
