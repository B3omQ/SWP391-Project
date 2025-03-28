/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Notification;
import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;
import model.NotifyType;

/**
 *
 * @author JIGGER
 */
public class NotifyDAO extends DBContext {

    CustomerDAO cdao = new CustomerDAO();
    StaffDAO sdao = new StaffDAO();

    public List<Notification> getAllNotificationByCusIdMarkRead(int cusId, boolean isRead) {
        List<Notification> notifyList = new ArrayList<>();
        String sql = """
                     SELECT Id, CusId, StaffId, NotifyType, Description, CreateTime, isRead
                     FROM BankingSystem.dbo.Notification
                     WHERE CusId = ? AND isRead = ?
                     """;

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, cusId);
            st.setBoolean(2, isRead);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Notification notify = new Notification(
                            rs.getInt("Id"),
                            cdao.getCustomerById(cusId),
                            null,
                            new NotifyType(rs.getInt("NotifyType")),
                            rs.getString("Description"),
                            rs.getTimestamp("CreateTime"),
                            rs.getBoolean("isRead")
                    );
                    notifyList.add(notify);
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return notifyList;
    }
    
    public Notification getNotifyById(int notifyId) {
        String sql = """
                     SELECT Id, CusId, StaffId, NotifyType, Description, CreateTime, isRead
                     FROM BankingSystem.dbo.Notification
                     WHERE Id = ?
                     """;

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, notifyId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    return new Notification(
                            notifyId,
                            null,
                            null,
                            new NotifyType(rs.getInt("NotifyType")),
                            rs.getString("Description"),
                            rs.getTimestamp("CreateTime"),
                            rs.getBoolean("isRead")
                    );
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return null;
    }

    public List<Notification> getAllNotificationByCusIdNotRead(int cusId, boolean isRead) {
        List<Notification> notifyList = new ArrayList<>();
        String sql = """
                     SELECT Id, CusId, StaffId, NotifyType, Description, CreateTime, isRead
                     FROM BankingSystem.dbo.Notification
                     WHERE CusId = ? AND isRead = ?
                     ORDER BY Id DESC
                     """;

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, cusId);
            st.setBoolean(2, isRead);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Notification notify = new Notification(
                            rs.getInt("Id"),
                            cdao.getCustomerById(cusId),
                            null,
                            new NotifyType(rs.getInt("NotifyType")),
                            rs.getString("Description"),
                            rs.getTimestamp("CreateTime"),
                            rs.getBoolean("isRead")
                    );
                    notifyList.add(notify);
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return notifyList;
    }

    public List<Notification> getAllNotificationByStaffIdMarkRead(int staffId, boolean isRead) {
        List<Notification> notifyList = new ArrayList<>();
        String sql = """
                     SELECT Id, CusId, StaffId, NotifyType, Description, CreateTime, isRead
                     FROM BankingSystem.dbo.Notification
                     WHERE StaffId = ? AND isRead = ?
                     """;

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, staffId);
            st.setBoolean(2, isRead);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Notification notify = new Notification(
                            rs.getInt("Id"),
                            null,
                            sdao.getStaffById(staffId),
                            new NotifyType(rs.getInt("NotifyType")),
                            rs.getString("Description"),
                            rs.getTimestamp("CreateTime"),
                            rs.getBoolean("isRead")
                    );
                    notifyList.add(notify);
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return notifyList;
    }

    public List<Notification> getAllNotificationByStaffIdNotRead(int staffId, boolean isRead) {
        List<Notification> notifyList = new ArrayList<>();
        String sql = """
                     SELECT Id, CusId, StaffId, NotifyType, Description, CreateTime, isRead
                     FROM BankingSystem.dbo.Notification
                     WHERE StaffId = ? AND isRead = ?
                     """;

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, staffId);
            st.setBoolean(2, isRead);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Notification notify = new Notification(
                            rs.getInt("Id"),
                            null,
                            sdao.getStaffById(staffId),
                            new NotifyType(rs.getInt("NotifyType")),
                            rs.getString("Description"),
                            rs.getTimestamp("CreateTime"),
                            rs.getBoolean("isRead")
                    );
                    notifyList.add(notify);
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return notifyList;
    }

    public int countNotificationNotReadByCusId(int cusId, boolean isRead) {
        String sql = "SELECT COUNT(*) as total FROM Notification WHERE CusId = ? AND isRead = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cusId);
            ps.setBoolean(2, isRead);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int countNotificationNotReadByStaffId(int staffId, boolean isRead) {
        String sql = "SELECT COUNT(*) as total FROM Notification WHERE StaffId = ? AND isRead = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            ps.setBoolean(2, isRead);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void insertNotificationForCustomer(int cusId, String description, int type) {
        String sql = """
                     INSERT INTO BankingSystem.dbo.Notification
                     (CusId, StaffId, NotifyType, Description)
                     VALUES(?, NULL, ?, ?);""";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, cusId);
            st.setString(3, description);
            st.setInt(2, type);

            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertNotificationForStaff(int staffId, String description, int type) {
        String sql = """
                     INSERT INTO BankingSystem.dbo.Notification
                     (CusId, StaffId, NotifyType, Description)
                     VALUES(NULL, ?, ?, ?);""";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, staffId);
            st.setString(3, description);
            st.setInt(2, type);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        NotifyDAO n = new NotifyDAO();
        List<Notification> l = n.getAllNotificationByCusIdNotRead(42, false);
        for (Notification o : l) {
            System.out.println(o);
        }
        n.insertNotificationForCustomer(42, "KHONG SOA DAU", 1);
    }

    public void updateIsRead(int id) {
        String sql = "UPDATE Notification SET isRead = 1 WHERE id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
