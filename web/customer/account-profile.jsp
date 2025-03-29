<%@ page import="model.Customer" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8" />
    <title>SmartBanking - Hệ thống quản lý tài khoản</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Hệ thống quản lý tài khoản ngân hàng thông minh" />
    <meta name="keywords" content="Ngân hàng, Tài khoản, Quản lý, Giao dịch" />
    <meta name="author" content="Shreethemes" />
    <meta name="email" content="support@shreethemes.in" />
    <meta name="website" content="https://shreethemes.in" />
    <meta name="Version" content="v1.2.0" />
    <!-- favicon -->
    <link rel="shortcut icon" href="<%= request.getContextPath() %>/assets/images/favicon.ico.png">
    <!-- Bootstrap -->
    <link href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Icons -->
    <link href="<%= request.getContextPath() %>/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="<%= request.getContextPath() %>/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <!-- Css -->
    <link href="<%= request.getContextPath() %>/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
</head>

<body>
<%
    // Kiểm tra session
    if (session.getAttribute("account") == null) {
        response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
        return;
    }

    Customer account = (Customer) session.getAttribute("account");
    String imagePath;

    if (account != null && account.getImage() != null && !account.getImage().isEmpty()) {
        imagePath = request.getContextPath() + "/" + account.getImage();
    } else {
        imagePath = request.getContextPath() + "/assets/images/default-avatar.jpg";
    }
%>

<!-- Loader -->
<div id="preloader">
    <div id="status">
        <div class="spinner">
            <div class="double-bounce1"></div>
            <div class="double-bounce2"></div>
        </div>
    </div>
</div>
<!-- Loader -->

<!-- Navbar Start -->
<header id="topnav" class="defaultscroll sticky">
    <div class="container">
        <!-- Logo container-->
        <a class="logo" href="Customer.jsp">
            <img src="<%= request.getContextPath() %>/assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
            <img src="<%= request.getContextPath() %>/assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
        </a>
        <!-- Logo End -->

        <!-- Start Mobile Toggle -->
        <div class="menu-extras">
            <div class="menu-item">
                <!-- Mobile menu toggle-->
                <a class="navbar-toggle" id="isToggle" onclick="toggleMenu()">
                    <div class="lines">
                        <span></span>
                        <span></span>
                        <span></span>
                    </div>
                </a>
                <!-- End mobile menu toggle-->
            </div>
        </div>
        <!-- End Mobile Toggle -->

        <!-- Start Dropdown -->
        <ul class="dropdowns list-inline mb-0">
            <li class="list-inline-item mb-0">
                <a href="javascript:void(0)" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
                    <div class="btn btn-icon btn-pills btn-primary"><i data-feather="settings" class="fea icon-sm"></i></div>
                </a>
            </li>

            <li class="list-inline-item mb-0 ms-1">
                <a href="javascript:void(0)" class="btn btn-icon btn-pills btn-primary" data-bs-toggle="offcanvas" data-bs-target="#offcanvasTop" aria-controls="offcanvasTop">
                    <i class="uil uil-search"></i>
                </a>
            </li>

            <li class="list-inline-item mb-0 ms-1">
                <div class="dropdown dropdown-primary">
                    <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <img src="<%= imagePath %>" class="avatar avatar-ex-small rounded-circle" alt="">
                    </button>
                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                        <a class="dropdown-item d-flex align-items-center text-dark" href="doctor-profile.html">
                            <img src="<%= imagePath %>" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                            <div class="flex-1 ms-2">
                                <span class="d-block mb-1">${account.firstname} ${account.lastname}</span>
                                <small class="text-muted">Khách hàng</small>
                            </div>
                        </a>
                        <a class="dropdown-item text-dark" href="Customer.jsp"><span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Bảng điều khiển</a>
                        <a class="dropdown-item text-dark" href="account-profile.jsp"><span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span> Cài đặt hồ sơ</a>
                        <div class="dropdown-divider border-top"></div>
                        <a class="dropdown-item text-dark" href="<%= request.getContextPath() %>/AuthServlet?action=logout">
                            <span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Đăng xuất
                        </a>
                    </div>
                </div>
            </li>
        </ul>
        <!-- Start Dropdown -->

        <div id="navigation">
            <!-- Navigation Menu-->
            <ul class="navigation-menu nav-left">
                <li class="has-submenu parent-menu-item">
                    <a href="javascript:void(0)">Trang chủ</a><span class="menu-arrow"></span>
                    <ul class="submenu">
                        <li><a href="index.jsp" class="sub-menu-item">Trang chủ 1</a></li>
                        <li><a href="index-two.html" class="sub-menu-item">Trang chủ 2</a></li>
                        <li><a href="index-three.html" class="sub-menu-item">Trang chủ 3</a></li>
                    </ul>
                </li>
            </ul><!--end navigation menu-->
        </div><!--end navigation-->
    </div><!--end container-->
</header><!--end header-->
<!-- Navbar End -->

<!-- Start -->
<section class="bg-dashboard">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-xl-4 col-lg-4 col-md-5 col-12">
                <div class="rounded shadow overflow-hidden sticky-bar">
                    <div class="card border-0">
                        <img src="<%= request.getContextPath() %>/assets/images/doctors/profile-bg.jpg" class="img-fluid" alt="">
                    </div>

                    <div class="text-center avatar-profile margin-nagative mt-n5 position-relative pb-4 border-bottom">
                        <img src="<%= imagePath %>" class="rounded-circle shadow-md avatar avatar-md-md" alt="">
                        <h5 class="mt-3 mb-1">${account.firstname} ${account.lastname}</h5>
                        <p class="text-muted mb-0">Khách hàng</p>
                    </div>

                    <ul class="list-unstyled sidebar-nav mb-0">
                        <li class="navbar-item"><a href="Customer.jsp" class="navbar-link"><i class="ri-airplay-line align-middle navbar-icon"></i>Bảng điều khiển</a></li>
                        <li class="navbar-item"><a href="account-profile.jsp" class="navbar-link"><i class="ri-user-settings-line align-middle navbar-icon"></i>Cài đặt hồ sơ</a></li>
                        <li class="navbar-item"><a href="<%= request.getContextPath() %>/identity-information-switch-case" class="navbar-link"><i class="ri-user-settings-line align-middle navbar-icon"></i>Xác thực tài khoản</a></li>
                    </ul>
                </div>
            </div><!--end col-->

            <div class="col-xl-8 col-lg-8 col-md-7 mt-4 pt-2 mt-sm-0 pt-sm-0">
                <div class="rounded shadow mt-4">
                    <div class="p-4 border-bottom">
                        <h5 class="mb-0">Thông tin cá nhân:</h5>
                    </div>

                    <div class="p-4 border-bottom">
                        <div class="row align-items-center">
                            <div class="col-lg-2 col-md-4">
                                <img src="<%= imagePath %>" class="avatar avatar-md-md rounded-pill shadow mx-auto d-block" alt="Ảnh người dùng">
                            </div>

                            <div class="col-lg-5 col-md-8 text-center text-md-start mt-4 mt-sm-0">
                                <h5>Tải ảnh đại diện</h5>
                                <p class="text-muted mb-0">Để có kết quả tốt nhất, hãy sử dụng hình ảnh có kích thước ít nhất 256px x 256px ở định dạng .jpg hoặc .png</p>
                            </div>

                            <div class="col-lg-5 col-md-12 text-lg-end text-center mt-4 mt-lg-0">
                                <!-- Form Upload -->
                                <form action="<%= request.getContextPath() %>/UploadImageServlet" method="post" enctype="multipart/form-data">
                                    <input type="file" name="image" accept=".jpg,.png" class="form-control mb-2">
                                    <button type="submit" class="btn btn-primary">Tải lên</button>

                                    <c:if test="${not empty sessionScope.error2}">
                                        <p style="color: red;">${sessionScope.error2}</p>
                                        <c:remove var="error2" scope="session"/>
                                    </c:if>

                                    <c:if test="${not empty sessionScope.success2}">
                                        <p style="color: green;">${sessionScope.success2}</p>
                                        <c:remove var="success2" scope="session"/>
                                    </c:if>
                                </form>
                            </div>
                        </div>
                    </div>

                    <form action="<%= request.getContextPath() %>/UpdateInfo" method="post" onsubmit="return confirmUpdate()">
                        <div class="p-4">
                            <div class="row">
                                <!-- First Name (Có thể chỉnh sửa) -->
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="firstName" class="form-label">Tên</label>
                                        <input id="firstName" name="firstName" type="text" class="form-control"
                                               value="${account != null ? account.firstname : ''}" required>
                                    </div>
                                </div>

                                <!-- Last Name (Có thể chỉnh sửa) -->
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="lastName" class="form-label">Họ</label>
                                        <input id="lastName" name="lastName" type="text" class="form-control"
                                               value="${account != null ? account.lastname : ''}" required>
                                    </div>
                                </div>

                                <!-- Email (Có thể chỉnh sửa) -->
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email của bạn</label>
                                        <input id="email" name="email" type="email" class="form-control"
                                               value="${account != null ? account.email : ''}" required>
                                    </div>
                                </div>

                                <!-- Phone (Có thể chỉnh sửa) -->
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="phone" class="form-label">Số điện thoại</label>
                                        <input id="phone" name="phone" type="text" class="form-control"
                                               value="${account != null ? account.phone : ''}" required>
                                    </div>
                                </div>

                                <!-- Gender (Có thể chỉnh sửa) -->
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="gender" class="form-label">Giới tính</label>
                                        <select id="gender" name="gender" class="form-control" required>
                                            <option value="Nam" ${account != null && account.gender != null && account.gender.equals("Nam") ? 'selected' : ''}>Nam</option>
                                            <option value="Nữ" ${account != null && account.gender != null && account.gender.equals("Nữ") ? 'selected' : ''}>Nữ</option>
                                            <option value="Khác" ${account != null && account.gender != null && account.gender.equals("Khác") ? 'selected' : ''}>Khác</option>
                                        </select>
                                    </div>
                                </div>

                                <!-- Date of Birth (Có thể chỉnh sửa) -->
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="dob" class="form-label">Ngày sinh</label>
                                        <input id="dob" name="dob" type="date" class="form-control"
                                               value="${account != null && account.dob != null ? account.dob : ''}" required>
                                    </div>
                                </div>

                                <!-- Address (Có thể chỉnh sửa) -->
                                <div class="col-md-12">
                                    <div class="mb-3">
                                        <label for="address" class="form-label">Địa chỉ</label>
                                        <input id="address" name="address" type="text" class="form-control"
                                               value="${account != null && account.address != null ? account.address : ''}" required>
                                    </div>
                                </div>
                            </div>

                            <!-- Nút Save Changes -->
                            <div class="row">
                                <div class="col-12 text-end">
                                    <input type="hidden" name="id" value="${account != null ? account.id : ''}">
                                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                </div>
                            </div>

                            <!-- Thông báo thành công / lỗi -->
                            <c:if test="${not empty sessionScope.error3}">
                                <p style="color: red;">${sessionScope.error3}</p>
                                <c:remove var="error3" scope="session"/>
                            </c:if>
                            <c:if test="${not empty sessionScope.success3}">
                                <p style="color: green;">${sessionScope.success3}</p>
                                <c:remove var="success3" scope="session"/>
                            </c:if>
                        </div>
                    </form>

                    <div class="rounded shadow mt-4">
                        <div class="p-4 border-bottom">
                            <h5 class="mb-0">Đổi mật khẩu:</h5>
                        </div>

                        <div class="p-4">
                            <form action="<%= request.getContextPath() %>/AuthServlet?action=changePassword" method="POST">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="mb-3 position-relative">
                                            <label class="form-label">Mật khẩu cũ:</label>
                                            <input type="password" class="form-control" placeholder="Nhập mật khẩu cũ" name="oldPassword" id="oldPassword" required>
                                            <span class="position-absolute top-50 end-0 translate-middle-y pe-3 cursor-pointer" onclick="togglePassword('oldPassword', 'toggleOldPasswordIcon')" style="padding-top: 30px;">
                                                <i id="toggleOldPasswordIcon" class="mdi mdi-eye-outline"></i>
                                            </span>
                                        </div>
                                    </div><!--end col-->

                                    <div class="col-lg-12">
                                        <div class="mb-3 position-relative">
                                            <label class="form-label">Mật khẩu mới:</label>
                                            <input type="password" class="form-control" placeholder="Nhập mật khẩu mới" name="newPassword" id="newPassword" required>
                                            <span class="position-absolute top-50 end-0 translate-middle-y pe-3 cursor-pointer" onclick="togglePassword('newPassword', 'toggleNewPasswordIcon')" style="padding-top: 30px;">
                                                <i id="toggleNewPasswordIcon" class="mdi mdi-eye-outline"></i>
                                            </span>
                                        </div>
                                    </div><!--end col-->

                                    <div class="col-lg-12">
                                        <div class="mb-3 position-relative">
                                            <label class="form-label">Nhập lại mật khẩu mới:</label>
                                            <input type="password" class="form-control" placeholder="Nhập lại mật khẩu mới" name="retypeNewPassword" id="retypeNewPassword" required>
                                            <span class="position-absolute top-50 end-0 translate-middle-y pe-3 cursor-pointer" onclick="togglePassword('retypeNewPassword', 'toggleRetypePasswordIcon')" style="padding-top: 30px;">
                                                <i id="toggleRetypePasswordIcon" class="mdi mdi-eye-outline"></i>
                                            </span>
                                        </div>
                                    </div><!--end col-->

                                    <div class="col-lg-12 mt-2 mb-0">
                                        <button class="btn btn-primary">Lưu mật khẩu</button>
                                    </div><!--end col-->
                                </div><!--end row-->
                            </form>
                            <c:if test="${not empty error}">
                                <p style="color: red;">${error}</p>
                            </c:if>
                            <c:if test="${not empty success}">
                                <p style="color: green;">${success}</p>
                            </c:if>
                        </div>
                    </div>
                </div><!--end col-->
            </div><!--end row-->
        </div><!--end container-->
</section><!--end section-->
<!-- End -->

<!-- Footer Start -->
<footer class="bg-footer py-4">
    <div class="container-fluid">
        <div class="row align-items-center">
            <div class="col-sm-6">
                <div class="text-sm-start text-center">
                    <p class="mb-0"><script>document.write(new Date().getFullYear())</script> © SmartBanking. Thiết kế với <i class="mdi mdi-heart text-danger"></i> bởi <a href="../../../index.jsp" target="_blank" class="text-reset">Shreethemes</a>.</p>
                </div>
            </div><!--end col-->

            <div class="col-sm-6 mt-4 mt-sm-0">
                <ul class="list-unstyled footer-list text-sm-end text-center mb-0">
                    <li class="list-inline-item"><a href="terms.html" class="text-foot me-2">Điều khoản</a></li>
                    <li class="list-inline-item"><a href="privacy.html" class="text-foot me-2">Chính sách bảo mật</a></li>
                    <li class="list-inline-item"><a href="aboutus.html" class="text-foot me-2">Về chúng tôi</a></li>
                    <li class="list-inline-item"><a href="contact.html" class="text-foot me-2">Liên hệ</a></li>
                </ul>
            </div><!--end col-->
        </div><!--end row-->
    </div><!--end container-->
</footer><!--end footer-->
<!-- End -->

<!-- Back to top -->
<a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>
<!-- Back to top -->

<!-- Offcanvas Start -->
<div class="offcanvas bg-white offcanvas-top" tabindex="-1" id="offcanvasTop">
    <div class="offcanvas-body d-flex align-items-center align-items-center">
        <div class="container">
            <div class="row">
                <div class="col">
                    <div class="text-center">
                        <h4>Tìm kiếm ngay...</h4>
                        <div class="subcribe-form mt-4">
                            <form>
                                <div class="mb-0">
                                    <input type="text" id="help" name="name" class="border bg-white rounded-pill" required="" placeholder="Tìm kiếm">
                                    <button type="submit" class="btn btn-pills btn-primary">Tìm kiếm</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div><!--end col-->
            </div><!--end row-->
        </div><!--end container-->
    </div>
</div>
<!-- Offcanvas End -->

<!-- Offcanvas Start -->
<div class="offcanvas offcanvas-end bg-white shadow" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
    <div class="offcanvas-header p-4 border-bottom">
        <h5 id="offcanvasRightLabel" class="mb-0">
            <img src="<%= request.getContextPath() %>/assets/images/logo-dark.png" height="24" class="light-version" alt="">
            <img src="<%= request.getContextPath() %>/assets/images/logo-light.png" height="24" class="dark-version" alt="">
        </h5>
        <button type="button" class="btn-close d-flex align-items-center text-dark" data-bs-dismiss="offcanvas" aria-label="Close"><i class="uil uil-times fs-4"></i></button>
    </div>
    <div class="offcanvas-body p-4 px-md-5">
        <div class="row">
            <div class="col-12">
                <!-- Style switcher -->
                <div id="style-switcher">
                    <div>
                        <ul class="text-center list-unstyled mb-0">
                            <li class="d-grid"><a href="javascript:void(0)" class="rtl-version t-rtl-light" onclick="setTheme('style-rtl')"><img src="<%= request.getContextPath() %>/assets/images/layouts/landing-light-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Phiên bản RTL</span></a></li>
                            <li class="d-grid"><a href="javascript:void(0)" class="ltr-version t-ltr-light" onclick="setTheme('style')"><img src="<%= request.getContextPath() %>/assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Phiên bản LTR</span></a></li>
                            <li class="d-grid"><a href="javascript:void(0)" class="dark-rtl-version t-rtl-dark" onclick="setTheme('style-dark-rtl')"><img src="<%= request.getContextPath() %>/assets/images/layouts/landing-dark-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Phiên bản RTL</span></a></li>
                            <li class="d-grid"><a href="javascript:void(0)" class="dark-ltr-version t-ltr-dark" onclick="setTheme('style-dark')"><img src="<%= request.getContextPath() %>/assets/images/layouts/landing-dark.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Phiên bản LTR</span></a></li>
                            <li class="d-grid"><a href="javascript:void(0)" class="dark-version t-dark mt-4" onclick="setTheme('style-dark')"><img src="<%= request.getContextPath() %>/assets/images/layouts/landing-dark.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Chế độ tối</span></a></li>
                            <li class="d-grid"><a href="javascript:void(0)" class="light-version t-light mt-4" onclick="setTheme('style')"><img src="<%= request.getContextPath() %>/assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Chế độ sáng</span></a></li>
                            <li class="d-grid"><a href="../admin/index.jsp" target="_blank" class="mt-4"><img src="<%= request.getContextPath() %>/assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Bảng điều khiển quản trị</span></a></li>
                        </ul>
                    </div>
                </div>
                <!-- end Style switcher -->
            </div><!--end col-->
        </div><!--end row-->
    </div>

    <div class="offcanvas-footer p-4 border-top text-center">
        <ul class="list-unstyled social-icon mb-0">
            <li class="list-inline-item mb-0"><a href="https://1.envato.market/doctris-template" target="_blank" class="rounded"><i class="uil uil-shopping-cart align-middle" title="Mua ngay"></i></a></li>
            <li class="list-inline-item mb-0"><a href="https://dribbble.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-dribbble align-middle" title="dribbble"></i></a></li>
            <li class="list-inline-item mb-0"><a href="https://www.facebook.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-facebook-f align-middle" title="facebook"></i></a></li>
            <li class="list-inline-item mb-0"><a href="https://www.instagram.com/shreethemes/" target="_blank" class="rounded"><i class="uil uil-instagram align-middle" title="instagram"></i></a></li>
            <li class="list-inline-item mb-0"><a href="https://twitter.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-twitter align-middle" title="twitter"></i></a></li>
            <li class="list-inline-item mb-0"><a href="mailto:support@shreethemes.in" class="rounded"><i class="uil uil-envelope align-middle" title="email"></i></a></li>
            <li class="list-inline-item mb-0"><a href="../../../index.jsp" target="_blank" class="rounded"><i class="uil uil-globe align-middle" title="website"></i></a></li>
        </ul><!--end icon-->
    </div>
</div>
<!-- Offcanvas End -->

<!-- javascript -->
<script src="<%= request.getContextPath() %>/assets/js/bootstrap.bundle.min.js"></script>
<!-- Icons -->
<script src="<%= request.getContextPath() %>/assets/js/feather.min.js"></script>
<!-- Main Js -->
<script src="<%= request.getContextPath() %>/assets/js/app.js"></script>
<script>
    function confirmUpdate() {
        return confirm("Bạn có chắc chắn muốn lưu thay đổi không?");
    }
</script>

<script>
    function togglePassword(passwordFieldId, iconId) {
        var passwordField = document.getElementById(passwordFieldId);
        var toggleIcon = document.getElementById(iconId);

        if (passwordField.type === "password") {
            passwordField.type = "text";
            toggleIcon.classList.remove("mdi-eye-outline");
            toggleIcon.classList.add("mdi-eye-off-outline");
        } else {
            passwordField.type = "password";
            toggleIcon.classList.remove("mdi-eye-off-outline");
            toggleIcon.classList.add("mdi-eye-outline");
        }
    }
</script>
</body>
</html>