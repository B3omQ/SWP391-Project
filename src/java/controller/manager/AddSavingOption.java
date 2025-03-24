/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("./manager/addDepOptionService.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DepServiceDAO depdao = new DepServiceDAO();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            JSONObject json = new JSONObject();

            try {
                String depName = request.getParameter("depName");
                String description = request.getParameter("description");
                String minimumDepStr = request.getParameter("minimumDep");
                String duringTimeStr = request.getParameter("duringTime");
                String savingRateStr = request.getParameter("savingRate");
                String savingRateMinimumStr = request.getParameter("savingRateMinimum");

                BigDecimal minimumDep = new BigDecimal(minimumDepStr);
                int duringTime = Integer.parseInt(duringTimeStr);
                double savingRate = Double.parseDouble(savingRateStr);
                double savingRateMinimum = Double.parseDouble(savingRateMinimumStr);

                if (minimumDep.compareTo(BigDecimal.ZERO) <= 0
                        || duringTime <= 0
                        || savingRate <= 0
                        || savingRateMinimum <= 0) {
                    json.put("success", false);
                    json.put("message", "All numeric values must be greater than 0");
                } else {
                    // Gọi phương thức createDepService với đầy đủ tham số
                    depdao.createDepService(depName, description, minimumDep, duringTime, 
                                            savingRate, savingRateMinimum, null, "Pending");
                    json.put("success", true);
                }

            } catch (NumberFormatException e) {
                json.put("success", false);
                json.put("message", "Invalid number format in input values");
            } catch (Exception e) {
                json.put("success", false);
                json.put("message", "An error occurred: " + e.getMessage());
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }

            out.write(json.toString());

        } catch (IOException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            throw new ServletException("Failed to process request", e);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}