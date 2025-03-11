<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="dal.DepHistoryDAO" %>
<%@ page import="model.DepHistory" %>
<%@ page import="java.util.List" %>

<%@ include file="template/header.jsp" %>
<%@ include file="template/sidebar.jsp" %>

<% 
    model.Customer customer = (model.Customer) session.getAttribute("account");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    // Truy vấn trực tiếp từ cơ sở dữ liệu
    DepHistoryDAO depHistoryDAO = new DepHistoryDAO();
    List<DepHistory> depHistoryList = depHistoryDAO.getDepHistoryByCustomerId(customer.getId());
    request.setAttribute("depHistoryList", depHistoryList); // Đặt vào request thay vì session
%>

<div class="container-fluid">
    <div class="layout-specing">
        <h5 class="mb-0">Dashboard</h5>
        <div class="row">
            <div class="col-xl-8 col-lg-7 mt-4">
                <div class="card shadow border-0 p-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="align-items-center mb-0">Lịch sử giao dịch</h6>
                        <div class="search-bar p-0 d-none d-md-block ms-2">
                            <div id="search" class="menu-search mb-0">
                                <form role="search" method="get" action="<%=request.getContextPath()%>/SearchTransactionHistory" id="searchform" class="searchform">
                                    <div>
                                        <input type="text" class="form-control border rounded-pill" name="s" id="s" value="${param.s}" placeholder="Tra cứu giao dịch">
                                        <input type="submit" id="searchsubmit" value="Search">
                                        <input type="hidden" name="sort" value="${param.sort}">
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="mb-0 position-relative ms-3">
                            <form method="get" action="<%=request.getContextPath()%>/SortTransactionHistory" id="sortform" style="display:inline;">
                                <input type="hidden" name="s" value="${param.s}">
                                <select class="form-select form-control" name="sort" onchange="this.form.submit()">
                                    <option value="" ${empty param.sort ? 'selected' : ''}>-- Sắp xếp --</option>
                                    <option value="time" ${param.sort == 'time' ? 'selected' : ''}>Theo Thời gian</option>
                                    <option value="amount" ${param.sort == 'amount' ? 'selected' : ''}>Theo Số tiền</option>
                                    <option value="description" ${param.sort == 'description' ? 'selected' : ''}>Theo Mô tả</option>
                                </select>
                            </form>
                        </div>
                    </div>
                    <!-- Bảng hiển thị lịch sử giao dịch -->
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
                                    <!-- Modal cho mỗi lịch sử -->
                                    <div class="modal fade" id="transactionModal_${history.id}" tabindex="-1" aria-labelledby="transactionModalLabel_${history.id}" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="transactionModalLabel_${history.id}">Chi tiết giao dịch #${history.id}</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <p><strong>ID Giao dịch:</strong> ${history.id}</p>
                                                    <p><strong>ID Dịch vụ (DSUId):</strong> ${history.dsuId}</p>
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
                </div>
            </div><!--end col-->

            <div class="col-xl-4 col-lg-5 mt-4">
                <div class="card shadow border-0 p-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h4 class="align-items-center mb-0">Tổng tài sản</h4>
                    </div>
                    <div style="position: relative; width: 100%; max-width: 300px; margin: auto;">
                        <canvas id="assetChart"></canvas>
                        <div id="chart-center" style="position: absolute; top: 50%; left: 35%; transform: translate(-50%, -50%); font-size: 20px; font-weight: bold; color: #333; text-align: center; width: 100%; max-width: 200px; white-space: nowrap;"></div>
                    </div>
                </div>
            </div><!--end col-->
        </div><!--end row-->
    </div>
</div>

<%@ include file="template/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/Chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>