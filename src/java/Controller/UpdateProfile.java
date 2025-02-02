/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import Dal.CustomerDAO;
import Model.Customer;
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
public class UpdateProfile extends HttpServlet {
       private CustomerDAO customerDAO = new CustomerDAO();

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
            out.println("<title>Servlet UpdateProfile</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateProfile at " + request.getContextPath () + "</h1>");
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
        
        // Lấy session hiện tại
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username != null) {
            // Lấy thông tin customer từ database
            Customer customer = customerDAO.getCustomerByUsername(username);

            if (customer != null) {
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("settings.jsp").forward(request, response);
            } else {
                response.sendRedirect("error.jsp");  // Nếu không tìm thấy user, chuyển hướng đến trang lỗi
            }
        } else {
            response.sendRedirect("login.jsp");  // Nếu chưa đăng nhập, chuyển về trang đăng nhập
        }
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
    // Lấy các tham số từ form sửa thông tin, không thay đổi wallet
//    String firstName = request.getParameter("firstName");
//    String lastName = request.getParameter("lastName");
//    String phone = request.getParameter("phone");
//    String address = request.getParameter("address");
//    String gender = request.getParameter("gender");
//    String dob = request.getParameter("dob");
//
//    // Lấy ID người dùng từ session
//    int userId = (int) request.getSession().getAttribute("userId");
//
//    // Cập nhật thông tin người dùng, không thay đổi wallet
//    boolean isUpdated = customerDAO.updateCustomerInfo(userId, firstName, lastName, phone, address, gender, dob);
//
//   if (isUpdated) {
//        // Nếu cập nhật thành công, truyền thông báo thành công vào request
//        request.setAttribute("success2", "Cập nhật thông tin thành công!");
//    } else {
//        // Nếu có lỗi, truyền thông báo lỗi vào request
//        request.setAttribute("error2", "Cập nhật thông tin thất bại. Vui lòng thử lại.");
//    }
//           request.getRequestDispatcher("/account-proflie.jsp").forward(request, response);

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
