/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.ceo;

import dal.CeoDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import model.Staff;
import org.apache.tomcat.dbcp.pool2.PoolUtils;
import util.AccountValidation;

/**
 *
 * @author Long
 */
@MultipartConfig
public class CeoProfileServlet extends HttpServlet {

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
        String fileName = System.currentTimeMillis() + "-" + filePart.getSubmittedFileName();
        // Combine the path and the file name
        String filePath = fileSavePath + File.separator + fileName;
        // Write the file to the specified path
        filePart.write(filePath);

        // Return the relative path for storing in the database
        return relativePath + fileName;
    }

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
        HttpSession session = request.getSession();
        CeoDAO aDao = new CeoDAO();
        AccountValidation validate = new AccountValidation();
        Staff currentAccount = (Staff) session.getAttribute("staff");

//        List<String> errorPassMess = new ArrayList<>();
//        String action = request.getParameter("action");
//        if (action != null) {
//            try {
//                String currentPassword = request.getParameter("oldPassword");
//                String newPassword = request.getParameter("newPassword");
//
//                if (!validate.hashPassword(currentPassword).equals(currentAccount.getPassword())) {
//                    errorPassMess.add("Your current password is incorrect");
//                } else if (!validate.checkHashOfPassword(newPassword)) {
//                    errorPassMess.add("Password must be at least 8 characters long and include an uppercase letter, "
//                            + "a lowercase letter, a number, a special character and not contains space characters.");
//                } else if (validate.hashPassword(newPassword).equals(currentAccount.getPassword())) {
//                    errorPassMess.add("Your new password matches your old password");
//                }
//                if (!errorPassMess.isEmpty()) {
//                    request.setAttribute("errorPassMess", errorPassMess);
//                    request.getRequestDispatcher("ceo/ceoProfile.jsp").forward(request, response);
//                    return;
//                }
//                aDao.updatePassword(currentAccount.getId(), validate.hashPassword(newPassword));
//                currentAccount = aDao.getStaffById(currentAccount.getId());
//                request.setAttribute("successMess", "Change password successfully. ");
//                session.setAttribute("staff", currentAccount);
//            } catch (Exception e) {
//                System.out.println(e);
//            }
//            request.getRequestDispatcher("ceo/ceoProfile.jsp").forward(request, response);
//            return;
//        }
        String username = validate.normalizeInput(request.getParameter("username"));
        String firstName = validate.normalizeInput(request.getParameter("firstname"));
        String lastName = validate.normalizeInput(request.getParameter("lastname"));
        String address = validate.normalizeInput(request.getParameter("address"));
        String gender = request.getParameter("gender");
        Part imagePart = request.getPart("image");
        String fileType = imagePart.getContentType();
        List<String> errorMessages = new ArrayList<>();
        // Xác thực dữ liệu
        if (validate.normalizeInput(username).isEmpty()) {
            errorMessages.add("Username is required.");
        }
        if (aDao.getStaffByUsername(username) != null && currentAccount.getId() != aDao.getStaffByUsername(username).getId()) {
            errorMessages.add("Duplicate username.");
        }

        if (!validate.isAlphabetic(validate.normalizeInput(firstName))) {
            errorMessages.add("Invalid first name");
        }

        if (!validate.isAlphabetic(validate.normalizeInput(lastName))) {
            errorMessages.add("Invalid last name");
        }
        String image = (imagePart != null && imagePart.getSize() > 0 ? getAndSaveImg(imagePart) : null);

        if (imagePart.getSize() > 1024 * 1024 * 5) {
            errorMessages.add("Image must be < 5mb");
        }
        if (image != null && !validate.isValidateImage(image)) {
            errorMessages.add("Image must be .jpg, .jpeg, .png");
        }
        // Nếu có lỗi, trả về trang trước đó với thông báo lỗi

        if (!errorMessages.isEmpty()) {
            request.setAttribute("errorMessages", errorMessages);
            request.getRequestDispatcher("ceo/ceoProfile.jsp").forward(request, response);
            return;
        }
        if (image != null) {
            String imgPath = currentAccount.getImage();
            if (!imgPath.equals("assets/images/default.jpg") && !image.equals(imgPath)) {
                deleteFile(imgPath);
            }
        } else {
            image = currentAccount.getImage();
        }
        currentAccount.setUsername(username);
        currentAccount.setFirstname(firstName);
        currentAccount.setLastname(lastName);
        currentAccount.setAddress(address);
        currentAccount.setGender(gender);
        currentAccount.setImage(image);
        aDao.updateStaffInfo(currentAccount, currentAccount.getId());
        session.setAttribute("staff", currentAccount);
        request.getRequestDispatcher("ceo/ceoProfile.jsp").forward(request, response);
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
