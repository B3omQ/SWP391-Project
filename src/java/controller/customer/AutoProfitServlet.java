package controller.customer;

import dal.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Customer;

public class AutoProfitServlet extends HttpServlet {

    private final CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("account");

        if (customer == null) {
            response.sendRedirect("auth/template/login.jsp");
            return;
        }

        // Đồng bộ trạng thái từ DB
        customer = customerDAO.getCustomerById(customer.getId());
        if (customer != null) {
            session.setAttribute("account", customer);
            System.out.println("Debug: isAutoProfitEnabled = " + customer.isAutoProfitEnabled());
        } else {
            session.setAttribute("account", null);
            response.sendRedirect("auth/template/login.jsp");
            return;
        }

        request.getRequestDispatcher("/customer/auto-profit-intro.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("account");

        if (customer == null) {
            response.sendRedirect("auth/template/login.jsp");
            return;
        }

        String confirm = request.getParameter("confirm");

        if ("yes".equals(confirm)) {
            boolean success = customerDAO.setAutoProfitEnabled(customer.getId(), true);
            if (success) {
                customer.setAutoProfitEnabled(true);
                request.setAttribute("message", "Chức năng sinh lời tự động đã được bật thành công!");
            } else {
                request.setAttribute("error", "Lỗi khi bật chức năng sinh lời tự động. Vui lòng thử lại sau!");
            }
        } else if ("no".equals(confirm)) {
            boolean success = customerDAO.setAutoProfitEnabled(customer.getId(), false);
            if (success) {
                customer.setAutoProfitEnabled(false);
                request.setAttribute("message", "Chức năng sinh lời tự động đã được tắt thành công!");
            } else {
                request.setAttribute("error", "Lỗi khi tắt chức năng sinh lời tự động. Vui lòng thử lại sau!");
            }
        } else {
            request.setAttribute("error", "Yêu cầu không hợp lệ!");
        }

        customer = customerDAO.getCustomerById(customer.getId());
        if (customer != null) {
            session.setAttribute("account", customer);
            System.out.println("Debug: isAutoProfitEnabled after update = " + customer.isAutoProfitEnabled());
        }

        request.getRequestDispatcher("/customer/auto-profit-result.jsp").forward(request, response);
    }
}