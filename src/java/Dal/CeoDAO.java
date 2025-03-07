/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import model.Customer;
import model.Role;
import model.Staff;
import util.AccountValidation;
import util.DBContext;

/**
 *
 * @author Long
 */
public class CeoDAO extends DBContext {

    private AccountValidation av = new AccountValidation();

    public String getRoleNameById(int roleId) {
        String sql = "SELECT Name FROM Role WHERE Id = ?";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setInt(1, roleId);
            try (ResultSet rs = p.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("Name"); // Return the Role Name
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

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
                rs.getTimestamp("LockTime") != null ? rs.getTimestamp("LockTime").toLocalDateTime() : null,
                rs.getBigDecimal("Wallet")
        );
    }

    public static Staff mapResultSetToStaff1(ResultSet rs) throws SQLException {
        LocalDate dob = rs.getDate("Dob") != null ? rs.getDate("Dob").toLocalDate() : null;
        LocalDateTime lockTime = rs.getTimestamp("LockTime") != null ? rs.getTimestamp("LockTime").toLocalDateTime() : null;
        CeoDAO c = new CeoDAO();
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
                new Role(rs.getInt("RoleId"), c.getRoleNameById(rs.getInt("RoleId"))) // Truyền đối tượng Role
        );
    }

    public List<Customer> searchCustomers(String searchTerm, int page, int pageSize) {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM Customer WHERE 1=1 ";
        List<Object> params = new ArrayList<>();

        // Thêm điều kiện tìm kiếm
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            sql += "AND (FirstName LIKE ? OR LastName LIKE ? OR Email LIKE ? OR Phone LIKE ?) ";
            String likeTerm = "%" + searchTerm + "%";
            Collections.addAll(params, likeTerm, likeTerm, likeTerm, likeTerm);
        }

        // Phân trang cho SQL Server
        sql += "ORDER BY Id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {

            // Thiết lập tham số
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Customer customer = mapResultSetToCustomer(rs);
                customers.add(customer); // Add the staff object to the list
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    public int getTotalCustomerRecords(String searchTerm) {
        int total = 0;
        String sql = "SELECT COUNT(*) AS total FROM Customer WHERE 1=1 ";
        List<Object> params = new ArrayList<>();
        // Thêm điều kiện tìm kiếm
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            sql += "AND (FirstName LIKE ? OR LastName LIKE ? OR Email LIKE ? OR Phone LIKE ?) ";
            String likeTerm = "%" + searchTerm + "%";
            Collections.addAll(params, likeTerm, likeTerm, likeTerm, likeTerm);
        }
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            // Thiết lập tham số
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public List<Staff> searchStaffs(String searchTerm, String role, int page, int pageSize) {
        List<Staff> staffs = new ArrayList<>();
        String sql = "SELECT s.*, r.Name as RoleName from Staff s join Role r on s.RoleId = r.Id WHERE 1=1 ";
        List<Object> params = new ArrayList<>();

        // Thêm điều kiện tìm kiếm
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            sql += "AND (s.FirstName LIKE ? OR s.LastName LIKE ? OR s.Email LIKE ? OR s.Phone LIKE ?) ";
            String likeTerm = "%" + searchTerm + "%";
            Collections.addAll(params, likeTerm, likeTerm, likeTerm, likeTerm);
        }

        // Thêm điều kiện role
        if (role != null && !role.trim().isEmpty()) {
            sql += "AND r.Name = ? ";
            params.add(role);
        }

        // Phân trang cho SQL Server
        sql += "ORDER BY s.Id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {

            // Thiết lập tham số
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Staff staff = mapResultSetToStaff1(rs);
                staffs.add(staff); // Add the staff object to the list
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staffs;
    }

    public int getTotalRecords(String searchTerm, String role) {
        int total = 0;
        String sql = "SELECT COUNT(*) AS total FROM Staff s JOIN Role r ON s.RoleId = r.Id WHERE 1=1 ";
        List<Object> params = new ArrayList<>();
        // Thêm điều kiện tìm kiếm
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            sql += "AND (s.FirstName LIKE ? OR s.LastName LIKE ? OR s.Email LIKE ? OR s.Phone LIKE ?) ";
            String likeTerm = "%" + searchTerm + "%";
            Collections.addAll(params, likeTerm, likeTerm, likeTerm, likeTerm);
        }
        // Thêm điều kiện role
        if (role != null && !role.trim().isEmpty()) {
            sql += "AND r.Name = ? ";
            params.add(role);
        }
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            // Thiết lập tham số
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
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

    public Customer getCustomerByPhone(String phone) {
        String sql = "SELECT * FROM [dbo].[Customer] WHERE Phone = ?";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setString(1, phone);
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

    public void updateCustomerInfo(Customer x, int id) {
        String sql = "UPDATE Customer SET \n"
                + "	Username = ?,\n"
                + "	Email = ?,\n"
                + "	FirstName = ?,\n"
                + "	LastName = ?,\n"
                + "	Gender = ?,\n"
                + "	Dob = ?,\n"
                + "	Phone = ?,\n"
                + "	Address = ?,\n"
                + "	Image = ?,\n"
                + "	Wallet = ? \n"
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
            ps.setString(9, x.getImage());
            ps.setBigDecimal(10, x.getWallet());
            ps.setInt(11, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
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
                + "	RoleId = ?, \n"
                + "	Image = ? \n"
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
            ps.setString(11, x.getImage());
            ps.setInt(12, id);
            ps.executeUpdate();
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
                    return mapResultSetToStaff1(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Staff getStaffByEmail(String email) {
        String sql = "SELECT * FROM [dbo].[Staff] WHERE Email = ?";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setString(1, email);
            try (ResultSet rs = p.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToStaff1(rs);  // Giả sử bạn có phương thức mapResultSetToStaff
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Staff getStaffByUsername(String username) {
        String sql = "SELECT * FROM [dbo].[Staff] WHERE Username = ?";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setString(1, username);
            try (ResultSet rs = p.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToStaff1(rs);  // Giả sử bạn có phương thức mapResultSetToStaff
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Staff getStaffByPhone(String phone) {
        String sql = "SELECT * FROM [dbo].[Staff] WHERE Phone = ?";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setString(1, phone);
            try (ResultSet rs = p.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToStaff1(rs);  // Giả sử bạn có phương thức mapResultSetToStaff
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
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

    public void updatePassword(int staffId, String newHashedPassword) {
        String sql = "UPDATE staff SET password = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, newHashedPassword);
            stmt.setInt(2, staffId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        CeoDAO c = new CeoDAO();
        c.deleteStaff(40);
        for (Staff x : c.searchStaffs("", "", 1, 5)) {
            System.out.println(x.toString());
        }
    }
}
