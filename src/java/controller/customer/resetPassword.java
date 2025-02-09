/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.customer;

import dal.ConsultantDAO;
import dal.DAOTokenForget;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import model.TokenForgetPassword;
import util.AccountValidation;

/**
 *
 * @author emkob
 */
public class resetPassword extends HttpServlet {
     DAOTokenForget DAOToken = new DAOTokenForget();
    ConsultantDAO DAOAccount = new ConsultantDAO();
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
            out.println("<title>Servlet resetPassword</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet resetPassword at " + request.getContextPath () + "</h1>");
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
    String token = request.getParameter("token");
    HttpSession session = request.getSession();
    
    if (token != null) {
        TokenForgetPassword tokenForgetPassword = DAOToken.getTokenPassword(token);
        resetService service = new resetService();
        
        if (tokenForgetPassword == null) {
            request.setAttribute("mess", "Token invalid");
            request.getRequestDispatcher("auth/template/requestPassword.jsp").forward(request, response);
            return;
        }
        
        if (tokenForgetPassword.isIsUsed()) {
            request.setAttribute("mess", "Token is used");
            request.getRequestDispatcher("auth/template/requestPassword.jsp").forward(request, response);
            return;
        }
        
        if (service.isExpireTime(tokenForgetPassword.getExpirytime())) {
            request.setAttribute("mess", "Token is expired");
            request.getRequestDispatcher("auth/template/requestPassword.jsp").forward(request, response);
            return;
        }
        
       Customer account = DAOAccount.getCustomerById(tokenForgetPassword.getUserId());
        
    
        if (account == null) {
            request.setAttribute("mess", "Account not found");
            request.getRequestDispatcher("auth/template/requestPassword.jsp").forward(request, response);
            return;
        }
        
        request.setAttribute("email", account.getEmail());
        session.setAttribute("token", tokenForgetPassword.getToken());
        request.getRequestDispatcher("auth/template/resetPassword.jsp").forward(request, response);
    } else {
        request.getRequestDispatcher("auth/template/requestPassword.jsp").forward(request, response);
    }
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
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirm_password");

    AccountValidation validator = new AccountValidation();

    // Validate password complexity
    if (!validator.checkHashOfPassword(password)) {
        request.setAttribute("mess", "Password must be at least 8 characters long and include an uppercase letter, a lowercase letter, a number, and a special character.");
        request.setAttribute("email", email);
        request.getRequestDispatcher("auth/template/resetPassword.jsp").forward(request, response);
        return;
    }

    // Ensure passwords match
    if (!password.equals(confirmPassword)) {
        request.setAttribute("mess", "Confirmation password does not match.");
        request.setAttribute("email", email);
        request.getRequestDispatcher("auth/template/resetPassword.jsp").forward(request, response);
        return;
    }

    HttpSession session = request.getSession();
    String tokenStr = (String) session.getAttribute("token");
    TokenForgetPassword tokenForgetPassword = DAOToken.getTokenPassword(tokenStr);

    // Validate the token
    resetService service = new resetService();
    if (tokenForgetPassword == null) {
        request.setAttribute("mess", "Invalid token.");
        request.getRequestDispatcher("auth/template/requestPassword.jsp").forward(request, response);
        return;
    }
    if (tokenForgetPassword.isIsUsed()) {
        request.setAttribute("mess", "Token has already been used.");
        request.getRequestDispatcher("auth/template/requestPassword.jsp").forward(request, response);
        return;
    }
    if (service.isExpireTime(tokenForgetPassword.getExpirytime())) {
        request.setAttribute("mess", "Token has expired.");
        request.getRequestDispatcher("auth/template/requestPassword.jsp").forward(request, response);
        return;
    }


    DAOAccount.updatePasswordByEmail(email, password);

    // Mark the token as used
    tokenForgetPassword.setIsUsed(true);
    DAOToken.updateStatus(tokenForgetPassword);

    // Redirect to the login page
     request.setAttribute("success", "Password reset successfully!");
    request.getRequestDispatcher("index.jsp").forward(request, response);
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
