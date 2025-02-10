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
        String changePwd = request.getParameter("changePwd");
        String changeInfo = request.getParameter("changeInfo");
        HttpSession session = request.getSession();
        Staff currentAccount = (Staff) session.getAttribute("staff");
        ManagerDAO mdao = new ManagerDAO();
//        if (changePwd != null) {
//            String newPassword = request.getParameter("password");
//            udao.changePassword(currentAccount.getId(), newPassword);
//        }

        if (changeInfo != null) {
            try {
                String firstname = request.getParameter("newFirstname");
                String lastname = request.getParameter("newLastname");
                String gender = request.getParameter("newGender");
                String dobStr = request.getParameter("newDob");
                String phone = request.getParameter("newPhone");
                String address = request.getParameter("newAddress");
                LocalDate dob = LocalDate.parse(dobStr);
                Part imagePart = request.getPart("newImg");
                String image = (imagePart != null && imagePart.getSize() > 0 ? getAndSaveImg(imagePart) : null);
                if (image != null) {
                    String imgPath = mdao.getStaffById(currentAccount.getId()).getImage();
                    deleteFile(imgPath);
                } else {
                    image = mdao.getStaffById(currentAccount.getId()).getImage();
                }
                mdao.updateInformationStaff(currentAccount.getId(), image, firstname, lastname, gender, dob, phone, address);
                currentAccount = mdao.getStaffById(currentAccount.getId());
                session.setAttribute("staff", currentAccount);

                response.sendRedirect("profile-manager");

                return;
            } catch (Exception e) {
                System.out.println(e);
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
