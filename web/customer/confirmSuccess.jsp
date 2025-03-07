<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<jsp:useBean id="customerDAO" class="dal.CustomerDAO" scope="page"/>

<%
    // Lấy thông tin từ session
    BigDecimal depositAmount = (BigDecimal) session.getAttribute("depositAmount");
    Integer selectedTerm = (Integer) session.getAttribute("selectedTerm");
    BigDecimal calculatedInterest = (BigDecimal) session.getAttribute("calculatedInterest");
    String maturityDate = (String) session.getAttribute("maturityDate");

    // Kiểm tra dữ liệu
    if (depositAmount == null || selectedTerm == null || calculatedInterest == null || maturityDate == null) {
        response.sendRedirect(request.getContextPath() + "/customer/template/chooseTerm.jsp?error=missing_data");
        return;
    }

    // Lấy số dư hiện tại sau khi gửi tiết kiệm
    BigDecimal newBalance = customerDAO.getWalletByCustomerId(((Customer) session.getAttribute("account")).getId());
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

<%@ include file="template/header.jsp" %>
<%@ include file="template/sidebar.jsp" %>

<div class="container-fluid">
    <div class="layout-specing">
        <div class="container" style="max-width: 600px; margin: 50px auto;">
            <div class="success-card">
                <div class="success-icon"><i class="fas fa-check-circle"></i></div>
                <h2 class="success-title">Mở Thành Công Tiền Gửi Phát Lộc Online</h2>
                <p class="success-message">Xin chúc mừng, giao dịch gửi tiết kiệm của bạn đã được thực hiện thành công.</p>
                
                <p class="info-text"><strong>Số tiền gửi:</strong> VND <%= formattedDeposit %></p>
                <p class="info-text"><strong>Số tiền lãi:</strong> VND <%= formattedInterest %></p>
                <p class="info-text"><strong>Ngày bắt đầu:</strong> <%= startDateFormatted %></p>
                <p class="info-text"><strong>Ngày đáo hạn:</strong> <%= maturityDate %></p>
                <p class="balance-text"><strong>Số dư còn lại:</strong> VND <%= formattedBalance %></p>
                
                <a href="${pageContext.request.contextPath}/customer/Customer.jsp" class="btn-home">Quay Về Trang Chủ</a>
            </div>
        </div>
    </div>
</div>

<%@ include file="template/footer.jsp" %>

<!-- Bootstrap JS và Popper.js (tùy chọn nếu cần các thành phần động) -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>