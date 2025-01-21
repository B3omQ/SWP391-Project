package Controller;

import Dal.CustomerDAO;
import Dal.StaffDAO;
import Model.Customer;
import Model.Role;
import Model.Staff;
import Validation.AccountValidation;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class Login extends HttpServlet {

    private CustomerDAO customerDAO = new CustomerDAO();
        private StaffDAO staffDAO = new StaffDAO();

    private AccountValidation av = new AccountValidation();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String passWord = request.getParameter("password");
        String rememberMe = request.getParameter("remember");
        String encodedPassword = av.hashPassword(passWord);

        Customer customer = customerDAO.Login(email, encodedPassword);

        if (customer != null) {
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

            request.getSession().setAttribute("account", customer);
  response.sendRedirect("Customer.jsp");
   return; }
           Staff staff = staffDAO.getStaffByUsername(email);

        if (staff != null && staff.getPassword().equals(encodedPassword)) {
            Role role = staff.getRole();
            if (role != null) {
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

                request.getSession().setAttribute("account", staff);

                switch (role.getRoleId()) {
                    case 1:
                        response.sendRedirect("Admin.jsp");
                        break;
                    case 2:
                        response.sendRedirect("Customer.jsp");
                        break;                
                    default:
                        request.setAttribute("errorAccount", "Invalid role assigned to this account.");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                        break;
                }
                return;
            } else {
                request.setAttribute("errorAccount", "Invalid role assigned to this account.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
        }

        request.setAttribute("errorAccount", "This account does not exist or wrong credentials.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    }

