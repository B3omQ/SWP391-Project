<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="model.Customer"%>

<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("account") == null) {
        response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
        return;
    }

    // Lấy thông tin từ session do Calculation đã lưu
    Object rawDepositAmount = sessionObj.getAttribute("depositAmount");
    Object rawSelectedTerm = sessionObj.getAttribute("selectedTerm");
    Object rawInterest = sessionObj.getAttribute("calculatedInterest");
    Object rawSavingRate = sessionObj.getAttribute("savingRate");
    Object rawMaturityDate = sessionObj.getAttribute("maturityDate");

    if (rawDepositAmount == null || rawSelectedTerm == null || rawInterest == null || 
        rawSavingRate == null || rawMaturityDate == null) {
        response.sendRedirect("chooseTerm.jsp?error=missing_data");
        return;
    }

    // Ép kiểu dữ liệu
    BigDecimal depositAmount = (BigDecimal) rawDepositAmount;
    int selectedTerm = (Integer) rawSelectedTerm;
    BigDecimal interestAmount = (BigDecimal) rawInterest;
    BigDecimal savingRate = (BigDecimal) rawSavingRate;
    String maturityDate = (String) rawMaturityDate;

    Customer account = (Customer) sessionObj.getAttribute("account");
    String selectedAction = (String) sessionObj.getAttribute("selectedAction");
    selectedAction = (selectedAction != null) ? selectedAction : "withdrawAll";

    // Định dạng số tiền
    DecimalFormat currencyFormat = new DecimalFormat("#,###");

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
                    <div class="col-6 text-end fw-bold"><%= savingRate %> %/năm</div>
                </div>
                <div class="row mb-3">
                    <div class="col-6">Ngày hiệu lực:</div>
                    <div class="col-6 text-end fw-bold">01/03/2025</div>
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
                    <div class="col-6 text-end fw-bold"><%= maturityDate %></div>
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