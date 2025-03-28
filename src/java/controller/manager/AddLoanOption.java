/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dal.DepServiceDAO;
import dal.LoanServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import org.json.JSONObject;

/**
 *
 * @author JIGGER
 */
public class AddLoanOption extends HttpServlet {

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
        request.getRequestDispatcher("./manager/addLoanOptionService.jsp").forward(request, response);
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
        LoanServiceDAO ldao = new LoanServiceDAO();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            JSONObject json = new JSONObject();

            try {
                String loanServiceName = request.getParameter("loanServiceName");
                String description = request.getParameter("description");
                String loanTypeRepay = request.getParameter("loanTypeRepay");
                String minimumLoanStr = request.getParameter("minimumLoan");
                String maximumLoanStr = request.getParameter("maximumLoan");
                String onTermRateStr = request.getParameter("onTermRate");
                String penaltyRateStr = request.getParameter("penaltyRate");
                String duringTimeStr = request.getParameter("duringTime");
                String afterTermRateStr = request.getParameter("afterTermRate");
                String gracePeriodStr = request.getParameter("gracePeriod");

                BigDecimal minimumLoan = new BigDecimal(minimumLoanStr);
                BigDecimal maximumLoan = new BigDecimal(maximumLoanStr);
                int duringTime = Integer.parseInt(duringTimeStr);
                int gracePeriod = Integer.parseInt(gracePeriodStr);
                double afterTermRate = Double.parseDouble(afterTermRateStr);
                double onTermRate = Double.parseDouble(onTermRateStr);
                double penaltyRate = Double.parseDouble(penaltyRateStr);

                if (minimumLoan.compareTo(BigDecimal.ZERO) <= 0
                        || maximumLoan.compareTo(BigDecimal.ZERO) <= 0
                        || duringTime <= 0
                        || gracePeriod <= 0
                        || afterTermRate <= 0
                        || onTermRate <= 0
                        || penaltyRate <= 0) {
                    json.put("success", false);
                    json.put("message", "All numeric values must be greater than 0");
                } else {
                    ldao.createLoanService(loanServiceName, description, loanTypeRepay, onTermRate, afterTermRate, penaltyRate, duringTime, gracePeriod, minimumLoan, maximumLoan);
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
