/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dal;

import context.DBContext;
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
                    rs.getString("Username"),    
                    rs.getString("Password"),    
                    rs.getString("Email"),       
                    rs.getString("FirstName"),   
                    rs.getString("LastName"),    
                    rs.getString("Phone"),       
                    rs.getString("Address"),    
                    rs.getBigDecimal("Wallet")   
                );
            }
        }
    } catch (SQLException e) {
        e.printStackTrace(); 
    }
    return null;
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
public boolean updatePasswordById(int customerId, String newPassword) {
    String sql = "UPDATE [dbo].[Customer] SET Password = ? WHERE Id = ?";
    try (PreparedStatement p = connection.prepareStatement(sql)) {
        AccountValidation accountValidation = new AccountValidation();
        String hashedPassword = accountValidation.hashPassword(newPassword);
        
        p.setString(1, hashedPassword);
        p.setInt(2, customerId);  
        
        int rowsAffected = p.executeUpdate();
        return rowsAffected > 0; 
    } catch (SQLException e) {
        e.printStackTrace();
        return false; 
    }
}



 
public Customer getCustomerById(int Id) {
    String sql = "SELECT * FROM [dbo].[Customer] WHERE Id = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, Id);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return new Customer(
                        rs.getInt("Id"),
                        rs.getString("Username"),  
                        rs.getString("Password"),  
                        rs.getString("Email"),    
                        rs.getString("FirstName"),
                        rs.getString("LastName"),  
                        rs.getString("Phone"),   
                        rs.getString("Address"),   
                        rs.getBigDecimal("Wallet") 
                );
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}

public boolean updatePasswordByEmail(String email, String password) {
    String sql = "UPDATE Customer SET Password = ? WHERE Email = ?"; 
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
    String sql = "SELECT * FROM Customer WHERE Email = ?";
    try (PreparedStatement p = connection.prepareStatement(sql)) {
        p.setString(1, email);
        try (ResultSet rs = p.executeQuery()) {
            if (rs.next()) {
                return new Customer(
                        rs.getInt("Id"),
                        rs.getString("Username"),  
                        rs.getString("Password"), 
                        rs.getString("Email"),     
                        rs.getString("FirstName"), 
                        rs.getString("LastName"),  
                        rs.getString("Phone"),    
                        rs.getString("Address"),   
                        rs.getBigDecimal("Wallet") 
                );
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}
public boolean updateCustomerInfo(Customer customer) {
    String sql = "UPDATE [dbo].[Customer] SET Username = ?, Email = ?, FirstName = ?, LastName = ?, Phone = ?, Address = ? WHERE Id = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, customer.getUsername());
        ps.setString(2, customer.getEmail());
        ps.setString(3, customer.getFirstName());
        ps.setString(4, customer.getLastName());
        ps.setString(5, customer.getPhone());
        ps.setString(6, customer.getAddress());
        ps.setInt(7, customer.getId());

        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

}
