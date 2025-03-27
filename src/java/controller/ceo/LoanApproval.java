/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.ceo;

import dal.CeoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.LoanService;

/**
 *
 * @author Long
 */
public class LoanApproval extends HttpServlet {
   
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
            out.println("<title>Servlet LoanApproval</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoanApproval at " + request.getContextPath () + "</h1>");
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
        CeoDAO ceoDAO = new CeoDAO();
        HttpSession session = request.getSession();
        String status = request.getParameter("pendingStatus");
        String sortBy = request.getParameter("sortBy");
        String order = request.getParameter("order");
        String id = request.getParameter("id");
        String changeStatus = request.getParameter("changeStatus");
        String currentPage = request.getParameter("page");
        int page;
        int DEFAULT_PER_PAGE = 5;
        int recordsPerPage = 5;
        String perPageParam = request.getParameter("perPage");
        try {
            if (perPageParam == null) {
                recordsPerPage = (Integer) session.getAttribute("perPageSession");
            } else {
                int perPage = Integer.parseInt(perPageParam);
                if (perPage < 1 || perPage > Integer.MAX_VALUE) {
                    throw new Exception();
                }
                session.setAttribute("perPageSession", perPage);
                recordsPerPage = perPage;
            }
        } catch (Exception e) {
            recordsPerPage = DEFAULT_PER_PAGE;
        }
        String search = request.getParameter("search");
        if (search != null) {
            // Loại bỏ khoảng trắng đầu cuối và thay thế nhiều khoảng trắng bằng 1 khoảng
            search = search.trim().replaceAll("\\s+", " ");
        }
        if (search == null) {
            search = (String) session.getAttribute("searchSession");
            if (search == null) {
                search = "";
            }
        } else {
            session.setAttribute("searchSession", search);
        }

        if (id != null) {
            ceoDAO.updatLoanServiceStatusById(Integer.parseInt(id), changeStatus);
        }

        if (status == null || status.trim().isEmpty()) {
            status = (String) session.getAttribute("statusSession");
            if (status == null) {
                status = "Pending";
            }
        } else {
            session.setAttribute("statusSession", status);
        }

        if (sortBy == null || sortBy.trim().isEmpty()) {
            sortBy = (String) session.getAttribute("sortBySession");
            if (sortBy == null) {
                sortBy = "DuringTime";
            }
        } else {
            session.setAttribute("sortBySession", sortBy);
        }

        if (order == null || order.trim().isEmpty()) {
            order = (String) session.getAttribute("orderSession");
            if (order == null) {
                order = "ASC";
            }
        } else {
            session.setAttribute("orderSession", order);
        }

        int numberOfRecords = ceoDAO.getTotalLoanServiceRecords(status, search);
        int endPage = numberOfRecords % recordsPerPage == 0 ? numberOfRecords / recordsPerPage : numberOfRecords / recordsPerPage + 1;
        try {
            page = Integer.parseInt(currentPage);
            if (page < 1 || page > endPage) {
                throw new Exception();
            }
        } catch (Exception e) {
            page = 1;
        }

        try {
            List<LoanService> loanServiceList = ceoDAO.getAllLoanServiceByStatus(status, sortBy, order, search, page, recordsPerPage);
            request.setAttribute("page", page);
            request.setAttribute("endPage", endPage);
            request.setAttribute("numberOfRecords", numberOfRecords);
            request.setAttribute("recordsPerPage", recordsPerPage);
            request.setAttribute("searchValue", search);
            request.setAttribute("perPage", recordsPerPage);
            request.setAttribute("currentStatus", status);
            request.setAttribute("currentSort", sortBy);
            request.setAttribute("currentOrder", order);
            request.setAttribute("loanServiceList", loanServiceList);
        } catch (Exception e) {
            System.out.println(e);
        }

        request.getRequestDispatcher("./ceo/loanApproval.jsp").forward(request, response);

    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
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
