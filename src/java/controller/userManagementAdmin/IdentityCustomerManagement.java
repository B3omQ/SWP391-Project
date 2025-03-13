/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.userManagementAdmin;

import dal.IdentityDAO;

import java.io.IOException;

import jakarta.servlet.ServletException;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;

import model.VerifyIdentityInformation;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author JIGGER
 */
public class IdentityCustomerManagement extends HttpServlet {

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
        IdentityDAO idao = new IdentityDAO();
        String pageParam = request.getParameter("page");
        String status = request.getParameter("pendingStatus");
        String phone = request.getParameter("phoneSearch");
        String identityCardNumber = request.getParameter("identityCardNumberSearch");

        if (status == null || status.trim().isEmpty()) {
            status = "Pending";
        }

        try {
            int page = (pageParam == null) ? 1 : Integer.parseInt(pageParam);
            int recordsPerPage;
            int totalRecords = idao.countTotalVerifyIdentityInformationByStatus(status);

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

            List<VerifyIdentityInformation> identityList = idao.getAllVerifyIdentityInformation(offset, recordsPerPage, status, phone, identityCardNumber);
            request.setAttribute("currentIdentityCardNumberSearch", identityCardNumber);
            request.setAttribute("identityList", identityList);
            request.setAttribute("currentPhoneSearch", phone);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentRecords", recordsPerPage);
            request.setAttribute("currentStatus", status);

        } catch (NumberFormatException ex) {
        }

        request.getRequestDispatcher("./admin/identityInformationAdminManagement.jsp").forward(request, response);
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
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONObject json = new JSONObject();
        String updateId = request.getParameter("updateId");
        IdentityDAO idao = new IdentityDAO();        
        if (updateId != null) {
            try {
                int id = Integer.parseInt(updateId);
                String reasonReject = request.getParameter("reasonReject");
                String status = request.getParameter("status");

                if ("Approved".equals(status)) {
                    idao.updateStatus(id, status);
                    response.sendRedirect("identity-customer-management?notify=success");
                    return;
                }

                if ("Denied".equals(status)) {
                    idao.updateVerifyIdentityInformation(id, reasonReject, status);
                    response.sendRedirect("identity-customer-management?notify=success");
                    return;
                }
            } catch (NumberFormatException | JSONException ex) {
            }
        }
        doGet(request, response);
    }
}
