/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;


import jakarta.websocket.*;
import jakarta.websocket.server.ServerEndpoint;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import model.Customer;
import model.Staff;

@ServerEndpoint(value = "/chat", configurator = WebSocketConfigurator.class)
public class ChatWebSocketServer {
    private static final Map<String, Session> userSessions = new ConcurrentHashMap<>();

    @OnOpen
    public void onOpen(Session session, EndpointConfig config) {
        HttpSession httpSession = (HttpSession) config.getUserProperties().get("httpSession");

        String username = null;

        if (httpSession != null) {
            Customer customer = (Customer) httpSession.getAttribute("account");
            Staff staff = (Staff) httpSession.getAttribute("staff");

            if (customer != null) {
                username = customer.getUsername();
            } else if (staff != null) {
                username = staff.getUsername();
            }
        }

        // Nếu không có username, tạo ID tạm thời cho khách chưa đăng nhập
        if (username == null) {
            username = "guest-" + session.getId();
        }

        userSessions.put(username, session);
        session.getUserProperties().put("username", username);
        System.out.println(username + " connected.");

        broadcast("System: " + username + " đã tham gia cuộc trò chuyện.", null);
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        String sender = (String) session.getUserProperties().get("username");
        if (sender == null) {
            return;
        }

        if (!message.contains(":")) {
            try {
                session.getBasicRemote().sendText("Lỗi: Tin nhắn phải có định dạng 'receiver: message'.");
            } catch (IOException e) {
                e.printStackTrace();
            }
            return;
        }

        String[] parts = message.split(":", 2);
        String receiver = parts[0].trim();
        String chatMessage = parts[1].trim();

        Session receiverSession = userSessions.get(receiver);
        if (receiverSession != null && receiverSession.isOpen()) {
            try {
                receiverSession.getBasicRemote().sendText(sender + ": " + chatMessage);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            try {
                session.getBasicRemote().sendText("Hệ thống: Người nhận " + receiver + " không trực tuyến.");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @OnClose
    public void onClose(Session session) {
        String username = (String) session.getUserProperties().get("username");
        if (username != null) {
            userSessions.remove(username);
            System.out.println(username + " disconnected.");
            broadcast("System: " + username + " đã rời khỏi cuộc trò chuyện.", null);
        }
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        System.err.println("Lỗi WebSocket: " + throwable.getMessage());
    }

    private void broadcast(String message, Session exceptSession) {
        userSessions.values().forEach(session -> {
            if (session.isOpen() && (exceptSession == null || !session.equals(exceptSession))) {
                try {
                    session.getBasicRemote().sendText(message);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        });
    }
}



