package Filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/staff/*")  // Chặn tất cả request tới thư mục /staff/
public class StaffFilter implements Filter {
    
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false); // Lấy session hiện tại (không tạo mới)

        // Kiểm tra vai trò (role) của người dùng
        String role = (session != null) ? (String) session.getAttribute("role") : null;
        if (role == null || !role.equals("staff")) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/customer/Customer.jsp");
            return;
        }
        chain.doFilter(request, response);
    }
}
