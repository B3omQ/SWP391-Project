package Dal;
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


import Model.TokenForgetPassword;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author HP
 */
public class DAOTokenForget extends DBContext{
    
     public String getFormatDate(LocalDateTime myDateObj) {
        DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");  
        String formattedDate = myDateObj.format(myFormatObj);  
        return formattedDate;
     }
    
public boolean insertTokenForget(TokenForgetPassword tokenForget) {
    String sql = "INSERT INTO tokenForgetPassword (token, isUsed, userId, expiryTime) VALUES (?, ?, ?, ?)";
    
    // Cập nhật thời gian hết hạn (expiryTime) là 1 giờ sau thời gian hiện tại
    LocalDateTime expiryTime = LocalDateTime.now().plusHours(1); // Cộng 1 giờ
    String formattedExpiryTime = getFormatDate(expiryTime); // Định dạng lại ngày giờ thành chuỗi

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, tokenForget.getToken());
        ps.setBoolean(2, tokenForget.isIsUsed());
        ps.setInt(3, tokenForget.getUserId());
        ps.setString(4, formattedExpiryTime);  // Thêm giá trị expiryTime vào câu lệnh SQL
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        System.err.println("Error while inserting tokenForgetPassword: " + e.getMessage());
        e.printStackTrace();
    }
    return false;
}

    public TokenForgetPassword getTokenPassword(String token) {
        String sql = "Select * from [tokenForgetPassword] where token = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, token);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return new TokenForgetPassword(
                       
                        rs.getInt("userId"),
                        rs.getBoolean("isUsed"),
                        rs.getString("token"),
                        rs.getTimestamp("expiryTime").toLocalDateTime()
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public void updateStatus(TokenForgetPassword token) {
        System.out.println("token = "+token);
        String sql = "UPDATE [dbo].[tokenForgetPassword]\n"
                + "   SET [isUsed] = ?\n"
                + " WHERE token = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setBoolean(1, token.isIsUsed());
            st.setString(2, token.getToken());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
}
