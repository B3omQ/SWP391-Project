/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.ceo;

import dal.CeoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import model.LoanServiceUsed;

/**
 *
 * @author Long
 */
public class CustomerLoanPayment extends HttpServlet {

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
            out.println("<title>Servlet CustomerLoanPayment</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CustomerLoanPayment at " + request.getContextPath() + "</h1>");
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
        CeoDAO dao = new CeoDAO();
        String loanServiceUsedId = request.getParameter("loanId");
        LoanServiceUsed loan = dao.getLoanServiceUsedById(Integer.parseInt(loanServiceUsedId));
        request.setAttribute("loan", loan);
        request.getRequestDispatcher("./ceo/customerLoanPayment.jsp").forward(request, response);
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
        String loanIdStr = request.getParameter("loanId");
        String repayAmountStr = request.getParameter("repayAmount");

        if (loanIdStr == null || repayAmountStr == null || loanIdStr.isEmpty() || repayAmountStr.isEmpty()) {
            request.setAttribute("error", "Thông tin không hợp lệ!");
            
            doGet(request, response);
            return;
        }

        try {
            int loanId = Integer.parseInt(loanIdStr);
            BigDecimal repayAmount = new BigDecimal(repayAmountStr);

            // Gọi DAO để chèn bản ghi thanh toán
            CeoDAO paymentDAO = new CeoDAO();
            boolean success = paymentDAO.insertPayment(loanId, repayAmount);

            if (success) {
                paymentDAO.updateDebtAfterPayment(loanId, repayAmount);
                request.setAttribute("message", "Thanh toán thành công!");
            } else {
                request.setAttribute("error", "Thanh toán thất bại. Vui lòng thử lại!");
            }
        } catch (NumberFormatException ex) {
            request.setAttribute("error", "Dữ liệu không hợp lệ!");
        }

        // Chuyển về trang form (hoặc trang kết quả)
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
