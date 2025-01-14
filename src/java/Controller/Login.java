package Controller;

import Dal.AccountDAO;
import Model.Account;
import Validation.AccountValidation;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class Login extends HttpServlet {

    private AccountDAO d = new AccountDAO();  
    private AccountValidation av = new AccountValidation(); 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String passWord = request.getParameter("password");
        String rememberMe = request.getParameter("remember");
        String encodedPassword = av.hashPassword(passWord);

     
        Account account = d.Login(email, encodedPassword);  

        if (account != null) {
       
            if (rememberMe != null) {
                Cookie emailCookie = new Cookie("email", email);
                emailCookie.setMaxAge(60 * 60 * 24 * 7);  
                response.addCookie(emailCookie);

                Cookie passWordCookie = new Cookie("password", passWord);
                passWordCookie.setMaxAge(60 * 60 * 24 * 7);
                response.addCookie(passWordCookie);
            } else {
                
                Cookie emailCookie = new Cookie("email", "");
                emailCookie.setMaxAge(0);
                response.addCookie(emailCookie);

                Cookie passWordCookie = new Cookie("password", "");
                passWordCookie.setMaxAge(0);
                response.addCookie(passWordCookie);
            }

           
            request.getSession().setAttribute("account", account);

  
            if (account.getRole().getRoleId() == 1) { 
                response.sendRedirect("staff.jsp");
            } else if (account.getRole().getRoleId() == 2) { 
                response.sendRedirect("Customer.jsp");
            } else if (account.getRole().getRoleId() == 3) { 
                response.sendRedirect("Admin.jsp");
            } else {

                request.setAttribute("errorAccount", "Invalid role assigned to this account.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else {

            request.setAttribute("errorAccount", "This account does not exist or wrong credentials.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
