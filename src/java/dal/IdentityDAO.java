package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.VerifyIdentityInformation;
import util.DBContext;

public class IdentityDAO extends DBContext {

    CustomerDAO cdao = new CustomerDAO();

    public List<VerifyIdentityInformation> getAllVerifyIdentityInformation(int offset, int recordsPerPage, String pendingStatus) {
        List<VerifyIdentityInformation> list = new ArrayList<>();
        String sql = """
            SELECT * FROM verifyIdentityInformation
            WHERE PendingStatus = ?
            ORDER BY Id
            OFFSET ? ROWS
            FETCH NEXT ? ROWS ONLY;
            """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, pendingStatus);
            ps.setInt(2, offset);
            ps.setInt(3, recordsPerPage);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    VerifyIdentityInformation v = new VerifyIdentityInformation(
                            rs.getInt("Id"),
                            cdao.getCustomerById(rs.getInt("CusId")),
                            rs.getString("IdentityCardNumber"),
                            rs.getString("IdentityCardFrontSide"),
                            rs.getString("IdentityCardBackSide"),
                            rs.getString("ReasonReject"),
                            rs.getString("PortraitPhoto"),
                            rs.getString("PendingStatus")
                    );
                    list.add(v);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countStatus(int id, String status) {
        String sql = "SELECT COUNT(*) as total FROM verifyIdentityInformation WHERE CusId = ? AND PendingStatus = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.setString(2, status);
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

    public int countTotalVerifyIdentityInformation() {
        String sql = "SELECT COUNT(*) as total FROM verifyIdentityInformation";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
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

    public int countTotalVerifyIdentityInformationByStatus(String status) {
        String sql = "SELECT COUNT(*) as total FROM verifyIdentityInformation WHERE PendingStatus = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
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

    public List<VerifyIdentityInformation> getListVerifyIdentityInformationByCusId(int id) {
        List<VerifyIdentityInformation> list = new ArrayList<>();
        String sql = "SELECT * FROM verifyIdentityInformation WHERE CusId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    VerifyIdentityInformation v = new VerifyIdentityInformation(
                            rs.getInt("Id"),
                            cdao.getCustomerById(rs.getInt("CusId")),
                            rs.getString("IdentityCardNumber"),
                            rs.getString("IdentityCardFrontSide"),
                            rs.getString("IdentityCardBackSide"),
                            rs.getString("ReasonReject"),
                            rs.getString("PortraitPhoto"),
                            rs.getString("PendingStatus")
                    );
                    list.add(v);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        IdentityDAO d = new IdentityDAO();
        List<VerifyIdentityInformation> list = d.getAllVerifyIdentityInformation(0, 1, "Pending");
        for (VerifyIdentityInformation o : list) {
            System.out.println(o);
        }
        System.out.println(d.countTotalVerifyIdentityInformation());
        System.out.println(d.countTotalVerifyIdentityInformationByStatus("Wait"));
        System.out.println(d.countStatus(42, "Pending"));
    }

    public VerifyIdentityInformation getVerifyIdentityInformationByCusId(int id) {
        String sql = "SELECT * FROM verifyIdentityInformation WHERE CusId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                ps.setInt(1, id);
                while (rs.next()) {
                    return new VerifyIdentityInformation(
                            rs.getInt("Id"),
                            cdao.getCustomerById(rs.getInt("CusId")),
                            rs.getString("IdentityCardNumber"),
                            rs.getString("IdentityCardFrontSide"),
                            rs.getString("IdentityCardBackSide"),
                            rs.getString("ReasonReject"),
                            rs.getString("PortraitPhoto"),
                            rs.getString("PendingStatus")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void insertVerifyIdentityInformation(int customerId, String identityCardNumber, String identityCardFrontSide,
            String identityCardBackSide,
            String portraitPhoto) {
        String sql = "INSERT INTO verifyIdentityInformation (CusId, IdentityCardNumber, IdentityCardFrontSide, IdentityCardBackSide,  PortraitPhoto) "
                + "VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.setString(2, identityCardNumber);
            ps.setString(3, identityCardFrontSide);
            ps.setString(4, identityCardBackSide);
            ps.setString(5, portraitPhoto);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateReasonReject(int id, String reasonReject) {
        String sql = "UPDATE verifyIdentityInformation SET ReasonReject = ? WHERE Id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, reasonReject);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateVerifyIdentityInformation(int id, String reasonReject, String pendingStatus) {
        String sql = "UPDATE verifyIdentityInformation SET ReasonReject = ?, PendingStatus = ? WHERE Id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, reasonReject);
            ps.setString(2, pendingStatus);
            ps.setInt(3, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteVerifyIdentityInformation(int id) {
        String sql = "DELETE FROM verifyIdentityInformation WHERE Id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateStatus(int id, String pendingStatus) {
        String sql = "UPDATE verifyIdentityInformation SET PendingStatus = ? WHERE Id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, pendingStatus);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
