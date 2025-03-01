<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="dal.DepHistoryDAO" %>
<%@ page import="model.DepHistory" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="depHistoryDAO" class="dal.DepHistoryDAO" scope="page"/>

<%
    // Lấy danh sách lịch sử giao dịch dựa trên account từ session
    // Vì session đã được kiểm tra trong header.jsp, nên ta chắc chắn account tồn tại
    List<DepHistory> depHistoryList = depHistoryDAO.getDepHistoryByCustomerId(((model.Customer) session.getAttribute("account")).getId());
    pageContext.setAttribute("depHistoryList", depHistoryList);
%>

<%@ include file="template/header.jsp" %>
<%@ include file="template/sidebar.jsp" %>

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
                                <form role="search" method="get" id="searchform" class="searchform">
                                    <div>
                                        <input type="text" class="form-control border rounded-pill" name="s" id="s" placeholder="Tra cứu giao dịch">
                                        <input type="submit" id="searchsubmit" value="Search">
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="mb-0 position-relative ms-3">
                            <select class="form-select form-control" id="sort" onchange="sortHistory(this.value)">
                                <option value="time">Sắp xếp theo Thời gian</option>
                                <option value="amount">Sắp xếp theo Số tiền</option>
                                <option value="description">Sắp xếp theo Mô tả</option>
                            </select>
                        </div>
                    </div>
                    <!-- Bảng hiển thị lịch sử giao dịch -->
                    <div class="table-responsive">
                        <table class="table table-hover table-striped">
                            <thead class="table-dark">
                                <tr>
                                    <th scope="col">ID Giao dịch</th>
                                    <th scope="col">Thời gian</th>
                                    <th scope="col">Số tiền</th>
                                    <th scope="col">Mô tả</th>
                                </tr>
                            </thead>
                            <tbody id="historyTable">
                            <c:forEach var="history" items="${depHistoryList}">
                                <tr>
                                    <td>${history.id}</td>
                                    <td><fmt:formatDate value="${history.createdAt}" pattern="dd/MM/yyyy HH:mm:ss" /></td>
                                    <td><fmt:formatNumber value="${history.amount}" type="number" groupingUsed="true" /> VND</td>
                                    <td>${history.description}</td>
                                </tr>
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
                    <!-- Thêm phần tử chứa biểu đồ -->
                    <div style="position: relative; width: 100%; max-width: 300px; margin: auto;">
                        <canvas id="assetChart"></canvas>
                        <div id="chart-center" style="
                            position: absolute;
                            top: 50%;
                            left: 35%;
                            transform: translate(-50%, -50%);
                            font-size: 20px;
                            font-weight: bold;
                            color: #333;
                            text-align: center;
                            width: 100%;
                            max-width: 200px;
                            white-space: nowrap;"></div>
                    </div>
                </div>
            </div><!--end col-->
        </div><!--end row-->
    </div>
</div>

<%@ include file="template/footer.jsp" %>

<!-- Script cho biểu đồ (nếu cần) -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/Chart.js"></script>