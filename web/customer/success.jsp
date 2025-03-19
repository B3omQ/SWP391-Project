<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="template/header.jsp" %>
<%@ include file="template/sidebar.jsp" %>

<div class="container-fluid">
    <div class="layout-specing">
        <div class="container mt-5">
            <div class="success-card mx-auto" style="max-width: 600px;">
                <div class="text-center mb-4">
                    <i class="fas fa-check-circle success-icon"></i>
                    <h2 class="success-title">Nạp Tiền Thành Công!</h2>
                    <p class="success-message">Giao dịch của bạn đã được thực hiện thành công.</p>
                </div>
                <div class="info-section">
                    <div class="row mb-3">
                        <div class="col-6 text-start fw-bold">Số tiền đã nạp:</div>
                        <div class="col-6 text-end amount">
                            <fmt:formatNumber value="${requestScope.amount}" type="number" groupingUsed="true" /> VNĐ
                        </div>
                    </div>
                    <div class="row mb-4">
                        <div class="col-6 text-start fw-bold">Số dư hiện tại:</div>
                        <div class="col-6 text-end balance">
                            <fmt:formatNumber value="${requestScope.newBalance}" type="number" groupingUsed="true" /> VNĐ
                        </div>
                    </div>
                </div>
                <div class="text-center">
                    <a href="${pageContext.request.contextPath}/customer/Customer.jsp" class="btn btn-home">
                        <i class="fas fa-home me-2"></i>Quay Về Trang Chủ
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="template/footer.jsp" %>