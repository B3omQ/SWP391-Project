/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

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
public class sendNotificationEmail {

    public sendNotificationEmail() {
        
    } 

    static final String from = "dichvuhotrosmartbank@gmail.com";
    static final String password = "dyzg xink qmht ovpj";

    public boolean sendNotify(String to, String message, String name) {
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
            msg.setSubject("SmartBanking thông báo", "UTF-8");

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
                    + "<h1 style='color: #cc0000;'>Xin chào, " + name + "!</h1>"
                    + "<p style='font-size: 16px;'>Có thể bạn đã bỏ lỡ:</p>"
                    + "<h2 style='font-size: 36px; color: #cc0000; text-align: center;'>" + message + "</h2>"
                    + "<p style='font-size: 14px;'>Không đặt câu hỏi, trả lời về mail này, trân trọng.</p>"
                    + "</div>"
                    + "<div class='footer'>"
                    + "<p>Chúc bạn một ngày tốt lành, <br/> SmartBanking </p>"
                    + "</div>"
                    + "</body>"
                    + "</html>";

            msg.setContent(content, "text/html; charset=UTF-8");
            Transport.send(msg);

            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }
}
