/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import context.DBContext;
import Model.Staff;
import com.sun.jdi.connect.spi.Connection;
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
public class StaffDAO extends DBContext {
       public Staff getStaffByUsername(String email) {
   String sql = "SELECT s.*, r.Id AS Id, r.role_name AS Name FROM [dbo].[Staff] s " +
             "LEFT JOIN [dbo].[Role] r ON s.RoleId = r.Id WHERE s.Email = ?";

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

}

