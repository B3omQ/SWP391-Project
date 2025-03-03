/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.ceo;

import dal.CeoDAO;
import dal.DepServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.DepService;

/**
 *
 * @author Long
 */
public class DepositApproval extends HttpServlet {
   
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
            out.println("<title>Servlet DepositApproval</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DepositApproval at " + request.getContextPath () + "</h1>");
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
        DepServiceDAO depdao = new DepServiceDAO();
        CeoDAO ceoDAO = new CeoDAO();
        
        String status = request.getParameter("pendingStatus");
        String sortBy = request.getParameter("sortBy");
        String order = request.getParameter("order");
        String id = request.getParameter("id");
        String changeStatus = request.getParameter("changeStatus");

        if(id != null) {
            ceoDAO.updateDepServiceStatusById(Integer.parseInt(id), changeStatus);
        }
        
        if (status == null || status.trim().isEmpty()) {
            status = "Approved";
        }

        if (sortBy == null || sortBy.trim().isEmpty()) {
            sortBy = "DuringTime";
        }

        if (order == null || order.trim().isEmpty()) {
            order = "ASC";
        }

        try {
            List<DepService> depList = depdao.getAllDepServiceByStatus(status, sortBy, order);
            request.setAttribute("currentStatus", status);
            request.setAttribute("currentSort", sortBy);
            request.setAttribute("currentOrder", order);
            request.setAttribute("depOptionServiceList", depList);
        } catch (Exception e) {
            System.out.println(e);
        }

        request.getRequestDispatcher("./ceo/depositApproval.jsp").forward(request, response);

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
