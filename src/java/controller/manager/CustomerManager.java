/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dal.ManagerDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;
import java.time.LocalDate;
import java.util.List;
import model.Customer;
import util.AccountValidation;
import org.json.JSONObject;

/**
 *
 * @author JIGGER
 */
@MultipartConfig
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
        ManagerDAO mdao = new ManagerDAO();
        String pageParam = request.getParameter("page");
        String phoneSearch = request.getParameter("phoneSearch");
        try {
            int page = (pageParam == null) ? 1 : Integer.parseInt(pageParam);
            int recordsPerPage = 8;
            int offset = (page - 1) * recordsPerPage;
            int totalRecords = mdao.countTotalRecords();
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

            List<Customer> customerList = mdao.getAllCustomer(offset, recordsPerPage, phoneSearch);
            request.setAttribute("currentPhoneSearch", phoneSearch);
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
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String deleteId = request.getParameter("deleteId");
        String updateId = request.getParameter("updateId");
        ManagerDAO mdao = new ManagerDAO();
        JSONObject json = new JSONObject();
        AccountValidation validator = new AccountValidation();
        if (updateId != null) {
            try {
                int id = Integer.parseInt(updateId);
                String email = request.getParameter("newEmail");
                String firstname = validator.normalizeInput(request.getParameter("newFirstname"));
                String lastname = validator.normalizeInput(request.getParameter("newLastname"));
                String gender = request.getParameter("newGender");
                String dobStr = request.getParameter("newDob");
                String phone = request.getParameter("newPhone");
                String address = request.getParameter("newAddress");
                LocalDate dob = LocalDate.parse(dobStr);
                Part imagePart = request.getPart("newImg");
                String fileType = imagePart.getContentType();
                
//                if (!fileType.equals("image/png") && !fileType.equals("image/jpeg") && !fileType.equals("image/jpg")) {
//                    json.put("success", false);
//                    json.put("message", "Only accept jpg, jpeg, png file");
//                    response.getWriter().write(json.toString());
//                    return;
//                }

                if (imagePart.getSize() > 1024 * 1024 * 5) {
                    json.put("success", false);
                    json.put("message", "Your file import is too big, please choose file size < 5mbs");
                    response.getWriter().write(json.toString());
                    return;
                }

                String image = (imagePart != null && imagePart.getSize() > 0 ? getAndSaveImg(imagePart) : null);
                if (image != null) {
                    String imgPath = mdao.getCustomerById(id).getImage();
                    deleteFile(imgPath);
                } else {
                    image = mdao.getCustomerById(id).getImage();
                }

//                if (mdao.isDuplicatedEmail(email)) {
//                    json.put("success", false);
//                    json.put("message", "Email already existed");
//                    response.getWriter().write(json.toString());
//                    return;
//                }

                if (!validator.isAlphabetic(firstname)) {
                    json.put("success", false);
                    json.put("message", "Invalid firstname characters");
                    response.getWriter().write(json.toString());
                    return;
                }

                if (!validator.isAlphabetic(lastname)) {
                    json.put("success", false);
                    json.put("message", "Invalid lastname characters");
                    response.getWriter().write(json.toString());
                    return;
                }

                if (!validator.isValidPhoneNumber(phone)) {
                    json.put("success", false);
                    json.put("message", "Invalid phone number");
                    response.getWriter().write(json.toString());
                    return;
                }

                mdao.updateInformationCustomer(id, image, email, firstname, lastname, gender, dob, phone, address);
                json.put("success", true);
                response.getWriter().write(json.toString());
                return;
            } catch (NumberFormatException ex) {
                ex.printStackTrace();
            }
        }

        if (deleteId != null) {
            try {
                int delId = Integer.parseInt(deleteId);
                Customer customer = mdao.getCustomerById(delId);

                if (customer != null) {
                    String imgPath = customer.getImage();
                    if (imgPath != null) {
                        deleteFile(imgPath);
                    }
                    mdao.deleteCustomer(delId);
                    json.put("success", true);
                    response.getWriter().write(json.toString());
                    return;
                }
            } catch (Exception ex) {
                json.put("success", false);
                json.put("message", "An error occurred while trying to delete customer");
                response.getWriter().write(json.toString());
                System.out.println(ex);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
