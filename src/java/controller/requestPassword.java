package controller;

import dal.DAOTokenForget;
import dal.CustomerDAO;
import dal.StaffDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customer;
import model.Staff;
import model.TokenForgetPassword;

public class requestPassword extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("auth/template/requestPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CustomerDAO daoCustomer = new CustomerDAO();
        StaffDAO daoStaff = new StaffDAO();
        String email = request.getParameter("email");

        // Kiểm tra email trong cả Customer và Staff
        Customer customer = daoCustomer.getCustomerByEmail(email);
        Staff staff = daoStaff.getStaffByEmail(email);

        if (customer == null && staff == null) {
            request.setAttribute("mess", "Email không tồn tại");
            request.getRequestDispatcher("auth/template/requestPassword.jsp").forward(request, response);
            return;
        }

        resetService service = new resetService();
        String token = service.generateToken();
        String linkReset = "http://localhost:9999/BankingSystem/resetPassword?token=" + token;

        // Xác định thông tin người dùng
        int userId = (customer != null) ? customer.getId() : staff.getId();
        String userType = (customer != null) ? "Customer" : "Staff";
        String firstName = (customer != null) ? customer.getFirstname() : staff.getFirstname();

        TokenForgetPassword newTokenForget = new TokenForgetPassword(
                token,
                service.expireDateTime(),
                false,
                userId,
                userType);

        DAOTokenForget daoToken = new DAOTokenForget();
        boolean isInsert = daoToken.insertTokenForget(newTokenForget);
        if (!isInsert) {
            request.setAttribute("mess", "Có lỗi xảy ra trên server");
            request.getRequestDispatcher("auth/template/requestPassword.jsp").forward(request, response);
            return;
        }

        boolean isSend = service.sendEmail(email, linkReset, firstName);
        if (!isSend) {
            request.setAttribute("mess", "Không thể gửi yêu cầu");
            request.getRequestDispatcher("auth/template/requestPassword.jsp").forward(request, response);
            return;
        }

        request.setAttribute("mess", "Yêu cầu đã được gửi thành công");
        request.getRequestDispatcher("auth/template/requestPassword.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}