/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import dal.CustomerDAO;
import model.TermInfo;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
            out.println("<title>Servlet Calculation</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Calculation at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("depositAmount") == null) {
            System.out.println("Dang null");
            response.sendRedirect("customer/template/savemoney.jsp");
            return;
        }
        System.out.println("User ID từ session: " + session.getAttribute("userId"));
        System.out.println("Wallet từ session: " + session.getAttribute("wallet"));
        System.out.println("Deposit Amount từ session: " + session.getAttribute("depositAmount"));

        BigDecimal depositAmount = (BigDecimal) session.getAttribute("depositAmount");

        List<TermInfo> termList = new ArrayList<>();
        LocalDate today = LocalDate.now(); // Lấy ngày hiện tại
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        int[] terms = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 24, 36};

        for (int term : terms) {
            double interestRate = 3 + term * 0.1; // Lãi suất (%)
            BigDecimal rateDecimal = BigDecimal.valueOf(interestRate / 100);

            // Công thức lãi đơn: Lãi = Số tiền * Lãi suất * Số tháng / 12
            BigDecimal interestAmount = depositAmount.multiply(rateDecimal).multiply(BigDecimal.valueOf(term)).divide(BigDecimal.valueOf(12), 2, BigDecimal.ROUND_HALF_UP);
            LocalDate dueDate = today.plusMonths(term);
            String dueDateFormatted = dueDate.format(formatter);
            termList.add(new TermInfo(term, interestAmount.doubleValue(), interestRate, dueDateFormatted));
        }

        request.setAttribute("termList", termList);
        request.getRequestDispatcher("customer/template/chooseTerm.jsp").forward(request, response);
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
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    System.out.println("----- [LOG] Bắt đầu xử lý doPost -----");

    String selectedTermStr = request.getParameter("selectedTerm");
    System.out.println("[LOG] selectedTerm nhận từ request: " + selectedTermStr);

    if (selectedTermStr == null || selectedTermStr.isEmpty()) {
        System.out.println("[ERROR] Không có kỳ hạn nào được chọn!");
        request.setAttribute("error", "Bạn chưa chọn kỳ hạn!");
        request.getRequestDispatcher("/customer/template/chooseTerm.jsp").forward(request, response);
        return;
    }

    try {
        int selectedTerm = Integer.parseInt(selectedTermStr);
        System.out.println("[LOG] Kỳ hạn đã chọn: " + selectedTerm);

        HttpSession session = request.getSession();
        session.setAttribute("selectedTerm", selectedTerm);
        System.out.println("[LOG] selectedTerm đã lưu vào session.");

        // Chuyển đến trang termOption.jsp
        String nextPage = "/customer/template/termOptions.jsp";
        System.out.println("[LOG] Chuyển hướng đến: " + nextPage);
        request.getRequestDispatcher(nextPage).forward(request, response);
    } catch (NumberFormatException e) {
        System.out.println("[ERROR] Lỗi chuyển đổi kỳ hạn: " + e.getMessage());
        request.setAttribute("error", "Kỳ hạn không hợp lệ!");
        request.getRequestDispatcher("/customer/template/chooseTerm.jsp").forward(request, response);
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
