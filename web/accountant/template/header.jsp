<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.Staff" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


<% 
    // Không khai báo lại biến session, sử dụng implicit object session có sẵn
    if (session == null || session.getAttribute("staff") == null) {
        response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
        return; 
    }

    Staff staff = (Staff) session.getAttribute("staff");
    String imagePath;
    if (staff != null && staff.getImage() != null && !staff.getImage().isEmpty()) {
        imagePath = request.getContextPath() + "/uploads/" + staff.getImage();
    } else {
        imagePath = request.getContextPath() + "/assets/images/default-avatar.jpg";
    }
%>
<div class="top-header">
    <div class="header-bar d-flex justify-content-between border-bottom">
        <div class="d-flex align-items-center">
        </div>
        <ul class="list-unstyled mb-0">
            <li class="list-inline-item mb-0 ms-1">
                <div class="dropdown dropdown-primary">
                    <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <img src="<%= imagePath %>" class="avatar avatar-ex-small rounded-circle" alt="">
                    </button>
                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                        <a class="dropdown-item d-flex align-items-center text-dark" href="staff-profile.jsp">
                            <img src="<%= imagePath %>" class="avatar avatar-md-sm rounded-circle border shadow" alt="Avatar">
                            <div class="flex-1 ms-2">
                                <span class="d-block mb-1"><%= staff.getFirstname() %> <%= staff.getLastname() %></span>
                                <small class="text-muted">Nhân viên</small>
                            </div>
                        </a>
                        <a class="dropdown-item text-dark" href="${pageContext.request.contextPath}/BlogServlet"><span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Quản lý Blogs</a>
                        <a class="dropdown-item text-dark" href="staff-profile.jsp"><span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                        <div class="dropdown-divider border-top"></div>
                        <a class="dropdown-item text-dark" href="${pageContext.request.contextPath}/AuthServlet?action=logout">
                            <span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Logout
                        </a>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</div>
<!-- JavaScript -->
<script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
<script>
    feather.replace();
</script>