/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.consultant;

import dal.ConsultantDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.time.LocalDate;
import model.Staff;
import util.AccountValidation;

/**
 *
 * @author LAPTOP
 */
@MultipartConfig
public class ConsultantProfile extends HttpServlet {

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
        request.getRequestDispatcher("./consultant/profileConsultant.jsp").forward(request, response);
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
        AccountValidation av = new AccountValidation();
        String changeInfo = request.getParameter("changeInfo");
        String changePwd = request.getParameter("changePwd");
        String changeEmail = request.getParameter("changeEmail");
        String deleteAccount = request.getParameter("deleteAccount");
        HttpSession session = request.getSession();
        Staff currentAccount = (Staff) session.getAttribute("staff");
        ConsultantDAO cdao = new ConsultantDAO();

        if (changeInfo != null) {
            try {
                String username = request.getParameter("username");
                String firstname = request.getParameter("firstname");
                String lastname = request.getParameter("lastname");
                String gender = request.getParameter("gender");
                String dobStr = request.getParameter("dob");
                String phone = request.getParameter("phoneNumber");
                String address = request.getParameter("address");
                LocalDate dob = LocalDate.parse(dobStr);
                
                
                if (phone != null && !phone.isEmpty() && cdao.isDuplicatedPhoneNumber(phone)) {
                    response.setContentType("text/plain");
                    response.getWriter().write("errorPhoneExist");
                    System.out.println("đã block phone");
                    return;
                }
                
                Part imagePart = request.getPart("otherImage");
                String image = (imagePart != null && imagePart.getSize() > 0) ? getAndSaveImg(imagePart) : currentAccount.getImage();
                if (imagePart.getSize() > 1024 * 1024 * 5) {
                    response.setContentType("text/plain");
                    response.getWriter().write("errorImageSize");
                    System.out.println("đã block image do quá dung lượng cho phép");
                    return;
                }
                if (!validator.isValidImagePath(image)) {
                    response.setContentType("text/plain");
                    response.getWriter().write("errorImageType");
                    System.out.println("đã block image do không đúng định dạng");
                    return;
                }
                cdao.updateInformationStaff(currentAccount.getId(), image, username, firstname, lastname, gender, dob, phone, address);
                Staff updatedAccount = cdao.getStaffById(currentAccount.getId());
                session.setAttribute("staff", updatedAccount);
                response.sendRedirect("ConsultantProfile");
                return;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (changePwd != null) {
            try {
                String password = currentAccount.getPassword();
                String currentpassword = request.getParameter("currentpassword");
                String newpassword = request.getParameter("newpassword");
                String confirmpassword = request.getParameter("confirmpassword");
                if (!av.checkPassword(currentpassword, password)) {
                    response.setContentType("text/plain");
                    response.getWriter().write("errorCheckPassword");
                    System.out.println("password không đúng");
                    return;
                }
                if (!newpassword.equals(confirmpassword)) {
                    response.setContentType("text/plain");
                    response.getWriter().write("errorConfirmPassword");
                    System.out.println("Confirm password không đúng");
                    return;
                }
                cdao.updatePasswordByIdStaff(currentAccount.getId(), newpassword);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (changeEmail != null) {
            try {
                String updateEmail = request.getParameter("updateEmail");
                if (cdao.isDuplicatedEmail(updateEmail)) {
                    response.setContentType("text/plain");
                    response.getWriter().write("errorEmailexist");
                    System.out.println("đã block");
                    return;
                }
                cdao.updateEmailStaff(currentAccount.getId(), updateEmail);
                Staff updatedAccount = cdao.getStaffById(currentAccount.getId());
                session.setAttribute("staff", updatedAccount);
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
        if (deleteAccount != null) {
            try {
                cdao.deleteStaff(currentAccount.getId());
            } catch (Exception e) {
                e.printStackTrace();
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
