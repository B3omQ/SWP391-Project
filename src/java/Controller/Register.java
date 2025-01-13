package Controller;

import Dal.AccountDAO;
import Model.Role;
import Validation.AccountValidation;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

public class Register extends HttpServlet {

    private AccountValidation av = new AccountValidation();
    AccountDAO d = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("signup.jsp").forward(request, response);
    }
@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    String fullName = request.getParameter("fullName");
    String password = request.getParameter("password");
    String cPassword = request.getParameter("password2");
    String email = request.getParameter("email");
    String gender = request.getParameter("gender"); 
    String phoneNumber = request.getParameter("phoneNumber"); 
    String address = request.getParameter("address"); 
    String msg = "";

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

    if (!av.checkMatching(password, cPassword)) {
        request.setAttribute("errorPassword2", "Passwords do not match.");
        hasError = true;
    }

    if (phoneNumber == null || phoneNumber.isEmpty()) {
        request.setAttribute("errorPhoneNumber", "Phone number is required.");
        hasError = true;
    }

    if (address == null || address.isEmpty()) {
        request.setAttribute("errorAddress", "Address is required.");
        hasError = true;
    }

    if (hasError) {

        request.getRequestDispatcher("signup.jsp").forward(request, response);
        return;
    }


    if (d.checkAccountExisted(email)) {  
        request.setAttribute("errorEmail", "Email already exists.");
    } else {
 
        Role role = new Role(2, "user");  
        d.Register(fullName, password, gender, phoneNumber, address, email, role);
        request.setAttribute("successMessage", "Sign up successfully!");
    }

    request.getRequestDispatcher("signup.jsp").forward(request, response);
}

}
