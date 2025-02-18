/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dal.DepServiceDAO;
import dal.ManagerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.List;
import model.Customer;
import model.DepService;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author JIGGER
 */
public class DepOptionService extends HttpServlet {

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
        DepServiceDAO depdao = new DepServiceDAO();
        try {
            List<DepService> depList = depdao.getAllDepService();
            request.setAttribute("depOptionServiceList", depList);
        } catch (Exception e) {
            System.out.println(e);
        }

        request.getRequestDispatcher("./manager/depOptionServiceManager.jsp").forward(request, response);
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
        DepServiceDAO depdao = new DepServiceDAO();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String add = request.getParameter("add");
        String edit = request.getParameter("edit");
        String delete = request.getParameter("delete");
        JSONObject json = new JSONObject();
        if (add != null) {
            try {
                String description = request.getParameter("description");
                String minimumDepStr = request.getParameter("minimumDep");
                BigDecimal minimumDep = new BigDecimal(minimumDepStr);
                String duringTimeStr = request.getParameter("duringTime");
                int duringTime = Integer.parseInt(duringTimeStr);
                String savingRateStr = request.getParameter("savingRate");
                double savingRate = Double.parseDouble(savingRateStr);
                String savingRateMinimumStr = request.getParameter("savingRateMinimum");
                double savingRateMinimum = Double.parseDouble(savingRateMinimumStr);
                depdao.createDepService(description, minimumDep, duringTime, savingRate, savingRateMinimum);
            } catch (Exception e) {

            }
        }

        if (delete != null) {
            try {
                int delId = Integer.parseInt(delete);
                DepServiceDAO ddao = new DepServiceDAO();
                ddao.deleteDep(delId);
                json.put("success", true);
                response.getWriter().write(json.toString());
                return;

            } catch (IOException | NumberFormatException | JSONException ex) {
                json.put("success", false);
                json.put("message", "An error occurred while trying to delete customer");
                response.getWriter().write(json.toString());
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
