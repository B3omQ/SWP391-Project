package controller;

import dal.CustomerDAO;
import dal.DAOTokenForget;
import dal.StaffDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import model.Staff;
import model.TokenForgetPassword;
import util.AccountValidation;

public class resetPassword extends HttpServlet {

    DAOTokenForget DAOToken = new DAOTokenForget();
    CustomerDAO DAOAccount = new CustomerDAO();
    StaffDAO DAOStaff = new StaffDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");
        HttpSession session = request.getSession();

        if (token != null) {
            TokenForgetPassword tokenForgetPassword = DAOToken.getTokenPassword(token);
            resetService service = new resetService();

            if (tokenForgetPassword == null) {
                request.setAttribute("mess", "Token không hợp lệ");
                request.getRequestDispatcher("auth/template/resetPassword.jsp").forward(request, response);
                return;
            }

            if (tokenForgetPassword.isIsUsed()) {
                request.setAttribute("mess", "Token đã được sử dụng");
                request.getRequestDispatcher("auth/template/resetPassword.jsp").forward(request, response);
                return;
            }

            if (service.isExpireTime(tokenForgetPassword.getExpiryTime())) {
                request.setAttribute("mess", "Token đã hết hạn");
                request.getRequestDispatcher("auth/template/resetPassword.jsp").forward(request, response);
                return;
            }

            String userType = tokenForgetPassword.getUserType();
            String email;
            if ("Customer".equals(userType)) {
                Customer account = DAOAccount.getCustomerById(tokenForgetPassword.getUserId());
                if (account == null) {
                    request.setAttribute("mess", "Tài khoản không tồn tại");
                    request.getRequestDispatcher("auth/template/resetPassword.jsp").forward(request, response);
                    return;
                }
                email = account.getEmail();
            } else if ("Staff".equals(userType)) {
                Staff staff = DAOStaff.getStaffById(tokenForgetPassword.getUserId());
                if (staff == null) {
                    request.setAttribute("mess", "Tài khoản không tồn tại");
                    request.getRequestDispatcher("auth/template/resetPassword.jsp").forward(request, response);
                    return;
                }
                email = staff.getEmail();
            } else {
                request.setAttribute("mess", "Loại tài khoản không hợp lệ");
                request.getRequestDispatcher("auth/template/resetPassword.jsp").forward(request, response);
                return;
            }

            request.setAttribute("email", email);
            session.setAttribute("token", tokenForgetPassword.getToken());
            request.getRequestDispatcher("auth/template/resetPassword.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("auth/template/resetPassword.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");

        AccountValidation validator = new AccountValidation();

        if (!validator.checkHashOfPassword(password)) {
            request.setAttribute("mess", "Mật khẩu phải dài ít nhất 8 ký tự và bao gồm chữ cái in hoa, thường, số và ký tự đặc biệt.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("auth/template/resetPassword.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("mess", "Mật khẩu xác nhận không khớp.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("auth/template/resetPassword.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        String tokenStr = (String) session.getAttribute("token");
        TokenForgetPassword tokenForgetPassword = DAOToken.getTokenPassword(tokenStr);

        resetService service = new resetService();
        if (tokenForgetPassword == null) {
            request.setAttribute("mess", "Token không hợp lệ.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("auth/template/resetPassword.jsp").forward(request, response);
            return;
        }
        if (tokenForgetPassword.isIsUsed()) {
            request.setAttribute("mess", "Token đã được sử dụng.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("auth/template/resetPassword.jsp").forward(request, response);
            return;
        }
        if (service.isExpireTime(tokenForgetPassword.getExpiryTime())) {
            request.setAttribute("mess", "Token đã hết hạn.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("auth/template/resetPassword.jsp").forward(request, response);
            return;
        }

        // Cập nhật mật khẩu dựa trên UserType
        String userType = tokenForgetPassword.getUserType();
        if ("Customer".equals(userType)) {
            DAOAccount.updatePasswordByEmail(email, password);
        } else if ("Staff".equals(userType)) {
            DAOStaff.updatePasswordByEmail(email, password);
        } else {
            request.setAttribute("mess", "Loại tài khoản không hợp lệ.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("auth/template/resetPassword.jsp").forward(request, response);
            return;
        }

        tokenForgetPassword.setIsUsed(true);
        DAOToken.updateStatus(tokenForgetPassword);

        request.setAttribute("success", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập lại.");
        request.getRequestDispatcher("auth/template/resetPassword.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}