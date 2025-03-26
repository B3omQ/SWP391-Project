/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.consultant;

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
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author LAPTOP
 */
public class ChatLogCustomer extends HttpServlet {

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
        HttpSession session = request.getSession();
        Staff currentAccount = (Staff) session.getAttribute("staff");

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
            List<ChatMessage> chatHistory = chatMessageDAO.getChatHistory(senderId, currentAccount.getId());

            if (!customers.isEmpty()) {
                System.out.println("Tải danh sách khách hàng thành công: " + customers.size() + " khách hàng.");
            }

            request.setAttribute("chatHistory", chatHistory);
            request.setAttribute("customers", customers);
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi khi tải dữ liệu. Vui lòng thử lại sau!");
        }

        request.getRequestDispatcher("./consultant/chatLogCustomer.jsp").forward(request, response);
    }
//        public static void main(String[] args) {
//        CustomerDAO customerDAO = new CustomerDAO();
//        ChatMessageDAO chatMessageDAO = new ChatMessageDAO();
//        List<Customer> customers = customerDAO.getAllCustomersPlus();
//        System.out.println("Danh sách Customers:");
//        for (Customer c : customers) {
//            System.out.println("ID: " + c.getId() + ", Username: " + c.getUsername());
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
