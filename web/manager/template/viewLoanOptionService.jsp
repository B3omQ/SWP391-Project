<%-- 
    Document   : viewDepOptionService
    Created on : Feb 17, 2025, 4:07:59 PM
    Author     : JIGGER
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang thông tin khoản vay</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                background-color: #f5f5f5;
            }
            .container {
                max-width: 800px;
                margin: 0 auto;
                padding: 30px;
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }
            .title {
                text-align: center;
                color: #333;
                margin-bottom: 20px;
                font-size: 24px;
                font-weight: bold;
            }
            .description {
                text-align: center;
                color: #666;
                font-size: 16px;
                line-height: 1.6;
                padding: 20px;
                background-color: #fafafa;
                border-radius: 5px;
            }
            .logo {
                display: block;
                margin: 0 auto 20px;
                max-width: 150px;
                height: auto;
            }
            .back-button-container {
                margin-top: 30px;
                margin-right: 500px;
                text-align: right;
            }
            .back-button {
                display: inline-block;
                padding: 12px 25px;
                background-color: red;
                color: white;
                text-decoration: none;
                border-radius: 15px;
                font-size: 16px;
                font-weight: 500;
                border: none;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }
            .back-button:hover {
                background-color: orange;
                transform: translateY(-2px);
            }
            .back-button:active {
                transform: translateY(0);
            }
        </style>
    </head>
    <body>
        <div class="container">
            <img src="https://www.saokim.com.vn/wp-content/uploads/2023/01/Bieu-Tuong-Logo-Ngan-Hang-Techcombank.png" alt="Techcombank Logo" class="logo">
            <h1 class="title">${loan.loanServiceName}</h1>
            <div class="description">
                ${loan.description}
            </div>
        </div>
        <div class="back-button-container">
            <button class="back-button" type="button" 
                    onclick="window.location.href = './loan-option-service?pendingStatus=&sortBy=&order='">
                Quay về
            </button>
        </div>
    </body>
</html>



