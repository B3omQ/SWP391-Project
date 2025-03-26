<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <title>SmartBanking - Quản lý Phiếu Nạp Tiền</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="<%= request.getContextPath() %>/assets/images/favicon.ico.png">
    <link href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="<%= request.getContextPath() %>/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
    <link href="<%= request.getContextPath() %>/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/assets/css/style.min.css" rel="stylesheet" type="text/css" />
    <style>
        body { display: flex; flex-direction: column; min-height: 100vh; }
        .page-content { flex: 1 0 auto; }
        .card-body { border-radius: 15px; border: 1px solid rgba(0, 0, 0, 0.05); padding: 30px; margin-bottom: 30px; }
        h3 { color: #1a1d24; font-weight: 600; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid #e9ecef; }
        footer { flex-shrink: 0; background-color: #d41c1c; color: white; padding: 20px 0; }
        .filter-section { margin-bottom: 20px; padding: 15px; background-color: #f8f9fa; border-radius: 8px; }
        .filter-section .form-control { margin-right: 10px; }
        .alert { transition: all 0.5s ease; }
        .alert.fade-out { opacity: 0; height: 0; margin: 0; padding: 0; }
    </style>
</head>
<body>
    <div class="page-wrapper doctris-theme toggled">
        <jsp:include page="/accountant/template/sidebar.jsp"/>
        
        <main class="page-content bg-light">
            <jsp:include page="/accountant/template/header.jsp"/>                
            <div class="container-fluid">
                <div class="layout-specing">
                    <div class="row">
                        <div class="col-12 d-flex justify-content-between align-items-center">
                            <h3 class="mb-4">Quản lý Phiếu Nạp Tiền Trực Tiếp</h3>
                        </div>
                    </div>

                    <c:if test="${not empty message}">
                        <div class="alert alert-success" id="successMessage">${message}</div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" id="errorMessage">${error}</div>
                    </c:if>

                    <div class="row">
                        <div class="col-12">
                            <div class="filter-section">
                                <form method="get" action="<%= request.getContextPath() %>/DirectDepositManageServlet" class="row g-3 align-items-end">
                                    <input type="hidden" name="action" value="list">
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" name="search" placeholder="Tìm kiếm theo mã phiếu..." value="${param.search}">
                                    </div>
                                    <div class="col-md-2">
                                        <select class="form-control" name="statusFilter">
                                            <option value="">Tất cả trạng thái</option>
                                            <option value="ACTIVE" ${param.statusFilter == 'ACTIVE' ? 'selected' : ''}>Đang xử lý</option>
                                            <option value="COMPLETED" ${param.statusFilter == 'COMPLETED' ? 'selected' : ''}>Hoàn thành</option>
                                            <option value="CANCEL" ${param.statusFilter == 'CANCEL' ? 'selected' : ''}>Đã hủy</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <select class="form-control" name="sortBy">
                                            <option value="createdAt_desc" ${param.sortBy == 'createdAt_desc' ? 'selected' : ''}>Mới nhất trước</option>
                                            <option value="createdAt_asc" ${param.sortBy == 'createdAt_asc' ? 'selected' : ''}>Cũ nhất trước</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <select class="form-control" name="recordsPerPage" onchange="this.form.submit()">
                                            <option value="5" ${recordsPerPage == 5 ? 'selected' : ''}>5 phiếu</option>
                                            <option value="10" ${recordsPerPage == 10 ? 'selected' : ''}>10 phiếu</option>
                                            <option value="20" ${recordsPerPage == 20 ? 'selected' : ''}>20 phiếu</option>
                                            <option value="50" ${recordsPerPage == 50 ? 'selected' : ''}>50 phiếu</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <button type="submit" class="btn btn-primary w-100">Lọc</button>
                                    </div>
                                    <input type="hidden" name="page" value="1">
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="card card-body">
                                <h3>Danh sách Phiếu Nạp Tiền</h3>
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>Mã Phiếu</th>
                                                <th>Khách Hàng</th>
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
                                                    <td>${request.cusId} (${request.username})</td>
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
                                                        <c:if test="${request.status == 'ACTIVE'}">
                                                            <form action="<%= request.getContextPath() %>/DirectDepositManageServlet" method="post" style="display:inline;">
                                                                <input type="hidden" name="action" value="update">
                                                                <input type="hidden" name="id" value="${request.id}">
                                                                <input type="hidden" name="recordsPerPage" value="${recordsPerPage}">
                                                                <select name="status" class="form-control form-control-sm" style="width: auto; display: inline-block;">
                                                                    <option value="COMPLETED">Hoàn thành</option>
                                                                    <option value="CANCEL">Hủy</option>
                                                                </select>
                                                                <button type="submit" class="btn btn-sm btn-outline-primary ml-2">Cập nhật</button>
                                                            </form>
                                                        </c:if>
                                                        <c:if test="${request.status != 'ACTIVE'}">
                                                            <span class="badge bg-secondary">Không thể cập nhật</span>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty depositRequests}">
                                                <tr><td colspan="7" class="text-center">Không có phiếu nào.</td></tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Phân trang -->
                                <nav aria-label="Page navigation">
                                    <ul class="pagination justify-content-center mt-4">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="<%= request.getContextPath() %>/DirectDepositManageServlet?action=list&page=${currentPage - 1}&search=${param.search}&statusFilter=${param.statusFilter}&sortBy=${param.sortBy}&recordsPerPage=${recordsPerPage}" aria-label="Previous">
                                                    <span aria-hidden="true">«</span>
                                                </a>
                                            </li>
                                        </c:if>
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link" href="<%= request.getContextPath() %>/DirectDepositManageServlet?action=list&page=${i}&search=${param.search}&statusFilter=${param.statusFilter}&sortBy=${param.sortBy}&recordsPerPage=${recordsPerPage}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="<%= request.getContextPath() %>/DirectDepositManageServlet?action=list&page=${currentPage + 1}&search=${param.search}&statusFilter=${param.statusFilter}&sortBy=${param.sortBy}&recordsPerPage=${recordsPerPage}" aria-label="Next">
                                                    <span aria-hidden="true">»</span>
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="/accountant/template/footer.jsp"/>
        </main>
    </div>

    <script src="<%= request.getContextPath() %>/assets/js/jquery.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/bootstrap.bundle.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/simplebar.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/feather.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/app.js"></script>
    <script>
        // Tự động ẩn thông báo sau 5 giây
        setTimeout(function() {
            var alert = document.getElementById("successMessage");
            if (alert) {
                alert.classList.add("fade-out");
                setTimeout(() => alert.style.display = "none", 500);
            }
            var errorAlert = document.getElementById("errorMessage");
            if (errorAlert) {
                errorAlert.classList.add("fade-out");
                setTimeout(() => errorAlert.style.display = "none", 500);
            }
        }, 5000);
    </script>
</body>
</html>