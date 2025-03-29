<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav id="sidebar" class="sidebar-wrapper">
    <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
        <div class="sidebar-brand">
            <a href="<%= request.getContextPath() %>/home.jsp">
                <img src="<%= request.getContextPath() %>/assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                <img src="<%= request.getContextPath() %>/assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
            </a>
        </div>

        <ul class="sidebar-menu pt-3">

            <li><a href="<%= request.getContextPath() %>/ceoProfileServlet"><i class="uil uil-user me-2 d-inline-block"></i>Thông tin cá nhân</a></li>         
            <li><a href="<%= request.getContextPath() %>/depositApproval"><i class="uil uil-user me-2 d-inline-block"></i>Duyệt phương án tiết kiệm</a></li>         
            <li><a href="<%= request.getContextPath() %>/loanApproval"><i class="uil uil-user me-2 d-inline-block"></i>Duyệt phương án vay</a></li>         

        </ul>
        <!-- sidebar-menu  -->
    </div>
    <!-- sidebar-content  -->
    <ul class="sidebar-footer list-unstyled mb-0">
        <li class="list-inline-item mb-0 ms-1">
            <a href="#" class="btn btn-icon btn-pills btn-soft-primary">
                <i class="uil uil-comment icons"></i>
            </a>
        </li>
    </ul>
</nav>