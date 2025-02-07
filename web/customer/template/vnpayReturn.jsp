<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Kết quả thanh toán</title>
</head>
<body>
    <h2>Kết quả giao dịch</h2>
    <%
        String resultCode = request.getParameter("vnp_ResponseCode");
        if ("00".equals(resultCode)) {
            out.println("<p style='color: green;'>Nạp tiền thành công!</p>");
        } else {
            out.println("<p style='color: red;'>Nạp tiền thất bại! Mã lỗi: " + resultCode + "</p>");
        }
    %>
    <a href="deposit.jsp">Quay lại</a>
</body>
</html>
