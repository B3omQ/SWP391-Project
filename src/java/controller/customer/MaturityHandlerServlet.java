package controller.customer;

import dal.CustomerDAO;
import dal.DepServiceUsedDAO;
import model.Customer;
import model.DepServiceUsed;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

public class MaturityHandlerServlet {

    private final CustomerDAO customerDAO = new CustomerDAO();
    private final DepServiceUsedDAO depServiceUsedDAO = new DepServiceUsedDAO();
    private static final double DEFAULT_DAILY_RATE = 0.05 / 365.0; // Lãi suất mặc định 5%/năm, chia cho 365 ngày

    public void processMaturedDeposits(Customer customer) {
        LocalDateTime now = LocalDateTime.now();
        boolean hasProcessed = false;

        // Xử lý sinh lời tự động dựa trên số dư ví
        if (customer.isAutoProfitEnabled()) {
            processAutoProfit(customer);
        }

        // Xử lý các khoản gửi theo gói (nếu có)
        List<DepServiceUsed> deposits = depServiceUsedDAO.getDepServiceUsedByCustomerId(customer.getId());
        for (DepServiceUsed deposit : deposits) {
            if ("ACTIVE".equals(deposit.getDepStatus()) && deposit.getEndDate().toLocalDateTime().isBefore(now)) {
                processMaturedDeposit(deposit, customer);
                hasProcessed = true;
            }
        }

        if (hasProcessed) {
            customer.setWallet(customerDAO.getWalletByCustomerId(customer.getId()));
        }
    }

    private void processAutoProfit(Customer customer) {
        BigDecimal wallet = customerDAO.getWalletByCustomerId(customer.getId());
        if (wallet.compareTo(BigDecimal.ZERO) <= 0) {
            return; // Không tính lãi nếu ví rỗng
        }

        // Tính lãi kép hàng ngày (giả sử lãi suất 5%/năm)
        BigDecimal dailyRate = new BigDecimal(DEFAULT_DAILY_RATE);
        BigDecimal factor = BigDecimal.ONE.add(dailyRate);
        BigDecimal interest = wallet.multiply(factor.subtract(BigDecimal.ONE));
        interest = interest.setScale(2, RoundingMode.HALF_UP);

        // Cộng lãi vào ví
        BigDecimal newWallet = wallet.add(interest);
        if (customerDAO.updateWallet(customer.getId(), newWallet)) {
            customer.setWallet(newWallet);
            System.out.println("✅ Sinh lãi tự động cho CustomerId " + customer.getId() + ": +" + interest + " VNĐ, Số dư mới: " + newWallet);
        }
    }

    private void processMaturedDeposit(DepServiceUsed deposit, Customer customer) {
        BigDecimal principal = deposit.getAmount();
       BigDecimal BigsavingRate = depServiceUsedDAO.getSavingRateByDepId(deposit.getDepId());
       double savingRate = BigsavingRate.doubleValue();

        long days = java.time.temporal.ChronoUnit.DAYS.between(
            deposit.getStartDate().toLocalDateTime(), 
            deposit.getEndDate().toLocalDateTime()
        );
        BigDecimal interest = calculateCompoundInterest(principal, savingRate, days);
        BigDecimal totalAmount = principal.add(interest);

        String maturityAction = deposit.getMaturityAction();
        if (maturityAction == null) {
            maturityAction = "withdrawAll";
        }

        depServiceUsedDAO.updateDepStatus(deposit.getId(), "COMPLETED");

        switch (maturityAction) {
            case "withdrawInterest":
                BigDecimal newBalanceWithdrawInterest = customerDAO.getWalletByCustomerId(customer.getId()).add(interest);
                customerDAO.updateWallet(customer.getId(), newBalanceWithdrawInterest);
                renewDeposit(deposit, principal, customer);
                break;
            case "renewAll":
                renewDeposit(deposit, totalAmount, customer);
                break;
            case "withdrawAll":
                BigDecimal newBalanceWithdrawAll = customerDAO.getWalletByCustomerId(customer.getId()).add(totalAmount);
                customerDAO.updateWallet(customer.getId(), newBalanceWithdrawAll);
                break;
            default:
                BigDecimal newBalanceDefault = customerDAO.getWalletByCustomerId(customer.getId()).add(totalAmount);
                customerDAO.updateWallet(customer.getId(), newBalanceDefault);
                break;
        }
    }

    private BigDecimal calculateCompoundInterest(BigDecimal principal, double annualRate, long days) {
        BigDecimal dailyRate = new BigDecimal(annualRate / 365.0 / 100.0);
        BigDecimal factor = BigDecimal.ONE.add(dailyRate);
        BigDecimal interest = principal.multiply(factor.pow((int) days).subtract(BigDecimal.ONE));
        return interest.setScale(2, RoundingMode.HALF_UP);
    }

   private void renewDeposit(DepServiceUsed oldDeposit, BigDecimal amount, Customer customer) {
        DepServiceUsed newDep = new DepServiceUsed(
            0, oldDeposit.getDepId(), customer.getId(), oldDeposit.getDepTypeId(),
            amount, Timestamp.valueOf(LocalDateTime.now()),
            Timestamp.valueOf(LocalDateTime.now().plusDays(depServiceUsedDAO.getTermMonthsByDepId(oldDeposit.getDepId()) * 30)),
            "ACTIVE", oldDeposit.getMaturityAction() // Sử dụng isAutoProfitEnabled từ Customer
        );
        depServiceUsedDAO.addDepServiceUsed(newDep);
    }
}