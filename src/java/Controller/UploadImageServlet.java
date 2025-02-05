package Controller;

import Dal.CustomerDAO;
import Dal.StaffDAO;
import Model.Customer;
import Model.Staff;
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

@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // Giới hạn file 5MB
public class UploadImageServlet extends HttpServlet {
    private static final String UPLOAD_DIRECTORY = "uploads";

    @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    // Lấy session và kiểm tra xem account có tồn tại không
    HttpSession session = request.getSession(false);
    if (session == null) {
        response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
        return;
    }

    // Kiểm tra nếu session chứa customer hoặc staff
    Object account = session.getAttribute("account");
    Object staff = session.getAttribute("staff");
    
    if (account == null && staff == null) {
        response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
        return;
    }

    // Lấy file từ request
    Part filePart = request.getPart("image");
    if (filePart == null || filePart.getSize() == 0) {
        response.sendRedirect(request.getContextPath() + "/profile.jsp?error=NoFileSelected");
        return;
    }

    // Kiểm tra định dạng file hợp lệ
    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
    String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
    if (!fileExtension.equals("jpg") && !fileExtension.equals("png")) {
        response.sendRedirect(request.getContextPath() + "/profile.jsp?error=InvalidFileType");
        return;
    }

    // Định nghĩa đường dẫn upload
    String uploadPath = getServletContext().getRealPath("/") + UPLOAD_DIRECTORY;
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdir();
    }

    // Lưu file vào thư mục server
    String filePath = uploadPath + File.separator + fileName;
    filePart.write(filePath);

    // Kiểm tra và cập nhật ảnh cho Customer hoặc Staff
    if (account != null) {  // Customer
        Customer customer = (Customer) account;
        customer.setImage(fileName);  // Lưu tên file ảnh vào model
        CustomerDAO customerDAO = new CustomerDAO();
        customerDAO.updateCustomerImage(customer.getId(), fileName);  // Cập nhật ảnh trong DB
        
        // Chuyển hướng về trang profile của customer
        response.sendRedirect(request.getContextPath() + "/customer/account-profile.jsp?success=ImageUpdated");
    } else if (staff != null) {  // Staff
        Staff staffMember = (Staff) staff;
        staffMember.setImage(fileName);  // Lưu tên file ảnh vào model
        StaffDAO staffDAO = new StaffDAO();
        staffDAO.updateStaffImage(staffMember.getId(), fileName);  // Cập nhật ảnh trong DB
        
        // Chuyển hướng về trang profile của staff
        response.sendRedirect(request.getContextPath() + "/staff/staff-profile.jsp?success=ImageUpdated");
    }
}


}
