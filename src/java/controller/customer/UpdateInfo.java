/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.customer;

import dal.CustomerDAO;
import dal.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import model.Staff;

/**
 *
 * @author emkob
 */
public class UpdateInfo extends HttpServlet {
   
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
            out.println("<title>Servlet UpdateInfo</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateInfo at " + request.getContextPath () + "</h1>");
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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
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

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
            return;
        }

        // Kiểm tra user hiện tại là Customer hay Staff
        Object user = session.getAttribute("account"); // Mặc định là Customer
        boolean isCustomer = true;

        if (user == null) { 
            user = session.getAttribute("staff"); // Nếu null, thử lấy Staff
            isCustomer = false;
        }

        if (user == null) { // Không có tài khoản nào
            response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
            return;
        }

        // Lấy thông tin từ form
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if (isCustomer) {
            Customer customer = (Customer) user;
            customer.setEmail(email);
            customer.setPhone(phone);
            customer.setAddress(address);

            // Cập nhật database
            CustomerDAO customerDAO = new CustomerDAO();
            customerDAO.updateCustomer(customer);

            // Cập nhật lại session
            session.setAttribute("account", customer);
            response.sendRedirect(request.getContextPath() + "/customer/template/account-profile.jsp?success=ProfileUpdated");
        } else {
            Staff staff = (Staff) user;
            staff.setEmail(email);
            staff.setPhone(phone);
            staff.setAddress(address);

            // Cập nhật database
            StaffDAO staffDAO = new StaffDAO();
            staffDAO.updateStaff(staff);

            // Cập nhật lại session
            session.setAttribute("staff", staff);
            response.sendRedirect(request.getContextPath() + "/staff/template/staff-profile.jsp?success=ProfileUpdated");
        }
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
