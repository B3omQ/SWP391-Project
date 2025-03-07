/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.calculation;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author emkob
 */
public class InterestCalculator {
    private static final int DAYS_IN_YEAR = 360;

    public static BigDecimal calculateInterest(BigDecimal depositAmount, double savingRate, int months) {
        int days = months * 30;
        return depositAmount.multiply(BigDecimal.valueOf(savingRate))
            .divide(BigDecimal.valueOf(100)) // Chuyển lãi suất về dạng phần trăm
            .multiply(BigDecimal.valueOf(days))
            .divide(BigDecimal.valueOf(DAYS_IN_YEAR), BigDecimal.ROUND_HALF_UP);
    }

    public static String calculateMaturityDate(int months) {
        LocalDate today = LocalDate.now();
    LocalDate maturityDate = today.plusDays(months * 30); // Tính theo 360 ngày/năm
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        return maturityDate.format(formatter);
    }
}
