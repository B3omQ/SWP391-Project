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
        String sql = "INSERT INTO [dbo].[Account] ([Full_Name], [Password], [Gender], [Phone_Number], [Address], [Email], [Role_ID]) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
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

    public void addUser(String fullName, String passWord, String gender, String phoneNumber,
            String address, String email, Role role) {
        String sql = "INSERT INTO [dbo].[Account] ([Full_Name], [Password], [Gender], [Phone_Number], [Address], [Email], [Role_ID]) "
                + "VALUES (?, ?, ?, ?, ?, ?, (select role_id from Role where role_name = ?))";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setString(1, fullName);
            p.setString(2, passWord);
            p.setString(3, gender);
            p.setString(4, phoneNumber);
            p.setString(5, address);
            p.setString(6, email);
            p.setString(7, role.getRoleName());
            p.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public Account getAccountById(int id) {
        String sql = "SELECT * FROM Account a JOIN Role r ON a.role_id = r.role_id WHERE id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
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
                return account;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
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

    public boolean updateAccountProfile(int id, String fullName, String phoneNumber, String address) {
        String sql = "UPDATE [dbo].[Account] SET full_name = ?, phone_number = ?, address = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, fullName);
            stmt.setString(2, phoneNumber);
            stmt.setString(3, address);
            stmt.setInt(4, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void editUser(Account acc) {
        String sql = "UPDATE [Account] SET full_name = ?, email = ?, gender = ?, phone_number = ?, "
                + "address = ?, role_id = \n"
                + "(select role_id from Role where role_name = ?) WHERE id = ?";
        try {
            // Thiết lập các tham số cho PreparedStatement
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, acc.getFullName());
            st.setString(2, acc.getEmail());
            st.setString(3, acc.getGender());
            st.setString(4, acc.getPhoneNumber());
            st.setString(5, acc.getAddress());
            st.setInt(7, acc.getId());
            st.setString(6, acc.getRole().getRoleName());

            // Thực hiện cập nhật
            int rowsUpdated = st.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("User updated successfully!");
            } else {
                System.out.println("No user found with the given ID.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Xử lý ngoại lệ       
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

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
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

    public void deleteUser(int id) {
        String sql = "DELETE FROM Account\n"
                + "WHERE id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, id + "");
            ps.executeUpdate();
        } catch (SQLException e) {

        }
    }
    
}
