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

// Sử dụng InterestCalculator hiện tại mà không sửa đổi
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
            System.out.println("⚠️ Lỗi: Session không hợp lệ hoặc người dùng chưa đăng nhập.");
            response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
            return;
        }

        // Lấy thông tin từ session
        Customer account = (Customer) session.getAttribute("account");
        Object rawDepositAmount = session.getAttribute("depositAmount");
        Object rawSelectedTerm = session.getAttribute("selectedTerm");

        if (rawDepositAmount == null || rawSelectedTerm == null) {
            System.out.println("⚠️ Lỗi: Thiếu dữ liệu gửi tiết kiệm.");
            response.sendRedirect(request.getContextPath() + "/customer/template/chooseTerm.jsp?error=missing_data");
            return;
        }

        try {
            BigDecimal depositAmount = new BigDecimal(rawDepositAmount.toString());
            int selectedTerm = Integer.parseInt(rawSelectedTerm.toString());

            System.out.println("✅ Người dùng " + account.getId() + " đang gửi tiết kiệm số tiền " 
                    + depositAmount + " kỳ hạn " + selectedTerm + " tháng.");

            // Kiểm tra số dư tài khoản
            BigDecimal currentBalance = customerDAO.getWalletByCustomerId(account.getId());

            if (currentBalance.compareTo(depositAmount) < 0) {
                System.out.println("❌ Lỗi: Người dùng " + account.getId() 
                        + " không đủ số dư. Số dư hiện tại: " + currentBalance 
                        + ", số tiền gửi: " + depositAmount);
                response.sendRedirect(request.getContextPath() + "/customer/template/confirmTermAction.jsp?error=insufficient_balance");
                return;
            }

            // Lấy DepId theo kỳ hạn (giả định phương thức này trả về DepId đúng)
            int depId = depServiceUsedDAO.getDepIdByTerm(selectedTerm);
            if (depId == -1) {
                System.out.println("❌ Lỗi: Không tìm thấy DepId cho kỳ hạn " + selectedTerm);
                response.sendRedirect(request.getContextPath() + "/customer/template/confirmTermAction.jsp?error=invalid_term");
                return;
            }
            System.out.println("✅ Tìm thấy DepId: " + depId);

            // Lấy lãi suất từ DepService (giả định bạn có phương thức trong DepServiceUsedDAO)
            BigDecimal savingRate = depServiceUsedDAO.getSavingRateByDepId(depId);
            if (savingRate == null) {
                System.out.println("❌ Lỗi: Không tìm thấy lãi suất cho DepId " + depId);
                response.sendRedirect(request.getContextPath() + "/customer/template/confirmTermAction.jsp?error=invalid_rate");
                return;
            }

            // Tính lãi và ngày đáo hạn sử dụng InterestCalculator hiện tại
            BigDecimal calculatedInterest = InterestCalculator.calculateInterest(depositAmount, savingRate, selectedTerm);
            String maturityDate = InterestCalculator.calculateMaturityDate(selectedTerm);

            // Trừ tiền khỏi tài khoản khách hàng
            boolean deducted = customerDAO.updateWallet(account.getId(), currentBalance.subtract(depositAmount));
            if (!deducted) {
                System.out.println("❌ Lỗi: Không thể trừ tiền tài khoản người dùng " + account.getId());
                response.sendRedirect(request.getContextPath() + "/customer/template/confirmTermAction.jsp?error=transaction_failed");
                return;
            }
            System.out.println("✅ Đã trừ tiền thành công. Số dư mới: " + currentBalance.subtract(depositAmount));

            // Tạo khoản tiền gửi mới
            DepServiceUsed newDep = new DepServiceUsed(
                0, // ID tự động tăng
                depId, // Gán DepId đúng
                account.getId(),
                1, // Giả sử DepTypeId = 1
                depositAmount,
                Timestamp.valueOf(LocalDateTime.now()),
                Timestamp.valueOf(LocalDateTime.now().plusDays(selectedTerm * 30)), // Sử dụng plusDays để khớp với InterestCalculator
                "ACTIVE"
            );

            boolean added = depServiceUsedDAO.addDepServiceUsed(newDep);
            if (!added) {
                System.out.println("❌ Lỗi: Không thể thêm khoản gửi tiết kiệm của người dùng " + account.getId());
                response.sendRedirect(request.getContextPath() + "/customer/template/confirmTermAction.jsp?error=transaction_failed");
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
                response.sendRedirect(request.getContextPath() + "/customer/template/confirmTermAction.jsp?error=history_failed");
                return;
            }
            System.out.println("✅ Đã ghi lịch sử gửi tiết kiệm cho người dùng " + account.getId() + " với DSUId: " + dsuId);

            // Cập nhật số dư trong đối tượng Customer trong session
            BigDecimal newBalance = currentBalance.subtract(depositAmount);
            Customer updatedAccount = account;
            updatedAccount.setWallet(newBalance); // Cập nhật số dư mới
            session.setAttribute("account", updatedAccount); // Lưu lại vào session

            // Lưu thông tin vào session để hiển thị trên confirmSuccess.jsp
            session.setAttribute("success", "Gửi tiết kiệm thành công!");
            session.setAttribute("newWalletBalance", newBalance);
            session.setAttribute("depositAmount", depositAmount);
            session.setAttribute("selectedTerm", selectedTerm);
            session.setAttribute("calculatedInterest", calculatedInterest);
            session.setAttribute("maturityDate", maturityDate);

            // Chuyển hướng đến trang kết quả
            response.sendRedirect(request.getContextPath() + "/customer/template/confirmSuccess.jsp");

        } catch (NumberFormatException e) {
            System.out.println("❌ Lỗi: Chuyển đổi dữ liệu gửi tiết kiệm thất bại.");
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/customer/template/confirmTermAction.jsp?error=invalid_data");
        } catch (Exception e) {
            System.out.println("❌ Lỗi không xác định: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/customer/template/confirmTermAction.jsp?error=unexpected_error");
        }
    }
}