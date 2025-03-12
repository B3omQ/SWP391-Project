package controller.customer;

import dal.IdentityDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.List;
import model.Customer;
import model.VerifyIdentityInformation;
import org.json.JSONObject;
import util.AccountValidation;

@MultipartConfig
public class IdentityInformationController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("./customer/addIdentityInformation.jsp").forward(request, response);
    }

    private String getAndSaveImg(Part filePart) throws IOException {
        String relativePath = "assets/images/identityInformation/";
        String uploadPath = getServletContext().getRealPath("");
        String projectRoot = uploadPath.replace("build" + File.separator + "web", "");
        String fileSavePath = projectRoot + "web" + File.separator + relativePath;
        File uploadDir = new File(fileSavePath);

        // Ensure directory exists and is writable
        if (!uploadDir.exists()) {
            if (!uploadDir.mkdirs()) {
                throw new IOException("Failed to create upload directory: " + fileSavePath);
            }
        }
        if (!uploadDir.canWrite()) {
            throw new IOException("Upload directory is not writable: " + fileSavePath);
        }

        String fileName = System.currentTimeMillis() + "-" + filePart.getSubmittedFileName();
        String filePath = fileSavePath + File.separator + fileName;
        filePart.write(filePath);
        log("File saved successfully: " + filePath);
        return relativePath + fileName;
    }

    private boolean deleteFile(String relativeFilePath) {
        try {
            if (relativeFilePath == null || relativeFilePath.isEmpty()) {
                return true;
            }
            String uploadPath = getServletContext().getRealPath("");
            String projectRoot = uploadPath.replace("build" + File.separator + "web", "");
            String absoluteFilePath = projectRoot + "web" + File.separator + relativeFilePath.replace("/", File.separator);
            File file = new File(absoluteFilePath);
            if (file.exists()) {
                return file.delete();
            } else {
                log("File not found: " + absoluteFilePath);
                return true; // File doesn't exist, consider it "deleted"
            }
        } catch (Exception e) {
            log("Error deleting file: " + e.getMessage());
            return false;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONObject json = new JSONObject();
        AccountValidation validator = new AccountValidation();
        IdentityDAO idao = new IdentityDAO();
        String add = request.getParameter("add");
        String delete = request.getParameter("delete");
        String id = request.getParameter("customerId");
        String create = request.getParameter("create");

        if (create != null) {
            response.sendRedirect("identity-information-controller");
        }

        if (add != null) {
            try {
                int customerId = Integer.parseInt(id);
                String identityCardNumber = request.getParameter("identityCardNumber");
                Part identityCardFrontSide = request.getPart("identityCardFrontSide");
                Part identityCardBackSide = request.getPart("identityCardBackSide");
                Part portraitPhoto = request.getPart("portraitPhoto");

                if (idao.isDuplicatedIdentityNumber(identityCardNumber, customerId)) {
                    json.put("success", false);
                    json.put("message", "Identity card number already existed");
                    response.getWriter().write(json.toString());
                    return;
                }

                // Validate file sizes
                if (identityCardFrontSide.getSize() > 1024 * 1024 * 5
                        || identityCardBackSide.getSize() > 1024 * 1024 * 5
                        || portraitPhoto.getSize() > 1024 * 1024 * 5) {
                    json.put("success", false);
                    json.put("message", "Your file import is too big, please choose file size < 5 MB");
                    response.getWriter().write(json.toString());
                    return;
                }

                // Save files (null if no file uploaded)
                String imageIdentityCardFrontSide = (identityCardFrontSide != null && identityCardFrontSide.getSize() > 0)
                        ? getAndSaveImg(identityCardFrontSide) : null;
                String imageIdentityCardBackSide = (identityCardBackSide != null && identityCardBackSide.getSize() > 0)
                        ? getAndSaveImg(identityCardBackSide) : null;
                String imagePortraitPhoto = (portraitPhoto != null && portraitPhoto.getSize() > 0)
                        ? getAndSaveImg(portraitPhoto) : null;

                // Validate file types
                if ((imageIdentityCardFrontSide != null && !validator.isValidateImage(imageIdentityCardFrontSide))
                        || (imageIdentityCardBackSide != null && !validator.isValidateImage(imageIdentityCardBackSide))
                        || (imagePortraitPhoto != null && !validator.isValidateImage(imagePortraitPhoto))) {
                    json.put("success", false);
                    json.put("message", "Only accept file .jpg, .jpeg, .png, .gif");
                    response.getWriter().write(json.toString());
                    return;
                }

                // Insert into database
                idao.insertVerifyIdentityInformation(customerId,
                        identityCardNumber,
                        imageIdentityCardFrontSide,
                        imageIdentityCardBackSide,
                        imagePortraitPhoto);
                
                VerifyIdentityInformation deleteIdentity = idao.getVerifyIdentityInformationByIdAndStatus(customerId, "Denied");
                if (deleteIdentity != null) {
                    deleteFile(deleteIdentity.getIdentityCardBackSide());
                    deleteFile(deleteIdentity.getIdentityCardFrontSide());
                    deleteFile(deleteIdentity.getPortraitPhoto());
                    idao.deleteVerifyIdentityInformation(customerId, "Denied");
                }

                json.put("success", true);
                json.put("message", "Changes saved successfully");
                response.getWriter().write(json.toString());

                return;
            } catch (Exception e) {
            }
        }

//        if (delete != null) {
//            try {
//                int deleteId = Integer.parseInt(delete);
//                VerifyIdentityInformation identityInfo = idao.getVerifyIdentityInformationByCusId(deleteId);
//                if (identityInfo != null) {
//                    String identityCardFrontSide = identityInfo.getIdentityCardFrontSide();
//                    String identityCardBackSide = identityInfo.getIdentityCardBackSide();
//                    String portraitPhoto = identityInfo.getPortraitPhoto();
//
//                    deleteFile(identityCardFrontSide);
//                    deleteFile(identityCardBackSide);
//                    deleteFile(portraitPhoto);
//
//                    idao.deleteVerifyIdentityInformation(deleteId);
//                }
//                json.put("success", true);
//                json.put("message", "Information successfully deleted");
//                response.getWriter().write(json.toString());
//
//                return;
//            } catch (Exception e) {
//            }
//
//        }
    }

    @Override
    public String getServletInfo() {
        return "Identity Information Controller";
    }
}
