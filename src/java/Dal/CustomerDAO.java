/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dal;

import Model.Customer;
import Model.Role;
import Validation.AccountValidation;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author emkob
 */
public class CustomerDAO extends DBContext {

    private AccountValidation av = new AccountValidation();

  public Customer Login(String email, String password) {
    String sql = "SELECT * FROM [dbo].[Customer] c JOIN [dbo].[Role] r ON c.role_id = r.role_id WHERE c.Email = ? AND c.Password = ?";
    try (PreparedStatement p = connection.prepareStatement(sql)) {
        p.setString(1, email);
        p.setString(2, password); // Đảm bảo password là mật khẩu đã mã hóa
        try (ResultSet rs = p.executeQuery()) {
            if (rs.next()) {
                Role role = new Role(rs.getInt("role_id"), rs.getString("role_name"));
                return new Customer(
                    rs.getInt("id"),
                    rs.getString("email"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("firstName"),
                    rs.getString("lastName"),
                    rs.getString("gender"),
                    rs.getString("phone"),
                    rs.getString("address"),
                    role
                );
            }
        }
    } catch (SQLException e) {
        e.printStackTrace(); 
    }
    return null;
}
    public void register(Customer customer) {
        String sql = "INSERT INTO [dbo].[Customer] (Email, Username, Password, FirstName, LastName, Gender, Phone, Address, Role_ID) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setString(1, customer.getEmail());
            p.setString(2, customer.getUsername());
            p.setString(3, customer.getPassword());
            p.setString(4, customer.getFirstName());
            p.setString(5, customer.getLastName());
            p.setString(6, customer.getGender());
            p.setString(7, customer.getPhone());
            p.setString(8, customer.getAddress());
            p.setInt(9, customer.getRole().getRoleId());
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

    public void updatePassword(String email, String newPassword) {
        String sql = "UPDATE [dbo].[Customer] SET Password = ? WHERE Email = ?";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setString(1, newPassword);
            p.setString(2, email);
            p.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[Customer] c JOIN [dbo].[Role] r ON c.role_id = r.role_id";
        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Role role = new Role(rs.getInt("role_id"), rs.getString("role_name"));
                Customer customer = new Customer(
                        rs.getInt("id"),
                        rs.getString("email"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getString("gender"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        role
                );
                customers.add(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    public Customer getCustomerById(int id) {
        String sql = "SELECT * FROM [dbo].[Customer] c JOIN [dbo].[Role] r ON c.role_id = r.role_id WHERE c.id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Role role = new Role(rs.getInt("role_id"), rs.getString("role_name"));
                    return new Customer(
                            rs.getInt("id"),
                            rs.getString("email"),
                            rs.getString("username"),
                            rs.getString("password"),
                            rs.getString("firstName"),
                            rs.getString("lastName"),
                            rs.getString("gender"),
                            rs.getString("phone"),
                            rs.getString("address"),
                            role
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updatePasswordByEmail(String email, String password) {
        String sql = "UPDATE Customer SET password = ? WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, password);
            ps.setString(2, email);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Customer getCustomerByEmail(String email) {
        String sql = "SELECT * FROM Customer c JOIN Role r ON c.role_id = r.role_id WHERE c.email = ?";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setString(1, email);
            try (ResultSet rs = p.executeQuery()) {
                if (rs.next()) {
                    Role role = new Role(rs.getInt("role_id"), rs.getString("role_name"));
                    return new Customer(
                            rs.getInt("id"),
                            rs.getString("email"),
                            rs.getString("username"),
                            rs.getString("password"),
                            rs.getString("firstName"),
                            rs.getString("lastName"),
                            rs.getString("gender"),
                            rs.getString("phone"),
                            rs.getString("address"),
                            role
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
