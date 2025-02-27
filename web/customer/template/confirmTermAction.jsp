<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.math.RoundingMode"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="model.Customer"%>

<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("account") == null) {
        response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
        return;
    }

    Object rawDepositAmount = sessionObj.getAttribute("depositAmount");
    Object rawSelectedTerm = sessionObj.getAttribute("selectedTerm");
    
    if (rawDepositAmount == null || rawSelectedTerm == null) {
        response.sendRedirect("chooseTerm.jsp");
        return;
    }

    // Lấy thông tin từ session
    Customer account = (Customer) sessionObj.getAttribute("account");
    String selectedAction = (String) sessionObj.getAttribute("selectedAction");
    selectedAction = (selectedAction != null) ? selectedAction : "Không xác định";

    // Kiểm tra kiểu dữ liệu và ép kiểu an toàn
    BigDecimal depositAmount;
    int selectedTerm;
    
    try {
        depositAmount = new BigDecimal(rawDepositAmount.toString());
        selectedTerm = Integer.parseInt(rawSelectedTerm.toString());
    } catch (NumberFormatException e) {
        response.sendRedirect("chooseTerm.jsp?error=invalid_data");
        return;
    }

    // Tính lãi suất và số tiền lãi
    double interestRate = 3 + selectedTerm * 0.1;
    BigDecimal rateDecimal = BigDecimal.valueOf(interestRate / 100);
    BigDecimal interestAmount = depositAmount.multiply(rateDecimal)
                                             .multiply(BigDecimal.valueOf(selectedTerm))
                                             .divide(BigDecimal.valueOf(12), 2, RoundingMode.HALF_UP);

    // Định dạng số tiền
    DecimalFormat currencyFormat = new DecimalFormat("#,###.##");

    // Ngày gửi và ngày đến hạn
    LocalDate today = LocalDate.now();
    LocalDate dueDate = today.plusDays(selectedTerm * 30);
    String dueDateFormatted = dueDate.format(DateTimeFormatter.ofPattern("dd MMMM, yyyy"));

    // Ảnh đại diện
    String imagePath = (account.getImage() != null && !account.getImage().isEmpty()) 
                        ? request.getContextPath() + "/uploads/" + account.getImage()
                        : request.getContextPath() + "/assets/images/default-avatar.jpg";
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận gửi tiết kiệm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .card { border-radius: 12px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); }
        .btn-custom { background-color: #000; color: #fff; border-radius: 8px; padding: 10px 20px; }
        .btn-custom:hover { background-color: #333; }
    </style>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card p-4">
                <h2 class="text-center">Xác nhận gửi tiết kiệm</h2>
                <p class="text-center text-muted">Vào Tiền gửi Phát Lộc Online</p>
                <hr>
                <div class="row mb-3">
                    <div class="col-6">Số tiền gửi:</div>
                    <div class="col-6 text-end fw-bold">VND <%= currencyFormat.format(depositAmount) %></div>
                </div>
                <div class="row mb-3">
                    <div class="col-6">Lãi suất:</div>
                    <div class="col-6 text-end fw-bold"><%= interestRate %> %/năm</div>
                </div>
                <div class="row mb-3">
                    <div class="col-6">Ngày hiệu lực:</div>
                    <div class="col-6 text-end fw-bold"><%= today.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) %></div>
                </div>
                <div class="row mb-3">
                    <div class="col-6">Kỳ hạn:</div>
                    <div class="col-6 text-end fw-bold"><%= selectedTerm %> tháng</div>
                </div>
                <div class="row mb-3">
                    <div class="col-6">Số tiền lãi:</div>
                    <div class="col-6 text-end fw-bold">VND <%= currencyFormat.format(interestAmount) %></div>
                </div>
                <div class="row mb-3">
                    <div class="col-6">Ngày đến hạn:</div>
                    <div class="col-6 text-end fw-bold"><%= dueDateFormatted %></div>
                </div>
                <div class="row mb-3">
                    <div class="col-6">Phương thức đáo hạn:</div>
                    <div class="col-6 text-end fw-bold"><%= selectedAction %></div>
                </div>
                <hr>
                <div class="d-flex justify-content-between">
                    <a href="chooseTerm.jsp" class="btn btn-outline-secondary">Quay lại</a>
                    <form action="<%= request.getContextPath() %>/ConfirmDepositServlet" method="post">
                        <input type="hidden" name="depositAmount" value="<%= depositAmount %>">
                        <input type="hidden" name="selectedTerm" value="<%= selectedTerm %>">
                        <button type="submit" class="btn btn-custom">Xác nhận</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>  
