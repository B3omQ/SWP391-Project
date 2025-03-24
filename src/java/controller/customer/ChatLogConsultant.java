/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.customer;

import dal.ChatMessageDAO;
import dal.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.ChatMessage;
import model.Customer;
import model.Staff;

/**
 *
 * @author LAPTOP
 */
public class ChatLogConsultant extends HttpServlet {
   

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    ChatMessageDAO chatMessageDAO = new ChatMessageDAO();
    HttpSession session = request.getSession();
        Customer currentAccount = (Customer) session.getAttribute("account");

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
        List<Staff> staffs = chatMessageDAO.getAllStaff();
        List<ChatMessage> chatHistory = chatMessageDAO.getChatHistory(currentAccount.getId(), receiverId);
        System.out.println(currentAccount.getId());
        if (!staffs.isEmpty()) {
            System.out.println("Tải danh sách nhân viên thành công: " + staffs.size() + " nhân viên.");
        }

        request.setAttribute("chatHistory", chatHistory);
        request.setAttribute("staffs", staffs);
    } catch (Exception ex) {
        ex.printStackTrace();
        request.setAttribute("error", "Đã xảy ra lỗi khi tải dữ liệu. Vui lòng thử lại sau!");
    }

    request.getRequestDispatcher("./customer/ChatLogConsultant.jsp").forward(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
