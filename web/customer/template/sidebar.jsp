<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<nav id="sidebar" class="sidebar-wrapper">
    <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
        <div class="sidebar-brand">
            <a href="Customer.jsp">
                <img src="<%= request.getContextPath() %>/assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                <img src="<%= request.getContextPath() %>/assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
            </a>
        </div>

        <ul class="sidebar-menu pt-3">
            <li><a href="Customer.jsp"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li>      
            <li><a href="account-profile.jsp"><i class="uil uil-cog me-2 d-inline-block"></i> Account Settings</a></li>
            <li class="sidebar-dropdown"> 
                <a href="javascript:void(0)"><i class="uil uil-university me-2 d-inline-block"></i>Manage Account Bank</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="blogs.html">Dashboard</a></li>
                        <li><a href="deposit.jsp">Deposit</a></li>
                        <li><a href="Saving.jsp">Saving Money</a></li>
                                            </ul>
                </div>
            </li>
            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Blogs</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="blogs.html">Blogs</a></li>
                        <li><a href="blog-detail.html">Blog Detail</a></li>
                    </ul>
                </div>
            </li>
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
