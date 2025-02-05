/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Customer;
import validation.AccountValidation;
import context.DBContext;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

/**
 *
 * @author emkob
 */
public class CustomerDAO extends DBContext {

    private AccountValidation av = new AccountValidation();

          public static Customer mapResultSetToCustomer(ResultSet rs) throws SQLException {
        return new Customer(
            rs.getInt("Id"),
            rs.getString("Username"),
            rs.getString("Password"),
            rs.getString("Email"),
            rs.getString("FirstName"),
            rs.getString("LastName"),
            rs.getString("Phone"),
            rs.getString("Address"),
            rs.getBigDecimal("Wallet"),
            rs.getInt("failed_attempts"),
            rs.getTimestamp("lock_time") != null ? rs.getTimestamp("lock_time").toLocalDateTime() : null,
            rs.getString("Gender"),
            rs.getDate("Dob") != null ? rs.getDate("Dob").toLocalDate() : null,
                 rs.getString("Image")
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