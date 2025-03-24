<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<nav id="sidebar" class="sidebar-wrapper">
    <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
        <div class="sidebar-brand">
            <a href="Customer.jsp">
                <img src="${pageContext.request.contextPath}/assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                <img src="${pageContext.request.contextPath}/assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
            </a>
        </div>
        <ul class="sidebar-menu pt-3">
            <li><a href="${pageContext.request.contextPath}/customer/Customer.jsp"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/customer/account-profile.jsp"><i class="uil uil-cog me-2 d-inline-block"></i>Account-Settings</a></li>
            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-university me-2 d-inline-block"></i>Manage Account Bank</a>
                <div class="sidebar-submenu">
                    <ul>
                         <li><a href="${pageContext.request.contextPath}/customer/deposit.jsp">Nạp tiền qua VNPay</a></li>
            <li><a href="${pageContext.request.contextPath}/customer/direct-deposit.jsp">Nạp tiền trực tiếp</a></li>
            <li><a href="${pageContext.request.contextPath}/customer/Saving.jsp">Gửi tiết kiệm</a></li>
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
            <li><a href="http://localhost:9999/BankingSystem/CustomerReview"><i class="uil uil-cog me-2 d-inline-block"></i>đánh giá</a></li>
            <li><a href="http://localhost:9999/BankingSystem/ChatLogConsultant"><i class="uil uil-cog me-2 d-inline-block"></i>Lịch sử chat với consultant</a></li>
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