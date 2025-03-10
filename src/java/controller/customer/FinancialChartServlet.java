package controller.customer;

import dal.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import model.Customer;
import org.json.JSONObject;

/**
 *
 * @author emkob
 */


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
        if (userId != null) {
            CustomerDAO customerDAO = new CustomerDAO();
            walletBalance = customerDAO.getWalletByCustomerId(userId);
        }
System.out.println("Số dư lấy từ DB: " + walletBalance);
        // Tính tổng tài sản (giả định)
        BigDecimal saving = new BigDecimal("30000");
        BigDecimal investment = new BigDecimal("13000");
        BigDecimal loan = new BigDecimal("24000");
        BigDecimal total = walletBalance.add(saving).add(investment).add(loan);

        // Tính % của từng khoản
        double walletPercent = walletBalance.multiply(new BigDecimal(100)).divide(total, 2, BigDecimal.ROUND_HALF_UP).doubleValue();
        double savingPercent = saving.multiply(new BigDecimal(100)).divide(total, 2, BigDecimal.ROUND_HALF_UP).doubleValue();
        double investmentPercent = investment.multiply(new BigDecimal(100)).divide(total, 2, BigDecimal.ROUND_HALF_UP).doubleValue();
        double loanPercent = loan.multiply(new BigDecimal(100)).divide(total, 2, BigDecimal.ROUND_HALF_UP).doubleValue();

        // Trả về JSON
        JSONObject json = new JSONObject();
        json.put("walletBalance", walletBalance);  // Số tiền tổng
        json.put("labels", new String[]{"Tài khoản", "Tiết kiệm", "Đầu tư", "Vay"});
        json.put("values", new Number[]{walletPercent, savingPercent, investmentPercent, loanPercent});

        PrintWriter out = response.getWriter();
        out.print(json.toString());
        out.flush();
    }
}
