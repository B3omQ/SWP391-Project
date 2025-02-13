/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.ceo;

import dal.StaffDAO;
import model.Staff;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Role;

/**
 *
 * @author Long
 */
public class StaffManagement extends HttpServlet {

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
            out.println("<title>Servlet StaffManagement</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StaffManagement at " + request.getContextPath() + "</h1>");
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
        StaffDAO sdao = new StaffDAO();
        String currentPage = request.getParameter("page");
        int page;
        int recordsPerPage = 6;
        String role = request.getParameter("role");
        if(role == null) {
            role = "";
        }        
        int numberOfRecords = sdao.getNumberOfStaff(role);
        role = role.trim();
        int endPage = numberOfRecords % recordsPerPage == 0 ? numberOfRecords / recordsPerPage : numberOfRecords / recordsPerPage + 1;
        try {
            page = Integer.parseInt(currentPage);
            if (page < 1 || page > endPage) {
                throw new Exception();
            }
        } catch (Exception e) {
            page = 1;
        }
        List<Staff> staffs = sdao.getAllStaffWithPagination((page - 1) * recordsPerPage, recordsPerPage, role);
        request.setAttribute("page", page);
        request.setAttribute("endPage", endPage);
        request.setAttribute("staffs", staffs);
        request.setAttribute("numberOfRecords", numberOfRecords);
        request.setAttribute("recordsPerPage", recordsPerPage);
        List<Role> roles = sdao.getAllRoles();
        request.setAttribute("roles", roles);
        request.setAttribute("role", role);
        request.getRequestDispatcher("./ceo/staffManagement.jsp").forward(request, response);
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
        processRequest(request, response);
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
