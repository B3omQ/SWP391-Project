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
import java.util.Date;
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
                            rs.getDate("Dob"),
                            rs.getString("Gender"),
                            rs.getBigDecimal("Wallet")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean createNewAccount(Customer customer) {
        String sql = "INSERT INTO Customer (Username, Password, Email, FirstName, LastName, Gender, Dob, Phone, Address) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            java.sql.Date sqlDob = new java.sql.Date(customer.getDob().getTime());
            p.setString(1, customer.getUsername());
            p.setString(2, customer.getPassword());
            p.setString(3, customer.getEmail());
            p.setString(4, customer.getFirstName());
            p.setString(5, customer.getLastName());
            p.setString(6, customer.getGender());
            p.setDate(7, sqlDob);
            p.setString(8, customer.getPhone());
            p.setString(9, customer.getAddress());
            int rowInserted = p.executeUpdate();
            
            return rowInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error creating new account: " + e.getMessage());
            return false;
        }
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
                            rs.getDate("Dob"),
                            rs.getString("Gender"),
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
                            rs.getDate("Dob"),
                            rs.getString("Gender"),
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
    public List<Customer> getAllCustomers(int offset, int recordsPerPage, String searchKey, String sortOrder) {
        List<Customer> customerList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("""
                SELECT * FROM [PJ].[dbo].[Customer] WHERE 1=1
            """);

        List<Object> parameters = new ArrayList<>();

        // Search bằng email hoặc username
        if (searchKey != null && !searchKey.isEmpty()) {
            sql.append(" AND (Username LIKE ? OR Email LIKE ?)");
            parameters.add("%" + searchKey + "%");
            parameters.add("%" + searchKey + "%");
        }

        // option sorts
        if ("asc".equalsIgnoreCase(sortOrder)) {
            sql.append(" ORDER BY Username ASC ");
        } else if ("desc".equalsIgnoreCase(sortOrder)) {
            sql.append(" ORDER BY Username DESC ");
        } else {
            sql.append(" ORDER BY Id ");
        }

        // Phân trang
        sql.append("""
                OFFSET ? ROWS
                FETCH NEXT ? ROWS ONLY;
            """);

        try (PreparedStatement st = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            for (Object param : parameters) {
                if (param instanceof String) {
                    st.setString(paramIndex++, (String) param);
                }
            }

            // Set pagination parameters
            st.setInt(paramIndex++, offset);
            st.setInt(paramIndex++, recordsPerPage);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Customer customer = new Customer(
                            rs.getInt("Id"),
                            rs.getString("Username"),
                            rs.getString("Password"),
                            rs.getString("Email"),
                            rs.getString("FirstName"),
                            rs.getString("LastName"),
                            rs.getString("Phone"),
                            rs.getString("Address"),
                            rs.getDate("Dob"),
                            rs.getString("Gender"),
                            rs.getBigDecimal("Wallet")
                    );
                customerList.add(customer);
            }
        } catch (SQLException ex) {
            ex.printStackTrace(); // Use proper logging instead
        }

        return customerList;
    }
}
