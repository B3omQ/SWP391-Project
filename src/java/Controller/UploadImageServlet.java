package Controller;

import Dal.CustomerDAO;
import Model.Customer;
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

        // Lấy customer từ session
 HttpSession session = request.getSession(false);
if (session == null || session.getAttribute("account") == null) {
    response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
    return;
}

Customer customer = (Customer) session.getAttribute("account");


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

        // Cập nhật đường dẫn ảnh vào database
        CustomerDAO customerDAO = new CustomerDAO();
        customer.setImage(fileName);  // Lưu tên file ảnh vào model
        customerDAO.updateCustomerImage(customer.getId(), fileName);

        // Chuyển hướng về trang profile
        response.sendRedirect(request.getContextPath() + "/account-profile.jsp?success=ImageUpdated");
    }
}
