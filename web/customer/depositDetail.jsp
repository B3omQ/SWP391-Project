<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="dal.DepServiceUsedDAO" %>
<%@ page import="model.DepServiceUsed" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="depServiceUsedDAO" class="dal.DepServiceUsedDAO" scope="page"/>

<%
    int depositId = Integer.parseInt(request.getParameter("depositId"));
    DepServiceUsed deposit = depServiceUsedDAO.getDepositById(depositId);
    pageContext.setAttribute("deposit", deposit);
%>

<%@ include file="template/header.jsp" %>
<%@ include file="template/sidebar.jsp" %>

<div class="container-fluid">
    <div class="layout-specing">
        <div class="container mt-5">
            <div class="text-center">
                <h2>Chi tiết khoản gửi tiết kiệm</h2>
            </div>
            <div class="card mb-3">
                <div class="card-body">
                    <h5 class="card-title">Tiền gửi có kỳ hạn (VND)</h5>
                    <div class="row mb-3">
                        <div class="col-6 text-start fw-bold">Mã khoản gửi</div>
                        <div class="col-6 text-end">${deposit.id}</div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-6 text-start fw-bold">Tổng tiền gốc</div>
                        <div class="col-6 text-end">
                            <fmt:formatNumber value="${deposit.amount}" type="number" groupingUsed="true" /> VND
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-6 text-start fw-bold">Ngày bắt đầu</div>
                        <div class="col-6 text-end">
                            <fmt:formatDate value="${deposit.startDate}" pattern="dd/MM/yyyy HH:mm:ss" />
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-6 text-start fw-bold">Ngày đáo hạn</div>
                        <div class="col-6 text-end">
                            <fmt:formatDate value="${deposit.endDate}" pattern="dd MMMM yyyy" />
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-6 text-start fw-bold">Hành động khi đáo hạn</div>
                        <div class="col-6 text-end">
                            <c:out value="${deposit.maturityAction}" default="Không xác định" />
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-6 text-start fw-bold">Trạng thái</div>
                        <div class="col-6 text-end">${deposit.depStatus}</div>
                    </div>
                </div>
            </div>
            <div class="text-center mt-4">
                <button class="btn btn-danger" onclick="confirmWithdrawal(${deposit.id})">
                    <i class="fas fa-money-bill-wave me-2"></i>Rút tiền
                </button>
                <a href="${pageContext.request.contextPath}/customer/Termsavings.jsp" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Quay lại
                </a>
            </div>
        </div>
    </div>
</div>

<%@ include file="template/footer.jsp" %>

<script>
    function confirmWithdrawal(depositId) {
        if (confirm("Bạn có chắc chắn muốn rút khoản gửi này? Số tiền sẽ được chuyển vào tài khoản thanh toán.")) {
            window.location.href = "${pageContext.request.contextPath}/WithdrawDepositServlet?depositId=" + depositId;
        }
    }
</script>