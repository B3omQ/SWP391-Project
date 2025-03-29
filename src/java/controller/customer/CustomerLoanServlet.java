/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import dal.CeoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Customer;
import model.LoanServiceUsed;

/**
 *
 * @author Long
 */
public class CustomerLoanServlet extends HttpServlet {

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
            out.println("<title>Servlet LoanServiceUsedListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoanServiceUsedListServlet at " + request.getContextPath() + "</h1>");
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
       // Lấy ID khách hàng từ session (giả sử đã đăng nhập)
        HttpSession session = request.getSession();
        String loanStr = request.getParameter("loanStatus");
        if (loanStr != null) {
            // Loại bỏ khoảng trắng đầu cuối và thay thế nhiều khoảng trắng bằng 1 khoảng
            loanStr = loanStr.trim().replaceAll("\\s+", " ");
        }
        if (loanStr == null) {
            loanStr = (String) session.getAttribute("loanStatusSession");
            if (loanStr == null) {
                loanStr = "In Progress";
            }
        } else {
            session.setAttribute("loanStatusSession", loanStr);
        }
        
        int cusID;
        try {
            Customer currentAccount = (Customer) session.getAttribute("account");
            cusID = currentAccount.getId(); // ID khách hàng đăng nhập
        } catch(Exception e) {
            request.getRequestDispatcher("./auth/template/login.jsp").forward(request, response);
            return;
        }

        // Gọi DAO để lấy khoản vay của khách hàng
        CeoDAO dao = new CeoDAO();
        List<LoanServiceUsed> loan = dao.getLoanByCustomerId(cusID, loanStr);

        // Đẩy thông tin khoản vay vào request và chuyển tiếp sang JSP
        request.setAttribute("loans", loan);
        request.setAttribute("loanStatus", loanStr);
        request.getRequestDispatcher("./customer/Loan.jsp").forward(request, response);
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
