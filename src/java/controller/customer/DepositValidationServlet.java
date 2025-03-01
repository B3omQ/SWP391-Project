/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.customer;

import dal.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;

/**
 *
 * @author emkob
 */
public class DepositValidationServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet DepositValidationServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DepositValidationServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
          HttpSession session = request.getSession(false);
            if (session == null) {
                response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
                return;
            }
        Integer userId = (Integer) session.getAttribute("userId");
            System.out.println(userId);
        CustomerDAO customerDao = new CustomerDAO();

        // Lấy số dư từ database (BigDecimal)
        BigDecimal accountBalance = customerDao.getWalletByCustomerId(userId);
        System.out.println("User ID từ session: " + userId);
        System.out.println("Số dư lấy từ DB: " + accountBalance);

        // Lưu số dư vào session
        session.setAttribute("wallet", accountBalance);

        // Lấy số tiền nhập từ form
        String amountStr = request.getParameter("depositAmount");
        BigDecimal amount;

        try {
            amount = new BigDecimal(amountStr);
        } catch (NumberFormatException e) {
            session.setAttribute("error4", "Số tiền không hợp lệ!");
            response.sendRedirect("customer/savemoney.jsp");
            return;
        }

        // Ngưỡng tối thiểu gửi tiết kiệm (1 triệu VND)
        BigDecimal minAmount = new BigDecimal("1000000");

        // Kiểm tra số tiền nhập vào
        if (amount.compareTo(minAmount) < 0) {
            session.setAttribute("error4", "Số tiền phải từ 1,000,000 VND trở lên!");
            response.sendRedirect("customer/savemoney.jsp");
        } else if (amount.compareTo(accountBalance) > 0) {
            session.setAttribute("error4", "Số dư không đủ để gửi tiết kiệm!");
            response.sendRedirect("customer/savemoney.jsp");
        } else {
              session.setAttribute("depositAmount", amount);
              System.out.println("Số tiền gửi tiết kiệm được lưu vào session: " + session.getAttribute("depositAmount"));

response.sendRedirect(request.getContextPath() + "/Calculation");
        }
    }






        /** 
         * Returns a short description of the servlet.
         * @return a String containing servlet description
         */
        @Override
        public String getServletInfo() {
            return "Short description";
        }// </editor-fold>

    }
