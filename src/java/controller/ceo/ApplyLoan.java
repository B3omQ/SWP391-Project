/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.ceo;

import controller.calculation.InterestCalculator;
import dal.CeoDAO;
import dal.IdentityDAO;
import dal.LoanServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.LoanService;
import model.Customer;
import model.LoanServiceUsed;
import model.VerifyIdentityInformation;
import util.AccountValidation;

/**
 *
 * @author Long
 */
@MultipartConfig
public class ApplyLoan extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ApplyLoan</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ApplyLoan at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        CeoDAO ceoDao = new CeoDAO();
        List<LoanService> listLoan = ceoDao.getAllLoanServiceByStatus("Approved", "DuringTime", "ASC", "", 1, 10);
        request.setAttribute("optionLoanList", listLoan);
        request.getRequestDispatcher("ceo/applyLoan.jsp").forward(request, response);
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
        List<String> errorMessages = new ArrayList<>();
        CeoDAO aDao = new CeoDAO();
        AccountValidation validate = new AccountValidation();
        Customer currentAccount = (Customer) session.getAttribute("account");
        
        if (currentAccount != null) {
            int cusId = currentAccount.getId();

            // Nếu khách hàng có khoản vay quá hạn mà chưa bị blacklist thì thêm vào danh sách đen
            if (aDao.isOverdue(cusId) && !aDao.isBlacklisted(cusId)) {
                aDao.addToBlacklist(cusId, "Quá hạn trả nợ");
                session.setAttribute("blacklistStatus", "Bạn đã bị chặn do quá hạn trả nợ!");
            }
        }
        if (aDao.isBlacklisted(currentAccount.getId())) {
            errorMessages.add("Bạn không thể thực hiện giao dịch vì bạn đang bị blacklist.");
            request.setAttribute("errorMessages", errorMessages);
            List<LoanService> listLoan = aDao.getAllLoanServiceByStatus("Approved", "DuringTime", "ASC", "", 1, 10);
            request.setAttribute("optionLoanList", listLoan);
            request.getRequestDispatcher("ceo/applyLoan.jsp").forward(request, response);
            return;
        }
//        Customer currentAccount = aDao.getCustomerById(2);
        IdentityDAO idao = new IdentityDAO();
        List<VerifyIdentityInformation> identityList = idao.getListVerifyIdentityInformationByCusId(currentAccount.getId());
        VerifyIdentityInformation reasonRejectIdentity = idao.getTop1(currentAccount.getId(), "Denied");
        request.setAttribute("identityList", identityList);

        if (idao.countStatus(currentAccount.getId(), "Pending") == 1) {
            session.setAttribute("status", "pending");
            request.getRequestDispatcher("./customer/identityInformation.jsp").forward(request, response);
            return;
        }

        if (idao.countStatus(currentAccount.getId(), "Denied") > 0) {
            session.setAttribute("reasonRejectIdentity", reasonRejectIdentity);
            session.setAttribute("status", "denied");
            request.getRequestDispatcher("./customer/identityInformation.jsp").forward(request, response);
            return;
        }
        if (idao.countStatus(currentAccount.getId(), "Approved") != 1) {
            session.setAttribute("status", "none");
            request.getRequestDispatcher("./customer/addIdentityInformation.jsp").forward(request, response);
            return;
        }

        String loanIDParam = request.getParameter("loanId");
        String amountParam = validate.normalizeInput(request.getParameter("amount"));
        Part imagePart = request.getPart("incomeVertification");
        String fileType = imagePart.getContentType();

        // Validate loan service ID
        int loanID = 0;
        if (loanIDParam == null || loanIDParam.trim().isEmpty()) {
            errorMessages.add("Loan service is required.");
        } else {
            try {
                loanID = Integer.parseInt(loanIDParam);
            } catch (NumberFormatException e) {
                errorMessages.add("Invalid Loan Service.");
            }
        }
        // Validate amount
        BigDecimal loanAmount = null;
        if (amountParam == null || amountParam.isEmpty()) {
            errorMessages.add("Loan amount is required.");
        } else {
            try {
                loanAmount = new BigDecimal(amountParam);
            } catch (NumberFormatException e) {
                errorMessages.add("Invalid loan amount format.");
            }
        }
        if (loanID != 0) {
            if(loanAmount.compareTo(aDao.getLoanServiceById(loanID).getMinimumLoan()) < 0 || 
                loanAmount.compareTo(aDao.getLoanServiceById(loanID).getMaximumLoan()) > 0){
            errorMessages.add("Loan amount is not in the valid loan range.");
        }
        }
        
        String image = (imagePart != null && imagePart.getSize() > 0 ? getAndSaveImg(imagePart) : null);

        if (imagePart.getSize() > 1024 * 1024 * 5) {
            errorMessages.add("Image must be < 5mb");
        }
        // Kiểm tra file có đúng định dạng ZIP không
        if (!image.endsWith(".zip")) {
            errorMessages.add("Only accept zip file");
        }
        if (image == null) {
            errorMessages.add("Missing income vertification");
        }
        // Nếu có lỗi, trả về trang trước đó với thông báo lỗi

        if (!errorMessages.isEmpty()) {
            request.setAttribute("errorMessages", errorMessages);
            List<LoanService> listLoan = aDao.getAllLoanServiceByStatus("Approved", "DuringTime", "ASC", "", 1, 10);
            request.setAttribute("optionLoanList", listLoan);
            request.getRequestDispatcher("ceo/applyLoan.jsp").forward(request, response);
            return;
        }
        LoanService loanService = new LoanServiceDAO().getLoanServiceById(loanID);

        LoanServiceUsed loanServiceUsed = new LoanServiceUsed(
                0,
                loanService,
                currentAccount,
                loanAmount,
                Timestamp.valueOf(LocalDateTime.now()),
                Timestamp.valueOf(LocalDateTime.now().plusDays(loanService.getDuringTime() * 30)),
                0,
                loanAmount,
                image,
                "Pending");

        // Call the DAL method to insert the new record into the database
        boolean isInserted = aDao.createLoanServiceUsed(loanServiceUsed);

        if (isInserted) {
            request.setAttribute("loanServiceUsed", loanServiceUsed);
            request.getRequestDispatcher("ceo/successApplyLoan.jsp").forward(request, response);
            return;
        }
        request.getRequestDispatcher("ceo/applyLoan.jsp").forward(request, response);
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
