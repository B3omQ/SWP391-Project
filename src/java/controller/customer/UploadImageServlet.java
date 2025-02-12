package controller.customer;

import dal.ConsultantDAO;
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

@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // Giới hạn file 5MB
public class UploadImageServlet extends HttpServlet {
    private static final String UPLOAD_DIRECTORY = "uploads";

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
        
        // Xác định trang đích dựa trên loại người dùng (Customer hay Staff)
        String targetPage = (account != null) 
                ? "/customer/template/account-profile.jsp" 
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
        if (!fileExtension.equals("jpg") && !fileExtension.equals("png")) {
            session.setAttribute("error2", "Loại file không hợp lệ. Chỉ chấp nhận file JPG và PNG.");
            response.sendRedirect(request.getContextPath() + targetPage);
            return;
        }

        String uploadPath = getServletContext().getRealPath("/") + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        if (account != null) {  
            Customer customer = (Customer) account;
            customer.setImage(fileName);  
            ConsultantDAO customerDAO = new ConsultantDAO();
            customerDAO.updateCustomerImage(customer.getId(), fileName);  
            
            session.setAttribute("account", customer);
            session.setAttribute("success2", "Cập nhật ảnh thành công.");
            response.sendRedirect(request.getContextPath() + targetPage);
        } else if (staff != null) {  
            Staff staffMember = (Staff) staff;
            staffMember.setImage(fileName);  
            StaffDAO staffDAO = new StaffDAO();
            staffDAO.updateStaffImage(staffMember.getId(), fileName); 
            
            session.setAttribute("staff", staffMember);
            session.setAttribute("success2", "Cập nhật ảnh thành công.");
            response.sendRedirect(request.getContextPath() + targetPage);
        }
    }
}
