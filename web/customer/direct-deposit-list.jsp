<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="template/header.jsp" %>
<%@ include file="template/sidebar.jsp" %>

<div class="container-fluid">
    <div class="layout-specing">
        <h2 class="mb-4">Danh Sách Phiếu Yêu Cầu Của Tôi</h2>
        <c:if test="${not empty message}">
            <div class="alert alert-success mt-3">${message}</div>
        </c:if>
        <div class="card card-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Mã Phiếu</th>
                            <th>Số Tiền (VNĐ)</th>
                            <th>Ghi Chú</th>
                            <th>Ngày Tạo</th>
                            <th>Trạng Thái</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="request" items="${depositRequests}">
                            <tr>
                                <td>${request.id}</td>
                                <td><fmt:formatNumber value="${request.amount}" type="number" groupingUsed="true"/></td>
                                <td>${request.note}</td>
                                <td><fmt:formatDate value="${request.createdAt}" pattern="dd/MM/yyyy HH:mm:ss" /></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${request.status == 'ACTIVE'}">
                                            <span class="badge bg-primary">Đang xử lý</span>
                                        </c:when>
                                        <c:when test="${request.status == 'COMPLETED'}">
                                            <span class="badge bg-success">Hoàn thành</span>
                                        </c:when>
                                        <c:when test="${request.status == 'CANCEL'}">
                                            <span class="badge bg-danger">Đã hủy</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${request.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${request.status == 'ACTIVE'}">
                                            <form action="${pageContext.request.contextPath}/DirectDepositListServlet" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="cancel">
                                                <input type="hidden" name="id" value="${request.id}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger" 
                                                        onclick="return confirm('Bạn có chắc chắn hủy phiếu này?')">Hủy</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">
                                                ${request.status == 'CANCEL' ? 'Đã hủy' : 'Không thể hủy'}
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty depositRequests}">
                            <tr><td colspan="6" class="text-center">Không có phiếu nào.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%@ include file="template/footer.jsp" %>