package dal;

import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import model.TokenForgetPassword;

public class DAOTokenForget extends DBContext {

    public String getFormatDate(LocalDateTime myDateObj) {
        DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return myDateObj.format(myFormatObj);
    }

    public boolean insertTokenForget(TokenForgetPassword tokenForget) {
        String sql = "INSERT INTO tokenForgetPassword (token, isUsed, userId, expiryTime, UserType) VALUES (?, ?, ?, ?, ?)";
        LocalDateTime expiryTime = LocalDateTime.now().plusHours(1);
        String formattedExpiryTime = getFormatDate(expiryTime);

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, tokenForget.getToken());
            ps.setBoolean(2, tokenForget.isIsUsed());
            ps.setInt(3, tokenForget.getUserId());
            ps.setString(4, formattedExpiryTime);
            ps.setString(5, tokenForget.getUserType()); // Thêm UserType
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error while inserting tokenForgetPassword: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public TokenForgetPassword getTokenPassword(String token) {
        String sql = "SELECT * FROM [tokenForgetPassword] WHERE token = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, token);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new TokenForgetPassword(
                            rs.getString("token"),
                            rs.getTimestamp("expiryTime").toLocalDateTime(),
                            rs.getBoolean("isUsed"),
                            rs.getInt("userId"),
                            rs.getString("UserType") // Thêm UserType
                    );
                }
            }
        } catch (SQLException e) {
            System.out.println("Error getting token: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public void updateStatus(TokenForgetPassword token) {
        System.out.println("Updating token status: " + token);
        String sql = "UPDATE [dbo].[tokenForgetPassword] SET [isUsed] = ? WHERE token = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setBoolean(1, token.isIsUsed());
            st.setString(2, token.getToken());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error updating token status: " + e.getMessage());
            e.printStackTrace();
        }
    }
}