package Controller;

import Dal.AccountDAO; 
import Model.Account;
import Validation.AccountValidation; 
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import java.io.PrintWriter;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author dai
 */


public class ChangePassword extends HttpServlet {

      AccountDAO accountDAO = new AccountDAO();
   AccountValidation accountValidation = new AccountValidation();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Change Password</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Change Password " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("change-password.jsp");
    }

 
   @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Clear any previous message
        request.setAttribute("msg", null);
        request.setAttribute("msg2", null);

        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        Account account = accountDAO.getAccountByNameAndPhone(fullName, phoneNumber);

 
        if (account == null) {
            request.setAttribute("msg", "Account information is incorrect. Please check and try again.");
        } 
        else if (!oldPassword.equals(account.getPassword())) {
            request.setAttribute("msg", "Old password is incorrect.");
        } 

        else if (!accountValidation.checkHashOfPassword(newPassword)) {
            request.setAttribute("msg", "New password must be at least 8 characters long and contain uppercase, lowercase, digit, and special character.");
        } 
        
        else if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("msg", "New password and confirm password do not match.");
        } 
   
        else {
                        String encodedNewPassword = accountValidation.hashPassword(newPassword);

            accountDAO.UpdatePassword(newPassword, fullName, phoneNumber);
            request.setAttribute("msg2", "Password changed successfully.");
        }

        request.getRequestDispatcher("change-password.jsp").forward(request, response);
    }
}
