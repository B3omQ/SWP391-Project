/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.manager;

import dal.CustomerDAO;
import dal.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.List;
import model.Customer;

/**
 *
 * @author JIGGER
 */
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
        StaffDAO sdao = new StaffDAO();
        String pageParam = request.getParameter("page");
        try {
            int page = (pageParam == null) ? 1 : Integer.parseInt(pageParam);
            int recordsPerPage = 10;
            int offset = (page - 1) * recordsPerPage;
            int totalRecords = sdao.countTotalRecords();
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

            List<Customer> customerList = sdao.getAllCustomerAccount(offset, recordsPerPage);
            request.setAttribute("customerList", customerList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

        } catch (NumberFormatException ex) {
            ex.printStackTrace();
        }

        request.getRequestDispatcher("./manager/customerManager.jsp").forward(request, response);
    }

    /**
     * This function will save a file to the images folder and return the
     * relative file path.
     *
     * @param filePart the uploaded file part
     * @return the relative path to the saved file
     * @throws IOException if an I/O error occurs during file writing
     */
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
        String deleteId = request.getParameter("deleteCustomer");
        String updateId = request.getParameter("updateOther");
        StaffDAO sdao = new StaffDAO();
        CustomerDAO cdao = new CustomerDAO();
        if (updateId != null) {
            try {
                int id = Integer.parseInt(updateId);
                String email = request.getParameter("newEmail");
                String firstname = request.getParameter("newFirstname");
                String lastname = request.getParameter("newLastname");
                String gender = request.getParameter("newGender");
                String phone = request.getParameter("newPhone");
                String address = request.getParameter("newAddress");
                Part imagePart = request.getPart("newImg");

                String image = (imagePart != null && imagePart.getSize() > 0) ? getAndSaveImg(imagePart) : null;

                Customer customer = sdao.getCustomerById(id);
                if (customer != null) {
                    if (image != null && customer.getImage()!= null) {
                        deleteFile(customer.getImage());
                    }
                    cdao.updateCustomer(id, image, email, firstname, lastname, gender, phone, address);
                }

                response.sendRedirect("customer-manager?page=1");
                return;
            } catch (NumberFormatException ex) {
                ex.printStackTrace();
            }
        }

        if (deleteId != null) {
            try {
                int delId = Integer.parseInt(deleteId);
                Customer customer = sdao.getCustomerById(delId);

                if (customer != null) {
                    String imgPath = customer.getImage();
                    if (imgPath != null) {
                        deleteFile(imgPath);
                    }
                    sdao.deleteCustomer(delId);
                }

                response.sendRedirect("customer-manager?page=1");
                return;
            } catch (NumberFormatException ex) {
                ex.printStackTrace();
            }
        }

        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
