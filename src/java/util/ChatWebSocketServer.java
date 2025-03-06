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
    private static final Map<String, String> userRoles = new ConcurrentHashMap<>();

    @OnOpen
    public void onOpen(Session session, EndpointConfig config) {
        HttpSession httpSession = (HttpSession) config.getUserProperties().get("httpSession");

        String username = null;
        String role = "guest";

        if (httpSession != null) {
            Customer customer = (Customer) httpSession.getAttribute("account");
            Staff staff = (Staff) httpSession.getAttribute("staff");

            if (customer != null) {
                username = customer.getUsername();
                role = "customer";
            } else if (staff != null) {
                username = staff.getUsername();
                role = "staff";
            }
        }

        if (username == null) {
            username = "guest-" + session.getId();
        }

        userSessions.put(username, session);
        userRoles.put(username, role);
        session.getUserProperties().put("username", username);
        session.getUserProperties().put("role", role);

        System.out.println(username + " connected as " + role);
        System.out.println("Dữ liệu phiên (session): " + httpSession);
        System.out.println("User đăng nhập: " + username + " với vai trò: " + role);
        sendOnlineUsers();
    }

    private void sendOnlineUsers() {
        StringBuilder staffList = new StringBuilder();
        StringBuilder customerList = new StringBuilder();
        StringBuilder guestList = new StringBuilder();

        for (Map.Entry<String, String> entry : userRoles.entrySet()) {
            String user = entry.getKey();
            String role = entry.getValue();

            if (role.equals("staff")) {
                if (staffList.length() > 0) {
                    staffList.append(",");
                }
                staffList.append(user);
            } else if (role.equals("customer")) {
                if (customerList.length() > 0) {
                    customerList.append(",");
                }
                customerList.append(user);
            } else if (role.equals("guest")) {
                if (guestList.length() > 0) {
                    guestList.append(",");
                }
                guestList.append(user);
            }
        }

        String staffMessage = "STAFF:" + staffList;
        String customerMessage = "CUSTOMER:" + customerList;
        String guestMessage = "GUEST:" + guestList;

        System.out.println("Gửi danh sách online: " + staffMessage + " | " + customerMessage + " | " + guestMessage);

        for (Session session : userSessions.values()) {
            if (session.isOpen()) {
                try {
                    String role = (String) session.getUserProperties().get("role");

                    if (role.equals("staff")) {
                        session.getBasicRemote().sendText(customerMessage + "|" + guestMessage);
                    } else {
                        session.getBasicRemote().sendText(staffMessage);
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        System.out.println("Danh sách STAFF: " + staffList);
        System.out.println("Danh sách CUSTOMER: " + customerList);
        System.out.println("Danh sách GUEST: " + guestList);
    }

@OnMessage
public void onMessage(String message, Session session) {
    String sender = (String) session.getUserProperties().get("username");
    String senderRole = (String) session.getUserProperties().get("role");

    System.out.println("Message nhận được từ " + sender + ": '" + message + "' (Kiểu: " + (message == null ? "null" : message.getClass().getName()) + ")");
    System.out.println("Độ dài message: " + (message != null ? message.length() : 0));

    if (sender == null || !message.contains(":")) {
        sendMessageToSession(session, "Lỗi: Tin nhắn phải có định dạng 'receiver: message'.");
        return;
    }

    String[] parts = message.split(":", 2);
    if (parts.length < 2 || parts[0].trim().isEmpty()) {
        sendMessageToSession(session, "Lỗi: Người nhận không hợp lệ.");
        return;
    }

    String receiver = parts[0].trim();
    String chatMessage = parts[1].trim();
    System.out.println("Receiver sau khi xử lý: '" + receiver + "'");
    System.out.println("Nội dung tin nhắn: '" + chatMessage + "'");

    if (chatMessage.isEmpty()) {
        sendMessageToSession(session, "Lỗi: Nội dung tin nhắn không thể rỗng.");
        return;
    }

    if (!userSessions.containsKey(receiver)) {
        sendMessageToSession(session, "Hệ thống: Người nhận không tồn tại hoặc không trực tuyến.");
        return;
    }

    String receiverRole = userRoles.get(receiver);
    if (receiverRole == null) {
        sendMessageToSession(session, "Lỗi: Không xác định được vai trò của người nhận.");
        return;
    }

    Session receiverSession = userSessions.get(receiver);
    System.out.println("Tin nhắn gửi tới client: " + sender + ": " + chatMessage);

    // Kiểm tra quyền trước khi gửi tin nhắn
    if ((senderRole.equals("staff") && (receiverRole.equals("customer") || receiverRole.equals("guest")))
            || ((senderRole.equals("customer") || senderRole.equals("guest")) && receiverRole.equals("staff"))) {
        // Xử lý tin nhắn ảnh
        if (chatMessage.startsWith("IMAGE")) {
            sendMessageToSession(receiverSession, sender + ": " + chatMessage); // Gửi tin nhắn ảnh với sender
        } else {
            sendMessageToSession(receiverSession, sender + ": " + chatMessage); // Gửi tin nhắn văn bản
        }
        // Gửi xác nhận cho sender
//        sendMessageToSession(session, "Hệ thống: Tin nhắn đã được gửi tới " + receiver);
    } else {
        sendMessageToSession(session, "Bạn không thể gửi tin nhắn đến người này.");
    }
}

    @OnClose
    public void onClose(Session session) {
        String username = (String) session.getUserProperties().get("username");
        if (username != null) {
            userSessions.remove(username);
            userRoles.remove(username);
            sendOnlineUsers();
        }
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        System.err.println("Lỗi WebSocket: " + throwable.getMessage());
    }

    private void sendMessageToSession(Session session, String message) {
        try {
            session.getBasicRemote().sendText(message);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
