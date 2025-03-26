/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dal.ChatMessageDAO;
import dal.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.ChatMessage;
import model.Customer;
import model.Staff;

/**
 *
 * @author LAPTOP
 */
public class ChatHistoryManagement extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ChatMessageDAO chatMessageDAO = new ChatMessageDAO();
    CustomerDAO cdao = new CustomerDAO();

    int senderId = -1, receiverId = -1;
    try {
        String senderIdParam = request.getParameter("senderId");
        String receiverIdParam = request.getParameter("receiverId");

        if (senderIdParam != null && !senderIdParam.isEmpty()) {
            senderId = Integer.parseInt(senderIdParam);
        }
        if (receiverIdParam != null && !receiverIdParam.isEmpty()) {
            receiverId = Integer.parseInt(receiverIdParam);
        }
    } catch (NumberFormatException e) {
        e.printStackTrace();
        request.setAttribute("error", "Lỗi định dạng ID! Vui lòng thử lại.");
    }

    try {
        List<Customer> customers = cdao.getAllCustomersPlus();
        List<Staff> staffs = chatMessageDAO.getAllStaff();
        List<ChatMessage> chatHistory = chatMessageDAO.getChatHistory(senderId, receiverId);

        if (!customers.isEmpty()) {
            System.out.println("Tải danh sách khách hàng thành công: " + customers.size() + " khách hàng.");
        }
        if (!staffs.isEmpty()) {
            System.out.println("Tải danh sách nhân viên thành công: " + staffs.size() + " nhân viên.");
        }

        request.setAttribute("chatHistory", chatHistory);
        request.setAttribute("customers", customers);
        request.setAttribute("staffs", staffs);
    } catch (Exception ex) {
        ex.printStackTrace();
        request.setAttribute("error", "Đã xảy ra lỗi khi tải dữ liệu. Vui lòng thử lại sau!");
    }

    request.getRequestDispatcher("./manager/chatHistory.jsp").forward(request, response);
    }

//    public static void main(String[] args) {
//        // Tạo DAO để truy vấn dữ liệu
//        CustomerDAO customerDAO = new CustomerDAO();
//        ChatMessageDAO chatMessageDAO = new ChatMessageDAO();
//
//        // Lấy danh sách tất cả customers
//        List<Customer> customers = customerDAO.getAllCustomersPlus();
//        System.out.println("Danh sách Customers:");
//        for (Customer c : customers) {
//            System.out.println("ID: " + c.getId() + ", Username: " + c.getUsername());
//        }
//
//        // Lấy danh sách tất cả Staff
//        List<Staff> staffs = chatMessageDAO.getAllStaff();
//        System.out.println("\nDanh sách Staff:");
//        for (Staff s : staffs) {
//            System.out.println("ID: " + s.getId() + ", Username: " + s.getUsername());
//        }
//        List<ChatMessage> chatHistory = chatMessageDAO.getChatHistory(2, 5);
//        System.out.println("\nDanh sách chat:");
//        for (ChatMessage s : chatHistory) {
//            System.out.println(chatHistory);
//        }
//    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
