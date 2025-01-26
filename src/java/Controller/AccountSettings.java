/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import Dal.CustomerDAO;
import Model.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;

/**
 *
 * @author emkob
 */
public class AccountSettings extends HttpServlet {
       private CustomerDAO customerDAO = new CustomerDAO();

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AccountSettings</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AccountSettings at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customerId"); // Lấy ID từ session

        if (customerId == null) {
            response.sendRedirect("/login.jsp"); // Nếu chưa đăng nhập, chuyển hướng về login
            return;
        }

        Customer customer = customerDAO.getCustomerById(customerId);
        if (customer == null) {
            request.setAttribute("message", "Không tìm thấy thông tin tài khoản.");
        } else {
            request.setAttribute("customer", customer);
        }

        request.getRequestDispatcher("/account/settings.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customerId");

        if (customerId == null) {
            response.sendRedirect("/login.jsp");
            return;
        }

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        Customer existingCustomer = customerDAO.getCustomerById(customerId);
        if (existingCustomer == null) {
            request.setAttribute("message", "Tài khoản không tồn tại!");
            request.getRequestDispatcher("/account/settings.jsp").forward(request, response);
            return;
        }

        Customer updatedCustomer = new Customer(customerId, username, "", email, firstName, lastName, phone, address, existingCustomer.getWallet(), 0, null);
        boolean isUpdated = customerDAO.updateCustomer(updatedCustomer);

        if (isUpdated) {
            request.setAttribute("message", "Cập nhật thông tin thành công!");
        } else {
            request.setAttribute("message", "Cập nhật thất bại. Vui lòng thử lại!");
        }

        request.setAttribute("customer", updatedCustomer);
        request.getRequestDispatcher("/account/settings.jsp").forward(request, response);
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
