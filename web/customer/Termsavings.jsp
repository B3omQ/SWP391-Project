<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="dal.DepServiceUsedDAO" %>
<%@ page import="model.DepServiceUsed" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="depServiceUsedDAO" class="dal.DepServiceUsedDAO" scope="page"/>

<%
    int customerId = ((model.Customer) session.getAttribute("account")).getId();
    System.out.println("Customer ID in termSavings.jsp: " + customerId);
    List<DepServiceUsed> activeDeposits = depServiceUsedDAO.getActiveDepositsByCustomerId(customerId);
    System.out.println("Active deposits count: " + (activeDeposits != null ? activeDeposits.size() : 0));
    pageContext.setAttribute("activeDeposits", activeDeposits);
%>

<%@ include file="template/header.jsp" %>
<%@ include file="template/sidebar.jsp" %>

<div class="container-fluid">
    <div class="layout-specing">
        <div class="container mt-5">
            <div class="text-center">
                <h2><i class="fas fa-piggy-bank"></i> Tiền gửi có kỳ hạn</h2>
                <p>Giữ tiền an toàn, sinh lời hấp dẫn với lãi suất lên đến 5%/năm.</p>
            </div>

            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger text-center">
                    ${sessionScope.error}
                    <% session.removeAttribute("error"); %>
                </div>
            </c:if>

            <c:choose>
                <c:when test="${not empty activeDeposits}">
                    <!-- Hiển thị khoản gửi nếu đã có -->
                    <c:forEach var="deposit" items="${activeDeposits}">
                        <a href="${pageContext.request.contextPath}/customer/depositDetail.jsp?depositId=${deposit.id}" style="text-decoration: none; color: inherit;">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <h5 class="card-title">Tiền gửi có kỳ hạn (VND)</h5>
                                    <div class="row mb-3">
                                        <div class="col-6 text-start fw-bold">Tổng tiền gốc</div>
                                        <div class="col-6 text-end">
                                            <fmt:formatNumber value="${deposit.amount}" type="number" groupingUsed="true" /> VND
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
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <!-- Hiển thị tính năng và nút "Bắt đầu ngay" nếu chưa có khoản gửi -->
                    <div class="row text-center mt-4">
                        <div class="col-md-4">
                            <div class="feature-box">
                                <i class="fas fa-shield-alt icon-large"></i>
                                <p>An toàn và bảo mật tuyệt đối</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="feature-box">
                                <i class="fas fa-percentage icon-large"></i>
                                <p>Nhận lãi suất đến 5%/năm</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="feature-box">
                                <i class="fas fa-wallet icon-large"></i>
                                <p>Rút tiền linh hoạt theo nhu cầu</p>
                            </div>
                        </div>
                    </div>
                    <div class="text-center mt-4">
                        <button class="btn btn-dark px-4 py-2" onclick="startSaving()">
                            <i class="fas fa-play"></i> Bắt đầu ngay
                        </button>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<%@ include file="template/footer.jsp" %>

<script>
    function startSaving() {
        window.location.href = 'savemoney.jsp';
    }
</script>