<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-header">
    <h5 class="modal-title" id="editBlogModalLabel">Chỉnh sửa Blog</h5>
    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
</div>
<div class="modal-body">
    <form action="<%= request.getContextPath() %>/BlogServlet" method="post" enctype="multipart/form-data" id="editBlogForm">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="${article.id}">
        <div class="mb-3">
            <label for="editBlogTitle" class="form-label">Tiêu đề</label>
            <input type="text" class="form-control" id="editBlogTitle" name="title" value="${article.title}" required>
        </div>
        <div class="mb-3">
            <label for="editBlogCategory" class="form-label">Thể loại</label>
            <select class="form-control" id="editBlogCategory" name="category" required>
                <option value="vay" ${article.category == 'vay' ? 'selected' : ''}>Vay</option>
                <option value="tin tức" ${article.category == 'tin tức' ? 'selected' : ''}>Tin tức</option>
                <option value="khác" ${article.category == 'khác' ? 'selected' : ''}>Khác</option>
            </select>
        </div>
        <div class="mb-3">
            <label for="editBlogImage" class="form-label">Hình ảnh</label>
            <input type="file" class="form-control" id="editBlogImage" name="image" accept=".jpg,.png,.jpeg">
            <c:if test="${not empty article.imageUrl}">
                <img src="<%= request.getContextPath() %>${article.imageUrl}" alt="Current Image" style="width: 100px; margin-top: 10px;">
            </c:if>
        </div>
        <div class="mb-3">
            <label for="editBlogDescription" class="form-label">Mô tả</label>
            <textarea class="form-control" id="editBlogDescription" name="description" required>${article.description}</textarea>
        </div>
    </form>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
    <button type="button" class="btn btn-primary" id="saveEditBlog">Lưu thay đổi</button>
</div>