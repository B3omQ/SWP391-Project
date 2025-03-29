<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<style>
    /* Ẩn submenu mặc định */
    .sidebar-submenu {
        display: none !important;
    }

    /* Chỉ hiển thị submenu của mục được hover */
    .sidebar-dropdown:hover > .sidebar-submenu {
        display: block !important;
    }

    /* Tùy chỉnh giao diện submenu */
    .sidebar-submenu {
        position: relative;
        background: #fff;
        border: 1px solid #ddd;
        border-radius: 5px;
        padding: 5px 0;
    }

    .sidebar-submenu ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .sidebar-submenu li a {
        padding: 8px 20px;
        display: block;
        color: #333;
        text-decoration: none;
    }

    .sidebar-submenu li a:hover {
        background: #f8f9fa;
    }
</style>

<nav id="sidebar" class="sidebar-wrapper">
    <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
        <div class="sidebar-brand">
            <a href="<%= request.getContextPath() %>/home.jsp">
                <img src="${pageContext.request.contextPath}/assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                <img src="${pageContext.request.contextPath}/assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
            </a>
        </div>
        <ul class="sidebar-menu pt-3">
            <li><a href="${pageContext.request.contextPath}/customer/Customer.jsp"><i class="uil uil-dashboard me-2 d-inline-block"></i>Bảng điều khiển</a></li>
            <li><a href="${pageContext.request.contextPath}/customer/account-profile.jsp"><i class="uil uil-cog me-2 d-inline-block"></i>Cài đặt</a></li>
            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-university me-2 d-inline-block"></i>Dịch vụ ngân hàng</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/customer/deposit.jsp">Nạp tiền qua VNPay</a></li>
                        <li><a href="${pageContext.request.contextPath}/customer/direct-deposit.jsp">Nạp tiền trực tiếp</a></li>
                        <li><a href="${pageContext.request.contextPath}/customer/Saving.jsp">Gửi tiết kiệm</a></li>
                        <li><a href="<%= request.getContextPath() %>/applyLoan">Tạo khoản vay</a></li>
                        <li><a href="<%= request.getContextPath() %>/customerLoanServlet">Khoản vay của tôi</a></li>
                    </ul>
                </div>
            </li>
            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Blogs</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="<%= request.getContextPath() %>/NewsServlet">Blogs</a></li>
                    </ul>
                </div>
            </li>
            <li><a href="<%= request.getContextPath() %>/CustomerReview"><i class="uil uil-cog me-2 d-inline-block"></i>Đánh giá</a></li>
            <li><a href="<%= request.getContextPath() %>/ChatLogConsultant"><i class="uil uil-cog me-2 d-inline-block"></i>Lịch sử chat với consultant</a></li>
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