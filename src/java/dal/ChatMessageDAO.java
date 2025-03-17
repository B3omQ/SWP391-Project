/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.ChatMessage;
import model.Role;
import model.Staff;

/**
 *
 * @author LAPTOP
 */
public class ChatMessageDAO extends DBContext {

    private RoleDAO roleDAO = new RoleDAO();

    public List<ChatMessage> getChatHistory(int customerId, int consultantId) {
        List<ChatMessage> messages = new ArrayList<>();
        String sql = "SELECT id, sender_id, sender_type, receiver_id, receiver_type, message, timestamp FROM chat_messages "
                + "WHERE (sender_id = ? AND receiver_id = ?) "
                + "   OR (sender_id = ? AND receiver_id = ?) "
                + "ORDER BY timestamp ASC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            stmt.setInt(2, consultantId);
            stmt.setInt(3, consultantId);
            stmt.setInt(4, customerId);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                messages.add(new ChatMessage(
                        rs.getInt("id"),
                        rs.getInt("sender_id"),
                        rs.getString("sender_type"),
                        rs.getInt("receiver_id"),
                        rs.getString("receiver_type"),
                        rs.getString("message"),
                        rs.getTimestamp("timestamp")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return messages;
    }

    public List<Staff> getAllStaff() {
        List<Staff> staffList = new ArrayList<>();
        String sql = "SELECT * FROM Staff";

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int roleId = rs.getInt("RoleId");
                Role role = roleDAO.getRoleById(roleId);
                staffList.add(new Staff(
                        rs.getInt("id"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("Image"),
                        rs.getString("Email"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getString("Gender"),
                        rs.getDate("Dob").toLocalDate(),
                        rs.getString("Phone"),
                        rs.getString("Address"),
                        role
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return staffList;
    }
}
