/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import context.DBContext;
import model.Staff;
import com.sun.jdi.connect.spi.Connection;
import java.sql.Date;
import model.Role;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import util.AccountValidation;

/**
 *
 * @author JIGGER
 */
public class StaffDAO extends DBContext {

    private AccountValidation av = new AccountValidation();

    public static Staff mapResultSetToStaff(ResultSet rs) throws SQLException {
        LocalDate dob = rs.getDate("Dob") != null ? rs.getDate("Dob").toLocalDate() : null;
        LocalDateTime lockTime = rs.getTimestamp("LockTime") != null ? rs.getTimestamp("LockTime").toLocalDateTime() : null;

        return new Staff(
                rs.getInt("Id"),
                rs.getString("Username"),
                rs.getString("Password"),
                rs.getString("Image"),
                rs.getString("Email"),
                rs.getString("FirstName"),
                rs.getString("LastName"),
                rs.getString("Gender"),
                dob, // Chuyển thành LocalDate
                rs.getString("Phone"),
                rs.getString("Address"),
                rs.getBigDecimal("Salary"),
                rs.getInt("failAttempts"),
                lockTime,
                new Role(rs.getInt("RoleId")) // Truyền đối tượng Role
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
        String sql = "SELECT failAttempts FROM Staff WHERE Email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("failAttempts");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void unlockAccount(String email) {
        String sql = "UPDATE Staff SET LockTime = NULL WHERE Email = ?";
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
        String sql = "UPDATE Staff SET failAttempts = failAttempts + 1 WHERE Email = ?";
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
        String sql = "UPDATE Staff SET failAttempts = 0, LockTime = NULL WHERE Email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void lockAccount(String email) {
        String sql = "UPDATE Staff SET LockTime = ? WHERE Email = ?";
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
        String sql = "SELECT failAttempts, LockTime FROM Staff WHERE Email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int failedAttempts = rs.getInt("failAttempts");
                    Timestamp lockTime = rs.getTimestamp("LockTime");

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
                    return mapResultSetToStaff(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public boolean emailExists(String email) {
    String sql = "SELECT 1 FROM [dbo].[Staff] WHERE Email = ?";
    
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
    public boolean phoneExists(String phone) {
    String sql = "SELECT 1 FROM [dbo].[Staff] WHERE Phone = ?";
    
    try (PreparedStatement p = connection.prepareStatement(sql)) {
        p.setString(1, phone);
        try (ResultSet rs = p.executeQuery()) {
            return rs.next(); 
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false; 
}

    
    public static Staff mapResultSetToStaff1(ResultSet rs) throws SQLException {
        LocalDate dob = rs.getDate("Dob") != null ? rs.getDate("Dob").toLocalDate() : null;
        LocalDateTime lockTime = rs.getTimestamp("LockTime") != null ? rs.getTimestamp("LockTime").toLocalDateTime() : null;

        return new Staff(
                rs.getInt("Id"),
                rs.getString("Username"),
                rs.getString("Password"),
                rs.getString("Image"),
                rs.getString("Email"),
                rs.getString("FirstName"),
                rs.getString("LastName"),
                rs.getString("Gender"),
                dob, // Chuyển thành LocalDate
                rs.getString("Phone"),
                rs.getString("Address"),
                rs.getBigDecimal("Salary"),
                rs.getInt("failAttempts"),
                lockTime,
                new Role(rs.getInt("RoleId"), rs.getString("RoleName")) // Truyền đối tượng Role
        );
    }
    
    public int getRoleIdByName(String roleName) {
        String sql = "SELECT Id FROM Role WHERE Name = ?";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setString(1, roleName);
            try (ResultSet rs = p.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("Id"); // Return the Role ID
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Return -1 if not found
    }
    
    public void updateStaffInfo(Staff x, int id) {
        String sql = "UPDATE Staff SET \n"
                + "	Username = ?,\n"
                + "	Email = ?,\n"
                + "	FirstName = ?,\n"
                + "	LastName = ?,\n"
                + "	Gender = ?,\n"
                + "	Dob = ?,\n"
                + "	Phone = ?,\n"
                + "	Address = ?,\n"
                + "	Salary = ?,\n"
                + "	RoleId = ?\n"
                + "WHERE Id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, x.getUsername());
            ps.setString(2, x.getEmail());
            ps.setString(3, x.getFirstname());
            ps.setString(4, x.getLastname());
            ps.setString(5, x.getGender());
            ps.setDate(6, Date.valueOf(x.getDob()));
            ps.setString(7, x.getPhone());
            ps.setString(8, x.getAddress());
            ps.setBigDecimal(9, x.getSalary());
            ps.setInt(10, x.getRoleId().getId());
            ps.setInt(11, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public int getNumberOfStaff() {
        int count = 0;
        String sql = "SELECT COUNT(Id) FROM Staff";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {

        }
        return count;
    }
    
    public List<Staff> getAllStaffWithPagination(int offset, int recordsPerPage) {
        List<Staff> staffs = new ArrayList<>();
        String sql = "SELECT s.*, r.Name as RoleName from Staff s join Role r on s.RoleId = r.Id \n"
                + "ORDER BY s.Id \n"
                + "OFFSET ? ROWS \n"
                + "FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, offset);
            ps.setInt(2, recordsPerPage);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {               
                Staff staff = mapResultSetToStaff1(rs);
                staffs.add(staff); // Add the staff object to the list
            }
        } catch (SQLException e) {

        }
        return staffs;
    }
    
    public List<Role> getAllRoles() {
        List<Role> roles = new ArrayList<>();
        String sql = "SELECT * FROM Role";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                roles.add(new Role(rs.getInt("Id"), rs.getString("Name")));
            }
        } catch (SQLException e) {

        }
        return roles;
    }
    
    public static void main(String[] args) {
        StaffDAO s = new StaffDAO();
        System.out.println(s.getNumberOfStaff());
        for(Staff x : s.getAllStaffWithPagination(0, 5)) {
            System.out.println(x.toString());
        }
        for(Role r : s.getAllRoles()) {
            System.out.println(r.toString());
        }
    }
}
