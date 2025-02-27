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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("depositAmount") == null) {
            response.sendRedirect(request.getContextPath() + "/customer/template/savemoney.jsp");
            return;
        }

        BigDecimal depositAmount = (BigDecimal) session.getAttribute("depositAmount");
        CustomerDAO customerDAO = new CustomerDAO();
        List<DepService> depServices = customerDAO.getAllDepServices();

        Map<Integer, BigDecimal> interestMap = new HashMap<>();
        Map<Integer, String> maturityDateMap = new HashMap<>();

        for (DepService dep : depServices) {
            BigDecimal interest = InterestCalculator.calculateInterest(depositAmount, dep.getSavingRate(), dep.getDuringTime());
            String maturityDate = InterestCalculator.calculateMaturityDate(dep.getDuringTime());

            interestMap.put(dep.getId(), interest);
            maturityDateMap.put(dep.getId(), maturityDate);
        }

        session.setAttribute("depServices", depServices);
        session.setAttribute("interestMap", interestMap);
        session.setAttribute("maturityDateMap", maturityDateMap);

        response.sendRedirect(request.getContextPath() + "/customer/template/chooseTerm.jsp");
    }
@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession();
    String selectedTermStr = request.getParameter("selectedTerm");

    if (selectedTermStr == null || selectedTermStr.isEmpty() || session.getAttribute("depositAmount") == null) {
        request.setAttribute("error", "Dữ liệu không hợp lệ!");
        request.getRequestDispatcher("/customer/template/chooseTerm.jsp").forward(request, response);
        return;
    }

    try {
        int selectedTerm = Integer.parseInt(selectedTermStr);
        CustomerDAO customerDAO = new CustomerDAO();
        List<DepService> depServices = customerDAO.getAllDepServices();

        // So sánh với DuringTime thay vì Id
        DepService selectedDepService = depServices.stream()
            .filter(dep -> dep.getId()== selectedTerm)
            .findFirst()
            .orElse(null);

        if (selectedDepService == null) {
            request.setAttribute("error", "Kỳ hạn không hợp lệ!");
            request.getRequestDispatcher("/customer/template/chooseTerm.jsp").forward(request, response);
            return;
        }

        BigDecimal depositAmount = (BigDecimal) session.getAttribute("depositAmount");
        BigDecimal interest = InterestCalculator.calculateInterest(depositAmount, selectedDepService.getSavingRate(), selectedDepService.getDuringTime());
        String maturityDate = InterestCalculator.calculateMaturityDate(selectedDepService.getDuringTime());

        session.setAttribute("calculatedInterest", interest);
        session.setAttribute("maturityDate", maturityDate);
        session.setAttribute("selectedDepService", selectedDepService);
        session.setAttribute("selectedTerm", selectedDepService.getDuringTime());

        response.sendRedirect(request.getContextPath() + "/customer/template/termOptions.jsp");

    } catch (NumberFormatException e) {
        request.setAttribute("error", "Kỳ hạn không hợp lệ!");
        request.getRequestDispatcher("/customer/template/chooseTerm.jsp").forward(request, response);
    }
}

}
