package controller.customer;

import controller.calculation.InterestCalculator;
import dal.CustomerDAO;
import model.DepService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Calculation extends HttpServlet {

    private final CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("depositAmount") == null) {
            response.sendRedirect(request.getContextPath() + "/customer/savemoney.jsp");
            return;
        }

        BigDecimal depositAmount = (BigDecimal) session.getAttribute("depositAmount");
        if (depositAmount.compareTo(BigDecimal.ZERO) <= 0) {
            session.setAttribute("error", "Số tiền gửi không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/customer/savemoney.jsp");
            return;
        }

        List<DepService> depServices = customerDAO.getAllDepServices();
        if (depServices == null || depServices.isEmpty()) {
            session.setAttribute("error", "Không tìm thấy kỳ hạn tiết kiệm nào!");
            response.sendRedirect(request.getContextPath() + "/customer/savemoney.jsp");
            return;
        }

        // Tính toán lãi, ngày đáo hạn và lưu lãi suất cho từng kỳ hạn
        Map<Integer, BigDecimal> interestMap = new HashMap<>();
        Map<Integer, String> maturityDateMap = new HashMap<>();
        Map<Integer, BigDecimal> savingRateMap = new HashMap<>();

        for (DepService dep : depServices) {
            BigDecimal interest = InterestCalculator.calculateInterest(
                depositAmount, 
                dep.getSavingRate(), 
                dep.getDuringTime()
            );
            String maturityDate = InterestCalculator.calculateMaturityDate(dep.getDuringTime());

            interestMap.put(dep.getId(), interest);
            maturityDateMap.put(dep.getId(), maturityDate);
            savingRateMap.put(dep.getId(), BigDecimal.valueOf(dep.getSavingRate())); // Lưu lãi suất

            System.out.println("✅ DepId: " + dep.getId() + ", SavingRate: " + dep.getSavingRate() + 
                            ", Interest: " + interest + ", MaturityDate: " + maturityDate);
        }

        // Lưu tất cả thông tin cần thiết vào session
        session.setAttribute("depServices", depServices);
        session.setAttribute("interestMap", interestMap);
        session.setAttribute("maturityDateMap", maturityDateMap);
        session.setAttribute("savingRateMap", savingRateMap);

        response.sendRedirect(request.getContextPath() + "/customer/chooseTerm.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("depositAmount") == null) {
            System.out.println("❌ Session hoặc depositAmount không tồn tại");
            request.setAttribute("error", "Vui lòng nhập số tiền gửi trước!");
            request.getRequestDispatcher("/customer/savemoney.jsp").forward(request, response);
            return;
        }

        String selectedTermStr = request.getParameter("selectedTerm");
        if (selectedTermStr == null || selectedTermStr.trim().isEmpty()) {
            System.out.println("❌ selectedTerm không được cung cấp");
            request.setAttribute("error", "Vui lòng chọn kỳ hạn!");
            request.getRequestDispatcher("/customer/chooseTerm.jsp").forward(request, response);
            return;
        }

        try {
            int selectedTermId = Integer.parseInt(selectedTermStr);
            BigDecimal depositAmount = (BigDecimal) session.getAttribute("depositAmount");

            List<DepService> depServices = customerDAO.getAllDepServices();
            if (depServices == null || depServices.isEmpty()) {
                System.out.println("❌ Không tìm thấy kỳ hạn tiết kiệm nào");
                request.setAttribute("error", "Không tìm thấy kỳ hạn tiết kiệm nào!");
                request.getRequestDispatcher("/customer/chooseTerm.jsp").forward(request, response);
                return;
            }

            DepService selectedDepService = depServices.stream()
                .filter(dep -> dep.getId() == selectedTermId)
                .findFirst()
                .orElse(null);

            if (selectedDepService == null) {
                System.out.println("❌ Không tìm thấy DepService với Id: " + selectedTermId);
                request.setAttribute("error", "Kỳ hạn không hợp lệ!");
                request.getRequestDispatcher("/customer/chooseTerm.jsp").forward(request, response);
                return;
            }

            BigDecimal savingRate = BigDecimal.valueOf(selectedDepService.getSavingRate());
            BigDecimal interest = InterestCalculator.calculateInterest(
                depositAmount, 
                savingRate.doubleValue(), 
                selectedDepService.getDuringTime()
            );
            String maturityDate = InterestCalculator.calculateMaturityDate(selectedDepService.getDuringTime());

            // Log để kiểm tra
            System.out.println("✅ Lưu vào session - depositAmount: " + depositAmount + 
                            ", selectedTerm: " + selectedDepService.getDuringTime() + 
                            ", calculatedInterest: " + interest + 
                            ", savingRate: " + savingRate + 
                            ", maturityDate: " + maturityDate);

            // Lưu đầy đủ thông tin cần thiết vào session
            session.setAttribute("depositAmount", depositAmount); // Đảm bảo giữ nguyên giá trị
            session.setAttribute("selectedTerm", selectedDepService.getDuringTime());
            session.setAttribute("calculatedInterest", interest);
            session.setAttribute("savingRate", savingRate);
            session.setAttribute("maturityDate", maturityDate);
            session.setAttribute("selectedDepService", selectedDepService); // Optional

            response.sendRedirect(request.getContextPath() + "/customer/termOptions.jsp");

        } catch (NumberFormatException e) {
            System.out.println("❌ selectedTerm không hợp lệ: " + selectedTermStr);
            request.setAttribute("error", "Kỳ hạn không hợp lệ!");
            request.getRequestDispatcher("/customer/chooseTerm.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("❌ Lỗi không xác định: " + e.getMessage());
            request.setAttribute("error", "Đã xảy ra lỗi không xác định!");
            request.getRequestDispatcher("/customer/chooseTerm.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet to calculate interest and maturity date for deposit terms";
    }
}