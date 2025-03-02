<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="template/header.jsp" %>
<%@ include file="template/sidebar.jsp" %>

<div class="container-fluid">
    <div class="layout-specing">
        <div class="container mt-5">
            <h2 class="text-center text-danger"><i class="fas fa-piggy-bank"></i> Nhập Số Tiền Gửi</h2>
            
            <!-- Hiển thị thông báo lỗi nếu có -->
    

            <form action="${pageContext.request.contextPath}/DepositValidationServlet" method="post">
                <h5>Từ tài khoản</h5>
                <div class="d-flex justify-content-between align-items-center p-3 border rounded">
                    <span><i class="fas fa-wallet"></i> Tài khoản thanh toán</span>
                    <fmt:formatNumber value="${account.wallet}" type="number" groupingUsed="true" /> VND
                </div>
                <h5 class="mt-3">Số tiền gửi</h5>
                <input type="number" id="depositAmount" name="depositAmount" class="form-control" 
                       placeholder="Nhập số tiền" required min="" step="1">

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
                 <%
                String errorAccount = (String) session.getAttribute("error4");
                if (errorAccount != null) {
            %>
                <div class="alert alert-danger text-center"><%= errorAccount %></div>
            <%
                    session.removeAttribute("error4");  
                }
            %>
        </div>
    </div>
</div>

<%@ include file="template/footer.jsp" %>

<script>
    function setAmount(amount) {
        document.getElementById('depositAmount').value = amount;
    }
</script>