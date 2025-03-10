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
    </style>
</head>
<body>
    <div id="preloader">
        <div id="status">
            <div class="spinner">
                <div class="double-bounce1"></div>
                <div class="double-bounce2"></div>
            </div>
        </div>
    </div>

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
                                            <c:choose>
                                                <c:when test="${not empty articles}">
                                                    <c:forEach var="article" items="${articles}">
                                                        <tr>
                                                            <td><c:out value="${article.id}" /></td>
                                                            <td><c:out value="${article.title}" /></td>
                                                            <td><c:out value="${article.category}" /></td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${not empty article.imageUrl && article.imageUrl != ''}">
                                                                        <img src="<%= request.getContextPath() %>${article.imageUrl}" alt="Blog Image" style="width: 50px; height: 50px; object-fit: cover;">
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <img src="<%= request.getContextPath() %>/assets/images/default-image.jpg" alt="Default Image" style="width: 50px; height: 50px; object-fit: cover; background-color: #ddd;">
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
                                                </c:when>
                                                <c:otherwise>
                                                    <tr>
                                                        <td colspan="6" class="text-center">Không có blog nào</td>
                                                    </tr>
                                                </c:otherwise>
                                            </c:choose>
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
                        <div class="mb-3">
                            <label for="blogTitle" class="form-label">Tiêu đề</label>
                            <input type="text" class="form-control" id="blogTitle" name="title" required>
                        </div>
                        <div class="mb-3">
                            <label for="blogCategory" class="form-label">Thể loại</label>
                            <select class="form-control" id="blogCategory" name="category" required>
                                <option value="vay">Vay</option>
                                <option value="tin tức">Tin tức</option>
                                <option value="khác">Khác</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="blogImage" class="form-label">Hình ảnh</label>
                            <input type="file" class="form-control" id="blogImage" name="image" accept=".jpg,.png,.jpeg" required>
                        </div>
                        <div class="mb-3">
                            <label for="blogDescription" class="form-label">Mô tả</label>
                            <textarea class="form-control" id="blogDescription" name="description" required></textarea>
                        </div>
                        <input type="hidden" name="action" value="add">
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="button" class="btn btn-primary" id="saveNewBlog">Lưu Blog</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Blog Modal -->
    <div class="modal fade" id="editBlogModal" tabindex="-1" aria-labelledby="editBlogModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content" id="editBlogModalContent">
                <!-- Nội dung modal sẽ được load động qua AJAX -->
            </div>
        </div>
    </div>

    <script src="<%= request.getContextPath() %>/assets/js/jquery.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/bootstrap.bundle.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/simplebar.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/feather.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/app.js"></script>
    <script src="<%= request.getContextPath() %>/assets/tinymce/tinymce.min.js"></script>
    <script>
       $('.edit-blog').on('click', function() {
    var blogId = $(this).data('id');
    console.log("Loading edit modal for blog ID: " + blogId);
    $.ajax({
        url: '<%= request.getContextPath() %>/BlogServlet?action=edit&id=' + blogId,
        type: 'GET',
        success: function(response) {
            $('#editBlogModalContent').html(response);
            $('#editBlogModal').modal('show');

            // Gắn sự kiện cho nút "Lưu thay đổi" sau khi modal được load
            $('#saveEditBlog').on('click', function() {
                console.log("Saving edited blog");
                tinymce.triggerSave(); // Lưu dữ liệu từ TinyMCE vào textarea
                $('#editBlogForm').submit();
            });

            // Khởi tạo TinyMCE nếu chưa có
            if (!tinymce.get('editBlogDescription')) {
                tinymce.init({
                    selector: '#editBlogDescription',
                    height: 300,
                    plugins: 'advlist autolink lists link charmap preview anchor searchreplace visualblocks code fullscreen insertdatetime media table paste code help wordcount',
                    toolbar: 'undo redo | formatselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat | help',
                    images_upload_url: false,
                    images_upload_handler: false,
                    setup: function(editor) {
                        editor.on('change', function() {
                            editor.save();
                        });
                    }
                });
            }
        },
        error: function(xhr, status, error) {
            console.error("Error loading edit modal - Status: " + status + ", Error: " + error);
            console.error("Response Text: " + xhr.responseText);
            alert('Lỗi khi tải dữ liệu blog: ' + status + ' - ' + xhr.responseText);
        }
    });
});
    </script>
    <script>
    $('#saveNewBlog').on('click', function() {
        console.log("Saving new blog");
        $('#addBlogForm').submit();
    });
</script>
</body>
</html>