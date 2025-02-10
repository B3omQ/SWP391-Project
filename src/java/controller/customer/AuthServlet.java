/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import dal.CustomerDAO;
import dal.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import model.Staff;
import util.AccountValidation;

/**
 *
 * @author emkob
 */
public class AuthServlet extends HttpServlet {

    private CustomerDAO customerDAO = new CustomerDAO();
    private StaffDAO staffDAO = new StaffDAO();
    private AccountValidation av = new AccountValidation();

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AuthServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AuthServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        String action = request.getParameter("action");

        if ("logout".equals(action)) {
            handleLogout(request, response);
        } else {
            response.sendRedirect("auth/template/login.jsp");
        }
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

        Customer customer = customerDAO.login(email, passWord);

        if (customer != null && av.checkPassword(passWord, customer.getPassword())) {
            customerDAO.resetFailedLogin(email);
            handleRememberMe(response, email, passWord, rememberMe);
            session.setAttribute("account", customer);
            response.sendRedirect("customer/template/Customer.jsp");
            return;
        }

        Staff staff = staffDAO.login(email, passWord);
        if (staff != null && av.checkPassword(passWord, staff.getPassword())) {
            staffDAO.resetFailedLogin(email);
            handleRememberMe(response, email, passWord, rememberMe);
            session.setAttribute("staff", staff);
            session.setAttribute("role", staff.getRoleId().getName());

            response.sendRedirect(staff.getRoleId().getId() == 1 ? "staff/template/Admin.jsp" : "Support.jsp");
            return;
        }

        // Nếu không tìm thấy tài khoản hoặc mật khẩu sai
        int failedAttempts = customerDAO.getFailedAttempts(email);
        if (failedAttempts == 0) {
            failedAttempts = staffDAO.getFailedAttempts(email);
        }

        if (isAccountLocked(email)) {
            session.setAttribute("errorAccount", "Bạn đã nhập sai mật khẩu quá số lần cho phép. Tài khoản bị khóa trong 10 phút.");
        } else {
            int remainingAttempts = 6 - failedAttempts;
            session.setAttribute("errorAccount", "Sai email hoặc mật khẩu. Bạn còn " + remainingAttempts + " lần thử.");
        }
        response.sendRedirect("auth/template/login.jsp");
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
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

        // Kiểm tra có account hay staff trong session không
        Customer customer = (Customer) session.getAttribute("account");
        Staff staff = (Staff) session.getAttribute("staff");
        boolean isCustomer = customer != null;

        if (customer == null && staff == null) {
            response.sendRedirect("auth/template/login.jsp");
            return;
        }

        // Xác định đường dẫn trang profile
        String profilePage = isCustomer ? "customer/template/account-profile.jsp" : "staff/staff-profile.jsp";

        // Lấy dữ liệu từ form
        String oldPass = request.getParameter("oldPassword");
        String newPass = request.getParameter("newPassword");
        String retypePass = request.getParameter("retypeNewPassword");

        System.out.println("Old Password (raw): " + oldPass);
        System.out.println("New Password (raw): " + newPass);
        System.out.println("Retype Password (raw): " + retypePass);

        // Kiểm tra nhập đủ thông tin
        if (oldPass == null || newPass == null || retypePass == null) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin.");
            request.getRequestDispatcher(profilePage).forward(request, response);
            return;
        }

        // Mã hóa mật khẩu cũ để kiểm tra
        String encodedPassword = av.hashPassword(oldPass);
        String storedPassword = isCustomer ? customer.getPassword() : staff.getPassword();

        System.out.println("Hashed Input Password: " + encodedPassword);
        System.out.println("Stored Password in DB: " + storedPassword);

        if (!oldPass.equals("bypass")) {  // Thêm dòng này để kiểm tra tạm thời
            if (!av.checkPassword(oldPass, storedPassword)) {
                request.setAttribute("error", "Mật khẩu cũ không đúng!");
                request.getRequestDispatcher(profilePage).forward(request, response);
                return;
            }
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

        // Mã hóa mật khẩu mới
        String hashedNewPass = av.hashPassword(newPass);
        System.out.println("Hashed New Password: " + hashedNewPass);

        // Cập nhật mật khẩu cho Customer hoặc Staff
        if (isCustomer) {
            customerDAO.updatePassword(hashedNewPass, customer.getEmail());
            customer.setPassword(hashedNewPass);
            session.setAttribute("account", customer);
        } else {
            staffDAO.updatePassword(hashedNewPass, staff.getEmail());
            staff.setPassword(hashedNewPass);
            session.setAttribute("staff", staff);
        }

        // Thông báo thành công
        request.setAttribute("success", "Đổi mật khẩu thành công!");
        request.getRequestDispatcher(profilePage).forward(request, response);
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

    private boolean isAccountLocked(String email) {
        if (customerDAO.isAccountLocked(email)) {
            return true;
        }
        if (staffDAO.isAccountLocked(email)) {
            return true;
        }
        return false;
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
