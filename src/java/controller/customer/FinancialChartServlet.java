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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    response.setContentType("application/json");
    PrintWriter out = response.getWriter();
    
    // Dữ liệu giả định
    String json = "{\"labels\": [\"Tài khoản\", \"Tiết kiệm\", \"Đầu tư\", \"CCTG\"], \"values\": [40, 30, 20, 10]}";
    out.print(json);
    out.flush();
}
}
