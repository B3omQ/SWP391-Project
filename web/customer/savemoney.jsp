<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="template/header.jsp" %>
<%@ include file="template/sidebar.jsp" %>

<div class="container-fluid">
    <div class="layout-specing">
        <div class="container mt-5">
            <h2 class="text-center text-danger"><i class="fas fa-piggy-bank"></i> Nhập Số Tiền Gửi</h2>
            
            <!-- Hiển thị thông báo lỗi nếu có -->
            <%
                String errorAccount = (String) session.getAttribute("error4");
                if (errorAccount != null) {
            %>
                <div class="alert alert-danger text-center"><%= errorAccount %></div>
            <%
                    session.removeAttribute("error4");  
                }
            %>

            <form action="${pageContext.request.contextPath}/DepositValidationServlet" method="post" onsubmit="prepareForm()">
                <h5>Từ tài khoản</h5>
                <div class="d-flex justify-content-between align-items-center p-3 border rounded">
                    <span><i class="fas fa-wallet"></i> Tài khoản thanh toán</span>
                    <span>
                        <fmt:formatNumber value="${account.wallet}" type="number" groupingUsed="true" /> VND
                    </span>
                </div>
                <h5 class="mt-3">Số tiền gửi</h5>
                <input type="text" id="depositAmountDisplay" class="form-control" 
                       placeholder="Nhập số tiền" required oninput="formatNumber(this)">
                <input type="hidden" id="depositAmount" name="depositAmount">

                <div class="d-flex justify-content-around mt-3">
                    <span class="quick-amount" onclick="setAmount(1000000)">1,000,000</span>
                    <span class="quick-amount" onclick="setAmount(10000000)">10,000,000</span>
                    <span class="quick-amount" onclick="setAmount(100000000)">100,000,000</span>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" id="continueBtn" class="btn btn-dark px-4 py-2">
                        <i class="fas fa-arrow-right"></i> Tiếp tục
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="template/footer.jsp" %>

<script>
    function formatNumber(input) {
        let value = input.value.replace(/[^0-9]/g, ''); // Loại bỏ mọi ký tự không phải số
        if (value) {
            // Định dạng số theo kiểu Việt Nam (dấu chấm làm phân cách hàng nghìn)
            input.value = Number(value).toLocaleString('vi-VN');
            document.getElementById("depositAmount").value = value; // Lưu giá trị sạch vào hidden input
        } else {
            input.value = '';
            document.getElementById("depositAmount").value = '';
        }
    }

    function setAmount(amount) {
        let displayInput = document.getElementById('depositAmountDisplay');
        let hiddenInput = document.getElementById('depositAmount');
        displayInput.value = Number(amount).toLocaleString('vi-VN'); // Hiển thị định dạng
        hiddenInput.value = amount; // Lưu giá trị sạch
    }

    function prepareForm() {
        let displayInput = document.getElementById("depositAmountDisplay");
        let hiddenInput = document.getElementById("depositAmount");
        let value = displayInput.value.replace(/[^0-9]/g, '');
        hiddenInput.value = value; // Đảm bảo giá trị gửi đi là số nguyên thuần
    }
</script>