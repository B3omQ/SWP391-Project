/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import dal.CustomerReviewDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import org.json.JSONArray;
import util.WordFilter;

/**
 *
 * @author LAPTOP
 */
public class CustomerReview extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("./customer/Review.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        CustomerReviewDAO crdao = new CustomerReviewDAO();
        HttpSession session = request.getSession();
        Customer currentAccount = (Customer) session.getAttribute("account");
        
        PrintWriter out = response.getWriter();
        
        try {
            if (currentAccount == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                out.print("{\"error\": \"Please login first\"}");
                return;
            }
            
            String rateStr = request.getParameter("rate");
            String review = request.getParameter("review");
            
            if (rateStr == null || review == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"error\": \"Missing required parameters\"}");
                return;
            }
            
            int rate = Integer.parseInt(rateStr);
            
            // Server-side validation
            if (review.length() > 500) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"error\": \"Review exceeds 500 characters\"}");
                return;
            }
            
            crdao.addReview(currentAccount.getId(), rate, review);
            
            response.setStatus(HttpServletResponse.SC_OK);
            out.print("{\"message\": \"Review submitted successfully\"}");
            
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\": \"Invalid rating format\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\": \"Server error occurred\"}");
            e.printStackTrace();
        } finally {
            out.flush();
        }
    }

    @Override
    public String getServletInfo() {
        return "Customer Review Servlet";
    }
}