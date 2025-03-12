/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import org.json.JSONObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.concurrent.TimeUnit;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import okhttp3.*;
import org.json.JSONArray;


public class AiChatBotServlet extends HttpServlet {

    private static final String API_KEY = "AIzaSyCL8F1P3gtc3On8JmzfPkxuaAF9V-KjOiI";
    private static final String API_URL = "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-pro:generateContent?key=" + API_KEY;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Sử dụng POST để gửi tin nhắn.");
    }

    private String getBotReply(String userMessage) throws IOException {
    OkHttpClient client = new OkHttpClient();
    
    
    String instruction = "Bạn là trợ lý ảo của SmartBank, một hệ thống ngân hàng mô phỏng. " +
            "Bạn chỉ được trả lời các câu hỏi liên quan đến SmartBank. " +
            "Nếu câu hỏi không liên quan, hãy trả lời: 'Xin lỗi, tôi chỉ hỗ trợ về SmartBank.' " +
            "Nếu khách hàng hỏi về cách tạo tài khoản, hãy hướng dẫn họ truy cập: " +
            "<a href=\\\"http://localhost:9999/BankingSystem/onlineChat.jsp\\\">ấn vào đây</a> để chat với hỗ trợ viên."+
            "Nếu khách hàng hỏi về cách nạp tiền vào tài khoản, hãy bảo họ đăng nhập vào tài khoản"
            + " hoặc nhờ hỗ trợ viên tạo tài khoản nếu chưa có qua đường truy cập bên trên, nếu đã có tài khoản thì đăng nhập và truy cập: "+
            "<a href=\\\"http://localhost:9999/BankingSystem/customer/template/deposit.jsp\\\">Manage Account Bank</a> để có nhập số tiền muốn gửi và phương thức thanh toán";

    // Tạo request body đúng chuẩn
    JSONObject requestBody = new JSONObject();
    JSONArray contents = new JSONArray();
    JSONObject userContent = new JSONObject();
    JSONArray userParts = new JSONArray();

    // Thêm hướng dẫn + tin nhắn của người dùng
    userParts.put(new JSONObject().put("text", instruction + "\n\nNgười dùng: " + userMessage));
    userContent.put("role", "user").put("parts", userParts);
    contents.put(userContent);

    requestBody.put("contents", contents);

    // Debug: In log request body
    System.out.println("Request gửi lên API: " + requestBody.toString());

    RequestBody body = RequestBody.create(MediaType.get("application/json"), requestBody.toString());

    Request request = new Request.Builder()
            .url(API_URL)
            .addHeader("Content-Type", "application/json")
            .post(body)
            .build();

    try (Response response = client.newCall(request).execute()) {
        String responseBody = response.body().string();
        System.out.println("Phản hồi từ API: " + responseBody);

        if (!response.isSuccessful()) {
            throw new IOException("Lỗi API: " + response.code() + " - " + response.message() + " - " + responseBody);
        }

        JSONObject jsonResponse = new JSONObject(responseBody);

        if (jsonResponse.has("candidates")) {
            return jsonResponse.getJSONArray("candidates").getJSONObject(0)
                    .getJSONObject("content").getJSONArray("parts")
                    .getJSONObject(0).getString("text");
        } else {
            return "Không thể nhận phản hồi từ AI.";
        }
    } catch (Exception e) {
        e.printStackTrace();
        return "Lỗi hệ thống khi kết nối API: " + e.getMessage();
    }
}


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        try {
            String userMessage = request.getParameter("message");
            if (userMessage == null || userMessage.trim().isEmpty()) {
                throw new Exception("Tin nhắn không hợp lệ!");
            }

            String botReply = getBotReply(userMessage); // Gọi API Google Gemini để lấy phản hồi

            JSONObject json = new JSONObject();
            json.put("reply", botReply);

            out.print(json.toString());
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(500);
            out.print("{\"reply\":\"Lỗi hệ thống. Vui lòng thử lại!\"}");
        } finally {
            out.flush();
            out.close();
        }
    }

    @Override
    public String getServletInfo() {
        return "AI Chatbot Servlet";
    }
}
