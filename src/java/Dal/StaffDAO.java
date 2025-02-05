/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import context.DBContext;
import model.Staff;
import com.sun.jdi.connect.spi.Connection;
import model.Role;
import validation.AccountValidation;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 *
 * @author emkob
 */
public class StaffDAO extends DBContext {

    private AccountValidation av = new AccountValidation();

    

    public static Staff mapResultSetToStaff(ResultSet rs) throws SQLException {
        LocalDate dob = rs.getDate("Dob") != null ? rs.getDate("Dob").toLocalDate() : null;

        LocalDateTime lockTime = rs.getTimestamp("lock_time") != null ? rs.getTimestamp("lock_time").toLocalDateTime() : null;

        return new Staff(
                rs.getInt("Id"),
                rs.getString("Username"),
                rs.getString("Password"),
                rs.getString("Email"),
                rs.getString("FirstName"),
                rs.getString("LastName"),
                rs.getString("Phone"),
                rs.getString("Address"),
                rs.getBigDecimal("Salary"),
                new Role(rs.getInt("RoleId")), // Lấy RoleId từ database và tạo đối tượng Role
                rs.getString("Gender"), // Lấy Gender từ database
                dob, // Sử dụng LocalDate cho Dob
                rs.getInt("failed_attempts"), // Lấy failed_attempts từ database
                lockTime, // Sử dụng LocalDateTime cho lockTime,
                rs.getString("Image")
        );
    }

    public boolean updatePasswordByEmail(String email, String password) {
        String sql = "UPDATE [dbo].[Staff] SET Password = ? WHERE Email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String hashedPassword = av.hashPassword(password);  // Mã hóa mật khẩu
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
    String sql = "SELECT failed_attempts FROM Staff WHERE Email = ?";
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
    String sql = "UPDATE Staff SET lock_time = NULL WHERE Email = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, email);
        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
public Staff getStaffByEmail(String email) {
    String sql = "SELECT * FROM [dbo].[Staff] WHERE Email = ?";
    try (PreparedStatement p = connection.prepareStatement(sql)) {
        p.setString(1, email);
        try (ResultSet rs = p.executeQuery()) {
            if (rs.next()) {
                return mapResultSetToStaff(rs);  // Giả sử bạn có phương thức mapResultSetToStaff
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}
public void increaseFailedLogin(String email) {
    String sql = "UPDATE Staff SET failed_attempts = failed_attempts + 1 WHERE Email = ?";
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
    String sql = "UPDATE Staff SET failed_attempts = 0, lock_time = NULL WHERE Email = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, email);
        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
public void lockAccount(String email) {
    String sql = "UPDATE Staff SET lock_time = ? WHERE Email = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
        ps.setString(2, email);
        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
public Staff login(String email, String password) {
    if (isAccountLocked(email)) {
        return null; 
    }

    String sql = "SELECT * FROM [dbo].[Staff] WHERE Email = ?";
    try (PreparedStatement p = connection.prepareStatement(sql)) {
        p.setString(1, email);
        try (ResultSet rs = p.executeQuery()) {
            if (rs.next()) {
                if (av.checkPassword(password, rs.getString("Password"))) {
                    resetFailedLogin(email);
                    return mapResultSetToStaff(rs); // Giả sử bạn có phương thức mapResultSetToStaff
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
    String sql = "SELECT failed_attempts, lock_time FROM Staff WHERE Email = ?";
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
 public void updateStaff(Staff staff) {
    String sql = "UPDATE Staff SET email = ?, phone = ?, address = ? WHERE id = ?";
    try (PreparedStatement p = connection.prepareStatement(sql)) {

        p.setString(1, staff.getEmail());
        p.setString(2, staff.getPhone());
        p.setString(3, staff.getAddress());
        p.setInt(4, staff.getId());

        p.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
public void updateStaffImage(int staffId, String imagePath) {
        String sql = "UPDATE Staff SET Image = ? WHERE Id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, imagePath);
            ps.setInt(2, staffId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
 public void updatePassword(String newPassword, String email) {
    String sql = "UPDATE Staff SET Password = ? WHERE Email = ?";
    try (PreparedStatement p = connection.prepareStatement(sql)) {
        p.setString(1, newPassword);
        p.setString(2, email);
        p.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
 public Staff getStaffById(int id) {
    String sql = "SELECT * FROM [dbo].[Staff] WHERE Id = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, id);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return mapResultSetToStaff(rs); // Giả sử bạn có phương thức mapResultSetToStaff
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}
 
}

