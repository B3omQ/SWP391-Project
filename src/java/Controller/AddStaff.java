/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import Dal.StaffDAO;
import Model.Staff;
import Validation.AccountValidation;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;

/**
 *
 * @author Long
 */
public class AddStaff extends HttpServlet {
   
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
            out.println("<title>Servlet AddStaff</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddStaff at " + request.getContextPath () + "</h1>");
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
        AccountValidation av = new AccountValidation();
        StaffDAO a = new StaffDAO();

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String salaryStr = request.getParameter("salary");
        String role = request.getParameter("role");
        

        boolean hasError = false;

// Kiểm tra lỗi cho các trường
        if (username == null || username.isEmpty()) {
            request.setAttribute("errorUsername", "Username is required.");
            hasError = true;
        }

        if (firstName == null || firstName.isEmpty()) {
            request.setAttribute("errorFirstName", "First name is required.");
            hasError = true;
        }

        if (lastName == null || lastName.isEmpty()) {
            request.setAttribute("errorLastName", "Last name is required.");
            hasError = true;
        }

        if (email == null || email.isEmpty()) {
            request.setAttribute("errorEmail", "Email is required.");
            hasError = true;
        }

        if (password == null || password.isEmpty()) {
            request.setAttribute("errorPassword", "Password is required.");
            hasError = true;
        } else if (!av.checkHashOfPassword(password)) {
            request.setAttribute("errorPassword", "Password must be at least 8 characters and contain uppercase, lowercase, digit, and special character.");
            hasError = true;
        }

        if (phone == null || phone.isEmpty()) {
            request.setAttribute("errorPhone", "Phone number is required.");
            hasError = true;
        }

        if (address == null || address.isEmpty()) {
            request.setAttribute("errorAddress", "Address is required.");
            hasError = true;
        }

        if (salaryStr == null || salaryStr.isEmpty()) {
            request.setAttribute("errorSalary", "Salary amount is required.");
            hasError = true;
        }

// Nếu có lỗi, quay lại trang
        if (hasError) {
            request.getRequestDispatcher("staff-management.jsp").forward(request, response);
            return;
        }

// Kiểm tra xem tài khoản đã tồn tại chưa
        if (a.getStaffByEmail(email)!= null) {
            request.setAttribute("errorEmail", "Email already exists.");
            request.getRequestDispatcher("addStaff.jsp").forward(request, response);
        } else {
            BigDecimal salary = new BigDecimal(salaryStr);
            String encodedPassword = av.hashPassword(password);           
            a.addStaff(username, password, email, firstName, lastName, phone, address, salary, role);
            request.setAttribute("successMessage", "Add successfully!");
            response.sendRedirect("staffManagement");
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
