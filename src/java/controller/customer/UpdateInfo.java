package controller.customer;

import dal.CustomerDAO;
import dal.StaffDAO;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import model.Staff;
import util.AccountValidation;

public class UpdateInfo extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
            return;
        }

        Object user = session.getAttribute("account");
        boolean isCustomer = true;
        if (user == null) {
            user = session.getAttribute("staff");
            isCustomer = false;
        }
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
            return;
        }

        // Lấy dữ liệu từ form
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String dobStr = request.getParameter("dob");
        String address = request.getParameter("address");

        AccountValidation validator = new AccountValidation();

        if (!validator.isValidName(firstName)) {
            session.setAttribute("error3", "Tên không hợp lệ. Tên chỉ được chứa chữ cái và khoảng trắng.");
            response.sendRedirect(request.getContextPath() + "/customer/account-profile.jsp");
            return;
        }
        if (!validator.isValidName(lastName)) {
            session.setAttribute("error3", "Họ không hợp lệ. Họ chỉ được chứa chữ cái và khoảng trắng.");
            response.sendRedirect(request.getContextPath() + "/customer/account-profile.jsp");
            return;
        }

        if (!validator.isValidEmail(email)) {
            session.setAttribute("error3", "Email không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/customer/account-profile.jsp");
            return;
        }

        if (!validator.isValidPhone(phone)) {
            session.setAttribute("error3", "Số điện thoại không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/customer/account-profile.jsp");
            return;
        }

        // Kiểm tra giới tính
        if (!validator.isValidGender(gender)) {
            session.setAttribute("error3", "Giới tính không hợp lệ. Vui lòng chọn Nam, Nữ hoặc Khác.");
            response.sendRedirect(request.getContextPath() + "/customer/account-profile.jsp");
            return;
        }

        // Kiểm tra ngày sinh
        LocalDate dob = null;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date date = sdf.parse(dobStr);
            dob = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            if (!validator.isValidDateOfBirth(dob)) {
                session.setAttribute("error3", "Ngày sinh không hợp lệ. Bạn phải trên 18 tuổi.");
                response.sendRedirect(request.getContextPath() + "/customer/account-profile.jsp");
                return;
            }
        } catch (ParseException e) {
            session.setAttribute("error3", "Ngày sinh không hợp lệ. Vui lòng nhập đúng định dạng (yyyy-MM-dd).");
            response.sendRedirect(request.getContextPath() + "/customer/account-profile.jsp");
            return;
        }

        // Kiểm tra địa chỉ
        if (!validator.isValidAddress(address)) {
            session.setAttribute("error3", "Địa chỉ không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/customer/account-profile.jsp");
            return;
        }

        if (isCustomer) {
            Customer customer = (Customer) user;
            CustomerDAO customerDAO = new CustomerDAO();

            if (!email.equalsIgnoreCase(customer.getEmail()) && customerDAO.emailExists(email)) {
                session.setAttribute("error3", "Email đã được sử dụng bởi người dùng khác.");
                response.sendRedirect(request.getContextPath() + "/customer/account-profile.jsp");
                return;
            }
            if (!phone.equals(customer.getPhone()) && customerDAO.phoneExists(phone)) {
                session.setAttribute("error3", "Số điện thoại đã được sử dụng bởi người dùng khác.");
                response.sendRedirect(request.getContextPath() + "/customer/account-profile.jsp");
                return;
            }

            customer.setFirstname(firstName);
            customer.setLastname(lastName);
            customer.setEmail(email);
            customer.setPhone(phone);
            customer.setGender(gender);
            customer.setDob(dob); 
            customer.setAddress(address);

            customerDAO.updateCustomer(customer);
            session.setAttribute("account", customer);
            session.setAttribute("success3", "Cập nhật thông tin thành công.");
            response.sendRedirect(request.getContextPath() + "/customer/account-profile.jsp");
        } else {
            Staff staff = (Staff) user;
            StaffDAO staffDAO = new StaffDAO();

            if (!email.equalsIgnoreCase(staff.getEmail()) && staffDAO.emailExists(email)) {
                session.setAttribute("error3", "Email đã được sử dụng bởi người dùng khác.");
                response.sendRedirect(request.getContextPath() + "/staff/template/staff-profile.jsp");
                return;
            }
            if (!phone.equals(staff.getPhone()) && staffDAO.phoneExists(phone)) {
                session.setAttribute("error3", "Số điện thoại đã được sử dụng bởi người dùng khác.");
                response.sendRedirect(request.getContextPath() + "/staff/template/staff-profile.jsp");
                return;
            }

            staff.setFirstname(firstName);
            staff.setLastname(lastName);
            staff.setEmail(email);
            staff.setPhone(phone);
            staff.setGender(gender);
            staff.setDob(dob);
            staff.setAddress(address);

            staffDAO.updateStaff(staff);
            session.setAttribute("staff", staff);
            session.setAttribute("success3", "Cập nhật thông tin thành công.");
            response.sendRedirect(request.getContextPath() + "/staff/template/staff-profile.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet to update user information";
    }
}