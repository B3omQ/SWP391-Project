<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nạp tiền thành công</title>
    <link rel="stylesheet" href="styles.css"> <!-- Thêm file CSS -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding: 50px;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            display: inline-block;
        }
        h2 {
            color: green;
        }
        .amount {
            font-size: 24px;
            font-weight: bold;
            color: #ff5722;
        }
        .balance {
            font-size: 20px;
            font-weight: bold;
            color: #2196F3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Nạp tiền thành công!</h2>
        <p>Số tiền đã nạp: <span class="amount"><%= request.getAttribute("amount") %> VNĐ</span></p>
        <p>Số dư hiện tại: <span class="balance"><%= request.getAttribute("newBalance") %> VNĐ</span></p>
        <a href="http://localhost:8080/BankingSystem/customer/template/Customer.jsp">Quay lại trang chủ</a>
    </div>
</body>
</html>
