/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.userManagementAdmin;

import controller.sendNotificationEmail;
import dal.CustomerDAO;
import dal.IdentityDAO;
import dal.NotifyDAO;

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
        String customerId = request.getParameter("customerId");
        IdentityDAO idao = new IdentityDAO();        
        NotifyDAO ndao = new NotifyDAO();
        sendNotificationEmail sendEmail = new sendNotificationEmail();
        CustomerDAO cdao = new CustomerDAO();
        if (updateId != null) {
            try {
                int id = Integer.parseInt(updateId);
                int cusId = Integer.parseInt(customerId);
                String reasonReject = request.getParameter("reasonReject");
                String status = request.getParameter("status");

                if ("Approved".equals(status)) {
                    String description = "Quản trị viên đã phê duyệt thành công xác minh định danh tài khoản của bạn";
                    sendEmail.sendNotify(cdao.getCustomerById(cusId).getEmail(), description, cdao.getCustomerById(cusId).getFirstname());
                    ndao.insertNotificationForCustomer(cusId, description, 1);
                    idao.updateStatus(id, status);
                    response.sendRedirect("identity-customer-management?notify=success");
                    return;
                }

                if ("Denied".equals(status)) {
                    String description = "Xác minh định danh tài khoản của bạn đã bị từ chối";
                    sendEmail.sendNotify(cdao.getCustomerById(cusId).getEmail(), description, cdao.getCustomerById(cusId).getFirstname());
                    ndao.insertNotificationForCustomer(cusId, description, 1);
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
