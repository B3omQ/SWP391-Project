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

    private static final String API_KEY = "AIzaSyAvwrIQZZZS50daDr-ryskTEJKxn9xjhs0";
    private static final String API_URL = "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-pro:generateContent?key=" + API_KEY;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Sử dụng POST để gửi tin nhắn.");
    }

    private String getBotReply(String message) throws IOException {
        OkHttpClient client = new OkHttpClient();

        // Tạo request body JSON
        JSONObject requestBody = new JSONObject();
        requestBody.put("contents", new JSONObject().put("parts", new JSONObject().put("text", message)));

        RequestBody body = RequestBody.create(MediaType.get("application/json"), requestBody.toString());

        Request request = new Request.Builder()
                .url(API_URL)
                .addHeader("Content-Type", "application/json")
                .post(body)
                .build();

        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) {
                throw new IOException("Lỗi API: " + response.code() + " - " + response.message());
            }

            // Lấy phản hồi từ API
            String responseBody = response.body().string();
            JSONObject jsonResponse = new JSONObject(responseBody);

            // Trích xuất nội dung phản hồi từ Gemini
            if (jsonResponse.has("candidates")) {
                return jsonResponse.getJSONArray("candidates").getJSONObject(0).getJSONObject("content").getJSONArray("parts").getJSONObject(0).getString("text");
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
        }
    }

    @Override
    public String getServletInfo() {
        return "AI Chatbot Servlet";
    }
}
