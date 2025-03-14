/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import controller.sendNotificationEmail;
import dal.CustomerDAO;
import dal.LoanServiceUsedDAO;
import dal.NotifyDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.List;
import model.LoanServiceUsed;

/**
 *
 * @author JIGGER
 */
public class CustomerLoanServiceManagement extends HttpServlet {

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
        String pageParam = request.getParameter("page");
        String status = request.getParameter("pendingStatus");
        String phone = request.getParameter("phoneSearch");
        LoanServiceUsedDAO ludao = new LoanServiceUsedDAO();

        if (status == null || status.trim().isEmpty()) {
            status = "Pending";
        }

        try {
            int page = (pageParam == null) ? 1 : Integer.parseInt(pageParam);
            int recordsPerPage;
            int totalRecords = ludao.totalLoanServiceUsed(status);

            if (totalRecords <= 5) {
                recordsPerPage = 5;
            } else if (totalRecords <= 50) {
                recordsPerPage = totalRecords * 50 / 100;
            } else if (totalRecords <= 100) {
                recordsPerPage = totalRecords * 30 / 100;
            } else if (totalRecords <= 300) {
                recordsPerPage = totalRecords * 20 / 100;
            } else {
                recordsPerPage = totalRecords * 10 / 100;
            }

            int offset = (page - 1) * recordsPerPage;
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

            List<LoanServiceUsed> loanList = ludao.getLoanServiceUsed(offset, recordsPerPage, status, phone);
            request.setAttribute("loanList", loanList);
            request.setAttribute("currentPhoneSearch", phone);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentRecords", recordsPerPage);
            request.setAttribute("currentStatus", status);
        } catch (NumberFormatException ex) {
        }

        request.getRequestDispatcher("./manager/customerLoanManager.jsp").forward(request, response);
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
        String update = request.getParameter("updateId");
        String delete = request.getParameter("deleteId");
        String status = request.getParameter("status");
        LoanServiceUsedDAO ldao = new LoanServiceUsedDAO();
        NotifyDAO ndao = new NotifyDAO();
        sendNotificationEmail sendEmail = new sendNotificationEmail();
        CustomerDAO cdao = new CustomerDAO();
        if (update != null) {
            try {
                int loanId = Integer.parseInt(update);
                int customerId = Integer.parseInt(request.getParameter("customerId"));
                if ("Approved".equalsIgnoreCase(status)) {
                    String description = "Quản trị viên đã ghi nhận thông tin gói vay của bạn, vui lòng chờ phản hồi mới nhất của chúng tôi";
                    sendEmail.sendNotify(cdao.getCustomerById(customerId).getEmail(), description, cdao.getCustomerById(customerId).getFirstname());
                    ndao.insertNotificationForCustomer(customerId, description, 3);
                    ldao.updateLoanServiceUsedStatus(loanId, status);
                }
                if ("Denied".equalsIgnoreCase(status)) {
                    String description = "Quản trị viên đã từ chối thông tin gói vay của bạn, vui lòng kiểm tra lại thông tin giấy tờ theo đúng quy chuẩn";
                    sendEmail.sendNotify(cdao.getCustomerById(customerId).getEmail(), description, cdao.getCustomerById(customerId).getFirstname());
                    ndao.insertNotificationForCustomer(customerId, description, 3);
                    ldao.updateLoanServiceUsedStatus(loanId, status);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (delete != null) {
            try {
                int deleteId = Integer.parseInt("delete");

            } catch (Exception e) {

            }
        }
        doGet(request, response);
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
