<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="model.Customer" %>
<%@ page import="model.Notification" %>
<%@ page import="dal.NotifyDAO" %>
<%@ page import="java.util.List, java.util.ArrayList" %>

<%@ include file="template/header.jsp" %>
<%@ include file="template/sidebar.jsp" %>

<div class="container-fluid">
    <div class="layout-specing">
        <div class="deposit-container">
            <div class="deposit-header">Nạp Tiền</div>
            <form action="${pageContext.request.contextPath}/VNpayServlet" method="post">
                <!-- Nhập số tiền -->
                <div class="mb-3">
                    <label for="amountDisplay" class="form-label">Nhập số tiền cần nạp (VNĐ):</label>
                    <input type="text" class="form-control" id="amountDisplay" oninput="formatNumber(this)" required min="10000">
                    <input type="hidden" id="amount" name="amount">
                    <small class="form-text text-muted">Tối thiểu: 10,000 VNĐ</small>
                </div>

                <!-- Dropdown chọn phương thức nạp -->
                <div class="mb-3">
                    <label class="form-label">Chọn phương thức nạp:</label>
                    <select id="paymentMethod" name="paymentMethod" class="form-select">
                        <option value="VNPAY" selected>VNPay</option>
                        <option value="MOMO" disabled>MoMo (Soon)</option>
                        <option value="BANK" disabled>Ngân hàng khác (Not Available)</option>
                    </select>
                </div>

                <!-- Nút nạp tiền -->
                <button type="submit" class="btn btn-deposit">Nạp Tiền Ngay</button>
            </form>
        </div>
    </div>
</div>

<%@ include file="template/footer.jsp" %>

<!-- JavaScript để định dạng số tiền -->
<script>
    function formatNumber(input) {
        let value = input.value.replace(/[^0-9]/g, ''); // Loại bỏ mọi ký tự không phải số
        if (value) {
            // Định dạng số theo kiểu Việt Nam (dấu chấm làm phân cách hàng nghìn)
            input.value = Number(value).toLocaleString('vi-VN');
            document.getElementById("amount").value = value; // Lưu giá trị sạch vào hidden input
        } else {
            input.value = '';
            document.getElementById("amount").value = '';
        }

        // Kiểm tra giá trị tối thiểu
        if (value && parseInt(value) < 10000) {
            input.setCustomValidity('Số tiền phải tối thiểu 10,000 VNĐ!');
        } else {
            input.setCustomValidity('');
        }
    }
</script>