/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.customer;

import dal.ConsultantDAO;
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
import util.AccountValidation;

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

        // Xác định người dùng hiện tại: Customer hoặc Staff
        Object user = session.getAttribute("account");
        boolean isCustomer = true;
        if (user == null) {
            user = session.getAttribute("staff");
            isCustomer = false;
        }
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
            return;
        }

        // Lấy dữ liệu từ form
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        AccountValidation validator = new AccountValidation();

        if (!validator.isValidEmail(email)) {
            session.setAttribute("error3", "Email không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/customer/account-profile.jsp");
            return;
        }
        if (!validator.isValidPhone(phone)) {
            session.setAttribute("error3", "Số điện thoại không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/customer/account-profile.jsp");
            return;
        }
        if (!validator.isValidAddress(address)) {
            session.setAttribute("error3", "Địa chỉ không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/customer/account-profile.jsp");
            return;
        }

        if (isCustomer) {
            Customer customer = (Customer) user;
            CustomerDAO customerDAO = new CustomerDAO();
            if (!email.equalsIgnoreCase(customer.getEmail()) && customerDAO.emailExists(email)) {
                session.setAttribute("error3", "Email đã được sử dụng bởi người dùng khác.");
                response.sendRedirect(request.getContextPath() + "/customer/account-profile.jsp");
                return;
            }
            if (!phone.equals(customer.getPhone()) && customerDAO.phoneExists(phone)) {
                session.setAttribute("error3", "Số điện thoại đã được sử dụng bởi người dùng khác.");
                response.sendRedirect(request.getContextPath() + "/customer/account-profile.jsp");
                return;
            }
            customer.setEmail(email);
            customer.setPhone(phone);
            customer.setAddress(address);
            customerDAO.updateCustomer(customer);
            session.setAttribute("account", customer);
            session.setAttribute("success3", "Cập nhật thông tin thành công.");
            response.sendRedirect(request.getContextPath() + "/customer/account-profile.jsp");
        } else {
            Staff staff = (Staff) user;
            StaffDAO staffDAO = new StaffDAO();
            if (!email.equalsIgnoreCase(staff.getEmail()) && staffDAO.emailExists(email)) {
                session.setAttribute("error3", "Email đã được sử dụng bởi người dùng khác.");
                response.sendRedirect(request.getContextPath() + "/staff/template/staff-profile.jsp");
                return;
            }
            if (!phone.equals(staff.getPhone()) && staffDAO.phoneExists(phone)) {
                session.setAttribute("error3", "Số điện thoại đã được sử dụng bởi người dùng khác.");
                response.sendRedirect(request.getContextPath() + "/staff/template/staff-profile.jsp");
                return;
            }
            staff.setEmail(email);
            staff.setPhone(phone);
            staff.setAddress(address);
            staffDAO.updateStaff(staff);
            session.setAttribute("staff", staff);
            session.setAttribute("success3", "Cập nhật thông tin thành công.");
            response.sendRedirect(request.getContextPath() + "/staff/template/staff-profile.jsp");
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
