/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.userManagementAdmin;

import dal.AdminDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Customer;

/**
 *
 * @author Long
 */
public class BlacklistCustomerManagement extends HttpServlet {
   
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
            out.println("<title>Servlet BlacklistCustomerManagement</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BlacklistCustomerManagement at " + request.getContextPath () + "</h1>");
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
        AdminDAO adao = new AdminDAO();
        String pageParam = request.getParameter("page");
        String phoneSearch = request.getParameter("phoneSearch");
        try {
            int page = (pageParam == null) ? 1 : Integer.parseInt(pageParam);
            int recordsPerPage;
            int totalRecords = adao.countTotalBlacklistCustomerRecords();
            
            if (totalRecords <= 50) {
                recordsPerPage = Math.max(1, totalRecords * 50 / 100);
            } else if (totalRecords <= 100) {
                recordsPerPage = totalRecords * 30 / 100;
            } else if (totalRecords <= 300) {
                recordsPerPage = totalRecords * 20 / 100;
            } else {
                recordsPerPage = totalRecords * 10 / 100;
            }
            int offset = (page - 1) * recordsPerPage;
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
            adao.addAllOverdueCustomersToBlacklist();
            List<Customer> customerList = adao.getAllCustomerInBlacklist(offset, recordsPerPage, phoneSearch);
            request.setAttribute("currentPhoneSearch", phoneSearch);
            request.setAttribute("customerList", customerList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentRecords", recordsPerPage);

        } catch (NumberFormatException ex) {
        }

        request.getRequestDispatcher("./admin/blacklistCustomerAdminManagement.jsp").forward(request, response);
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
