<%-- 
    Document   : newjsp
    Created on : Feb 15, 2025, 7:08:04 PM
    Author     : JIGGER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tippy.js Tooltip</title>
        <link rel="stylesheet" href="https://unpkg.com/tippy.js@6/dist/tippy.css">
        <script src="https://unpkg.com/@popperjs/core@2"></script>
        <script src="https://unpkg.com/tippy.js@6"></script>
        <style>
            body {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background-color: #f4f4f4;
            }
            button {
                padding: 10px 20px;
                font-size: 16px;
                border: none;
                background-color: #007bff;
                color: white;
                cursor: pointer;
                border-radius: 5px;
            }
            .tippy-box {
                font-family: Arial, sans-serif; /* Đổi font chữ */
                font-size: 14px; /* Đổi kích thước chữ */
                font-weight: bold; /* Tùy chỉnh độ đậm */
                color: white; /* Màu chữ */
                background-color: black; /* Màu nền */
                padding: 8px; /* Tạo khoảng cách */
                border-radius: 5px; /* Bo tròn góc */
            }
        </style>
    </head>
    <body>
        <button id="tooltipButton">Hover me</button>

        <script>
            tippy('#tooltipButton', {
                content: "I'm a tooltip!",
                animation: 'fade',
                duration: [300, 300], // 200ms fade in, 200ms fade out
                placement: 'top'
            });
        </script>
    </body>
</html>

