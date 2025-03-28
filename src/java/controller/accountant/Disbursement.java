/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.accountant;

import controller.sendNotificationEmail;
import dal.LoanServiceUsedDAO;
import dal.CustomerDAO;
import dal.NotifyDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.List;
import model.LoanServiceUsed;

/**
 *
 * @author LAPTOP
 */
public class Disbursement extends HttpServlet {

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
        LoanServiceUsedDAO ldao = new LoanServiceUsedDAO();
        String pageParam = request.getParameter("page");
        String recordsPerPage = request.getParameter("recordPerPage");
        int page = (pageParam == null) ? 1 : Integer.parseInt(pageParam);
        int recordsPerPageInt = 8;
        String status = "Approved";
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                System.out.println("Invalid page number: " + pageParam);
            }
        }
        if (recordsPerPage != null) {
            try {
                recordsPerPageInt = Integer.parseInt(recordsPerPage);
            } catch (NumberFormatException e) {
                System.out.println("Invalid recordsPerPage value: " + recordsPerPage);
            }
        }
        int offset = (page - 1) * recordsPerPageInt;
        try {
            List<LoanServiceUsed> loanServiceUseds = ldao.getLoanServiceUsedByStatus(offset, recordsPerPageInt, status);

            int totalRecords = ldao.totalLoanServiceUsed(status);
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPageInt);

            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("loanServiceUseds", loanServiceUseds);
            request.setAttribute("recordPerPage", recordsPerPageInt);
            System.out.println("Customer list size: " + loanServiceUseds.size());
        } catch (Exception ex) {
            System.out.println("Error retrieving customers: " + ex.getMessage());
            ex.printStackTrace();
        }
        request.getRequestDispatcher("./accountant/disbursementsManager.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String updateLoanId = request.getParameter("updateLoanId");
        String updateCusId = request.getParameter("updateCusId");
        String amountParam = request.getParameter("amount");
        String walletParam = request.getParameter("wallet");
        LoanServiceUsedDAO ldao = new LoanServiceUsedDAO();
        NotifyDAO ndao = new NotifyDAO();
        CustomerDAO cdao = new CustomerDAO();
        sendNotificationEmail sendEmail = new sendNotificationEmail();

        if (updateLoanId != null && updateCusId != null) {
            try {
                int loanId = Integer.parseInt(updateLoanId);
                int cusId = Integer.parseInt(updateCusId);
                BigDecimal amount = new BigDecimal(amountParam);
                BigDecimal wallet = new BigDecimal(walletParam);
                wallet = wallet.add(amount);
                cdao.updateWallet(cusId, wallet);
                String description = "Gói vay của bạn đã được xác nhận thành công, vui lòng kiểm tra lại số dư tài khoản"; 
                sendEmail.sendNotify(cdao.getCustomerById(cusId).getEmail(), description, cdao.getCustomerById(cusId).getFirstname());
                ndao.insertNotificationForCustomer(cusId, description, 3);
                ldao.updateLoanServiceUsedStatusAndDate(loanId, "In Progress");
            } catch (Exception e) {
                e.printStackTrace();
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
