/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.ceo;

import dal.CeoDAO;
import dal.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import model.LoanServiceUsed;
import controller.calculation.InterestCalculator;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.Period;
import java.time.temporal.ChronoUnit;

/**
 *
 * @author Long
 */
public class CustomerLoanPayment extends HttpServlet {

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
            out.println("<title>Servlet CustomerLoanPayment</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CustomerLoanPayment at " + request.getContextPath() + "</h1>");
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
        CeoDAO dao = new CeoDAO();
        HttpSession session = request.getSession();
        String payType = request.getParameter("payType");
        if (payType == null || payType.trim().isEmpty()) {
            if (payType == null) {
                payType = "Monthly";
            }
        } 
        request.setAttribute("payType", payType);

        String loanServiceUsedId = request.getParameter("loanId");
        LoanServiceUsed loan = dao.getLoanServiceUsedById(Integer.parseInt(loanServiceUsedId));
        request.setAttribute("loan", loan);

        // Tinh tien lai dinh ky 
        BigDecimal interestAmount = InterestCalculator.calculateMonthlyInterestPayment(loan);
        request.setAttribute("interestAmount", interestAmount);
        // Tinh thoi gian thanh toan dinh ky
        LocalDate startDate = loan.getStartDate().toLocalDateTime().toLocalDate();
        
        // Tinh debt count de xac dinh da tra duoc tien cho bao nhieu thang -> xac dinh ngay tra no dinh ky tiep theo
        int debtCount = InterestCalculator.getDebtCount(loan);
        
        LocalDate minLocalDate = startDate.plusMonths(debtCount);
        LocalDate dueLocalDate = startDate.plusMonths(debtCount + 1);
        // Chuyển LocalDate thành Timestamp
        Timestamp minDate = Timestamp.valueOf(minLocalDate.atStartOfDay());
        Timestamp dueDate = Timestamp.valueOf(dueLocalDate.atStartOfDay());
        request.setAttribute("minDate", minDate);
        request.setAttribute("dueDate", dueDate);
        // No lai trong han
        BigDecimal overdueInterestDebt = BigDecimal.ZERO;
        // No lai qua han
        BigDecimal overduePrincipal = BigDecimal.ZERO;
        // Ngày hiện tại
        LocalDate today = LocalDate.now();
        // Kiểm tra nếu đã quá hạn kỳ này
        if (today.isAfter(dueLocalDate)) {
            // Tính nợ lãi quá hạn
            long overdueDays = ChronoUnit.DAYS.between(dueLocalDate, today);
            request.setAttribute("overdueDays", overdueDays);
            overdueInterestDebt = InterestCalculator.calculateOverdueInterestDebt(loan, interestAmount, overdueDays);
        }
        LocalDate endDate = loan.getEndDate().toLocalDateTime().toLocalDate();
        // Kiểm tra nếu đã quá hạn tổng (tức là đã quá hạn cuối cùng của khoản vay)
        if (today.isAfter(endDate)) {
            // Số ngày quá hạn tổng
            long totalOverdueDays = ChronoUnit.DAYS.between(endDate, today);
            request.setAttribute("totalOverdueDays", totalOverdueDays);
            // Tính nợ gốc quá hạn
            overduePrincipal = InterestCalculator.calculateOverduePrincipal(loan, totalOverdueDays);
        }
        request.setAttribute("overdueInterestDebt", overdueInterestDebt);
        request.setAttribute("overduePrincipal", overduePrincipal);

        // Tính tổng số tháng cần thanh toán đến hết tháng hiện tại
        long monthsToPay = ChronoUnit.MONTHS.between(minLocalDate, today) + 1;
//        if (today.getDayOfMonth() < dueLocalDate.getDayOfMonth()) {
//            monthsToPay--; // Nếu chưa đến ngày thanh toán kỳ tiếp theo, giảm 1 kỳ
//        }
        // Đảm bảo không vượt quá thời gian khoản vay
        monthsToPay = Math.min(monthsToPay, loan.getLoanId().getDuringTime() - debtCount);
        if (payType.equalsIgnoreCase("Monthly")) {
            monthsToPay = 1;
        }
        request.setAttribute("monthsToPay", monthsToPay);
        request.setAttribute("debtCount", debtCount);

        // Tong so tien phai tra = tong goc + lai + no lai 
        BigDecimal paymentAmount = InterestCalculator.calculateTotalPaymentMonthly(loan);
        if (monthsToPay > 1) {
            paymentAmount = InterestCalculator.calculateTotalPaymentMonths(loan, (int) monthsToPay);
        }
        if (payType.equalsIgnoreCase("Full")) {
            int count = 0;
            if (today.isBefore(endDate)) {
                count = loan.getLoanId().getDuringTime() - debtCount;
            }
            paymentAmount = InterestCalculator.calculateTotalPayment(loan, count);
        }
        paymentAmount = paymentAmount.add(overdueInterestDebt).add(overduePrincipal);
        request.setAttribute("paymentAmount", paymentAmount);
        request.getRequestDispatcher("./ceo/customerLoanPayment.jsp").forward(request, response);
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
        CeoDAO dao = new CeoDAO();
        HttpSession session = request.getSession();
        String loanIdStr = request.getParameter("loanId");
        String repayAmountStr = request.getParameter("repayAmount");
        request.setAttribute("paymentAmount", repayAmountStr);
        String payType = request.getParameter("pType");
        LoanServiceUsed loan = dao.getLoanServiceUsedById(Integer.parseInt(loanIdStr));
        String monthsToPayStr = request.getParameter("monthsToPay");
        int monthsToPay = Integer.parseInt(monthsToPayStr);

        if (loanIdStr == null || repayAmountStr == null || loanIdStr.isEmpty() || repayAmountStr.isEmpty()) {
            request.setAttribute("errorMess", "Thông tin không hợp lệ!");
            request.getRequestDispatcher("./ceo/customerLoanPayment.jsp").forward(request, response);
            return;
        }
        try {
            BigDecimal repayAmount = new BigDecimal(repayAmountStr);
            BigDecimal customerWallet = loan.getCusId().getWallet();
            if (customerWallet.compareTo(repayAmount) < 0) {
                request.setAttribute("errorMess", "Số dư trong ví không đủ thanh toán");
                request.getRequestDispatcher("./ceo/customerLoanPayment.jsp").forward(request, response);
                return;
            }
            // Thanh toan khoan vay
            BigDecimal newDebtRepayAmount = InterestCalculator.calculateBaseDebtRemain(loan, monthsToPay);
            if (payType.equalsIgnoreCase("Full")) {
                newDebtRepayAmount = BigDecimal.ZERO;
            }
            boolean isSuccessPayment = dao.customerPayLoan(newDebtRepayAmount, loan.getId());
            //Cap nhat thong tin khoan vay thanh done neu khach hang tra het 
            if (dao.getLoanServiceUsedById(loan.getId()).getDebtRepayAmount().compareTo(BigDecimal.ZERO) == 0) {
                dao.updateLoanStatus(loan.getId(), "Done");
            }
            //Cap nhat so du trong vi khach hang
            CustomerDAO cDAO = new CustomerDAO();
            cDAO.updateWallet(loan.getCusId().getId(), loan.getCusId().getWallet().subtract(repayAmount));
            //Ghi lai lich su thanh toan cua khach hang
            dao.insertPayment(loan.getId(), repayAmount);
            loan = dao.getLoanServiceUsedById(Integer.parseInt(loanIdStr));
            request.setAttribute("loan", loan);
            if (isSuccessPayment) {
                request.setAttribute("message", "Thanh toán thành công!");
            } else {
                request.setAttribute("errorMess", "Thanh toán thất bại. Vui lòng thử lại!");
            }
            request.getRequestDispatcher("./ceo/paymentResult.jsp").forward(request, response);
        } catch (NumberFormatException ex) {
            request.setAttribute("errorMess", "Dữ liệu không hợp lệ!");
            loan = dao.getLoanServiceUsedById(Integer.parseInt(loanIdStr));
            request.setAttribute("loan", loan);
            request.getRequestDispatcher("./ceo/customerLoanPayment.jsp").forward(request, response);
        }
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
