<%-- 
    Document   : header
    Created on : Feb 26, 2025, 11:53:32 AM
    Author     : LAPTOP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <header id="topnav" class="navigation sticky">
        <div class="container">
            <!-- Logo container-->
            <div>
                <a class="logo" href="index.html">
                    <span class="logo-light-mode">
                        <img src="assets/images/logo-dark.png" class="l-dark" height="24" alt="">
                        <img src="assets/images/logo-light.png" class="l-light" height="24" alt="">
                    </span>
                    <img src="assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                </a>
            </div>
            <!-- End Logo container-->

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
                    <a href="javascript:void(0)" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
                       aria-controls="offcanvasRight">
                        <div class="btn btn-icon btn-pills btn-primary"><i data-feather="settings"
                                                                           class="fea icon-sm"></i></div>
                    </a>
                </li>
                <c:if test="${sessionScope.sustomer == null && sessionScope.staff == null}">

                    <!--                    <li class="list-inline-item mb-0 ms-1">
                                            <a href="javascript:void(0)" class="btn btn-icon btn-pills btn-primary" data-bs-toggle="offcanvas"
                                               data-bs-target="#offcanvasTop" aria-controls="offcanvasTop">
                                                <i class="uil uil-search"></i>
                                            </a>
                                        </li>-->
                    <li class="list-inline-item mb-0 ms-1">
                        <a href="
                           ${pageContext.request.contextPath}/auth/template/login.jsp"" class="btn btn-pills btn-soft-primary">
                            <i class="uil uil-sign-in-alt align-middle h6 me-1"></i> Đăng nhập
                        </a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.customer != null}">
                    <li class="list-inline-item mb-0 ms-1">
                        <div class="dropdown dropdown-primary">
                            <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0"
                                    data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img
                                    src={customer.image} class="avatar avatar-ex-small rounded-circle"
                                    alt=""></button>
                            <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3"
                                 style="min-width: 200px;">
                                <a class="dropdown-item d-flex align-items-center text-dark" href="">
                                    <img src="assets/images/doctors/01.jpg"
                                         class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                    <div class="flex-1 ms-2">
                                        <span class="d-block mb-1">${Customer.username}</span>
                                    </div>
                                </a>
                                <a class="dropdown-item text-dark" href="doctor-dashboard.html"><span
                                        class="mb-0 d-inline-block me-1"><i
                                            class="uil uil-dashboard align-middle h6"></i></span> Dashboard</a>
                                <a class="dropdown-item text-dark" href="doctor-profile-setting.html"><span
                                        class="mb-0 d-inline-block me-1"><i
                                            class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                <div class="dropdown-divider border-top"></div>
                                <a class="dropdown-item text-dark" href="login.jsp"><span
                                        class="mb-0 d-inline-block me-1"><i
                                            class="uil uil-sign-out-alt align-middle h6"></i></span> Logout</a>
                            </div>
                        </div>
                    </li>
                </c:if>
                <c:if test="${sessionScope.staff != null}">
                    <li class="list-inline-item mb-0 ms-1">
                        <div class="dropdown dropdown-primary">
                            <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0"
                                    data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img
                                    src="assets/images/doctors/01.jpg" class="avatar avatar-ex-small rounded-circle"
                                    alt=""></button>
                            <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3"
                                 style="min-width: 200px;">
                                <a class="dropdown-item d-flex align-items-center text-dark" href="">
                                    <img src="assets/images/doctors/01.jpg"
                                         class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                    <div class="flex-1 ms-2">
                                        <span class="d-block mb-1">${customer.username}</span>
                                    </div>
                                </a>
                                <a class="dropdown-item text-dark" href="doctor-dashboard.html"><span
                                        class="mb-0 d-inline-block me-1"><i
                                            class="uil uil-dashboard align-middle h6"></i></span> Dashboard</a>
                                        <c:if test="${sessionScope.staff.roleId.id == 1}">
                                    <a class="dropdown-item text-dark" href="doctor-profile-setting.html"><span
                                            class="mb-0 d-inline-block me-1"><i
                                                class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                        </c:if>
                                        <c:if test="${sessionScope.staff.roleId.id == 2}">
                                    <a class="dropdown-item text-dark" href="./consultant-customer"><span
                                            class="mb-0 d-inline-block me-1"><i
                                                class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                        </c:if>
                                        <c:if test="${sessionScope.staff.roleId.id == 3}">
                                    <a class="dropdown-item text-dark" href="./profile-manager"><span
                                            class="mb-0 d-inline-block me-1"><i
                                                class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                        </c:if>
                                        <c:if test="${sessionScope.staff.roleId.id == 4}">
                                    <a class="dropdown-item text-dark" href="./Admin.jsp"><span
                                            class="mb-0 d-inline-block me-1"><i
                                                class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                        </c:if>
                                <div class="dropdown-divider border-top"></div>
                                <a class="dropdown-item text-dark" href="AuthServlet" name ="action" value="logout"><span
                                        class="mb-0 d-inline-block me-1"><i
                                            class="uil uil-sign-out-alt align-middle h6"></i></span> Logout</a>
                            </div>
                        </div>
                    </li>
                </c:if>
            </ul>
            <!-- Start Dropdown -->

            <div id="navigation">
                <!-- Navigation Menu-->
                <ul class="navigation-menu nav-left nav-light">
                    <li class="has-submenu parent-menu-item">
                        <a href="javascript:void(0)">Tiết kiệm</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <li><a href="index.html" class="sub-menu-item">Tiền gửi tiết kiệm có kì hạn</a></li>
                            <li><a href="index-two.html" class="sub-menu-item">tiết kiệm linh hoạt</a></li>
                            <li><a href="index-three.html" class="sub-menu-item">Chứng chỉ tiền gửi</a></li>
                        </ul>
                    </li>

                    <li class="has-submenu parent-parent-menu-item">
                        <a href="javascript:void(0)">Vay</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <li class="has-submenu parent-menu-item">
                                <a href="javascript:void(0)" class="menu-item"> Dashboard </a>
                                <!--                                    <span
                                                                        class="submenu-arrow"></span>
                                                                    <ul class="submenu"> //submenu dùng lại nếu cần
                                                                        <li><a href="doctor-dashboard.html" class="sub-menu-item">Dashboard</a></li>
                                                                        <li><a href="doctor-appointment.html" class="sub-menu-item">Appointment</a></li>
                                                                        <li><a href="patient-list.html" class="sub-menu-item">Patients</a></li>
                                                                        <li><a href="doctor-schedule.html" class="sub-menu-item">Schedule Timing</a></li>
                                                                        <li><a href="invoices.html" class="sub-menu-item">Invoices</a></li>
                                                                        <li><a href="patient-review.html" class="sub-menu-item">Reviews</a></li>
                                                                        <li><a href="doctor-messages.html" class="sub-menu-item">Messages</a></li>
                                                                        <li><a href="doctor-profile.html" class="sub-menu-item">Profile</a></li>
                                                                        <li><a href="doctor-profile-setting.html" class="sub-menu-item">Profile Settings</a>
                                                                        </li>
                                                                        <li><a href="doctor-chat.html" class="sub-menu-item">Chat</a></li>
                                                                        <li><a href="/login.jsp" class="sub-menu-item">Login</a></li>
                                                                        <li><a href="
                                                                               /signup.jsp" class="sub-menu-item">Sign Up</a></li>
                                                                        <li><a href="
                                                                               /forgot-password.jsp" class="sub-menu-item">Forgot Password</a></li>
                                                                    </ul>-->
                            </li>
                            <li><a href="doctor-team-one.html" class="sub-menu-item">Vay mua nhà</a></li>
                            <li><a href="doctor-team-two.html" class="sub-menu-item">Vay mua ô tô</a></li>
                            <li><a href="doctor-team-three.html" class="sub-menu-item">Vay tiêu dùng</a></li>
                        </ul>
                    </li>

                    <li class="has-submenu parent-menu-item">
                        <a href="javascript:void(0)">Đầu tư</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <li><a href="patient-dashboard.html" class="sub-menu-item">Dashboard</a></li>
                            <li><a href="patient-profile.html" class="sub-menu-item">Profile</a></li>
                            <li><a href="booking-appointment.html" class="sub-menu-item">Book Appointment</a></li>
                            <li><a href="patient-invoice.html" class="sub-menu-item">Invoice</a></li>
                        </ul>
                    </li>

                    <li class="has-submenu parent-menu-item">
                        <a href="javascript:void(0)">Bảo hiểm</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <li><a href="pharmacy.html" class="sub-menu-item">Pharmacy</a></li>
                            <li><a href="pharmacy-shop.html" class="sub-menu-item">Shop</a></li>
                            <li><a href="pharmacy-product-detail.html" class="sub-menu-item">Medicine Detail</a></li>
                            <li><a href="pharmacy-shop-cart.html" class="sub-menu-item">Shop Cart</a></li>
                            <li><a href="pharmacy-checkout.html" class="sub-menu-item">Checkout</a></li>
                            <li><a href="pharmacy-account.html" class="sub-menu-item">Account</a></li>
                        </ul>
                    </li>

                    <li class="has-submenu parent-parent-menu-item"><a href="javascript:void(0)">Các công cụ và tiện ích</a><span
                            class="menu-arrow"></span>
                        <ul class="submenu">
                            <li class="has-submenu parent-menu-item">
                                <a href="javascript:void(0)" class="menu-item"> Các loại bảng tính </a><span
                                    class="submenu-arrow"></span>
                                <ul class="submenu">
                                    <li><a href="./public/LoanInterestRateTool.jsp" class="sub-menu-item">Bảng tính lãi suất vay</a></li>
                                    <li><a href="./public/InsuranceBenefitsTool.jsp" class="sub-menu-item">Bảng tính quyền lợi bảo hiểm</a></li>
                                    <li><a href="./public/SaveInterestTool.jsp" class="sub-menu-item">Bảng tính lãi suất tiết kiệm</a></li>
                                </ul>
                            </li>
                            <li class="has-submenu parent-menu-item">
                                <a href="javascript:void(0)" class="menu-item"> Tỉ giá </a><span
                                    class="submenu-arrow"></span>
                                <ul class="submenu">
                                    <li><a href="blog-detail.html" class="sub-menu-item">Tỷ giá hối đoái</a></li>
                                    <li><a href="blog-detail.html" class="sub-menu-item">Quy đổi tiền tệ</a></li>
                                    <li><a href="blog-detail.html" class="sub-menu-item">Tỷ giá chốt</a></li>
                                    <li><a href="blog-detail.html" class="sub-menu-item">Tỷ giá vàng</a></li>
                                </ul>
                            </li>
                            <li class="has-submenu parent-menu-item">
                                <a href="javascript:void(0)" class="menu-item"> Biểu phí biểu mẫu </a><span
                                    class="submenu-arrow"></span>
                                <ul class="submenu">
                                    <li><a href="blogs.html" class="sub-menu-item">Biểu phí và biểu mẫu</a></li>
                                    <li><a href="blog-detail.html" class="sub-menu-item">Biểu lãi suất</a></li>
                                </ul>
                            </li>
                            <li><a href="departments.html" class="sub-menu-item">Hỗ trợ</a></li>
                            <li><a href="faqs.html" class="sub-menu-item">Liên hệ</a></li>
                        </ul>
                    </li>
                    <!--                    <li><a href="../admin/index.html" class="sub-menu-item" target="_blank">Admin</a></li>-->
                </ul><!--end navigation menu-->
            </div><!--end navigation-->
        </div><!--end container-->
    </header>
</html>
