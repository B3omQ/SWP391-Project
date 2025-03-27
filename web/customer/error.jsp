<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="template/header.jsp" %>
<%@ include file="template/sidebar.jsp" %>

<div class="container-fluid">
    <div class="layout-specing">
        <div class="container mt-5">
            <div class="error-card mx-auto" style="max-width: 600px;">
                <div class="text-center mb-4">
                    <i class="fas fa-times-circle error-icon" style="font-size: 4rem; color: #dc3545;"></i>
                    <h2 class="error-title" style="color: #dc3545; font-weight: bold; margin-top: 1rem;">Nạp Tiền Thất Bại!</h2>
                    <p class="error-message" style="color: #333; font-size: 1.1rem;">
                        ${requestScope.error != null ? requestScope.error : "Đã có lỗi xảy ra trong quá trình nạp tiền."}
                    </p>
                </div>
                <div class="text-center">
                    <a href="${pageContext.request.contextPath}/customer/deposit.jsp" class="btn btn-retry" style="background-color: #dc3545; color: white; padding: 0.5rem 1rem; margin-right: 10px;">
                        <i class="fas fa-redo me-2"></i>Thử Lại
                    </a>
                    <a href="${pageContext.request.contextPath}/customer/Customer.jsp" class="btn btn-home" style="background-color: #6c757d; color: white; padding: 0.5rem 1rem;">
                        <i class="fas fa-home me-2"></i>Quay Về Trang Chủ
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="template/footer.jsp" %>