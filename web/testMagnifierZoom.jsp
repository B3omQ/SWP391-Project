<%-- 
    Document   : testMagnifierZoom
    Created on : Mar 13, 2025, 8:33:18 AM
    Author     : JIGGER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>ElevateZoom</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/elevatezoom/3.0.8/jquery.elevatezoom.min.js"></script>
    </head>
    <body>
        <img id="zoom" src="https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D" data-zoom-image="https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D" width="400">

        <script>
            $(document).ready(function () {
                $("#zoom").elevateZoom({
                    zoomType: "lens", // Kiểu kính lúp: "lens", "window", "inner"
                    lensShape: "square", // Hình dạng kính lúp: "round" hoặc "square"
                    lensSize: 300, // Kích thước kính lúp
                    scrollZoom: true, // Cuộn chuột để thay đổi mức độ zoom
                });
            });
        </script>
    </body>
</html>

