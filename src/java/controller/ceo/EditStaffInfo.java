/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.ceo;

import dal.CeoDAO;
import model.Role;
import model.Staff;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import util.AccountValidation;

/**
 *
 * @author Long
 */
@MultipartConfig
public class EditStaffInfo extends HttpServlet {

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
        String fileName = filePart.getSubmittedFileName();
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
        String acccountId = request.getParameter("uid");
        CeoDAO aDao = new CeoDAO();
        try {
            int uid = Integer.parseInt(acccountId);
            Staff a = aDao.getStaffById(uid);
            request.setAttribute("staff", a);
            List<Role> roles = aDao.getAllRoles();
            request.setAttribute("roles", roles);
            request.getRequestDispatcher("ceo/editStaffInfo.jsp").forward(request, response);
        } catch (NumberFormatException e) {

        }

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
        int id = Integer.parseInt(request.getParameter("id"));
        String username = validate.normalizeInput(request.getParameter("username"));
        String firstName = validate.normalizeInput(request.getParameter("firstName"));
        String lastName = validate.normalizeInput(request.getParameter("lastName"));
        String phone = request.getParameter("phone").trim();
        String email = request.getParameter("email").trim();
        String address = validate.normalizeInput(request.getParameter("address"));
        String role = request.getParameter("role");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String salary = request.getParameter("salary");
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate date = LocalDate.parse(dob, formatter);
        BigDecimal bigDecimalValue = new BigDecimal(salary);
        Part imagePart = request.getPart("image");
        String fileType = imagePart.getContentType();
        List<String> errorMessages = new ArrayList<>();
        List<Role> roles = aDao.getAllRoles();
        request.setAttribute("roles", roles);

        // Xác thực dữ liệu
        // Xác thực dữ liệu
        if (validate.normalizeInput(username).isEmpty()) {
            errorMessages.add("Username is required.");
        }

        if (!validate.isValidEmail(email)) {
            errorMessages.add("Invalid email format.");
        }

        if (aDao.getStaffByEmail(email) != null && id != aDao.getStaffByEmail(email).getId()) {
            errorMessages.add("Duplicate email.");
        }

        if (!validate.isAlphabetic(validate.normalizeInput(firstName))) {
            errorMessages.add("Invalid first name");
        }

        if (!validate.isAlphabetic(validate.normalizeInput(lastName))) {
            errorMessages.add("Invalid last name");
        }

        if (dob == null || dob.isEmpty()) {
            errorMessages.add("Date of Birth is required.");
        } else {
            try {
                // 2. Kiểm tra định dạng và ngày hợp lệ
                LocalDate dateOfBirth = LocalDate.parse(dob, formatter);
                LocalDate today = LocalDate.now();

                // 3. Ngày không được ở tương lai
                if (dateOfBirth.isAfter(today)) {
                    errorMessages.add("Date of Birth cannot be in the future.");
                }
            } catch (Exception e) {
                errorMessages.add("Invalid date.");
            }
        }

        if (!validate.isValidPhone(phone)) {
            errorMessages.add("Invalid phone number.");
        }
        if (aDao.getStaffByPhone(phone) != null && id != aDao.getStaffByPhone(phone).getId()) {
            errorMessages.add("Duplicate phone number.");
        }

        double w = 0;
        try {
            w = Double.parseDouble(salary);
            if (w < 0) {
                errorMessages.add("Salary cannot be negative.");
            }
        } catch (NumberFormatException e) {
            errorMessages.add("Salary must be a valid number.");
        }
        String image = (imagePart != null && imagePart.getSize() > 0 ? getAndSaveImg(imagePart) : null);

        if (imagePart.getSize() > 1024 * 1024 * 5) {
            errorMessages.add("Image must be < 5mb");
        }

        // Nếu có lỗi, trả về trang trước đó với thông báo lỗi
        if (!errorMessages.isEmpty()) {
            request.setAttribute("errorMessages", errorMessages);
            request.setAttribute("staff", new Staff(id, username, "", image, email, firstName, lastName, gender, date, phone, address, bigDecimalValue,
                    id, LocalDateTime.MIN, new Role(aDao.getRoleIdByName(role), role)));
            request.getRequestDispatcher("ceo/editStaffInfo.jsp").forward(request, response);
            return;
        }

        if (image != null) {
            String imgPath = aDao.getStaffById(id).getImage();
            if (!imgPath.equals("assets/images/default.jpg")) {
                deleteFile(imgPath);
            }
        } else {
            image = aDao.getStaffById(id).getImage();
        }

        Staff staff = new Staff(id, username, "", image, email, firstName, lastName, gender, date, phone, address, bigDecimalValue,
                id, LocalDateTime.MIN, new Role(aDao.getRoleIdByName(role), role));// Cập nhật thông tin người dùng
        aDao.updateStaffInfo(staff, id);
        response.sendRedirect("staffManagement");
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
