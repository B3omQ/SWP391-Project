<%-- 
    Document   : sidebar
    Created on : Jan 31, 2025, 12:38:49 PM
    Author     : JIGGER
--%>

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
            <li><a href="index.html"><i class="uil uil-dashboard me-2 d-inline-block"></i>Bảng điều khiển</a></li>

            <li><a href="profile-admin"><i class="uil uil-user me-2 d-inline-block"></i>Trang cá nhân</a></li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-file me-2 d-inline-block"></i>Danh sách khách hàng</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="customer-admin-management">Danh sách thông tin cá nhân</a></li>
                        <li><a href="identity-customer-management">Danh sách thông tin định danh</a></li>  
                        <li><a href="blacklist-customer-management">Danh sách đen</a></li>
                    </ul>
                </div>
            </li>            

            <li><a href="accountant-admin-management"><i class="uil uil-file me-2 d-inline-block"></i>Danh sách kế toán</a></li>

            <li><a href="consultant-admin-management"><i class="uil uil-file me-2 d-inline-block"></i>Danh sách tư vấn viên</a></li>

            <li><a href="manager-admin-management"><i class="uil uil-file me-2 d-inline-block"></i>Danh sách quản lí</a></li>

            <li><a href="home.jsp"><i
                        class="uil uil-window me-2 d-inline-block"></i>Trang chủ</a></li>
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

