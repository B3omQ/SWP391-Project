/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Role;

/**
 *
 * @author LAPTOP
 */
public class RoleDAO extends DBContext {

    public Role getRoleById(int id) {
        String sql = """
                    SELECT * 
                    FROM BankingSystem.dbo.Role 
                    WHERE Id = ? 
                    """;
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    return new Role(
                            rs.getInt("Id"),
                            rs.getString("Name")
                    );
                }
            }
        } catch (Exception e) {
        }
        return null;
    }
}
