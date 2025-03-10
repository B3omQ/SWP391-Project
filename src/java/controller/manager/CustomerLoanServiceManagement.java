/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dal.CustomerDAO;
import dal.LoanServiceUsedDAO;
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
        if (update != null) {
            try {
                int loanId = Integer.parseInt(update);
                ldao.updateLoanServiceUsedStatus(loanId, status);
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
