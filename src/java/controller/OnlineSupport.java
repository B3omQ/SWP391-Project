/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ConsultantDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import model.Customer;
import util.AccountValidation;

/**
 *
 * @author LAPTOP
 */
public class OnlineSupport extends HttpServlet {

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
        request.getRequestDispatcher("onlineChat.jsp").forward(request, response);
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
        AccountValidation validator = new AccountValidation();
        String add = request.getParameter("add");
        ConsultantDAO cdao = new ConsultantDAO();
        if (add != null) {
            try {
                String username = request.getParameter("username");
                String firstname = request.getParameter("firstname");
                String lastname = request.getParameter("lastname");
                String email = request.getParameter("email");
                String address = request.getParameter("address");
                String gender = request.getParameter("gender");
                String phoneNumber = request.getParameter("phone");
                String dobStr = request.getParameter("dob");
                LocalDate dob = null;

                if (cdao.isDuplicatedEmail(email)) {
                    response.setContentType("text/plain");
                    response.getWriter().write("errorEmailexist");
                    System.out.println("đã block email");
                    return;
                }
                if (cdao.isDuplicatedPhoneNumber(phoneNumber)) {
                    response.setContentType("text/plain");
                    response.getWriter().write("errorPhoneExist");
                    System.out.println("đã block phone");
                    return;
                }
                if (dobStr != null && !dobStr.isEmpty()) {
                    dob = LocalDate.parse(dobStr, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                }
                String password = validator.generateRandomPassword(10);

                Customer customer = new Customer(username, password, email, firstname, lastname, gender, dob, phoneNumber, address);

                // Add the customer via DAO
                boolean success = cdao.booleanCreateNewAccount(customer);

                if (success) {
                    response.getWriter().write("success");
                } else {
                    response.getWriter().write("error");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
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
