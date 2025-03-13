package controller.customer;

import dal.CustomerDAO;
import dal.DepServiceUsedDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.List;
import model.Customer;
import model.DepServiceUsed;
import org.json.JSONObject;

public class FinancialChartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "GET, POST");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        response.setContentType("application/json");

        HttpSession session = request.getSession();
        Customer account = (Customer) session.getAttribute("account");
        Integer userId = (account != null) ? account.getId() : null;

        System.out.println("User ID từ session: " + userId);

        BigDecimal walletBalance = BigDecimal.ZERO;
        BigDecimal saving = BigDecimal.ZERO; // Tổng số tiền tiết kiệm thực tế
        CustomerDAO customerDAO = new CustomerDAO();
        DepServiceUsedDAO depServiceUsedDAO = new DepServiceUsedDAO();

        if (userId != null) {
            // Lấy số dư ví từ CustomerDAO
            walletBalance = customerDAO.getWalletByCustomerId(userId);
            System.out.println("Số dư ví lấy từ DB: " + walletBalance);

            // Lấy danh sách các khoản tiết kiệm đang hoạt động của khách hàng
            List<DepServiceUsed> activeDeposits = depServiceUsedDAO.getActiveDepositsByCustomerId(userId);
            for (DepServiceUsed deposit : activeDeposits) {
                saving = saving.add(deposit.getAmount()); // Cộng dồn số tiền tiết kiệm
            }
            System.out.println("Tổng số tiền tiết kiệm lấy từ DB: " + saving);
        }

        // Giả định các giá trị khác (đầu tư và vay)
        BigDecimal investment = new BigDecimal("13000");
        BigDecimal loan = new BigDecimal("24000");

        // Tính tổng tài sản (bao gồm tất cả để vẽ biểu đồ)
        BigDecimal total = walletBalance.add(saving).add(investment).add(loan);
        System.out.println("Tổng tài sản: " + total);

        // Tính tổng không bao gồm đầu tư (dùng để hiển thị ở giữa biểu đồ)
        BigDecimal totalWithoutInvestment = walletBalance.add(saving).add(loan);
        System.out.println("Tổng tài sản không bao gồm đầu tư: " + totalWithoutInvestment);

        // Tính phần trăm của từng khoản (để vẽ biểu đồ)
        double walletPercent = total.compareTo(BigDecimal.ZERO) == 0 ? 0 : 
            walletBalance.multiply(new BigDecimal(100)).divide(total, 2, BigDecimal.ROUND_HALF_UP).doubleValue();
        double savingPercent = total.compareTo(BigDecimal.ZERO) == 0 ? 0 : 
            saving.multiply(new BigDecimal(100)).divide(total, 2, BigDecimal.ROUND_HALF_UP).doubleValue();
        double investmentPercent = total.compareTo(BigDecimal.ZERO) == 0 ? 0 : 
            investment.multiply(new BigDecimal(100)).divide(total, 2, BigDecimal.ROUND_HALF_UP).doubleValue();
        double loanPercent = total.compareTo(BigDecimal.ZERO) == 0 ? 0 : 
            loan.multiply(new BigDecimal(100)).divide(total, 2, BigDecimal.ROUND_HALF_UP).doubleValue();

        // Trả về JSON
        JSONObject json = new JSONObject();
        json.put("walletBalance", walletBalance);
        json.put("saving", saving);
        json.put("investment", investment);
        json.put("loan", loan);
        json.put("totalWithoutInvestment", totalWithoutInvestment); // Tổng không bao gồm đầu tư
        json.put("labels", new String[]{"Tài khoản", "Tiết kiệm", "Đầu tư", "Vay"});
        json.put("values", new Number[]{walletPercent, savingPercent, investmentPercent, loanPercent});
        json.put("amounts", new Number[]{walletBalance.doubleValue(), saving.doubleValue(), 
                                        investment.doubleValue(), loan.doubleValue()}); // Số tiền thực tế

        PrintWriter out = response.getWriter();
        out.print(json.toString());
        out.flush();
    }
}