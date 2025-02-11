/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.consultant;

import dal.ConsultantDAO;
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
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import util.AccountValidation;

/**
 *
 * @author LAPTOP
 */
@MultipartConfig(maxFileSize = 1024 * 1024 * 5)
public class CustomerManager extends HttpServlet {

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
        ConsultantDAO cdao = new ConsultantDAO();
        String pageParam = request.getParameter("page");
        int page = (pageParam == null) ? 1 : Integer.parseInt(pageParam);
        int recordsPerPage = 6;
        int offset = (page - 1) * recordsPerPage;
        try {
            List<Customer> customers = cdao.getCustomerList(offset, recordsPerPage);
            int totalRecords = cdao.totalAccount();
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("customers", customers);
            System.out.println("Customer list size:" + customers.size());
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        }
        request.getRequestDispatcher("./consultant/customerManager.jsp").forward(request, response);
    }

    private String getAndSaveImg(Part filePart) throws IOException {
        // Define the path relative to the project
        String relativePath = "assets/images/";

        // Get the absolute path to the project directory
        String uploadPath = getServletContext().getRealPath("");  // Root of the web application
        String projectRoot = uploadPath.replace("build" + File.separator + "web", ""); // Adjust to get to project root

        // Full path to the images folder inside web/resources/images/
        String fileSavePath = projectRoot + "web" + File.separator + relativePath;

        // Create the directory if it doesn't exist
        File uploadDir = new File(fileSavePath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Get the uploaded file name
        String fileName = filePart.getSubmittedFileName();
        // Combine the path and the file name
        String filePath = fileSavePath + File.separator + fileName;
        // Write the file to the specified path
        filePart.write(filePath);

        // Return the relative path for storing in the database
        return relativePath + fileName;
    }

    private boolean deleteFile(String relativeFilePath) {
        try {
            // Get the absolute path to the project directory
            String uploadPath = getServletContext().getRealPath("");  // Root of the web application
            String projectRoot = uploadPath.replace("build" + File.separator + "web", ""); // Adjust to get to project root

            // Combine the project root and the relative file path to get the absolute file path
            String absoluteFilePath = projectRoot + "web" + File.separator + relativeFilePath.replace("/", File.separator);

            // Create a File object for the file to be deleted
            File file = new File(absoluteFilePath);

            // Check if the file exists and delete it
            if (file.exists()) {
                return file.delete(); // Returns true if the file was successfully deleted
            } else {
                System.out.println("File not found: " + absoluteFilePath);
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
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
        String deleteId = request.getParameter("deleteId");
        String add = request.getParameter("add");
        String changeinfoId = request.getParameter("changeinfoId");
        ConsultantDAO cdao = new ConsultantDAO();
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
            return;
        }

        // Xác định người dùng hiện tại: Customer hoặc Staff
//        Object user = session.getAttribute("account");
//        boolean isCustomer = true;
//        if (user == null) {
//            user = session.getAttribute("staff");
//            isCustomer = false;
//        }
//        if (user == null) {
//            response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
//            return;
//        }
        if (deleteId != null) {
            try {
                int delId = Integer.parseInt(deleteId);
                cdao.deleteCustomer(delId);
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
                String phoneNumber = request.getParameter("phone");
                String password = request.getParameter("password");
                String dobStr = request.getParameter("dob");
//        Part filePart = request.getPart("otherImage");
//        String image = getAndSaveImg(filePart); 
                LocalDate dob = null;
//                if (!validator.isValidEmail(email)) {
//                    session.setAttribute("error3", "Email không hợp lệ.");
//                    response.sendRedirect(request.getContextPath() + "/customer/template/account-profile.jsp");
//                    return;
//                }
//                if (!validator.isValidPhone(phoneNumber)) {
//                    session.setAttribute("error3", "Số điện thoại không hợp lệ.");
//                    response.sendRedirect(request.getContextPath() + "/customer/template/account-profile.jsp");
//                    return;
//                }
//                if (!validator.isValidAddress(address)) {
//                    session.setAttribute("error3", "Địa chỉ không hợp lệ.");
//                    response.sendRedirect(request.getContextPath() + "/customer/template/account-profile.jsp");
//                    return;
//                }
                if (dobStr != null && !dobStr.isEmpty()) {
                    dob = LocalDate.parse(dobStr, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                }
                Part filePart = request.getPart("otherImage"); // "image" is the name of the input field in the form
                String image = getAndSaveImg(filePart);
                Customer customer = new Customer(image,username, password, email, firstname, lastname, gender, dob, phoneNumber, address);

                // Add the customer via DAO
                cdao.booleanCreateNewAccount(customer);

            } catch (Exception e) {
                e.printStackTrace();
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
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
