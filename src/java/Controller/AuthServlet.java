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
import jakarta.servlet.http.HttpSession;

public class AuthServlet extends HttpServlet {

    private CustomerDAO customerDAO = new CustomerDAO();
    private StaffDAO staffDAO = new StaffDAO();
    private AccountValidation av = new AccountValidation();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("login".equals(action)) {
            handleLogin(request, response);
        } else if ("changePassword".equals(action)) {
            handleChangePassword(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("logout".equals(action)) {
            handleLogout(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }
private void handleLogin(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String email = request.getParameter("email");
    String passWord = request.getParameter("password");
    String rememberMe = request.getParameter("remember");
    String encodedPassword = av.hashPassword(passWord);

    if (customerDAO.isAccountLocked(email)) {
        request.setAttribute("errorAccount", "Tài khoản của bạn đã bị khóa. Vui lòng thử lại sau 10 phút.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
        return;
    }

    Customer customer = customerDAO.login(email, encodedPassword);

    if (customer != null) {
        customerDAO.resetFailedLogin(email);
        handleRememberMe(response, email, passWord, rememberMe);
        request.getSession().setAttribute("account", customer);
        response.sendRedirect("Customer.jsp");
        return;
    }

    Staff staff = staffDAO.getStaffByUsername(email);
    if (staff != null && staff.getPassword().equals(encodedPassword)) {
        handleRememberMe(response, email, passWord, rememberMe);
        request.getSession().setAttribute("account", staff);
        response.sendRedirect(staff.getRole().getRoleId() == 1 ? "Admin.jsp" : "Customer.jsp");
        return;
    }

    customerDAO.increaseFailedLogin(email);
    if (customerDAO.isAccountLocked(email)) {
        request.setAttribute("errorAccount", "Bạn đã nhập sai mật khẩu quá số lần cho phép. Tài khoản bị khóa trong 10 phút.");
    } else {
        int remainingAttempts = 3 - customerDAO.getFailedAttempts(email);
if (remainingAttempts > 0) {
    request.setAttribute("errorAccount", "Sai email hoặc mật khẩu. Bạn còn " + remainingAttempts + " lần thử.");
} else {
    request.setAttribute("errorAccount", "Bạn đã nhập sai mật khẩu quá số lần cho phép. Tài khoản bị khóa trong 10 phút.");
}

    }
    request.getRequestDispatcher("login.jsp").forward(request, response);
}


    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        request.getSession().invalidate();
        response.sendRedirect("login.jsp");
    }

    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("account");

        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String oldPass = request.getParameter("oldPassword");
        String newPass = request.getParameter("newPassword");
        String retypePass = request.getParameter("retypeNewPassword");

        if (!av.checkPassword(oldPass, customer.getPassword())) {
            request.setAttribute("error", "Mật khẩu cũ không đúng!");
            request.getRequestDispatcher("account-profile.jsp").forward(request, response);
            return;
        }

        if (!newPass.trim().equals(retypePass.trim())) {
            request.setAttribute("error", "Mật khẩu mới không khớp!");
            request.getRequestDispatcher("account-profile.jsp").forward(request, response);
            return;
        }

        if (!av.checkHashOfPassword(newPass)) {
            request.setAttribute("error", "Mật khẩu mới phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt!");
            request.getRequestDispatcher("account-profile.jsp").forward(request, response);
            return;
        }

        String hashedNewPass = av.hashPassword(newPass);
        customerDAO.updatePassword(hashedNewPass, customer.getEmail());

        customer.setPassword(hashedNewPass);
        session.setAttribute("account", customer);

        request.setAttribute("success", "Đổi mật khẩu thành công!");
        request.getRequestDispatcher("account-profile.jsp").forward(request, response);
    }

    private void handleRememberMe(HttpServletResponse response, String email, String password, String rememberMe) {
        if (rememberMe != null) {
            Cookie emailCookie = new Cookie("email", email);
            emailCookie.setMaxAge(60 * 60 * 24 * 7);
            response.addCookie(emailCookie);

            Cookie passWordCookie = new Cookie("password", password);
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
    }
}
