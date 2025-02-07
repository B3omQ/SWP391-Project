/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.consultant;

import dal.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import model.Customer;

/**
 *
 * @author LAPTOP
 */
@WebServlet(name="CustomerManager", urlPatterns={"/consultant-customer"})
public class CustomerManager extends HttpServlet {
   
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
        CustomerDAO cdao = new CustomerDAO();
        String pageParam = request.getParameter("page");
        int page = (pageParam == null) ? 1: Integer.parseInt(pageParam);
        int recordsPerPage = 6;
        int offset = (page - 1)* recordsPerPage;
        try{
            List<Customer> customers = cdao.getCustomerList(offset, recordsPerPage);
            int totalRecords = cdao.totalAccount();
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("customers", customers);
            System.out.println("Customer list size:" + customers.size());
        }catch(NumberFormatException ex){
            System.out.println(ex);
        }
        request.getRequestDispatcher("./consultant/customerManager.jsp").forward(request, response);
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
        String deleteId = request.getParameter("deleteId");
        String add = request.getParameter("add");
        String changeinfoId = request.getParameter("changeinfoId");
        CustomerDAO cdao = new CustomerDAO();
        if (deleteId != null) {
            try {
                int delId = Integer.parseInt(deleteId);
                cdao.deleteAccount(delId);
            } catch (NumberFormatException ex) {
                System.out.println(ex);
            }
        }
        if (add != null) {
            try {
                String username = request.getParameter("username");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String phoneNumber = request.getParameter("phoneNumber");
        String password = request.getParameter("password");
        String dobStr = request.getParameter("dob");
//        Part filePart = request.getPart("otherImage");
//        String image = getAndSaveImg(filePart); 
        LocalDate dob = null;
        if (dobStr != null && !dobStr.isEmpty()) {
            dob = LocalDate.parse(dobStr, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        }
        Customer customer = new Customer(username,password,email,firstname,lastname,gender,dob,phoneNumber,address);

        // Add the customer via DAO
        cdao.booleanCreateNewAccount(customer);

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Invalid input.");
                request.getRequestDispatcher("failure.jsp").forward(request, response);
            }
        }
        if (changeinfoId != null) {
            try {
                int changeId = Integer.parseInt(changeinfoId);
                String username = request.getParameter("username");
                String firstname = request.getParameter("firstname");
                String lastname = request.getParameter("lastname");
                String email = request.getParameter("email");
                String address = request.getParameter("address");
                String gender = request.getParameter("gender");
                String phoneNumber = request.getParameter("phoneNumber");
                String dobStr = request.getParameter("dob");
                Date dob = null;
                try {
                    if (dobStr != null && !dobStr.isEmpty()) {
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        dob = sdf.parse(dobStr);
                    }
                } catch (ParseException e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Invalid date format. Please use YYYY-MM-DD.");
                    request.getRequestDispatcher("./consultant/customerManagemer.jsp").forward(request, response);
                    return;
                }
                cdao.updateInformation(changeId, address, firstname, lastname, username, phoneNumber, gender, dobStr, email);

            } catch (NumberFormatException ex) {
                System.out.println(ex);
            }
        }
        doGet(request, response);
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
