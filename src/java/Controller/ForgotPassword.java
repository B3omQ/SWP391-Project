package Controller;

import Dal.AccountDAO; 
import Model.Account;
import Validation.AccountValidation; 
import java.io.IOException;
import jakarta.servlet.ServletException;
import java.io.PrintWriter;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author dai
 */
public class ForgotPassword extends HttpServlet {

    private AccountDAO d = new AccountDAO(); 
    private AccountValidation av = new AccountValidation(); 

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ForgotPasswordController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgotPasswordController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("forgot-password.jsp");
    }

   @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        boolean doPasswordsMatch = av.checkMatching(newPassword, confirmPassword);
        boolean isValidPassword = av.checkHashOfPassword(newPassword);

        if (!doPasswordsMatch) {
            request.setAttribute("msg", "New password and confirm password do not match.");
        } else if (!isValidPassword) {
            request.setAttribute("msg", "Password must contain at least 8 characters, including uppercase, lowercase, digit, and special characters.");
        } else {
             Account account = d.getAccountByNameAndPhone(fullName, phoneNumber);
        if (account != null) {
                d.UpdatePassword(newPassword, fullName, phoneNumber);

                request.setAttribute("msg", "Password reset successfully.");
            } else {
                request.setAttribute("msg", "Account with the given name and phone number does not exist.");
            }
        }
        request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
    }

    
}
