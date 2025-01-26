package Dal;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
import Model.Staff;
import com.sun.jdi.connect.spi.Connection;
import Model.Role;
import Validation.AccountValidation;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author emkob
 */
public class StaffDAO extends DBContext {

    public Staff getStaffByUsername(String email) {
        String sql = "SELECT s.*, r.Id AS Id, r.Name AS Name FROM [dbo].[Staff] s "
                + "LEFT JOIN [dbo].[Role] r ON s.RoleId = r.Id WHERE s.Email = ?";

        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setString(1, email);
            try (ResultSet rs = p.executeQuery()) {
                if (rs.next()) {
                    Role role = new Role(rs.getInt("Id"), rs.getString("Name"));

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
                            role
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Staff getStaffByEmail(String email) {
        String sql = " SELECT * FROM Staff s LEFT JOIN Role r on s.RoleId = r.Id WHERE s.Email = ?";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setString(1, email);
            try (ResultSet rs = p.executeQuery()) {
                if (rs.next()) {
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
                            // Assuming Role is another class and handled appropriately
                            new Role(rs.getInt("Id"), rs.getString("Name")) // Modify as needed
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if no staff found
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

    public Staff getStaffById(int id) {
        String sql = " SELECT * FROM Staff s LEFT JOIN Role r on s.RoleId = r.Id WHERE s.Id = ?";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setInt(1, id);
            try (ResultSet rs = p.executeQuery()) {
                if (rs.next()) {
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
                            // Assuming Role is another class and handled appropriately
                            new Role(rs.getInt("Id"), rs.getString("Name")) // Modify as needed
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if no staff found
    }

    public boolean addStaff(String username, String password, String email,
            String firstName, String lastName,
            String phone, String address,
            BigDecimal salary, String roleName) {
        StaffDAO s = new StaffDAO();
        int roleId = s.getRoleIdByName(roleName);
        if (roleId == -1) {
            System.out.println("Role not found: " + roleName);
            return false; // Handle case where role is not found
        }

        String sql = "INSERT INTO Staff (Username, Password, Email, FirstName, LastName, Phone, Address, Salary, RoleId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setString(1, username);
            p.setString(2, password);
            p.setString(3, email);
            p.setString(4, firstName);
            p.setString(5, lastName);
            p.setString(6, phone);
            p.setString(7, address);
            p.setBigDecimal(8, salary);
            p.setInt(9, roleId); // Use the retrieved Role ID

            int rowsAffected = p.executeUpdate();
            return rowsAffected > 0; // Return true if a row was added
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Return false if an error occurred
        }
    }

    public List<Staff> getAllStaffs() {
        List<Staff> staffList = new ArrayList<>();
        String sql = "SELECT s.*, r.Name AS RoleName FROM [dbo].[Staff] s LEFT JOIN [dbo].[Role] r ON s.RoleId = r.Id";

        try (PreparedStatement p = connection.prepareStatement(sql)) {
            try (ResultSet rs = p.executeQuery()) {
                while (rs.next()) {
                    Role role = new Role(rs.getInt("RoleId"), rs.getString("RoleName")); // Assuming RoleId is available

                    Staff staff = new Staff(
                            rs.getInt("Id"),
                            rs.getString("Username"),
                            rs.getString("Password"),
                            rs.getString("Email"),
                            rs.getString("FirstName"),
                            rs.getString("LastName"),
                            rs.getString("Phone"),
                            rs.getString("Address"),
                            rs.getBigDecimal("Salary"),
                            role
                    );

                    staffList.add(staff); // Add the staff object to the list
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staffList; // Return the populated list of staff
    }

    public void updateStaffInfo(Staff x, int id) {
        String sql = "UPDATE Staff SET \n"
                + "	Username = ?,\n"
                + "	Email = ?,\n"
                + "	FirstName = ?,\n"
                + "	LastName = ?,\n"
                + "	Phone = ?,\n"
                + "	Address = ?,\n"
                + "	RoleId = ?\n"
                + "WHERE Id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, x.getUsername());
            ps.setString(2, x.getEmail());
            ps.setString(3, x.getFirstName());
            ps.setString(4, x.getLastName());
            ps.setString(5, x.getPhone());
            ps.setString(6, x.getAddress());
            ps.setInt(7, x.getRole().getRoleId());
            ps.setInt(8, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteStaff(int id) {
        String sql = "DELETE FROM Staff\n"
                + "WHERE Id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, id + "");
            ps.executeUpdate();
        } catch (SQLException e) {

        }
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
                Role role = new Role(rs.getInt("RoleId"), rs.getString("RoleName")); // Assuming RoleId is available
                Staff staff = new Staff(
                        rs.getInt("Id"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("Email"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getString("Phone"),
                        rs.getString("Address"),
                        rs.getBigDecimal("Salary"),
                        role
                );
                staffs.add(staff); // Add the staff object to the list
            }
        } catch (SQLException e) {

        }
        return staffs;
    }
    
    public int getNumberOfStaff() {
        int count = 0;
        String sql = "SELECT COUNT(Id) FROM Staff";
        try {
           PreparedStatement ps = connection.prepareStatement(sql);
           ResultSet rs = ps.executeQuery();
           if(rs.next()) {
               count = rs.getInt(1);
           }
        } catch(SQLException e) {
            
        }
        return count;
    }

    public static void main(String[] args) {
        StaffDAO s = new StaffDAO();
        System.out.println(s.getStaffById(1));
        List<Staff> ss = s.getAllStaffWithPagination(4, 3);
        for (Staff x : ss) {
            System.out.println(x.toString());
        }
        System.out.println("Total: " + s.getNumberOfStaff());
    }
}
