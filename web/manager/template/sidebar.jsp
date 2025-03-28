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

            <li><a href="profile-manager"><i class="uil uil-user me-2 d-inline-block"></i>Quản lí tài khoản</a></li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-file me-2 d-inline-block"></i>Dịch vụ khách hàng</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="customer-loan-service-management">Duyệt dịch vụ vay</a></li> 
                    </ul>
                </div>
            </li>   

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-file me-2 d-inline-block"></i>Dịch vụ gửi tiết kiệm</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="dep-option-service">Danh sách các gói dịch vụ</a></li>
                        <li><a href="add-saving-option">Tạo mới gói dịch vụ</a></li>                        
                    </ul>
                </div>
            </li>            

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-file me-2 d-inline-block"></i>Dịch vụ cho vay</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="loan-option-service">Danh sách các gói dịch vụ</a></li>
                        <li><a href="add-loan-option">Tạo mới gói dịch vụ</a></li>                        
                    </ul>
                </div>
            </li>       
            
            <li><a href="ChatHistoryManagement"><i class="uil uil-user me-2 d-inline-block"></i>Lịch sử chat của consultant</a></li>
            
            <li><a href="home.jsp"><i class="uil uil-window me-2 d-inline-block"></i>Home page</a></li>
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