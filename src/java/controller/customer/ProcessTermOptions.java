package controller.customer;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;

public class ProcessTermOptions extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("selectedTerm") == null || session.getAttribute("depositAmount") == null) {
            System.out.println("[ERROR] Session không hợp lệ hoặc thiếu dữ liệu cần thiết (selectedTerm/depositAmount), quay lại chooseTerm.jsp");
            response.sendRedirect(request.getContextPath() + "/customer/chooseTerm.jsp?error=missing_data");
            return;
        }

        Integer selectedTerm = (Integer) session.getAttribute("selectedTerm");
        BigDecimal depositAmount = (BigDecimal) session.getAttribute("depositAmount");
        System.out.println("[DEBUG] selectedTerm from session: " + selectedTerm);
        System.out.println("[DEBUG] depositAmount from session: " + depositAmount);

        String action = request.getParameter("action");
        if (action == null) {
            request.setAttribute("error", "Bạn chưa chọn phương án xử lý khi kỳ hạn kết thúc!");
            request.getRequestDispatcher("/customer/termOptions.jsp").forward(request, response);
            return;
        }

        // Lưu giá trị tiếng Anh và tiếng Việt
        String actionValue;
        String maturityActionDisplay;
        switch (action) {
            case "withdrawInterest":
                actionValue = "withdrawInterest";
                maturityActionDisplay = "Rút lãi và tái tục gốc";
                break;
            case "renewAll":
                actionValue = "renewAll";
                maturityActionDisplay = "Tái tục cả gốc và lãi";
                break;
            case "withdrawAll":
                actionValue = "withdrawAll";
                maturityActionDisplay = "Rút toàn bộ gốc và lãi";
                break;
            default:
                actionValue = "withdrawAll";
                maturityActionDisplay = "Rút toàn bộ gốc và lãi (mặc định)";
        }

        session.setAttribute("selectedAction", actionValue);
        session.setAttribute("maturityActionDisplay", maturityActionDisplay);
        System.out.println("[DEBUG] Stored selectedAction in session: " + actionValue);
        System.out.println("[DEBUG] Stored maturityActionDisplay in session: " + maturityActionDisplay);

        response.sendRedirect(request.getContextPath() + "/customer/confirmTermAction.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/customer/chooseTerm.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý tùy chọn đáo hạn cho khoản gửi tiết kiệm";
    }
}