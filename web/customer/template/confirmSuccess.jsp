<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="model.Customer" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<jsp:useBean id="customerDAO" class="dal.CustomerDAO" scope="page"/>

<%
    HttpSession sessionObj = request.getSession(false);
    Customer account = (sessionObj != null) ? (Customer) sessionObj.getAttribute("account") : null;

    if (account == null) {
        response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
        return;
    }

    // Lấy thông tin từ session
    BigDecimal depositAmount = (BigDecimal) sessionObj.getAttribute("depositAmount");
    Integer selectedTerm = (Integer) sessionObj.getAttribute("selectedTerm");
    BigDecimal calculatedInterest = (BigDecimal) sessionObj.getAttribute("calculatedInterest");
    String maturityDate = (String) sessionObj.getAttribute("maturityDate");

    // Kiểm tra dữ liệu
    if (depositAmount == null || selectedTerm == null || calculatedInterest == null || maturityDate == null) {
        response.sendRedirect(request.getContextPath() + "/customer/template/chooseTerm.jsp?error=missing_data");
        return;
    }

    // Lấy số dư hiện tại sau khi gửi tiết kiệm
    BigDecimal newBalance = customerDAO.getWalletByCustomerId(account.getId());
    if (newBalance == null) {
        newBalance = BigDecimal.ZERO; // Gán giá trị mặc định nếu không lấy được số dư
    }

    // Định dạng số tiền
    String formattedDeposit = String.format("%,.2f", depositAmount);
    String formattedInterest = String.format("%,.2f", calculatedInterest);
    String formattedBalance = String.format("%,.2f", newBalance);

    // Ngày bắt đầu (hôm nay)
    LocalDate startDate = LocalDate.now();
    String startDateFormatted = startDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gửi Tiết Kiệm Thành Công</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome cho biểu tượng -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts (Arial hoặc Roboto cho giao diện chuyên nghiệp) -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #fff; /* Nền trắng sạch sẽ */
            font-family: 'Roboto', Arial, sans-serif; /* Phông chữ chuyên nghiệp */
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
        }
        .success-card {
            background-color: #fff;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(255, 0, 0, 0.15); /* Bóng đỏ nhẹ nhàng */
            padding: 30px;
            text-align: center;
            border: 2px solid #ff0000; /* Viền đỏ */
            animation: fadeIn 1s ease-in;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .success-icon {
            font-size: 60px; /* Biểu tượng lớn hơn */
            color: #ff0000; /* Đỏ đậm cho biểu tượng */
            margin-bottom: 20px;
        }
        .bank-logo {
            max-width: 180px; /* Logo lớn hơn một chút */
            margin-bottom: 25px;
        }
        .success-title {
            color: #ff0000; /* Đỏ đậm cho tiêu đề */
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 20px;
            text-transform: uppercase; /* Chữ in hoa để nổi bật */
        }
        .success-message {
            color: #333;
            font-size: 18px;
            margin-bottom: 25px;
        }
        .info-text {
            color: #ff3333; /* Đỏ nhạt cho thông tin */
            font-size: 16px;
            margin-bottom: 15px;
            font-weight: 500;
        }
        .balance-text {
            color: #ff0000; /* Đỏ đậm cho số dư */
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 25px;
        }
        .btn-home {
            background-color: #ff0000; /* Nút đỏ */
            color: #fff;
            padding: 12px 40px;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            border: none;
            transition: background-color 0.3s ease;
        }
        .btn-home:hover {
            background-color: #cc0000; /* Đỏ đậm hơn khi hover */
            color: #fff;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="success-card">
            <img src="<%= request.getContextPath() %>/assets/images/logo.png" alt="Techcombank Logo" class="bank-logo">
            <div class="success-icon"><i class="fas fa-check-circle"></i></div>
            <h2 class="success-title">Mở Thành Công Tiền Gửi Phát Lộc Online</h2>
            <p class="success-message">Xin chúc mừng, giao dịch gửi tiết kiệm của bạn đã được thực hiện thành công.</p>
            
            <p class="info-text"><strong>Số tiền gửi:</strong> VND <%= formattedDeposit %></p>
            <p class="info-text"><strong>Số tiền lãi:</strong> VND <%= formattedInterest %></p>
            <p class="info-text"><strong>Ngày bắt đầu:</strong> <%= startDateFormatted %></p>
            <p class="info-text"><strong>Ngày đáo hạn:</strong> <%= maturityDate %></p>
            <p class="balance-text"><strong>Số dư còn lại:</strong> VND <%= formattedBalance %></p>
            
            <a href="<%= request.getContextPath() %>/customer/template/Customer.jsp" class="btn-home">Quay Về Trang Chủ</a>
        </div>
    </div>

    <!-- Bootstrap JS và Popper.js (tùy chọn nếu cần các thành phần động) -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>