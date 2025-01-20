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
    String sql = "SELECT * FROM [dbo].[Customer] WHERE Email = ? AND Password = ?";
    try (PreparedStatement p = connection.prepareStatement(sql)) {
        p.setString(1, email);
        p.setString(2, password);
        try (ResultSet rs = p.executeQuery()) {
            if (rs.next()) {
                return new Customer(
                    rs.getInt("Id"),
                    rs.getString("Username"),    // Cập nhật từ "email" sang "Username"
                    rs.getString("Password"),    // Cập nhật từ "password" thành "Password"
                    rs.getString("Email"),       // Cập nhật từ "email" thành "Email"
                    rs.getString("FirstName"),   // Cập nhật từ "firstName" thành "FirstName"
                    rs.getString("LastName"),    // Cập nhật từ "lastName" thành "LastName"
                    rs.getString("Phone"),       // Cập nhật từ "phone" thành "Phone"
                    rs.getString("Address"),     // Cập nhật từ "address" thành "Address"
                    rs.getBigDecimal("Wallet")   // Cập nhật từ "wallet" với kiểu BigDecimal
                );
            }
        }
    } catch (SQLException e) {
        e.printStackTrace(); 
    }
    return null;
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
    String sql = "SELECT * FROM [dbo].[Customer]";
    try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
        while (rs.next()) {
            Customer customer = new Customer(
                    rs.getInt("Id"),
                    rs.getString("Username"),  // Cập nhật tên trường thành "Username"
                    rs.getString("Password"),  // Cập nhật tên trường thành "Password"
                    rs.getString("Email"),     // Cập nhật tên trường thành "Email"
                    rs.getString("FirstName"), // Cập nhật tên trường thành "FirstName"
                    rs.getString("LastName"),  // Cập nhật tên trường thành "LastName"
                    rs.getString("Phone"),     // Cập nhật tên trường thành "Phone"
                    rs.getString("Address"),   // Cập nhật tên trường thành "Address"
                    rs.getBigDecimal("Wallet") // Cập nhật để lấy giá trị "Wallet" kiểu BigDecimal
            );
            customers.add(customer);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return customers;
}

public Customer getCustomerById(int Id) {
    String sql = "SELECT * FROM [dbo].[Customer] WHERE Id = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, Id);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return new Customer(
                        rs.getInt("Id"),
                        rs.getString("Username"),  // Cập nhật tên trường thành "Username"
                        rs.getString("Password"),  // Cập nhật tên trường thành "Password"
                        rs.getString("Email"),     // Cập nhật tên trường thành "Email"
                        rs.getString("FirstName"), // Cập nhật tên trường thành "FirstName"
                        rs.getString("LastName"),  // Cập nhật tên trường thành "LastName"
                        rs.getString("Phone"),     // Cập nhật tên trường thành "Phone"
                        rs.getString("Address"),   // Cập nhật tên trường thành "Address"
                        rs.getBigDecimal("Wallet") // Cập nhật để lấy giá trị "Wallet" kiểu BigDecimal
                );
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}

public boolean updatePasswordByEmail(String email, String password) {
    String sql = "UPDATE Customer SET Password = ? WHERE Email = ?"; // Cập nhật tên trường thành "Password"
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
    String sql = "SELECT * FROM Customer WHERE Email = ?"; // Cập nhật tên trường thành "Email"
    try (PreparedStatement p = connection.prepareStatement(sql)) {
        p.setString(1, email);
        try (ResultSet rs = p.executeQuery()) {
            if (rs.next()) {
                return new Customer(
                        rs.getInt("Id"),
                        rs.getString("Username"),  // Cập nhật tên trường thành "Username"
                        rs.getString("Password"),  // Cập nhật tên trường thành "Password"
                        rs.getString("Email"),     // Cập nhật tên trường thành "Email"
                        rs.getString("FirstName"), // Cập nhật tên trường thành "FirstName"
                        rs.getString("LastName"),  // Cập nhật tên trường thành "LastName"
                        rs.getString("Phone"),     // Cập nhật tên trường thành "Phone"
                        rs.getString("Address"),   // Cập nhật tên trường thành "Address"
                        rs.getBigDecimal("Wallet") // Cập nhật để lấy giá trị "Wallet" kiểu BigDecimal
                );
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}
}
