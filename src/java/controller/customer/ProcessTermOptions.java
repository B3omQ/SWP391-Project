package controller.customer;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class ProcessTermOptions extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("selectedTerm") == null) {
            System.out.println("[ERROR] Session không hợp lệ hoặc thiếu selectedTerm, quay lại chooseTerm.jsp");
            response.sendRedirect(request.getContextPath() + "/customer/chooseTerm.jsp");
            return;
        }

        Integer selectedTerm = (Integer) session.getAttribute("selectedTerm");
        System.out.println("[DEBUG] selectedTerm from session: " + selectedTerm);

        String action = request.getParameter("action");
        if (action == null) {
            request.setAttribute("error", "Bạn chưa chọn phương án xử lý khi kỳ hạn kết thúc!");
            request.getRequestDispatcher("/customer/termOptions.jsp").forward(request, response);
            return;
        }

        // Lưu giá trị tiếng Anh vào session
        String actionValue;
        switch (action) {
            case "withdrawInterest":
                actionValue = "withdrawInterest";
                break;
            case "renewAll":
                actionValue = "renewAll";
                break;
            case "withdrawAll":
                actionValue = "withdrawAll";
                break;
            default:
                actionValue = "withdrawAll"; // Mặc định
        }
        session.setAttribute("selectedAction", actionValue);
        System.out.println("[DEBUG] Stored selectedAction in session: " + actionValue);

        response.sendRedirect(request.getContextPath() + "/customer/confirmTermAction.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/customer/chooseTerm.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}