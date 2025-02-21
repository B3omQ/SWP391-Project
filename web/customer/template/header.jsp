<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.Customer" %>

<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
        return; 
    }

    // Lấy thông tin người dùng từ session
    Customer account = (Customer) session.getAttribute("account");
    String imagePath = (account != null && account.getImage() != null && !account.getImage().isEmpty()) 
                        ? request.getContextPath() + "/uploads/" + account.getImage() 
                        : request.getContextPath() + "/assets/images/default-avatar.jpg";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>SmartBanking</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="<%= request.getContextPath() %>/assets/images/favicon.ico.png">
    
    <!-- Bootstrap -->
    <link href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Simplebar -->
    <link href="<%= request.getContextPath() %>/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
    <!-- Icons -->
    <link href="<%= request.getContextPath() %>/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="<%= request.getContextPath() %>/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <!-- SLIDER -->
    <link href="<%= request.getContextPath() %>/assets/css/tiny-slider.css" rel="stylesheet" />
    <!-- Main CSS -->
    <link href="<%= request.getContextPath() %>/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
</head>
