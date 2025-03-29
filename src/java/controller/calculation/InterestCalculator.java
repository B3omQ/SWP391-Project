/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.calculation;

import dal.CeoDAO;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.MathContext;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import model.LoanServiceUsed;

/**
 *
 * @author emkob
 */
public class InterestCalculator {

    private static final int DAYS_IN_YEAR = 360;

    public static BigDecimal calculateInterest(BigDecimal depositAmount, double savingRate, int months) {
        int days = months * 30;
        return depositAmount.multiply(BigDecimal.valueOf(savingRate))
                .divide(BigDecimal.valueOf(100))
                .multiply(BigDecimal.valueOf(days))
                .divide(BigDecimal.valueOf(DAYS_IN_YEAR), BigDecimal.ROUND_HALF_UP);
    }

    public static String calculateMaturityDate(int months) {
        LocalDate today = LocalDate.now();
        LocalDate maturityDate = today.plusDays(months * 30); // Tính theo 360 ngày/năm
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        return maturityDate.format(formatter);
    }

    public static BigDecimal calculateTotalPaymentMonthly(LoanServiceUsed loan) {
        //Tien goc phai tra hang thang
        BigDecimal monthlyBasePayment = loan.getAmount().divide(BigDecimal.valueOf(loan.getLoanId().getDuringTime()), BigDecimal.ROUND_HALF_UP);
        BigDecimal monthlyInterestPayment = calculateMonthlyInterestPayment(loan);
        return monthlyBasePayment.add(monthlyInterestPayment);
    }

    public static BigDecimal calculateMonthlyInterestPayment(LoanServiceUsed loan) {
        BigDecimal interestValue = new BigDecimal(BigInteger.ONE);
        LocalDate startDate = loan.getStartDate().toLocalDateTime().toLocalDate(); // Lấy ngày bắt đầu khoản vay
        LocalDate today = LocalDate.now(); // Lấy ngày hiện tại
        // Kiểm tra nếu đã qua 6 tháng kể từ ngày bắt đầu
        boolean isOverSixMonths = today.isAfter(startDate.plusMonths(6));
        // If amortized loan -> use getDebtRepayAmount, else use getAmount for calculate interest
        BigDecimal loanBase = loan.getLoanId().getLoanTypeRepay().equalsIgnoreCase("Amortized Loan") ? loan.getDebtRepayAmount() : loan.getAmount();

        if (!isOverSixMonths) {
            //Remain x Rate /12(Because rate is %/year)
            interestValue = loanBase
                    .multiply(BigDecimal.valueOf(loan.getLoanId().getOnTermRate()))
                    .divide(BigDecimal.valueOf(100), BigDecimal.ROUND_HALF_UP)
                    .divide(BigDecimal.valueOf(12), BigDecimal.ROUND_HALF_UP);
        } else {
            interestValue = loanBase
                    .multiply(BigDecimal.valueOf(loan.getLoanId().getAfterTermRate()))
                    .divide(BigDecimal.valueOf(100), BigDecimal.ROUND_HALF_UP)
                    .divide(BigDecimal.valueOf(12), BigDecimal.ROUND_HALF_UP);
        }

        if (!loan.getLoanId().getLoanTypeRepay().equalsIgnoreCase("Amortization")) {
            interestValue = loanBase
                    .multiply(BigDecimal.valueOf(loan.getLoanId().getAfterTermRate()))
                    .divide(BigDecimal.valueOf(100), BigDecimal.ROUND_HALF_UP)
                    .divide(BigDecimal.valueOf(12), BigDecimal.ROUND_HALF_UP);
        }
        return interestValue;
    }

    public static BigDecimal calculateBaseDebtRemain(LoanServiceUsed loan, int monthsToPay) {
        return loan.getDebtRepayAmount()
                .subtract(loan.getAmount()
                        .multiply(BigDecimal.valueOf(monthsToPay))
                        .divide(BigDecimal.valueOf(loan.getLoanId().getDuringTime()),
                                BigDecimal.ROUND_HALF_UP));
    }

    public static void main(String[] args) {
//        System.out.println(InterestCalculator.calculateDebtRepay(new BigDecimal(3000000), 1 , new BigDecimal(21.2)));
//        System.out.println("Test: " + calculateMonthlyInterestPayment(new CeoDAO().getLoanServiceUsedById(5)));
//        System.out.println("Overdue Interest : " + calculateOverdueInterestDebt(new CeoDAO().getLoanServiceUsedById(1), BigDecimal.valueOf(2000000), 32));
//        System.out.println("Overdue principal: " + calculateOverduePrincipal(new CeoDAO().getLoanServiceUsedById(1), 180));
        System.out.println("Total months: " + calculateTotalPaymentMonths(new CeoDAO().getLoanServiceUsedById(1), 2));
        System.out.println("BaseRemain: " + calculateBaseDebtRemain(new CeoDAO().getLoanServiceUsedById(1), 2));
        System.out.println(new CeoDAO().getLoanServiceUsedById(1).getAmount() + "___" + new CeoDAO().getLoanServiceUsedById(1).getDebtRepayAmount());
        System.out.println("DebtCount :" + getDebtCount(new CeoDAO().getLoanServiceUsedById(1)));
    }

    public static BigDecimal calculateOverdueInterestDebt(LoanServiceUsed l, BigDecimal interestAmount, long overdueDays) {
        BigDecimal result = BigDecimal.ZERO;
        result = interestAmount.multiply(BigDecimal.valueOf(l.getLoanId().getPenaltyRate()))
                .divide(BigDecimal.valueOf(100), BigDecimal.ROUND_HALF_UP)
                .divide(BigDecimal.valueOf(365), 10, BigDecimal.ROUND_HALF_UP)
                .multiply(BigDecimal.valueOf(overdueDays));
        return result;
    }

    public static BigDecimal calculateOverduePrincipal(LoanServiceUsed loan, long totalOverdueDays) {
        BigDecimal result = BigDecimal.ZERO;
        result = loan.getDebtRepayAmount().multiply(BigDecimal.valueOf(1.5))
                .multiply(BigDecimal.valueOf(loan.getLoanId().getPenaltyRate()))
                .divide(BigDecimal.valueOf(100), BigDecimal.ROUND_HALF_UP)
                .divide(BigDecimal.valueOf(365), BigDecimal.ROUND_HALF_UP)
                .multiply(BigDecimal.valueOf(totalOverdueDays));
        return result;
    }

    public static BigDecimal calculateTotalPayment(LoanServiceUsed loan, int count) {
        BigDecimal totalBasePayment = loan.getDebtRepayAmount();
        // Fee 
        BigDecimal feeTotalPayment = feePaymentPaymentAllBeforeEndDate(loan, count);
        return totalBasePayment.add(feeTotalPayment);
    }
    
    public static BigDecimal feePaymentPaymentAllBeforeEndDate(LoanServiceUsed loan, int count) {
        BigDecimal fee = BigDecimal.ZERO;
        if (count > 0) {
            fee = loan.getDebtRepayAmount().multiply(BigDecimal.valueOf(3))
                    .divide(BigDecimal.valueOf(100), BigDecimal.ROUND_HALF_UP)
                    .multiply(BigDecimal.valueOf(count))
                    .divide(BigDecimal.valueOf(12), BigDecimal.ROUND_HALF_UP);
        }
        if(fee.compareTo(BigDecimal.valueOf(200000)) < 0) {
            fee = BigDecimal.valueOf(200000);
        }
        return fee;
    }

    public static BigDecimal calculateTotalPaymentMonths(LoanServiceUsed loan, int month) {
        //Tien goc phai tra hang thang
        LoanServiceUsed loanCopy = new LoanServiceUsed();
        // Copy all relevant fields from originalLoan to loanCopy
        loanCopy.setDebtRepayAmount(loan.getDebtRepayAmount());
        loanCopy.setAmount(loan.getAmount());
        loanCopy.setLoanId(loan.getLoanId());
        loanCopy.setStartDate(loan.getStartDate());
        BigDecimal rs = BigDecimal.ZERO;
        for (int i = 1; i <= month; i++) {
            BigDecimal monthlyBasePayment = loanCopy.getAmount().divide(BigDecimal.valueOf(loanCopy.getLoanId().getDuringTime()), BigDecimal.ROUND_HALF_UP);
            BigDecimal monthlyInterestPayment = calculateMonthlyInterestPayment(loanCopy);
            loanCopy.setDebtRepayAmount(loanCopy.getDebtRepayAmount().subtract(monthlyInterestPayment));
            rs = rs.add(monthlyBasePayment).add(monthlyInterestPayment);
        }
        return rs;
    }

    public static int getDebtCount(LoanServiceUsed loan) {
        int count = 0;
        if (loan.getDebtRepayAmount().compareTo(loan.getAmount()) == 0) {
            count = 0;
        } else {
            BigDecimal totalBasePay = loan.getAmount().subtract(loan.getDebtRepayAmount());
            BigDecimal monthlyBasePayment = loan.getAmount().divide(BigDecimal.valueOf(loan.getLoanId().getDuringTime()), BigDecimal.ROUND_HALF_UP);
            count = totalBasePay.divide(monthlyBasePayment, BigDecimal.ROUND_HALF_UP).intValue();
        }
        return count;
    }

}
