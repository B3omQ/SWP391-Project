package Dal;

import Model.Customer;
import Validation.AccountValidation;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

public class CustomerDAO extends DBContext {

    private AccountValidation av = new AccountValidation();

     // Xử lý đăng nhập
    public Customer login(String email, String password) {
        if (isAccountLocked(email)) {
            return null; // Tài khoản đang bị khóa
        }

        String sql = "SELECT * FROM [dbo].[Customer] WHERE Email = ?";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setString(1, email);
            try (ResultSet rs = p.executeQuery()) {
                if (rs.next()) {
                    if (rs.getString("Password").equals(password)) {
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
                        if (elapsedTime < 10 * 60 * 1000) { // Chưa qua 10 phút
                            return true;
                        } else {
                            unlockAccount(email);
                        }
                    }

                    // Nếu đã sai 6 lần mà chưa bị khóa, khóa ngay
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

    public boolean checkCustomerExists(String email) {
        String sql = "SELECT * FROM [dbo].[Customer] WHERE Email = ?";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setString(1, email);
            try (ResultSet rs = p.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
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

        // Kiểm tra lại số lần nhập sai
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
    public boolean updatePasswordById(int customerId, String newPassword) {
        String sql = "UPDATE [dbo].[Customer] SET Password = ? WHERE Id = ?";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            String hashedPassword = av.hashPassword(newPassword);
            p.setString(1, hashedPassword);
            p.setInt(2, customerId);
            int rowsAffected = p.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
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

    private Customer mapResultSetToCustomer(ResultSet rs) throws SQLException {
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
            rs.getTimestamp("lock_time") != null ? rs.getTimestamp("lock_time").toLocalDateTime() : null
        );
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

    // Map dữ liệu

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
