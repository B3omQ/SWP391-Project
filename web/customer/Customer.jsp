<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="dal.DepHistoryDAO" %>
<%@ page import="model.DepHistory" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="depHistoryDAO" class="dal.DepHistoryDAO" scope="page"/>

<%@ include file="template/header.jsp" %>
<%@ include file="template/sidebar.jsp" %>

<%
    List<DepHistory> depHistoryList = depHistoryDAO.getDepHistoryByCustomerId(((model.Customer) session.getAttribute("account")).getId());
    pageContext.setAttribute("depHistoryList", depHistoryList);
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
                                        <td>
                                            <c:choose>
                                                <c:when test="${history.createdAt != null}">
                                                    <fmt:formatDate value="${history.createdAt}" pattern="dd/MM/yyyy HH:mm:ss" />
                                                </c:when>
                                                <c:otherwise>
                                                    Không xác định
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${history.amount != null}">
                                                    <fmt:formatNumber value="${history.amount}" type="number" groupingUsed="true" /> VND
                                                </c:when>
                                                <c:otherwise>
                                                    Không xác định
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
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

<!-- Script cho biểu đồ -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/Chart.js"></script>
<script>
                                function sortHistory(criteria) {
                                    let table = document.getElementById("historyTable");
                                    let rows = Array.from(table.getElementsByTagName("tr"));

                                    rows.sort((a, b) => {
                                        let aValue, bValue;
                                        if (criteria === "time") {
                                            aValue = new Date(a.cells[1].textContent);
                                            bValue = new Date(b.cells[1].textContent);
                                        } else if (criteria === "amount") {
                                            aValue = parseFloat(a.cells[2].textContent.replace(/[^\d.-]/g, ''));
                                            bValue = parseFloat(b.cells[2].textContent.replace(/[^\d.-]/g, ''));
                                        } else if (criteria === "description") {
                                            aValue = a.cells[3].textContent;
                                            bValue = b.cells[3].textContent;
                                        }
                                        return aValue > bValue ? 1 : -1;
                                    });

                                    rows.forEach(row => table.appendChild(row));
                                }
</script>