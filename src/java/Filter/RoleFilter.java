///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//package Filter;
//
//import Model.Customer;
//import jakarta.servlet.FilterChain;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebFilter;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import java.io.IOException;
//
///**
// *
// * @author emkob
// */
//@WebFilter("/*") 
//public class RoleFilter {
//       public void doFilter(jakarta.servlet.ServletRequest request, jakarta.servlet.ServletResponse response, FilterChain chain)
//            throws IOException, ServletException {
//        HttpServletRequest httpRequest = (HttpServletRequest) request;
//        HttpServletResponse httpResponse = (HttpServletResponse) response;
//
//        // Lấy thông tin role từ session
//        Object role = httpRequest.getSession().getAttribute("role");
//
//        // Kiểm tra nếu người dùng có role là customer
//        if (role != null && role.equals("customer")) {
//            // Nếu là customer, chuyển hướng về trang khác (ví dụ: trang chủ)
//            httpResponse.sendRedirect("Customer.jsp");
//        } else {
//            // Nếu không phải customer (nghĩa là staff), cho phép tiếp tục truy cập
//            chain.doFilter(request, response);
//        }
//    }
//}
