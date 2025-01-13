package Dal;

import Model.Account;
import Model.Role;
import Validation.AccountValidation;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AccountDAO extends DBContext {
    private AccountValidation av = new AccountValidation(); 

    public Account Login(String email, String passWord) {
        String sql = "SELECT * FROM [dbo].[Account] a JOIN [dbo].[Role] r ON a.role_id = r.role_id WHERE a.Email = ? AND a.Password = ?";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setString(1, email);  
            p.setString(2, passWord);  
            try (ResultSet rs = p.executeQuery()) {
                if (rs.next()) {

                    Role role = new Role(rs.getInt("role_id"), rs.getString("role_name"));
                    return new Account(
                        rs.getInt("id"), 
                        rs.getString("email"), 
                        rs.getString("password"), 
                        rs.getString("full_name"), 
                        rs.getString("gender"),
                        rs.getString("phone_number"), 
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


    public void Register(String fullName, String passWord, String gender, String phoneNumber, 
                         String address, String email, Role role) {
        String sql = "INSERT INTO [dbo].[Account] ([Full_Name], [Password], [Gender], [Phone_Number], [Address], [Email], [Role_ID]) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setString(1, fullName);
            p.setString(2, passWord);  
            p.setString(3, gender);
            p.setString(4, phoneNumber);
            p.setString(5, address);
            p.setString(6, email);
            p.setInt(7, role.getRoleId()); 
            p.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean checkAccountExisted(String email) {
        String sql = "SELECT * FROM [dbo].[Account] WHERE Email = ?";
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

 public void UpdatePassword(String password, String fullName, String phoneNumber) {
    String sql = "UPDATE [dbo].[Account] SET [Password] = ? WHERE Full_Name = ? AND Phone_Number = ?";
    try (PreparedStatement p = connection.prepareStatement(sql)) {
        p.setString(1, password);
        p.setString(2, fullName);
        p.setString(3, phoneNumber);
        p.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

      public Account getAccountByNameAndPhone(String name, String sdt) {
        String sql = "SELECT * FROM [dbo].[Account] a JOIN [dbo].[Role] r ON a.role_id = r.role_id WHERE a.Full_Name = ? AND a.Phone_Number = ?";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setString(1, name);
            p.setString(2, sdt);
            try (ResultSet rs = p.executeQuery()) {
                if (rs.next()) {
                    
                    Role role = new Role(rs.getInt("role_id"), rs.getString("role_name"));
                    return new Account(
                        rs.getInt("id"), 
                        rs.getString("email"), 
                        rs.getString("password"), 
                        rs.getString("full_name"), 
                        rs.getString("gender"),
                        rs.getString("phone_number"), 
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
     public List<Account> getAllAccounts() {
        List<Account> accounts = new ArrayList<>();
        String sql = "SELECT * FROM Account a JOIN Role r ON a.role_id = r.role_id";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Role role = new Role(rs.getInt("role_id"), rs.getString("role_name"));
                Account account = new Account(
                    rs.getInt("id"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("full_name"),
                    rs.getString("gender"),
                    rs.getString("phone_number"),
                    rs.getString("address"),
                    role
                );
                accounts.add(account);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return accounts;
    }

}
