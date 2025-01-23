package Dal;

import Model.Staff;
import Model.Role;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class StaffDAO extends DBContext {
    public Staff getStaffByUsername(String email) {
        String sql = "SELECT s.*, r.Id AS RoleId, r.Name AS RoleName FROM [dbo].[Staff] s " +
                     "LEFT JOIN [dbo].[Role] r ON s.RoleId = r.Id WHERE s.Email = ?";

        try (PreparedStatement p = connection.prepareStatement(sql)) {
            p.setString(1, email);
            try (ResultSet rs = p.executeQuery()) {
                if (rs.next()) {
                    Role role = new Role(rs.getInt("RoleId"), rs.getString("RoleName"));

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
}
