<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="template/header.jsp" />
<jsp:include page="template/sidebar.jsp" />

<div class="container-fluid">
    <div class="layout-specing">
        <h2 class="mb-4">Danh Sách Phiếu Yêu Cầu Của Tôi</h2>
        <c:if test="${not empty message}">
            <div class="alert alert-success mt-3">${message}</div>
        </c:if>

        <!-- Dropdown chọn số lượng phiếu trên mỗi trang -->
        <div class="row mb-3">
            <div class="col-md-3">
                <form method="get" action="${pageContext.request.contextPath}/DirectDepositListServlet">
                    <div class="input-group">
                        <select class="form-control" name="recordsPerPage" onchange="this.form.submit()">
                            <option value="5" ${recordsPerPage == 5 ? 'selected' : ''}>5 phiếu</option>
                            <option value="10" ${recordsPerPage == 10 ? 'selected' : ''}>10 phiếu</option>
                            <option value="20" ${recordsPerPage == 20 ? 'selected' : ''}>20 phiếu</option>
                            <option value="50" ${recordsPerPage == 50 ? 'selected' : ''}>50 phiếu</option>
                        </select>
                        <input type="hidden" name="page" value="1">
                    </div>
                </form>
            </div>
        </div>

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
                                                <input type="hidden" name="recordsPerPage" value="${recordsPerPage}">
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

            <!-- Phân trang -->
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center mt-4">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/DirectDepositListServlet?page=${currentPage - 1}&recordsPerPage=${recordsPerPage}" aria-label="Previous">
                                <span aria-hidden="true">«</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/DirectDepositListServlet?page=${i}&recordsPerPage=${recordsPerPage}">${i}</a>
                        </li>
                    </c:forEach>
                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/DirectDepositListServlet?page=${currentPage + 1}&recordsPerPage=${recordsPerPage}" aria-label="Next">
                                <span aria-hidden="true">»</span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>
    </div>
</div>

<jsp:include page="template/footer.jsp" />