<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <title>SmartBanking - Quản lý Blogs</title>
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
        .table img { border-radius: 4px; }
        footer { flex-shrink: 0; background-color: #d41c1c; color: white; padding: 20px 0; }
        .filter-section { margin-bottom: 20px; padding: 15px; background-color: #f8f9fa; border-radius: 8px; }
        .filter-section .form-control { margin-right: 10px; }
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
                            <h3 class="mb-4">Quản lý Blogs</h3>
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBlogModal">Thêm Blog Mới</button>
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
                                <form method="get" action="<%= request.getContextPath() %>/BlogServlet" class="row g-3 align-items-end">
                                    <input type="hidden" name="action" value="list">
                                    <div class="col-md-4">
                                        <input type="text" class="form-control" name="search" placeholder="Tìm kiếm theo tiêu đề..." value="${param.search}">
                                    </div>
                                    <div class="col-md-3">
                                        <select class="form-control" name="categoryFilter">
                                            <option value="">Tất cả thể loại</option>
                                            <option value="vay" ${param.categoryFilter == 'vay' ? 'selected' : ''}>Vay</option>
                                            <option value="tin tức" ${param.categoryFilter == 'tin tức' ? 'selected' : ''}>Tin tức</option>
                                            <option value="khác" ${param.categoryFilter == 'khác' ? 'selected' : ''}>Khác</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <select class="form-control" name="sortBy">
                                            <option value="publishDate_desc" ${param.sortBy == 'publishDate_desc' ? 'selected' : ''}>Mới nhất trước</option>
                                            <option value="publishDate_asc" ${param.sortBy == 'publishDate_asc' ? 'selected' : ''}>Cũ nhất trước</option>
                                            <option value="title_asc" ${param.sortBy == 'title_asc' ? 'selected' : ''}>Tiêu đề (A-Z)</option>
                                            <option value="title_desc" ${param.sortBy == 'title_desc' ? 'selected' : ''}>Tiêu đề (Z-A)</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <button type="submit" class="btn btn-primary w-100">Lọc</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="card card-body">
                                <h3>Danh sách Blog</h3>
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Tiêu đề</th>
                                                <th>Thể loại</th>
                                                <th>Hình ảnh</th>
                                                <th>Ngày đăng</th>
                                                <th>Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="article" items="${articles}">
                                                <tr>
                                                    <td>${article.id}</td>
                                                    <td>${article.title}</td>
                                                    <td>${article.category}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty article.imageUrl}">
                                                                <img src="<%= request.getContextPath() %>${article.imageUrl}" alt="Blog Image" style="width: 50px; height: 50px; object-fit: cover;">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="<%= request.getContextPath() %>/assets/images/default-image.jpg" alt="Default Image" style="width: 50px; height: 50px; object-fit: cover;">
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td><fmt:formatDate value="${article.publishDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                                                    <td>
                                                        <button class="btn btn-sm btn-outline-primary edit-blog" data-bs-toggle="modal" data-bs-target="#editBlogModal" data-id="${article.id}">Sửa</button>
                                                        <form action="<%= request.getContextPath() %>/BlogServlet" method="post" style="display:inline;">
                                                            <input type="hidden" name="action" value="delete">
                                                            <input type="hidden" name="id" value="${article.id}">
                                                            <button type="submit" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc chắn?')">Xóa</button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty articles}">
                                                <tr><td colspan="6" class="text-center">Không có blog nào</td></tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="/accountant/template/footer.jsp"/>
        </main>
    </div>

    <!-- Add Blog Modal -->
    <div class="modal fade" id="addBlogModal" tabindex="-1" aria-labelledby="addBlogModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addBlogModalLabel">Thêm Blog Mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>
                <div class="modal-body">
                    <form action="<%= request.getContextPath() %>/BlogServlet" method="post" enctype="multipart/form-data" id="addBlogForm">
                        <input type="hidden" name="action" value="add">
                        <div class="mb-3">
                            <label for="addBlogTitle" class="form-label">Tiêu đề</label>
                            <input type="text" class="form-control" id="addBlogTitle" name="title" required>
                        </div>
                        <div class="mb-3">
                            <label for="addBlogCategory" class="form-label">Thể loại</label>
                            <select class="form-control" id="addBlogCategory" name="category" required>
                                <option value="vay">Vay</option>
                                <option value="tin tức">Tin tức</option>
                                <option value="khác">Khác</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="addBlogImage" class="form-label">Hình ảnh</label>
                            <input type="file" class="form-control" id="addBlogImage" name="image" accept=".jpg,.png,.jpeg" required>
                        </div>
                        <div class="mb-3">
                            <label for="addBlogDescription" class="form-label">Mô tả</label>
                            <textarea class="form-control" id="addBlogDescription" name="description" required></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="button" class="btn btn-primary" onclick="document.getElementById('addBlogForm').submit();">Lưu Blog</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Blog Modal -->
    <div class="modal fade" id="editBlogModal" tabindex="-1" aria-labelledby="editBlogModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content" id="editBlogModalContent">
                <!-- Nội dung sẽ được load động qua AJAX -->
            </div>
        </div>
    </div>

    <script src="<%= request.getContextPath() %>/assets/js/jquery.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/bootstrap.bundle.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/simplebar.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/feather.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/app.js"></script>
    <script>
        $(document).ready(function() {
            $('.edit-blog').on('click', function() {
                var blogId = $(this).data('id');
                $.ajax({
                    url: '<%= request.getContextPath() %>/BlogServlet?action=edit&id=' + blogId,
                    type: 'GET',
                    success: function(response) {
                        $('#editBlogModalContent').html(response);
                        $('#editBlogModal').modal('show');
                    },
                    error: function() {
                        alert('Lỗi khi tải dữ liệu blog');
                    }
                });
            });
        });
    </script>
</body>
</html>