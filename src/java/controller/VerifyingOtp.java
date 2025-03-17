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
            out.println("<title>Servlet VerifyingOtp</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerifyingOtp at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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
                }
            }

            if (generatedOtp == null) {
                response.sendRedirect("auth/template/login.jsp");
                return;
            }

            if (userOtp != null && userOtp.equals(generatedOtp)) {
                session.removeAttribute("otp");
                if (session.getAttribute("staff") != null) {
                    Staff staff = (Staff) session.getAttribute("staff");
                    if (staff.getRoleId().getId() == 1) {
                        response.sendRedirect("accountant/home.jsp");
                    }
                    if (staff.getRoleId().getId() == 2) {
                        response.sendRedirect("");
                    }
                    if (staff.getRoleId().getId() == 3) {
                        response.sendRedirect("profile-manager");
                    }
                    if (staff.getRoleId().getId() == 4) {
                        response.sendRedirect("profile-admin");
                    }
                    if (staff.getRoleId().getId() == 5) {
                        response.sendRedirect("");
                    }
                } else {
                    response.sendRedirect("customer/template/Customer.jsp");
                }
            } else {
                session.setAttribute("otpError", "Mã OTP không đúng, vui lòng thử lại!");
                response.sendRedirect(request.getContextPath() + "/auth/template/otp.jsp");
            }

            if (userOtp != null && userOtp.equals(generatedOtp)) {
                session.removeAttribute("otp");

                if (session.getAttribute("staff") != null) {
                    // Staff không có tiết kiệm, chuyển hướng thẳng
                    response.sendRedirect("profile-manager");
                } else {
                    // Customer: Xử lý đáo hạn trước khi chuyển hướng
                    Customer customer = (Customer) session.getAttribute("account");
                    if (customer != null) {
                    }
                    response.sendRedirect("customer/Customer.jsp");
                }
            } else {
                session.setAttribute("otpError", "Mã OTP không đúng, vui lòng thử lại!");
                response.sendRedirect(request.getContextPath() + "/auth/template/otp.jsp");
            }
        }catch(Exception e) {
            System.out.println(e);
        }
    }

}
