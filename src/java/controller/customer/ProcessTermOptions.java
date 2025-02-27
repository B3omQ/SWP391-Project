/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.customer;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author emkob
 */
public class ProcessTermOptions extends HttpServlet {
   
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
            out.println("<title>Servlet ProcessTermOptions</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProcessTermOptions at " + request.getContextPath () + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession(false); // Không tạo session mới
    if (session == null || session.getAttribute("selectedTerm") == null) {
        System.out.println("[ERROR] Session không hợp lệ hoặc thiếu selectedTerm, quay lại chooseTerm.jsp");
        response.sendRedirect(request.getContextPath() + "/customer/template/chooseTerm.jsp");
        return;
    }

    Integer selectedTerm = (Integer) session.getAttribute("selectedTerm");
    System.out.println("[DEBUG] selectedTerm from session: " + selectedTerm);

    String action = request.getParameter("action");
    if (action == null) {
        request.setAttribute("error", "Bạn chưa chọn phương án xử lý khi kỳ hạn kết thúc!");
        request.getRequestDispatcher("/customer/template/termOptions.jsp").forward(request, response);
        return;
    }

    // Lưu lựa chọn vào session
    String actionLabel;
    switch (action) {
        case "withdrawInterest":
            actionLabel = "Rút tiền lãi và gửi tiếp gốc";
            break;
        case "renewAll":
            actionLabel = "Gửi tiếp cả tiền gốc và lãi";
            break;
        case "withdrawAll":
            actionLabel = "Rút toàn bộ cả tiền gốc và lãi";
            break;
        default:
            actionLabel = "Không xác định";
    }
    session.setAttribute("selectedAction", actionLabel);

    response.sendRedirect(request.getContextPath() + "/customer/template/confirmTermAction.jsp");
}
}