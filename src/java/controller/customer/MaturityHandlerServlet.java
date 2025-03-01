package controller.customer;

import dal.CustomerDAO;
import dal.DepServiceUsedDAO;
import dal.DepHistoryDAO;
import model.Customer;
import model.DepServiceUsed;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import jakarta.servlet.http.HttpSession;
import controller.calculation.InterestCalculator;

public class MaturityHandlerServlet {

    private final CustomerDAO customerDAO = new CustomerDAO();
    private final DepServiceUsedDAO depServiceUsedDAO = new DepServiceUsedDAO();
    private final DepHistoryDAO depHistoryDAO = new DepHistoryDAO();

    // Phương thức chính để xử lý các khoản đáo hạn
    public void processMaturedDeposits(Customer customer, HttpSession session) {
        List<DepServiceUsed> maturedDeposits = depServiceUsedDAO.getDepServiceUsedByCustomerId(customer.getId());
        LocalDateTime now = LocalDateTime.now();
        boolean hasProcessed = false;

        for (DepServiceUsed deposit : maturedDeposits) {
            if ("ACTIVE".equals(deposit.getDepStatus()) && deposit.getEndDate().toLocalDateTime().isBefore(now)) {
                processMaturedDeposit(deposit, customer);
                hasProcessed = true;
            }
        }

        if (hasProcessed) {
            session.setAttribute("success", "Đã tự động xử lý các khoản tiết kiệm đáo hạn!");
        }
        customer.setWallet(customerDAO.getWalletByCustomerId(customer.getId()));
        session.setAttribute("account", customer);
    }

    private void processMaturedDeposit(DepServiceUsed deposit, Customer customer) {
        BigDecimal principal = deposit.getAmount();
        BigDecimal savingRate = depServiceUsedDAO.getSavingRateByDepId(deposit.getDepId());
        int termMonths = depServiceUsedDAO.getTermMonthsByDepId(deposit.getDepId()); // Sử dụng DuringTime từ DepService
        BigDecimal interest = InterestCalculator.calculateInterest(principal, savingRate, termMonths);
        BigDecimal totalAmount = principal.add(interest);

        // Log để kiểm tra giá trị
        System.out.println("✅ Principal của deposit " + deposit.getId() + ": " + principal);
        System.out.println("✅ SavingRate: " + savingRate);
        System.out.println("✅ TermMonths: " + termMonths);
        System.out.println("✅ Interest tính được: " + interest);
        System.out.println("✅ TotalAmount: " + totalAmount);

        String maturityAction = deposit.getMaturityAction();
        System.out.println("✅ MaturityAction của deposit " + deposit.getId() + ": " + maturityAction);
        if (maturityAction == null) {
            System.out.println("⚠️ MaturityAction là null, gán mặc định 'withdrawAll'");
            maturityAction = "withdrawAll";
        }

        depServiceUsedDAO.updateDepStatus(deposit.getId(), "COMPLETED");

        // Xử lý theo maturityAction
        switch (maturityAction) {
            case "withdrawInterest":
                BigDecimal newBalanceWithdrawInterest = customerDAO.getWalletByCustomerId(customer.getId()).add(interest);
                customerDAO.updateWallet(customer.getId(), newBalanceWithdrawInterest);
                renewDeposit(deposit, principal, customer);
                depHistoryDAO.addDepHistory(deposit.getId(), "Đáo hạn tự động: Rút lãi " + interest + " VND, gửi lại gốc " + principal + " VND");
                break;

            case "renewAll":
                renewDeposit(deposit, totalAmount, customer);
                depHistoryDAO.addDepHistory(deposit.getId(), "Đáo hạn tự động: Gửi lại toàn bộ " + totalAmount + " VND");
                break;

            case "withdrawAll":
                BigDecimal currentBalance = customerDAO.getWalletByCustomerId(customer.getId());
                BigDecimal newBalanceWithdrawAll = currentBalance.add(totalAmount);
                boolean updated = customerDAO.updateWallet(customer.getId(), newBalanceWithdrawAll);
                if (!updated) {
                    System.out.println("❌ Lỗi: Không thể cập nhật ví cho customer " + customer.getId());
                } else {
                    System.out.println("✅ Đã cộng " + totalAmount + " (gốc + lãi) vào ví, số dư mới: " + newBalanceWithdrawAll);
                }
                depHistoryDAO.addDepHistory(deposit.getId(), "Đáo hạn tự động: Rút toàn bộ " + totalAmount + " VND (gốc: " + principal + ", lãi: " + interest + ")");
                break;

            default:
                BigDecimal newBalanceDefault = customerDAO.getWalletByCustomerId(customer.getId()).add(totalAmount);
                customerDAO.updateWallet(customer.getId(), newBalanceDefault);
                depHistoryDAO.addDepHistory(deposit.getId(), "Đáo hạn tự động: Rút toàn bộ (mặc định) " + totalAmount + " VND");
                break;
        }
    }

    private void renewDeposit(DepServiceUsed oldDeposit, BigDecimal amount, Customer customer) {
        DepServiceUsed newDep = new DepServiceUsed(
            0, oldDeposit.getDepId(), customer.getId(), oldDeposit.getDepTypeId(),
            amount, Timestamp.valueOf(LocalDateTime.now()),
            Timestamp.valueOf(LocalDateTime.now().plusDays(depServiceUsedDAO.getTermMonthsByDepId(oldDeposit.getDepId()) * 30)),
            "ACTIVE", oldDeposit.getMaturityAction()
        );
        depServiceUsedDAO.addDepServiceUsed(newDep);
    }

    private int calculateTermMonths(Timestamp start, Timestamp end) {
        LocalDateTime startDate = start.toLocalDateTime();
        LocalDateTime endDate = end.toLocalDateTime();
        return (int) java.time.temporal.ChronoUnit.MONTHS.between(startDate, endDate);
    }
}