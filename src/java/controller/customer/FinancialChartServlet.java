package controller.customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 *
 * @author emkob
 */
public class FinancialChartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Thiết lập CORS headers
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "GET, POST");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");

        // Đảm bảo servlet trả về JSON
        response.setContentType("application/json");

        // Tạo dữ liệu giả định
        String json = "{\"labels\": [\"Tài khoản\", \"Tiết kiệm\", \"Đầu tư\", \"Vay\"], \"values\": [34,3,13,24]}";

        // In ra JSON
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
}
