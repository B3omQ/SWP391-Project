/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CustomerDAO;
import dal.DepServiceUsedDAO;
import dal.DepHistoryDAO;
import model.Customer;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import model.Staff;

/**
 *
 * @author emkob
 */
public class VerifyingOtp extends HttpServlet {

    private CustomerDAO customerDAO = new CustomerDAO();
    private DepServiceUsedDAO depServiceUsedDAO = new DepServiceUsedDAO();
    private DepHistoryDAO depHistoryDAO = new DepHistoryDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet VerifyingOtp</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerifyingOtp at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userOtp = request.getParameter("otp");
        String generatedOtp = (String) session.getAttribute("otp");

        try {
            String otpChangePass = request.getParameter("otpChangePass");
            if (otpChangePass != null) {
                if (userOtp != null && userOtp.equals(generatedOtp)) {
                    session.removeAttribute("otp");
                    response.sendRedirect("change-email");
                    return;
                } else {
                    session.setAttribute("otpError", "Mã OTP không đúng, vui lòng thử lại!");
                    response.sendRedirect(request.getContextPath() + "/auth/template/otpEmail.jsp");
                    return;
                }
            }

            if (generatedOtp == null) {
                response.sendRedirect("auth/template/login.jsp");
                return;
            }

            if (userOtp != null && userOtp.equals(generatedOtp)) {
                session.removeAttribute("otp");

                // Lấy thông tin tạm từ session và lưu chính thức
                Customer customer = (Customer) session.getAttribute("tempAccount");
                Staff staff = (Staff) session.getAttribute("tempStaff");

                if (customer != null) {
                    session.setAttribute("account", customer);
                    session.setAttribute("userId", customer.getId());
                    session.removeAttribute("tempAccount");
                    response.sendRedirect("home");
                } else if (staff != null) {
                    session.setAttribute("staff", staff);
                    session.setAttribute("staffId", staff.getId());
                    session.removeAttribute("tempStaff");

                    int roleId = staff.getRoleId().getId();
                    switch (roleId) {
                        case 1: 
                            response.sendRedirect("home");
                            break;
                        case 2: 
                            response.sendRedirect("home");
                            break;
                        case 3: 
                            response.sendRedirect("home");
                            break;
                        case 4:
                            response.sendRedirect("loanApproval");
                            break;
                        case 5:
                            response.sendRedirect("");
                            break;
                        default:
                            response.sendRedirect("home");
                            break;
                    }
                } else {
                    response.sendRedirect("auth/template/login.jsp");
                }
            } else {
                session.setAttribute("otpError", "Mã OTP không đúng, vui lòng thử lại!");
                response.sendRedirect(request.getContextPath() + "/auth/template/otp.jsp");
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}