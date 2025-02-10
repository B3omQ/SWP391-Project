/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import context.DBContext;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.Customer;
import util.AccountValidation;

/**
 *
 * @author JIGGER
 */
public class CustomerDAO extends DBContext {

    private AccountValidation av = new AccountValidation();

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

    public void updateCustomer(Customer customer) {
        String sql = "UPDATE Customer SET email = ?, phone = ?, address = ? WHERE id = ?";
        try (PreparedStatement p = connection.prepareStatement(sql)) {

            p.setString(1, customer.getEmail());
            p.setString(2, customer.getPhone());
            p.setString(3, customer.getAddress());
            p.setInt(4, customer.getId());

            p.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Customer login(String email, String password) {
        if (isAccountLocked(email)) {
            return null;
        }

        String sql = "SELECT * FROM [dbo].[Customer] WHERE Email = ?";
        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setString(1, email);
            try (ResultSet rs = p.executeQuery()) {
                if (rs.next()) {
                    if (av.checkPassword(password, rs.getString("Password"))) {
                        resetFailedLogin(email);
                        return mapResultSetToCustomer(rs);
                    }
                    increaseFailedLogin(email);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateCustomerImage(int customerId, String imagePath) {
        String sql = "UPDATE Customer SET Image = ? WHERE Id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, imagePath);
            ps.setInt(2, customerId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean isAccountLocked(String email) {
        String sql = "SELECT failAttempts, LockTime FROM Customer WHERE Email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int failedAttempts = rs.getInt("failAttempts");
                    Timestamp lockTime = rs.getTimestamp("LockTime");

                    if (lockTime != null) {
                        long elapsedTime = System.currentTimeMillis() - lockTime.getTime();
                        if (elapsedTime < 10 * 60 * 1000) {
                            return true;
                        } else {
                            unlockAccount(email);
                        }
                    }

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

    public void increaseFailedLogin(String email) {
        String sql = "UPDATE Customer SET failAttempts = failAttempts + 1 WHERE Email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (getFailedAttempts(email) >= 6) {
            lockAccount(email);
        }
    }

    public void resetFailedLogin(String email) {
        String sql = "UPDATE Customer SET failAttempts = 0, LockTime = NULL WHERE Email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void lockAccount(String email) {
        String sql = "UPDATE Customer SET LockTime = ? WHERE Email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean updatePasswordByEmail(String email, String password) {
        String sql = "UPDATE [dbo].[Customer] SET Password = ? WHERE Email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String hashedPassword = av.hashPassword(password);
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
        String sql = "SELECT failAttempts FROM Customer WHERE Email = ?";
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
        String sql = "UPDATE Customer SET LockTime = NULL WHERE Email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getNumberOfCustomer() {
        int count = 0;
        String sql = "SELECT COUNT(Id) FROM Customer";
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

    public List<Customer> getAllCustomersWithPagination(int offset, int recordsPerPage) {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * from Customer \n"
                + "ORDER BY Id \n"
                + "OFFSET ? ROWS \n"
                + "FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, offset);
            ps.setInt(2, recordsPerPage);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customer customer = mapResultSetToCustomer(rs);
                customers.add(customer); // Add the staff object to the list
            }
        } catch (SQLException e) {

        }
        return customers;
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
            ps.setBigDecimal(9, x.getWallet());
            ps.setInt(10, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        CustomerDAO cDao = new CustomerDAO();
        System.out.println(cDao.getNumberOfCustomer());
        for (Customer x : cDao.getAllCustomersWithPagination(5, 5)) {
            System.out.println(x.toString());
        }
        cDao.updateCustomerInfo(cDao.getCustomerById(28), 1);
        System.out.println(cDao.getCustomerById(1).toString());
        System.out.println();
    }
}
