package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import model.Staff;
import java.io.IOException;

public class CustomerAccessFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo filter (nếu cần)
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = requestURI.substring(contextPath.length());

        if (path.equals("/home.jsp") || path.equals("/auth/template/login.jsp")) {
            chain.doFilter(request, response);
            return;
        }

        // Kiểm tra session nếu không phải trang công khai
        if (session == null) {
            httpResponse.sendRedirect(contextPath + "/auth/template/login.jsp");
            return;
        }

        Customer customer = (Customer) session.getAttribute("account");
        Staff staff = (Staff) session.getAttribute("staff");

        if (customer != null && staff == null) {
      
            if (path.startsWith("/admin") || 
                path.startsWith("/manager") || 
                path.startsWith("/ceo") || 
                path.startsWith("/consultant") || 
                path.startsWith("/accountant")) {
                httpResponse.sendRedirect(contextPath + "/home");
                return;
            }
        }

        // Tiếp tục xử lý request
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Dọn dẹp (nếu cần)
    }
}