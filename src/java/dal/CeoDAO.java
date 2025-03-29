/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import controller.calculation.InterestCalculator;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import model.Customer;
import model.DepService;
import model.LoanService;
import model.LoanServiceUsed;
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
            sql += "AND (FirstName LIKE ? OR LastName LIKE ? OR Email LIKE ? OR Phone LIKE ? OR FirstName + ' ' + LastName LIKE ?) ";
            String likeTerm = "%" + searchTerm + "%";
            Collections.addAll(params, likeTerm, likeTerm, likeTerm, likeTerm, likeTerm);
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

    public DepService getDepServiceById(int id) {
        String sql = """
                     SELECT * 
                     FROM BankingSystem.dbo.DepService
                     WHERE Id = ?""";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    return new DepService(
                            rs.getInt("Id"),
                            rs.getString("Description"),
                            rs.getString("DepServiceName"),
                            rs.getBigDecimal("MinimumDep"),
                            rs.getInt("DuringTime"),
                            rs.getDouble("SavingRate"),
                            rs.getDouble("SavingRateMinimum"),
                            rs.getString("PendingStatus"),
                            rs.getString("ReasonReject")
                    );
                }
            }
        } catch (Exception e) {
        }
        return null;
    }

    public void updateDepServiceStatusById(int id, String changeStatus, String reasonReject) {
        String sql = """
                     UPDATE BankingSystem.dbo.DepService SET PendingStatus = ?, ReasonReject = ? WHERE Id = ?""";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, changeStatus);
            st.setString(2, reasonReject);
            st.setInt(3, id);
            st.executeUpdate();
        } catch (Exception e) {
        }
    }

    public int getTotalDepositRecords(String status, String search) {
        int total = 0;

        String sql = """
        SELECT COUNT(*) 
        FROM BankingSystem.dbo.DepService 
        WHERE PendingStatus = ?""";
        List<Object> params = new ArrayList<>();
        params.add(status);

        // Thêm điều kiện tìm kiếm
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND (MinimumDep = ? OR DuringTime = ? OR SavingRate = ? OR SavingRateMinimum = ?)";
            Collections.addAll(params, search, search, search, search);
        }

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            // Thiết lập tham số
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return total;
    }

    public List<DepService> getAllDepServiceByStatus(String status, String sortBy, String order, String search, int page, int pageSize) {
        List<DepService> list = new ArrayList<>();

        String sql = """
         SELECT Id, Description, MinimumDep, DuringTime, SavingRate, SavingRateMinimum, PendingStatus, ReasonReject, DepServiceName
         FROM BankingSystem.dbo.DepService
         WHERE PendingStatus = ?""";
        List<Object> params = new ArrayList<>();

        // Thêm điều kiện tìm kiếm
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND (MinimumDep = ? OR DuringTime = ? OR SavingRate = ? OR SavingRateMinimum = ?)";
            String likeTerm = search;
            Collections.addAll(params, likeTerm, likeTerm, likeTerm, likeTerm);
        }

        if ("DuringTime".equalsIgnoreCase(sortBy)) {
            sql += " ORDER BY [DuringTime] " + order;
        } else {
            sql += " ORDER BY [MinimumDep] " + order;
        }
        // Phân trang cho SQL Server
        sql += " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, status);
            // Thiết lập tham số
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 2, params.get(i));
            }
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    DepService depService = new DepService(
                            rs.getInt("Id"),
                            rs.getString("Description"),
                            rs.getString("DepServiceName"),
                            rs.getBigDecimal("MinimumDep"),
                            rs.getInt("DuringTime"),
                            rs.getDouble("SavingRate"),
                            rs.getDouble("SavingRateMinimum"),
                            rs.getString("PendingStatus"),
                            rs.getString("ReasonReject")
                            
                    );
                    list.add(depService);
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return list;
    }

    public void updatLoanServiceStatusById(int id, String changeStatus, String reasonReject) {
        String sql = """
                     UPDATE BankingSystem.dbo.LoanService SET PendingStatus = ?, ReasonReject = ? WHERE Id = ?""";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, changeStatus);
            st.setString(2, reasonReject);
            st.setInt(3, id);
            st.executeUpdate();
        } catch (Exception e) {
        }
    }

    public int getTotalLoanServiceRecords(String status, String search) {
        int total = 0;

        String sql = """
        SELECT COUNT(*) 
        FROM BankingSystem.dbo.LoanService 
        WHERE PendingStatus = ?""";
        List<Object> params = new ArrayList<>();
        params.add(status);

        // Thêm điều kiện tìm kiếm
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND (MinimumLoan = ? OR DuringTime = ? OR OnTermRate = ? OR MaximumLoan = ?)";
            Collections.addAll(params, search, search, search, search);
        }

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            // Thiết lập tham số
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return total;
    }

    public LoanService getLoanServiceById(int id) {
        LoanService loanService = null;
        String sql = "SELECT Id, LoanServiceName, Description, LoanTypeRepay, DuringTime, GracePeriod, "
                + "OnTermRate, AfterTermRate, PenaltyRate, MinimumLoan, MaximumLoan, "
                + "ReasonReject, PendingStatus "
                + "FROM LoanService WHERE Id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    loanService = new LoanService(
                            rs.getInt("Id"),
                            rs.getString("LoanServiceName"),
                            rs.getString("Description"),
                            rs.getInt("DuringTime"),
                            rs.getDouble("OnTermRate"),
                            rs.getDouble("PenaltyRate"),
                            rs.getBigDecimal("MinimumLoan"),
                            rs.getBigDecimal("MaximumLoan"),
                            rs.getString("PendingStatus"),
                            rs.getDouble("AfterTermRate"),
                            rs.getString("ReasonReject"),
                            rs.getString("LoanTypeRepay"),
                            rs.getInt("GracePeriod")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return loanService;
    }

    public List<LoanService> getAllLoanServiceByStatus(String status, String sortBy, String order, String search, int page, int pageSize) {
        List<LoanService> list = new ArrayList<>();

        String sql = """
         SELECT Id, LoanServiceName, Description, DuringTime, OnTermRate, PenaltyRate, MinimumLoan, MaximumLoan, PendingStatus, AfterTermRate, ReasonReject, LoanTypeRepay, GracePeriod
         FROM BankingSystem.dbo.LoanService
         WHERE PendingStatus = ?""";
        List<Object> params = new ArrayList<>();

        // Thêm điều kiện tìm kiếm
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND (MinimumLoan = ? OR DuringTime = ? OR OnTermRate = ? OR MaximumLoan = ?)";
            String likeTerm = search;
            Collections.addAll(params, likeTerm, likeTerm, likeTerm, likeTerm);
        }

        if ("DuringTime".equalsIgnoreCase(sortBy)) {
            sql += " ORDER BY [DuringTime] " + order;
        } else {
            sql += " ORDER BY [MinimumLoan] " + order;
        }
        // Phân trang cho SQL Server
        sql += " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, status);
            // Thiết lập tham số
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 2, params.get(i));
            }
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    LoanService loanService = new LoanService(
                            rs.getInt("Id"),
                            rs.getString("LoanServiceName"),
                            rs.getString("Description"),
                            rs.getInt("DuringTime"),
                            rs.getDouble("OnTermRate"),
                            rs.getDouble("PenaltyRate"),
                            rs.getBigDecimal("MinimumLoan"),
                            rs.getBigDecimal("MaximumLoan"),
                            rs.getString("PendingStatus"),
                            rs.getDouble("AfterTermRate"),
                            rs.getString("ReasonReject"),
                            rs.getString("LoanTypeRepay"),
                            rs.getInt("GracePeriod")
                    );
                    list.add(loanService);
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return list;
    }

    public boolean createLoanServiceUsed(LoanServiceUsed loanServiceUsed) {
        String sql = "INSERT INTO LoanServiceUsed "
                + "(loanId, cusId, amount, startDate, endDate, dateExpiredCount, debtRepayAmount, incomeVertification, loanStatus) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {

            // Assuming LoanService and Customer objects have getId() methods
            stmt.setInt(1, loanServiceUsed.getLoanId().getId());
            stmt.setInt(2, loanServiceUsed.getCusId().getId());
            stmt.setBigDecimal(3, loanServiceUsed.getAmount());
            stmt.setTimestamp(4, loanServiceUsed.getStartDate());
            stmt.setTimestamp(5, loanServiceUsed.getEndDate());
            stmt.setInt(6, loanServiceUsed.getDateExpiredCount());
            stmt.setBigDecimal(7, loanServiceUsed.getDebtRepayAmount());
            stmt.setString(8, loanServiceUsed.getIncomeVertification());
            stmt.setString(9, loanServiceUsed.getLoanStatus());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public List<LoanServiceUsed> getAllLoanServiceUsedByStatus(String status, String sortBy, String order, String search, int page, int pageSize) {
        List<LoanServiceUsed> list = new ArrayList<>();

        String sql = """
            SELECT Id FROM BankingSystem.dbo.LoanServiceUsed WHERE LoanStatus = ?
        """;

        List<Object> params = new ArrayList<>();

        // Thêm điều kiện tìm kiếm nếu cần (sử dụng LIKE cho các trường hợp phù hợp)
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND (CAST(Amount AS NVARCHAR(50)) LIKE ? OR CAST(DateExpiredCount AS NVARCHAR(50)) LIKE ? OR CAST(DebtRepayAmount AS NVARCHAR(50)) LIKE ? OR IncomeVertification LIKE ?)";
            String searchPattern = "%" + search + "%";
            Collections.addAll(params, searchPattern, searchPattern, searchPattern, searchPattern);
        }

        // Sắp xếp theo StartDate hoặc DebtRepayAmount
        if ("StartDate".equalsIgnoreCase(sortBy)) {
            sql += " ORDER BY [StartDate] " + order;
        } else {
            sql += " ORDER BY [DebtRepayAmount] " + order;
        }

        // Phân trang cho SQL Server
        sql += " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            // Thiết lập tham số đầu tiên là status
            st.setString(1, status);

            // Các tham số tiếp theo được thiết lập từ danh sách params
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 2, params.get(i));
            }

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    LoanServiceUsed loanUsed = getLoanServiceUsedById(rs.getInt("Id"));

                    list.add(loanUsed);
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return list;
    }

    public List<LoanServiceUsed> getLoanByCustomerId(int cusId, String loanStatus) {
        List<LoanServiceUsed> loanList = new ArrayList<>();

        String sql = "SELECT Id FROM LoanServiceUsed WHERE CusId = ? AND LoanStatus = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, cusId);
            st.setString(2, loanStatus);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    loanList.add(getLoanServiceUsedById(rs.getInt("Id")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return loanList;
    }

    public LoanServiceUsed getLoanServiceUsedById(int id) {
        LoanServiceUsed lsu = null;
        String sql = "SELECT Id, LoanId, CusId, Amount, StartDate, EndDate, "
                + "DateExpiredCount, DebtRepayAmount, IncomeVertification, LoanStatus "
                + "FROM LoanServiceUsed WHERE Id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Lấy thông tin LoanService từ LoanServiceDAO
                    LoanService loanService = new CeoDAO().getLoanServiceById(rs.getInt("LoanId"));

                    // Lấy thông tin khách hàng
                    Customer customer = getCustomerById(rs.getInt("CusId"));

                    // Tạo đối tượng LoanServiceUsed
                    lsu = new LoanServiceUsed();
                    lsu.setId(rs.getInt("Id"));
                    lsu.setLoanId(loanService);
                    lsu.setCusId(customer);
                    lsu.setAmount(rs.getBigDecimal("Amount"));
                    lsu.setStartDate(rs.getTimestamp("StartDate"));
                    lsu.setEndDate(rs.getTimestamp("EndDate"));
                    lsu.setDateExpiredCount(rs.getInt("DateExpiredCount"));
                    lsu.setDebtRepayAmount(rs.getBigDecimal("DebtRepayAmount"));
                    lsu.setIncomeVertification(rs.getString("IncomeVertification"));
                    lsu.setLoanStatus(rs.getString("LoanStatus"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lsu;
    }

    public boolean customerPayLoan(BigDecimal newDebtAmount, int loanId) {
        String sql = "UPDATE LoanServiceUsed SET DebtRepayAmount = ? WHERE Id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setBigDecimal(1, newDebtAmount);
            st.setInt(2, loanId);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return true;
    }

    public void updateLoanStatus(int loanId, String newStatus) {
        String sql = "UPDATE LoanServiceUsed SET LoanStatus = ? WHERE Id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, loanId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertPayment(int loanId, BigDecimal paymentAmount) {
        String sql = "INSERT INTO LoanPayment (LSUId, PaymentAmount) VALUES (?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, loanId);
            ps.setBigDecimal(2, paymentAmount);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Thêm khách hàng vào danh sách đen
    public void addToBlacklist(int cusId) {
        String sql = "INSERT INTO Blacklist (CusId) VALUES (?)";
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cusId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public boolean isOverdue(int cusId) {
    String sql = """
            SELECT LSU.Id 
            FROM LoanServiceUsed LSU 
            JOIN LoanService LS ON LSU.LoanId = LS.Id 
            WHERE LSU.CusId = ? 
            AND LSU.DebtRepayAmount != 0 
            AND DATEDIFF(MONTH, LSU.EndDate, GETDATE()) > LS.GracePeriod
            """;

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, cusId);
        ResultSet rs = ps.executeQuery();
        return rs.next(); // If there's a record, the loan is overdue
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}


    // Kiểm tra khách hàng có bị blacklist không
    public boolean isBlacklisted(int cusId) {
        String sql = "Select * from Blacklist where CusId = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cusId);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // Nếu có kết quả, khách hàng bị blacklist
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Mặc định không bị blacklist nếu có lỗi xảy ra
    }

    // Xóa khách hàng khỏi danh sách đen (nếu cần)
    public void removeFromBlacklist(int cusId) {
        String sql = "DELETE FROM Blacklist WHERE CusId = ?";
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cusId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getNumberOfLoanPaymentByLoanId(int id) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM LoanPayment WHERE LSUId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    
    public static void main(String[] args) {
        CeoDAO c = new CeoDAO();
//        c.deleteStaff(40);
//        for (Staff x : c.searchStaffs("", "", 1, 5)) {
//            System.out.println(x.toString());
//        }
        System.out.println(c.isOverdue(1));
        System.out.println(c.isBlacklisted(2));
        System.out.println(c.isBlacklisted(1));

//        for (LoanServiceUsed x : c.getAllLoanServiceUsedByStatus("Pending", "DuringTime", "ASC", "", 1, 10)) {
//            System.out.println(x.toString());
//        }
//        LoanServiceUsed loanServiceUsed = new LoanServiceUsed(
//                0,
//                loanService,
//                c.getCustomerById(1),
//                new BigDecimal(1000000),
//                Timestamp.valueOf(LocalDateTime.now()),
//                Timestamp.valueOf(LocalDateTime.now().plusDays(loanService.getDuringTime() * 30)),
//                0,
//                InterestCalculator.calculateDebtRepay(new BigDecimal(1000000), loanService.getDuringTime(), new BigDecimal(loanService.getOnTermRate())),
//                "",
//                "Pending");
//
//        // Call the DAL method to insert the new record into the database
//        boolean isInserted = c.createLoanServiceUsed(loanServiceUsed);
    }
}
