package controller.customer;

import dal.CustomerDAO;
import dal.StaffDAO;
import java.io.IOException;
import java.util.Random;
import model.Customer;
import model.GoogleAccount;
import model.Staff;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.AccountValidation;

public class AuthServlet extends HttpServlet {

    private CustomerDAO customerDAO = new CustomerDAO();
    private StaffDAO staffDAO = new StaffDAO();
    private AccountValidation av = new AccountValidation();
    private resetService resetService = new resetService();
    private MaturityHandlerServlet maturityHandler = new MaturityHandlerServlet(); 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("loginGG".equals(action)) {
            String googleCode = request.getParameter("code");
            if (googleCode != null) {
                try {
                    String accessToken = GoogleLogin.getToken(googleCode);
                    GoogleAccount googleAccount = GoogleLogin.getUserInfo(accessToken);
                    String email = googleAccount.getEmail();

                    boolean emailExists = customerDAO.emailExists(email) || staffDAO.emailExists(email);
                    if (!emailExists) {
                        request.getSession().setAttribute("errorAccount", "Tài khoản chưa tồn tại.");
                        response.sendRedirect("auth/template/login.jsp");
                        return;
                    }

                    Customer customer = customerDAO.getCustomerByEmail(email);
                    Staff staff = staffDAO.getStaffByEmail(email);
                    HttpSession session = request.getSession();

                    if (customer != null) {
                        session.setAttribute("account", customer);
                        session.setAttribute("userId", customer.getId());

                        // Gọi handler để xử lý đáo hạn
                        maturityHandler.processMaturedDeposits(customer, session);

                        response.sendRedirect("customer/Customer.jsp");
                        return;
                    } else if (staff != null) {
                        session.setAttribute("staff", staff);
                        session.setAttribute("staffId", staff.getId());
                        response.sendRedirect("staff/template/Staff.jsp");
                        return;
                    }

                } catch (Exception e) {
                    request.getSession().setAttribute("errorAccount", "Đăng nhập Google thất bại.");
                    response.sendRedirect("auth/template/login.jsp");
                }
            } else {
                response.sendRedirect("auth/template/login.jsp");
            }
        } else {
            response.sendRedirect("auth/template/login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("logout".equals(action)) {
            handleLogout(request, response);
        } else if ("login".equals(action)) {
            handleLogin(request, response);
        } else if ("changePassword".equals(action)) {
            handleChangePassword(request, response);
        } else {
            response.sendRedirect("auth/template/login.jsp");
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String passWord = request.getParameter("password");
        String rememberMe = request.getParameter("remember");
        HttpSession session = request.getSession();

        if (email == null || passWord == null) {
            session.setAttribute("errorAccount", "Vui lòng nhập email và mật khẩu.");
            response.sendRedirect("auth/template/login.jsp");
            return;
        }

        if (isAccountLocked(email)) {
            session.setAttribute("errorAccount", "Tài khoản của bạn đã bị khóa. Vui lòng thử lại sau 10 phút.");
            response.sendRedirect("auth/template/login.jsp");
            return;
        }

        boolean emailExists = customerDAO.emailExists(email) || staffDAO.emailExists(email);
        if (!emailExists) {
            session.setAttribute("errorAccount", "Tài khoản không tồn tại.");
            response.sendRedirect("auth/template/login.jsp");
            return;
        }

        Customer customer = customerDAO.login(email, passWord);
        Staff staff = staffDAO.login(email, passWord);

        if (customer != null && av.checkPassword(passWord, customer.getPassword())) {
            session.setAttribute("account", customer);
            session.setAttribute("userId", customer.getId());

            String otp = String.format("%06d", new Random().nextInt(999999));
            session.setAttribute("otp", otp);
            session.setAttribute("email", email);

            String otpMessage = "Mã OTP của bạn là: " + otp + ". OTP có hiệu lực trong 10 phút.";
            resetService.sendOtpEmail(email, otpMessage, customer.getFirstname());

            response.sendRedirect("auth/template/otp.jsp");
            return;
        }

        if (staff != null && av.checkPassword(passWord, staff.getPassword())) {
            session.setAttribute("staff", staff);
            session.setAttribute("staffId", staff.getId());

            String otp = resetService.generateOTP();
            session.setAttribute("otp", otp);
            session.setAttribute("email", email);

            String otpMessage = "Mã OTP của bạn là: " + otp + ". OTP có hiệu lực trong 10 phút.";
            resetService.sendOtpEmail(email, otpMessage, staff.getFirstname());

            response.sendRedirect("auth/template/otp.jsp");
            return;
        }

        int failedAttempts = customerDAO.getFailedAttempts(email);
        if (failedAttempts == 0) {
            failedAttempts = staffDAO.getFailedAttempts(email);
        }

        if (isAccountLocked(email)) {
            session.setAttribute("errorAccount", "Bạn đã nhập sai mật khẩu quá số lần cho phép. Tài khoản bị khóa trong 10 phút.");
        } else {
            int remainingAttempts = 6 - failedAttempts;
            session.setAttribute("errorAccount", "Sai mật khẩu. Bạn còn " + remainingAttempts + " lần thử.");
        }
        response.sendRedirect("auth/template/login.jsp");
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.getSession().invalidate();
        response.sendRedirect("auth/template/login.jsp");
    }

    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("auth/template/login.jsp");
            return;
        }

        Customer customer = (Customer) session.getAttribute("account");
        Staff staff = (Staff) session.getAttribute("staff");
        boolean isCustomer = customer != null;

        if (customer == null && staff == null) {
            response.sendRedirect("auth/template/login.jsp");
            return;
        }

        String profilePage = isCustomer ? "customer/account-profile.jsp" : "staff/staff-profile.jsp";

        String oldPass = request.getParameter("oldPassword");
        String newPass = request.getParameter("newPassword");
        String retypePass = request.getParameter("retypeNewPassword");

        if (oldPass == null || newPass == null || retypePass == null) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin.");
            request.getRequestDispatcher(profilePage).forward(request, response);
            return;
        }

        String storedPassword = isCustomer ? customer.getPassword() : staff.getPassword();

        if (!av.checkPassword(oldPass, storedPassword)) {
            request.setAttribute("error", "Mật khẩu cũ không đúng!");
            request.getRequestDispatcher(profilePage).forward(request, response);
            return;
        }

        if (!newPass.trim().equals(retypePass.trim())) {
            request.setAttribute("error", "Mật khẩu mới không khớp!");
            request.getRequestDispatcher(profilePage).forward(request, response);
            return;
        }

        if (!av.checkHashOfPassword(newPass)) {
            request.setAttribute("error", "Mật khẩu mới phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt!");
            request.getRequestDispatcher(profilePage).forward(request, response);
            return;
        }

        String hashedNewPass = av.hashPassword(newPass);
        if (isCustomer) {
            customerDAO.updatePassword(hashedNewPass, customer.getEmail());
            customer.setPassword(hashedNewPass);
            session.setAttribute("account", customer);
        } else {
            staffDAO.updatePassword(hashedNewPass, staff.getEmail());
            staff.setPassword(hashedNewPass);
            session.setAttribute("staff", staff);
        }

        request.setAttribute("success", "Đổi mật khẩu thành công!");
        request.getRequestDispatcher(profilePage).forward(request, response);
    }

    private boolean isAccountLocked(String email) {
        return customerDAO.isAccountLocked(email) || staffDAO.isAccountLocked(email);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}