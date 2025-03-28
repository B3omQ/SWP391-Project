package controller.customer;

import dal.ConsultantDAO;
import dal.CustomerDAO;
import dal.StaffDAO;
import model.Customer;
import model.Staff;
import java.io.IOException;
import java.nio.file.Paths;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;

/**
 *
 * @author emkob
 */
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // Giới hạn file 5MB
public class UploadImageServlet extends HttpServlet {
    private static final String UPLOAD_DIRECTORY = "assets/images";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
            return;
        }

        Object account = session.getAttribute("account");
        Object staff = session.getAttribute("staff");

        if (account == null && staff == null) {
            response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
            return;
        }

        String targetPage = (account != null)
                ? "/customer/account-profile.jsp"
                : "/staff/template/staff-profile.jsp";

        Part filePart = request.getPart("image");
        if (filePart == null || filePart.getSize() == 0) {
            session.setAttribute("error2", "Không có file được chọn.");
            response.sendRedirect(request.getContextPath() + targetPage);
            return;
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
        if (!fileExtension.equals("jpg") && !fileExtension.equals("png")) {
            session.setAttribute("error2", "Loại file không hợp lệ. Chỉ chấp nhận file JPG và PNG.");
            response.sendRedirect(request.getContextPath() + targetPage);
            return;
        }

        String uploadPath = getServletContext().getRealPath("/") + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        if (account != null) {
            Customer customer = (Customer) account;
            String oldImage = customer.getImage();
            if (oldImage != null && !oldImage.isEmpty()) {
                File oldImageFile = new File(getServletContext().getRealPath("/") + oldImage);
                if (oldImageFile.exists()) {
                    oldImageFile.delete();
                }
            }
        } else if (staff != null) {
            Staff staffMember = (Staff) staff;
            String oldImage = staffMember.getImage();
            if (oldImage != null && !oldImage.isEmpty()) {
                File oldImageFile = new File(getServletContext().getRealPath("/") + oldImage);
                if (oldImageFile.exists()) {
                    oldImageFile.delete();
                }
            }
        }

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        String fullImagePath = UPLOAD_DIRECTORY + "/" + fileName;

        if (account != null) {
            Customer customer = (Customer) account;
            customer.setImage(fullImagePath); 
            CustomerDAO customerDAO = new CustomerDAO();
            customerDAO.updateCustomerImage(customer.getId(), fullImagePath); 

            session.setAttribute("account", customer);
            session.setAttribute("success2", "Cập nhật ảnh thành công.");
            response.sendRedirect(request.getContextPath() + targetPage);
        } else if (staff != null) {
            Staff staffMember = (Staff) staff;
            staffMember.setImage(fullImagePath); // Lưu đường dẫn đầy đủ
            StaffDAO staffDAO = new StaffDAO();
            staffDAO.updateStaffImage(staffMember.getId(), fullImagePath); // Cập nhật đường dẫn đầy đủ vào DB

            session.setAttribute("staff", staffMember);
            session.setAttribute("success2", "Cập nhật ảnh thành công.");
            response.sendRedirect(request.getContextPath() + targetPage);
        }
    }
}