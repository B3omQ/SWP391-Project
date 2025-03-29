<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav id="sidebar" class="sidebar-wrapper">
    <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
        <div class="sidebar-brand">
            <a href="index.html">
                <img src="<%= request.getContextPath() %>/assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                <img src="<%= request.getContextPath() %>/assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
            </a>
        </div>

        <ul class="sidebar-menu pt-3">        
            <li>
                <a href="<%= request.getContextPath() %>/DirectDepositManageServlet"><i class="uil uil-file me-2 d-inline-block"></i>Quản lí phiếu nạp tiền</a>

            </li>
            <li><a href="<%= request.getContextPath() %>/Disbursement"><i class="uil uil-file me-2 d-inline-block"></i>Giải Ngân</a></li>
            <li><a href="<%= request.getContextPath() %>/BlogServlet"><i class="uil uil-blogger me-2 d-inline-block"></i>Blogs</a></li>
            <li><a href="home.jsp"><i class="uil uil-window me-2 d-inline-block"></i>Home page</a></li>
        </ul>
    </div>
    <ul class="sidebar-footer list-unstyled mb-0">
        <li class="list-inline-item mb-0 ms-1">
            <a href="#" class="btn btn-icon btn-pills btn-soft-primary">
                <i class="uil uil-comment icons"></i>
            </a>
        </li>
    </ul>
</nav>