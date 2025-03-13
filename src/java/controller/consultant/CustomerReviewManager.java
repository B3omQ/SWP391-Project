/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.consultant;

import dal.CustomerReviewDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.CustomerReview;

/**
 *
 * @author LAPTOP
 */
public class CustomerReviewManager extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CustomerReviewDAO crdao = new CustomerReviewDAO();
        String pageParam = request.getParameter("page");
        String rateStr = request.getParameter("rate");
        String recordsPerPage = request.getParameter("recordPerPage");
        int rate = 0;
        if (rateStr != null && !rateStr.isEmpty()) {
            try {
                rate = Integer.parseInt(rateStr);
            } catch (NumberFormatException e) {
                System.out.println("Invalid rate value: " + rateStr);
            }
        }
        int page = (pageParam == null) ? 1 : Integer.parseInt(pageParam);
        int recordsPerPageInt = 8;
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
            List<CustomerReview> crList = crdao.getAllCustomerReview(offset, recordsPerPageInt, rate);
            int totalRecords = crdao.TotalReview(rate);
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPageInt);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("crList", crList);
            request.setAttribute("recordPerPage", recordsPerPageInt);
        } catch (Exception ex) {
            System.out.println("Error retrieving customerReview list: " + ex.getMessage());
            ex.printStackTrace();
        }
        request.getRequestDispatcher("./consultant/reviewManager.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String deleteId = request.getParameter("deleteId");
        CustomerReviewDAO crdao = new CustomerReviewDAO();
        if (deleteId != null) {
            try {
                int delId = Integer.parseInt(deleteId);
                crdao.deleteReview(delId);
            } catch (NumberFormatException ex) {
                System.out.println(ex);
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
