<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%@ include file="template/header.jsp" %>
<%@ include file="template/sidebar.jsp" %>

<div class="container-fluid">
    <div class="layout-specing">
        <div class="deposit-container">
            <div class="deposit-header">Nạp Tiền</div>
            <form action="${pageContext.request.contextPath}/VNpayServlet" method="post">
                <!-- Nhập số tiền -->
                <div class="mb-3">
                    <label for="amount" class="form-label">Nhập số tiền cần nạp (VNĐ):</label>
                    <input type="number" class="form-control" id="amount" name="amount" min="10000" required>
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