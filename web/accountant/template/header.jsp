<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.Staff" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


<% 
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
            <a href="#" class="logo-icon">
                <img src="${pageContext.request.contextPath}/assets/images/logo-icon2.png" height="30" class="small" alt="">
                <span class="big">
                    <img src="${pageContext.request.contextPath}/assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                    <img src="${pageContext.request.contextPath}/assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                </span>
            </a>
            <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2" href="#">
                <i class="uil uil-bars"></i>
            </a>
            <div class="search-bar p-0 d-none d-md-block ms-2">
                <div id="search" class="menu-search mb-0">
                    <form role="search" method="get" id="searchform" class="searchform">
                        <div>
                            <input type="text" class="form-control border rounded-pill" name="s" id="s" placeholder="Search Keywords...">
                            <input type="submit" id="searchsubmit" value="Search">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <ul class="list-unstyled mb-0">
            <li class="list-inline-item mb-0">
                <div class="dropdown dropdown-primary">
                    <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <img src="${pageContext.request.contextPath}/assets/images/language/american.png" class="avatar avatar-ex-small rounded-circle p-2" alt="">
                    </button>
                    <div class="dropdown-menu dd-menu drop-ups dropdown-menu-end bg-white shadow border-0 mt-3 p-2" data-simplebar style="height: 175px;">
                        <a href="javascript:void(0)" class="d-flex align-items-center">
                            <img src="${pageContext.request.contextPath}/assets/images/language/chinese.png" class="avatar avatar-client rounded-circle shadow" alt="">
                            <div class="flex-1 text-left ms-2 overflow-hidden">
                                <small class="text-dark mb-0">Chinese</small>
                            </div>
                        </a>
                        <a href="javascript:void(0)" class="d-flex align-items-center mt-2">
                            <img src="${pageContext.request.contextPath}/assets/images/language/european.png" class="avatar avatar-client rounded-circle shadow" alt="">
                            <div class="flex-1 text-left ms-2 overflow-hidden">
                                <small class="text-dark mb-0">European</small>
                            </div>
                        </a>
                        <a href="javascript:void(0)" class="d-flex align-items-center mt-2">
                            <img src="${pageContext.request.contextPath}/assets/images/language/indian.png" class="avatar avatar-client rounded-circle shadow" alt="">
                            <div class="flex-1 text-left ms-2 overflow-hidden">
                                <small class="text-dark mb-0">Indian</small>
                            </div>
                        </a>
                        <a href="javascript:void(0)" class="d-flex align-items-center mt-2">
                            <img src="${pageContext.request.contextPath}/assets/images/language/japanese.png" class="avatar avatar-client rounded-circle shadow" alt="">
                            <div class="flex-1 text-left ms-2 overflow-hidden">
                                <small class="text-dark mb-0">Japanese</small>
                            </div>
                        </a>
                        <a href="javascript:void(0)" class="d-flex align-items-center mt-2">
                            <img src="${pageContext.request.contextPath}/assets/images/language/russian.png" class="avatar avatar-client rounded-circle shadow" alt="">
                            <div class="flex-1 text-left ms-2 overflow-hidden">
                                <small class="text-dark mb-0">Russian</small>
                            </div>
                        </a>
                    </div>
                </div>
            </li>
            <li class="list-inline-item mb-0 ms-1">
                <a href="javascript:void(0)" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
                    <div class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="settings" class="fea icon-sm"></i></div>
                </a>
            </li>
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
                         <a class="dropdown-item text-dark" href="${pageContext.request.contextPath}/LogoutServlet">
                            <span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Đăng xuất
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