/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dal.DepServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author JIGGER
 */
public class AddSavingOption extends HttpServlet {

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
        request.getRequestDispatcher("./manager/addDepOptionService.jsp").forward(request, response);
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
        JSONObject json = new JSONObject();
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
