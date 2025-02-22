/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.customer;

import model.TermInfo;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author emkob
 */
public class Calculation extends HttpServlet {
   
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
            out.println("<title>Servlet Calculation</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Calculation at " + request.getContextPath () + "</h1>");
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
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<TermInfo> termList = new ArrayList<>();
        int[] terms = {1,2,3,4,5,6,7,8,9,10,11,12,24,36};

        for (int term : terms) {
            double interestRate = 3 + term * 0.1;
            double interestAmount = term * 2000;
            termList.add(new TermInfo(term, interestAmount, interestRate));
        }
        System.out.println(">>> termList size: " + termList.size());
    for (TermInfo t : termList) {
        System.out.println("Term: " + t.getTerm() + ", Interest: " + t.getInterestAmount() + ", Rate: " + t.getInterestRate());
    }

        request.setAttribute("termList", termList);
        request.getRequestDispatcher("customer/template/chooseTerm.jsp").forward(request, response);
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
        String termParam = request.getParameter("term");
        if (termParam == null || !termParam.matches("\\d+")) {
            request.setAttribute("error", "Invalid term");
            RequestDispatcher dispatcher = request.getRequestDispatcher("errorPage.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        int term = Integer.parseInt(termParam);
        double interestRate = 3 + term * 0.1; // % per year
        double interestAmount = term * 2000; // Fixed calculation for example
        
        request.setAttribute("term", term);
        request.setAttribute("interestAmount", interestAmount);
        request.setAttribute("interestRate", interestRate);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
        dispatcher.forward(request, response);
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
