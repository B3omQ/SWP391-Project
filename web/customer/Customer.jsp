<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Kiểm tra nếu truy cập trực tiếp, chuyển hướng đến TransactionHistoryServlet --%>
<%
    if (request.getAttribute("depHistoryList") == null) {
        response.sendRedirect(request.getContextPath() + "/TransactionHistoryServlet");
        return;
    }
%>

<%@ include file="template/header.jsp" %>
<%@ include file="template/sidebar.jsp" %>

<%-- Kiểm tra session để tránh truy cập nếu chưa đăng nhập --%>
<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<c:if test="${not empty errorMessage}">
    <div class="container-fluid">
        <div class="alert alert-danger" role="alert">
            ${errorMessage}
        </div>
    </div>
</c:if>

<div class="container-fluid">
    <div class="layout-specing">
        <h5 class="mb-0">Dashboard</h5>
        <div class="row">
            <div class="col-xl-8 col-lg-7 mt-4">
                <div class="card shadow border-0 p-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="align-items-center mb-0">Lịch sử giao dịch</h6>
                        <div class="d-flex align-items-center">
                            <!-- Dropdown chọn số lượng bản ghi trên mỗi trang -->
                            <form method="get" action="<%=request.getContextPath()%>/TransactionHistoryServlet" style="display:inline;">
                                <input type="hidden" name="s" value="${searchQuery}">
                                <input type="hidden" name="sort" value="${sortCriteria}">
                                <input type="hidden" name="page" value="1">
                                <select class="form-select form-control me-2" name="recordsPerPage" onchange="this.form.submit()">
                                    <option value="5" ${recordsPerPage == 5 ? 'selected' : ''}>5</option>
                                    <option value="10" ${recordsPerPage == 10 ? 'selected' : ''}>10</option>
                                    <option value="20" ${recordsPerPage == 20 ? 'selected' : ''}>20</option>
                                    <option value="50" ${recordsPerPage == 50 ? 'selected' : ''}>50</option>
                                </select>
                            </form>
                            <!-- Form tìm kiếm -->
                            <div class="search-bar p-0 d-none d-md-block ms-2">
                                <form role="search" method="get" action="<%=request.getContextPath()%>/TransactionHistoryServlet" class="searchform">
                                    <div class="d-flex">
                                        <input type="text" class="form-control border rounded-pill" name="s" value="${searchQuery}" placeholder="Tra cứu giao dịch">
                                        <input type="submit" class="btn btn-primary ms-2" value="Tìm">
                                        <input type="hidden" name="sort" value="${sortCriteria}">
                                        <input type="hidden" name="page" value="1">
                                        <input type="hidden" name="recordsPerPage" value="${recordsPerPage}">
                                    </div>
                                </form>
                            </div>
                            <!-- Form sắp xếp -->
                            <div class="mb-0 position-relative ms-3 d-flex align-items-center">
                                <form method="get" action="<%=request.getContextPath()%>/TransactionHistoryServlet" style="display:inline;">
                                    <input type="hidden" name="s" value="${searchQuery}">
                                    <input type="hidden" name="page" value="${currentPage}">
                                    <input type="hidden" name="recordsPerPage" value="${recordsPerPage}">
                                    <select class="form-select form-control" name="sort" onchange="this.form.submit()">
                                        <option value="" ${empty sortCriteria ? 'selected' : ''}>-- Sắp xếp --</option>
                                        <option value="time_desc" ${sortCriteria == 'time_desc' ? 'selected' : ''}>Mới nhất trước</option>
                                        <option value="time_asc" ${sortCriteria == 'time_asc' ? 'selected' : ''}>Cũ nhất trước</option>
                                        <option value="amount_asc" ${sortCriteria == 'amount_asc' ? 'selected' : ''}>Số tiền tăng</option>
                                        <option value="amount_desc" ${sortCriteria == 'amount_desc' ? 'selected' : ''}>Số tiền giảm</option>
                                        <option value="description_asc" ${sortCriteria == 'description_asc' ? 'selected' : ''}>Mô tả (A-Z)</option>
                                        <option value="description_desc" ${sortCriteria == 'description_desc' ? 'selected' : ''}>Mô tả (Z-A)</option>
                                    </select>
                                </form>
                                <a href="<%=request.getContextPath()%>/TransactionHistoryServlet?recordsPerPage=${recordsPerPage}" class="btn btn-outline-primary ms-2">Làm mới</a>
                            </div>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover table-striped">
                            <thead class="table-dark">
                                <tr>
                                    <th scope="col">Thời gian</th>
                                    <th scope="col">Số tiền</th>
                                    <th scope="col">Mô tả</th>
                                    <th scope="col">Chi tiết</th>
                                </tr>
                            </thead>
                            <tbody id="historyTable">
                                <c:forEach var="history" items="${depHistoryList}">
                                    <tr>
                                        <td>
                                            <c:choose>
                                                <c:when test="${history.createdAt != null}">
                                                    <fmt:formatDate value="${history.createdAt}" pattern="dd/MM/yyyy HH:mm:ss" />
                                                </c:when>
                                                <c:otherwise>Không xác định</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${history.amount != null}">
                                                    <fmt:formatNumber value="${history.amount}" type="number" groupingUsed="true" /> VND
                                                </c:when>
                                                <c:otherwise>Không xác định</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${history.description}</td>
                                        <td>
                                            <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#transactionModal_${history.id}">
                                                Xem chi tiết
                                            </button>
                                        </td>
                                    </tr>
                                    <div class="modal fade" id="transactionModal_${history.id}" tabindex="-1" aria-labelledby="transactionModalLabel_${history.id}" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="transactionModalLabel_${history.id}">Chi tiết giao dịch #${history.id}</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <p><strong>ID Giao dịch:</strong> ${history.id}</p>
                                                    <p><strong>ID Dịch vụ (DSUId):</strong> ${history.dsuId != null ? history.dsuId : 'Không có'}</p>
                                                    <p><strong>Thời gian:</strong>
                                                        <c:choose>
                                                            <c:when test="${history.createdAt != null}">
                                                                <fmt:formatDate value="${history.createdAt}" pattern="dd/MM/yyyy HH:mm:ss" />
                                                            </c:when>
                                                            <c:otherwise>Không xác định</c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                    <p><strong>Số tiền:</strong>
                                                        <c:choose>
                                                            <c:when test="${history.amount != null}">
                                                                <fmt:formatNumber value="${history.amount}" type="number" groupingUsed="true" /> VND
                                                            </c:when>
                                                            <c:otherwise>Không xác định</c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                    <p><strong>Mô tả:</strong> ${history.description}</p>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty depHistoryList}">
                                    <tr>
                                        <td colspan="4" class="text-center">Không có lịch sử giao dịch nào.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>

                    <!-- Phân trang -->
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center mt-3">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="<%=request.getContextPath()%>/TransactionHistoryServlet?page=${currentPage - 1}&s=${searchQuery}&sort=${sortCriteria}&recordsPerPage=${recordsPerPage}" aria-label="Previous">
                                        <span aria-hidden="true">«</span>
                                    </a>
                                </li>
                            </c:if>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="<%=request.getContextPath()%>/TransactionHistoryServlet?page=${i}&s=${searchQuery}&sort=${sortCriteria}&recordsPerPage=${recordsPerPage}">${i}</a>
                                </li>
                            </c:forEach>
                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="<%=request.getContextPath()%>/TransactionHistoryServlet?page=${currentPage + 1}&s=${searchQuery}&sort=${sortCriteria}&recordsPerPage=${recordsPerPage}" aria-label="Next">
                                        <span aria-hidden="true">»</span>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </div>
            <div class="col-xl-4 col-lg-5 mt-4">
                <div class="card shadow border-0 p-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h4 class="align-items-center mb-0">Tổng tài sản</h4>
                    </div>
                    <div style="position: relative; width: 100%; max-width: 300px; margin: auto;">
                        <canvas id="assetChart"></canvas>
                        <div id="chart-center" style="position: absolute; top: 50%; left: 35%; transform: translate(-50%, -50%); font-size: 20px; font-weight: bold; color: #333; text-align: center; width: 100%; max-width: 200px; white-space: nowrap;"></div>
                    </div>
                    <div class="mt-3">
                        <div class="d-flex align-items-center justify-content-center">
                            <i class="fas fa-coins me-2" style="font-size: 16px; color: #555;"></i>
                            <p class="mb-0" style="font-size: 14px; font-weight: 500; color: #555;">
                                Số dư sinh lời:
                                <fmt:formatNumber value="${totalAutoProfit}" type="number" groupingUsed="true" /> VND
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="template/footer.jsp" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/Chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>