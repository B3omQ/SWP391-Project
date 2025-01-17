/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dal.AccountDAO;
import Model.Account;
import Model.Role;
import Validation.AccountValidation;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Long
 */
@WebServlet(name = "AddUser", urlPatterns = {"/addUser"})
public class AddUser extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        AccountValidation av = new AccountValidation();
        AccountDAO a = new AccountDAO();
        String fullName = request.getParameter("fullName");
        String password = request.getParameter("pass");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String role = request.getParameter("role");

        boolean hasError = false;

        if (fullName == null || fullName.isEmpty()) {
            request.setAttribute("errorFullName", "Full name is required.");
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
            request.setAttribute("errorPhoneNumber", "Phone number is required.");
            hasError = true;
        }

        if (address == null || address.isEmpty()) {
            request.setAttribute("errorAddress", "Address is required.");
            hasError = true;
        }

        if (hasError) {
            request.getRequestDispatcher("addUser.jsp").forward(request, response);
            return;
        }

        if (a.checkAccountExisted(email)) {
            request.setAttribute("errorEmail", "Email already exists.");
            request.getRequestDispatcher("addUser.jsp").forward(request, response);
        } else {
            Role r = new Role(10, role);
            a.addUser(fullName, password, gender, phone, address, email, r);
            request.setAttribute("successMessage", "Add successfully!");
            response.sendRedirect("userManager");
        }

    }

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
        processRequest(request, response);
    }

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
        processRequest(request, response);
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
