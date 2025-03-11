 package controller.customer;

import dal.CustomerDAO;
import dal.DepHistoryDAO;
import dal.DepServiceUsedDAO;
import jakarta.servlet.http.HttpServlet;
import model.Customer;
import model.DepServiceUsed;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import controller.calculation.InterestCalculator;

public class ConfirmDepositServlet extends HttpServlet {

    private final CustomerDAO customerDAO = new CustomerDAO();
    private final DepServiceUsedDAO depServiceUsedDAO = new DepServiceUsedDAO();
    private final DepHistoryDAO depHistoryDAO = new DepHistoryDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
            return;
        }
        Customer account = (Customer) session.getAttribute("account");
        Object rawDepositAmount = session.getAttribute("depositAmount");
        Object rawSelectedTerm = session.getAttribute("selectedTerm");

        if (rawDepositAmount == null || rawSelectedTerm == null) {
            response.sendRedirect(request.getContextPath() + "/customer/chooseTerm.jsp?error=missing_data");
            return;
        }

        try {
            BigDecimal depositAmount = new BigDecimal(rawDepositAmount.toString());
            int selectedTerm = Integer.parseInt(rawSelectedTerm.toString());
            BigDecimal currentBalance = customerDAO.getWalletByCustomerId(account.getId());
            int depId = depServiceUsedDAO.getDepIdByTerm(selectedTerm);
            if (depId == -1) {
                System.out.println("❌ Lỗi: Không tìm thấy DepId cho kỳ hạn " + selectedTerm);
                response.sendRedirect(request.getContextPath() + "/customer/confirmTermAction.jsp?error=invalid_term");
                return;
            }
            BigDecimal savingRate = depServiceUsedDAO.getSavingRateByDepId(depId);
            if (savingRate == null) {
                System.out.println("❌ Lỗi: Không tìm thấy lãi suất cho DepId " + depId);
                response.sendRedirect(request.getContextPath() + "/customer/confirmTermAction.jsp?error=invalid_rate");
                return;
            }
            BigDecimal calculatedInterest = InterestCalculator.calculateInterest(depositAmount, savingRate.doubleValue(), selectedTerm);
            String maturityDate = InterestCalculator.calculateMaturityDate(selectedTerm);
            boolean deducted = customerDAO.updateWallet(account.getId(), currentBalance.subtract(depositAmount));
            if (!deducted) {
                System.out.println("❌ Lỗi: Không thể trừ tiền tài khoản người dùng " + account.getId());
                response.sendRedirect(request.getContextPath() + "/customer/confirmTermAction.jsp?error=transaction_failed");
                return;
            }
            System.out.println("✅ Đã trừ tiền thành công. Số dư mới: " + currentBalance.subtract(depositAmount));

            String maturityAction = (String) session.getAttribute("selectedAction");
            System.out.println("✅ Giá trị selectedAction từ session: " + maturityAction);
            if (maturityAction == null) {
                System.out.println("⚠️ Cảnh báo: selectedAction là null, gán giá trị mặc định 'withdrawAll'");
                maturityAction = "withdrawAll";
            }

            // Tạo khoản tiền gửi mới với constructor bao gồm maturityAction
            DepServiceUsed newDep = new DepServiceUsed(
                0, // ID tự động tăng
                depId, // Gán DepId đúng
                account.getId(),
                1, // Giả sử DepTypeId = 1
                depositAmount,
                Timestamp.valueOf(LocalDateTime.now()),
                Timestamp.valueOf(LocalDateTime.now().plusDays(selectedTerm * 30)),
                "ACTIVE",
                maturityAction // Truyền giá trị đã kiểm tra
            );

            boolean added = depServiceUsedDAO.addDepServiceUsed(newDep);
            if (!added) {
                System.out.println("❌ Lỗi: Không thể thêm khoản gửi tiết kiệm của người dùng " + account.getId());
                response.sendRedirect(request.getContextPath() + "/customer/confirmTermAction.jsp?error=transaction_failed");
                return;
            }
            System.out.println("✅ Khoản gửi tiết kiệm đã được tạo thành công cho người dùng " + account.getId());

            // Lấy ID của DepServiceUsed vừa tạo để lưu vào DepHistory
            int dsuId = newDep.getId();
            System.out.println("✅ DSUId vừa tạo: " + dsuId);

            // Lưu lịch sử giao dịch
            boolean historyAdded = depHistoryDAO.addDepHistory(dsuId, "Gửi tiết kiệm kỳ hạn " + selectedTerm + " tháng");
            if (!historyAdded) {
                System.out.println("❌ Lỗi: Không thể thêm lịch sử giao dịch cho người dùng " + account.getId() + " với DSUId: " + dsuId);
                response.sendRedirect(request.getContextPath() + "/customer/confirmTermAction.jsp?error=history_failed");
                return;
            }
            System.out.println("✅ Đã ghi lịch sử gửi tiết kiệm cho người dùng " + account.getId() + " với DSUId: " + dsuId);

            // Cập nhật số dư trong đối tượng Customer trong session
            BigDecimal newBalance = currentBalance.subtract(depositAmount);
            Customer updatedAccount = account;
            updatedAccount.setWallet(newBalance);
            session.setAttribute("account", updatedAccount);

            // Lưu thông tin vào session để hiển thị trên confirmSuccess.jsp
            session.setAttribute("success", "Gửi tiết kiệm thành công!");
            session.setAttribute("newWalletBalance", newBalance);
            session.setAttribute("depositAmount", depositAmount);
            session.setAttribute("selectedTerm", selectedTerm);
            session.setAttribute("calculatedInterest", calculatedInterest);
            session.setAttribute("maturityDate", maturityDate);

            // Chuyển hướng đến trang kết quả
            response.sendRedirect(request.getContextPath() + "/customer/confirmSuccess.jsp");

        } catch (NumberFormatException e) {
            System.out.println("❌ Lỗi: Chuyển đổi dữ liệu gửi tiết kiệm thất bại.");
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/customer/confirmTermAction.jsp?error=invalid_data");
        } catch (Exception e) {
            System.out.println("❌ Lỗi không xác định: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/customer/confirmTermAction.jsp?error=unexpected_error");
        }
    }
}