/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.userManagementAdmin;

import dal.AdminDAO;
import dal.ManagerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.time.LocalDate;
import java.util.List;
import model.Customer;
import model.Staff;
import org.json.JSONException;
import org.json.JSONObject;
import util.AccountValidation;

/**
 *
 * @author JIGGER
 */
public class ConsultantAdminManagement extends HttpServlet {
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
        AdminDAO adao = new AdminDAO();
        String pageParam = request.getParameter("page");
        String phoneSearch = request.getParameter("phoneSearch");
        String recordsEntries = request.getParameter("recordsPerPage");
        try {
            int page = (pageParam == null) ? 1 : Integer.parseInt(pageParam);
            int recordsPerPage = (recordsEntries == null) ? 8 : Integer.parseInt(recordsEntries);
            int offset = (page - 1) * recordsPerPage;
            int totalRecords = adao.countTotalStaffRecords(2);
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

            List<Staff> staffList = adao.getAllStaff(offset, recordsPerPage, phoneSearch, 2);
            request.setAttribute("currentPhoneSearch", phoneSearch);
            request.setAttribute("staffList", staffList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentRecords", recordsPerPage);

        } catch (NumberFormatException ex) {
        }

        request.getRequestDispatcher("./admin/consultantAdminManagement.jsp").forward(request, response);
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
        AdminDAO adao = new AdminDAO();
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

                if (imagePart.getSize() > 1024 * 1024 * 5) {
                    json.put("success", false);
                    json.put("message", "Your file import is too big, please choose file size < 5mbs");
                    response.getWriter().write(json.toString());
                    return;
                }

                String image = (imagePart != null && imagePart.getSize() > 0 ? getAndSaveImg(imagePart) : null);

                if (image != null && !validator.isValidateImage(image)) {
                    json.put("success", false);
                    json.put("message", "Only accept file .jpg, .jpeg, .png, .gif");
                    response.getWriter().write(json.toString());
                    return;
                }

                if (image != null) {
                    String imgPath = adao.getStaffById(id).getImage();
                    deleteFile(imgPath);
                } else {
                    image = adao.getStaffById(id).getImage();
                }

                if (adao.isDuplicatedEmail(email) && !email.equals(adao.getStaffById(id).getEmail())) {
                    json.put("success", false);
                    json.put("message", "Email already existed");
                    response.getWriter().write(json.toString());
                    return;
                }

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

                adao.updateInformationStaff(id, image, email, firstname, lastname, gender, dob, phone, address);
                json.put("success", true);
                response.getWriter().write(json.toString());
                return;
            } catch (ServletException | IOException | NumberFormatException | JSONException ex) {
                json.put("success", false);
                json.put("message", "An error occurred while updating information");
                response.getWriter().write(json.toString());
                System.out.println(ex);
            }
        }

        if (deleteId != null) {
            try {
                int delId = Integer.parseInt(deleteId);
                Staff staff = adao.getStaffById(delId);

                if (staff != null) {
                    String imgPath = staff.getImage();
                    if (imgPath != null) {
                        deleteFile(imgPath);
                    }
                    adao.deleteStaff(delId);
                    json.put("success", true);
                    response.getWriter().write(json.toString());
                }
            } catch (IOException | NumberFormatException | JSONException ex) {
                json.put("success", false);
                json.put("message", "An error occurred while trying to delete customer");
                response.getWriter().write(json.toString());
                System.out.println(ex);
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
