/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dal.ManagerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.time.LocalDate;
import model.Staff;
import org.json.JSONException;
import util.AccountValidation;
import org.json.JSONObject;

/**
 *
 * @author JIGGER
 */
@MultipartConfig
public class ProfileManager extends HttpServlet {

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
        request.getRequestDispatcher("./manager/profileManager.jsp").forward(request, response);
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
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        AccountValidation validator = new AccountValidation();
        ManagerDAO mdao = new ManagerDAO();
        JSONObject json = new JSONObject();
        String changePwd = request.getParameter("changePwd");
        String changeInfo = request.getParameter("changeInfo");
        Staff currentAccount = (Staff) session.getAttribute("staff");
        if (changePwd != null) {
            try {
                String currentPassword = request.getParameter("currentPassword");
                String newPassword = request.getParameter("newPassword");

                if (!validator.hashPassword(currentPassword).equals(currentAccount.getPassword())) {
                    json.put("success", false);
                    json.put("message", "Your current password is incorrect");
                    response.getWriter().write(json.toString());
                    return;
                }
                if (!validator.checkHashOfPassword(newPassword)) {
                    json.put("success", false);
                    json.put("message", "Password must be at least 8 characters long and include an uppercase letter, a lowercase letter, a number, a special character and not contains space characters.");
                    response.getWriter().write(json.toString());
                    return;
                }
                if (validator.hashPassword(newPassword).equals(currentAccount.getPassword())) {
                    json.put("success", false);
                    json.put("message", "Your new password matches your old password");
                    response.getWriter().write(json.toString());
                    return;
                }
                mdao.updateManagerPassword(currentAccount.getId(), validator.hashPassword(newPassword));
                currentAccount = mdao.getStaffById(currentAccount.getId());
                session.setAttribute("staff", currentAccount);
                json.put("success", true);
                response.getWriter().write(json.toString());
            } catch (IOException | JSONException e) {
                json.put("success", false);
                json.put("message", "An error occurred while changing password");
                response.getWriter().write(json.toString());
                System.out.println(e);
            }
        }

        if (changeInfo != null) {
            try {
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
                    String imgPath = mdao.getStaffById(currentAccount.getId()).getImage();
                    deleteFile(imgPath);
                } else {
                    image = mdao.getStaffById(currentAccount.getId()).getImage();
                }

                if (!(validator.isAlphabetic(firstname))) {
                    json.put("success", false);
                    json.put("message", "Invalid first name characters");
                    response.getWriter().write(json.toString());
                    return;
                }

                if (!(validator.isAlphabetic(lastname))) {
                    json.put("success", false);
                    json.put("message", "Invalid last name characters");
                    response.getWriter().write(json.toString());
                    return;
                }

                if (!validator.isValidPhone(phone)) {
                    json.put("success", false);
                    json.put("message", "Input must be the number and around 10 - 11 digits");
                    response.getWriter().write(json.toString());
                    return;
                }

                mdao.updateInformationStaff(currentAccount.getId(), image, firstname, lastname, gender, dob, phone, address);
                currentAccount = mdao.getStaffById(currentAccount.getId());
                session.setAttribute("staff", currentAccount);
                json.put("success", true);
                response.getWriter().write(json.toString());
            } catch (ServletException | IOException | JSONException e) {
                json.put("success", false);
                json.put("message", "An error occurred while updating information");
                response.getWriter().write(json.toString());
                System.out.println(e);
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
