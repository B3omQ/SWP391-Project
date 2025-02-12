/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.customer;

import java.time.LocalDateTime;
import java.util.Properties;
import java.util.Random;
import java.util.UUID;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author emkob
 */
public class resetService {

    private final int LIMIT_MINUS = 10;
    static final String from = "dichvuhotrosmartbank@gmail.com";
    static final String password = "dyzg xink qmht ovpj";

    public String generateToken() {
        return UUID.randomUUID().toString();
    }

    public LocalDateTime expireDateTime() {
        return LocalDateTime.now().plusMinutes(LIMIT_MINUS);
    }

    public boolean isExpireTime(LocalDateTime time) {
        return LocalDateTime.now().isAfter(time);
    }
public String generateOTP() {
        Random rand = new Random();
        int otp = rand.nextInt(999999);
        return String.format("%06d", otp);  
    }
    public boolean sendEmail(String to, String link, String name) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        };

        Session session = Session.getInstance(props, auth);

        MimeMessage msg = new MimeMessage(session);

        try {
            msg.addHeader("Content-type", "text/html; charset=UTF-8");
            msg.setFrom(from);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            msg.setSubject("Request password reset", "UTF-8");
            String content = "<html>"
                    + "<head>"
                    + "<style>"
                    + "body {font-family: Arial, sans-serif; background-color: #f4f4f4; color: #333; padding: 20px;}"
                    + ".container {background-color: #ffffff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); width: 100%; max-width: 600px; margin: 0 auto;}"
                    + ".button {display: inline-block; padding: 10px 20px; font-size: 16px; color: #000; background-color: #ff4d4d; border-radius: 4px; text-decoration: none;}"
                    + ".button:hover {background-color: #e60000;}"
                    + ".footer {font-size: 12px; color: #aaa; text-align: center; margin-top: 20px;}"
                    + "</style>"
                    + "</head>"
                    + "<body>"
                    + "<div class='container'>"
                    + "<h1 style='color: #cc0000;'>Hello, " + name + "!</h1>"
                    + "<p style='font-size: 16px;'>We received a request to reset your password. Click the button below to reset it.</p>"
                    + "<p style='text-align: center;'>"
                    + "<a href='" + link + "' class='button'>Reset Password</a>"
                    + "</p>"
                    + "<p style='font-size: 14px;'>If you did not request this change, you can ignore this email.</p>"
                    + "</div>"
                    + "<div class='footer'>"
                    + "<p>Best regards, <br/> Your Company Name</p>"
                    + "</div>"
                    + "</body>"
                    + "</html>";
            msg.setContent(content, "text/html; charset=UTF-8");
            Transport.send(msg);
            System.out.println("Send successfully");
            return true;
        } catch (Exception e) {
            System.out.println("Send error");
            System.out.println(e);
            return false;
        }
    }
     public boolean sendOtpEmail(String to, String otp, String name) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        };

        Session session = Session.getInstance(props, auth);
        MimeMessage msg = new MimeMessage(session);

        try {
            msg.addHeader("Content-type", "text/html; charset=UTF-8");
            msg.setFrom(from);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            msg.setSubject("OTP for Two-Step Authentication", "UTF-8");

            // Nội dung email để gửi OTP
            String content = "<html>"
                    + "<head>"
                    + "<style>"
                    + "body {font-family: Arial, sans-serif; background-color: #f4f4f4; color: #333; padding: 20px;} "
                    + ".container {background-color: #ffffff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); width: 100%; max-width: 600px; margin: 0 auto;} "
                    + ".footer {font-size: 12px; color: #aaa; text-align: center; margin-top: 20px;} "
                    + "</style>"
                    + "</head>"
                    + "<body>"
                    + "<div class='container'>"
                    + "<h1 style='color: #cc0000;'>Hello, " + name + "!</h1>"
                    + "<p style='font-size: 16px;'>Use the OTP below to complete your login:</p>"
                    + "<h2 style='font-size: 36px; color: #cc0000; text-align: center;'>" + otp + "</h2>"
                    + "<p style='font-size: 14px;'>If you did not request this, please ignore this email.</p>"
                    + "</div>"
                    + "<div class='footer'>"
                    + "<p>Best regards, <br/> Your Company Name</p>"
                    + "</div>"
                    + "</body>"
                    + "</html>";

            msg.setContent(content, "text/html; charset=UTF-8");
            Transport.send(msg);
            System.out.println("OTP sent successfully");
            return true;
        } catch (Exception e) {
            System.out.println("Error sending OTP");
            System.out.println(e);
            return false;
        }
    }
}
