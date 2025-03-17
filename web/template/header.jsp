<%-- 
    Document   : header
    Created on : Feb 3, 2025, 6:51:37 PM
    Author     : LAPTOP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>SmartBanking</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
    <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
    <meta name="author" content="Shreethemes" />
    <meta name="email" content="support@shreethemes.in" />
    <meta name="website" content="../../../index.html" />
    <meta name="Version" content="v1.2.0" />
    <!-- favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
    <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Icons -->
    <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <!-- SLIDER -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/tiny-slider.css" />
    <!-- Css -->
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/script/animate.min.css">

    <style>
        .chat-icon {
            position: fixed;
            bottom: 40px;
            right: 5px;
            background: transparent;
            padding: 0;
            border-radius: 50%;
            cursor: pointer;
            border: none;
        }

        .chat-container {
            display: none;
            position: fixed;
            bottom: 80px;
            right: 20px;
            width: 300px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            overflow: hidden;
        }

        .chat-header {
            background: #dc3545;
            color: white;
            padding: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 16px;
            position: relative;
            font-weight: bold;
        }

        .close-btn {
            background: none;
            border: none;
            cursor: pointer;
            padding: 0;
        }

        .close-btn img {
            width: 10px;
            height: 20px;
            width: 1.5rem;
            height: 1.5rem;
        }

        .chat-box {
            height: 250px;
            overflow-y: auto;
            padding: 10px;
            background: #f9f9f9;
        }

        .chat-box p {
            padding: 8px;
            border-radius: 5px;
            margin: 5px 0;
        }

        .user-message {
            background: #dc3545;
            color: white;
            text-align: left;
        }

        .ai-message {
            background: #e9ecef;
            text-align: left;
        }

        .chat-input {
            display: flex;
            padding: 10px;
            border-top: 1px solid #ddd;
        }

        .chat-input input {
            flex: 1;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .chat-input button {
            background: #dc3545;
            color: white;
            border: none;
            padding: 8px 15px;
            margin-left: 5px;
            cursor: pointer;
            border-radius: 5px;
        }
    </style>
</head>
<body>
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
    <header id="topnav" class="navigation sticky">
        <div class="container">
            <!-- Logo container-->
            <div>
                <a class="logo" href="${pageContext.request.contextPath}/index.html">
                    <span class="logo-light-mode">
                        <img src="${pageContext.request.contextPath}/assets/images/logo-dark.png" class="l-dark" height="24" alt="">
                        <img src="${pageContext.request.contextPath}/assets/images/logo-light.png" class="l-light" height="24" alt="">
                    </span>
                    <img src="${pageContext.request.contextPath}/assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
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
                    <a href="javascript:void(0)" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
                        <div class="btn btn-icon btn-pills btn-primary"><i data-feather="settings" class="fea icon-sm"></i></div>
                    </a>
                </li>
                <c:if test="${sessionScope.account == null && sessionScope.staff == null}">
                    <li class="list-inline-item mb-0 ms-1">
                        <a href="${pageContext.request.contextPath}/auth/template/login.jsp" class="btn btn-pills btn-soft-primary">
                            <i class="uil uil-sign-in-alt align-middle h6 me-1"></i> Đăng nhập
                        </a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.account != null}">
                    <li class="list-inline-item mb-0 ms-1">
                        <div class="dropdown dropdown-primary">
                            <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <img src="${account.image}" class="avatar avatar-ex-small rounded-circle" alt="">
                            </button>
                            <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                <a class="dropdown-item d-flex align-items-center text-dark" href="">
                                    <img src="${pageContext.request.contextPath}/assets/images/doctors/01.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                    <div class="flex-1 ms-2">
                                        <span class="d-block mb-1">${sessionScope.account.username}</span>
                                    </div>
                                </a>
                                <a class="dropdown-item text-dark" href="doctor-dashboard.html"><span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Dashboard</a>
                                <a class="dropdown-item text-dark" href="doctor-profile-setting.html"><span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                <div class="dropdown-divider border-top"></div>
                                <a class="dropdown-item text-dark" href="${pageContext.request.contextPath}/login.jsp"><span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Logout</a>
                            </div>
                        </div>
                    </li>
                </c:if>
                <c:if test="${sessionScope.staff != null}">
                    <li class="list-inline-item mb-0 ms-1">
                        <div class="dropdown dropdown-primary">
                            <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <img src="${pageContext.request.contextPath}/assets/images/doctors/01.jpg" class="avatar avatar-ex-small rounded-circle" alt="">
                            </button>
                            <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                <a class="dropdown-item d-flex align-items-center text-dark" href="">
                                    <img src="${pageContext.request.contextPath}/assets/images/doctors/01.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                    <div class="flex-1 ms-2">
                                        <span class="d-block mb-1">${sessionScope.staff.username}</span>
                                    </div>
                                </a>
                                <a class="dropdown-item text-dark" href="doctor-dashboard.html"><span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Dashboard</a>
                                <c:if test="${sessionScope.staff.roleId.id == 1}">
                                    <a class="dropdown-item text-dark" href="doctor-profile-setting.html"><span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                </c:if>
                                <c:if test="${sessionScope.staff.roleId.id == 2}">
                                    <a class="dropdown-item text-dark" href="./consultant-customer"><span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                </c:if>
                                <c:if test="${sessionScope.staff.roleId.id == 3}">
                                    <a class="dropdown-item text-dark" href="./profile-manager"><span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                </c:if>
                                <c:if test="${sessionScope.staff.roleId.id == 4}">
                                    <a class="dropdown-item text-dark" href="./Admin.jsp"><span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                </c:if>
                                <div class="dropdown-divider border-top"></div>
                                <a class="dropdown-item text-dark" href="${pageContext.request.contextPath}/AuthServlet?action=logout"><span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Logout</a>
                            </div>
                        </div>
                    </li>
                </c:if>
            </ul>
            <!-- End Dropdown -->

            <div id="navigation">
                <!-- Navigation Menu-->
                <ul class="navigation-menu nav-left nav-light">
                    <li class="has-submenu parent-menu-item">
                        <a href="javascript:void(0)">Tiết kiệm</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <li class="has-submenu parent-menu-item">
                                <a href="javascript:void(0)" class="menu-item">Gửi tiết kiệm</a><span class="submenu-arrow"></span>
                                <ul class="submenu">
                                    <li><a href="${pageContext.request.contextPath}/public/SaveInterestTool.jsp" class="sub-menu-item">Gửi tiết kiệm có kì hạn</a></li>
                                </ul>
                            </li>
                            <li><a href="index-three.html" class="sub-menu-item">Chứng chỉ tiền gửi</a></li>
                        </ul>
                    </li>

                    <li class="has-submenu parent-parent-menu-item">
                        <a href="javascript:void(0)">Vay</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <li class="has-submenu parent-menu-item">
                                <a href="javascript:void(0)" class="menu-item"> Dashboard </a>
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
                        <a href="${pageContext.request.contextPath}/NewsServlet">Thông tin mới</a><span class="menu-arrow"></span>
                                            </li>

                    <li class="has-submenu parent-parent-menu-item">
                        <a href="${pageContext.request.contextPath}/public/News.jsp">Các công cụ và tiện ích</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <li class="has-submenu parent-menu-item">
                                <a href="javascript:void(0)" class="menu-item"> Các loại bảng tính </a><span class="submenu-arrow"></span>
                                <ul class="submenu">
                                    <li><a href="${pageContext.request.contextPath}/public/SaveInterestTool.jsp" class="sub-menu-item">Bảng tính lãi suất vay</a></li>
                                    <li><a href="${pageContext.request.contextPath}/public/InsuranceBenefitsTool.jsp" class="sub-menu-item">Bảng tính quyền lợi bảo hiểm</a></li>
                                    <li><a href="${pageContext.request.contextPath}/public/SaveInterestTool.jsp" class="sub-menu-item">Bảng tính lãi suất tiết kiệm</a></li>
                                </ul>
                            </li>
                            <li class="has-submenu parent-menu-item">
                                <a href="javascript:void(0)" class="menu-item"> Tỉ giá </a><span class="submenu-arrow"></span>
                                <ul class="submenu">
                                    <li><a href="blog-detail.html" class="sub-menu-item">Tỷ giá hối đoái</a></li>
                                    <li><a href="blog-detail.html" class="sub-menu-item">Quy đổi tiền tệ</a></li>
                                    <li><a href="blog-detail.html" class="sub-menu-item">Tỷ giá chốt</a></li>
                                    <li><a href="blog-detail.html" class="sub-menu-item">Tỷ giá vàng</a></li>
                                </ul>
                            </li>
                            <li class="has-submenu parent-menu-item">
                                <a href="javascript:void(0)" class="menu-item"> Biểu phí biểu mẫu </a><span class="submenu-arrow"></span>
                                <ul class="submenu">
                                    <li><a href="blogs.html" class="sub-menu-item">Biểu phí và biểu mẫu</a></li>
                                    <li><a href="blog-detail.html" class="sub-menu-item">Biểu lãi suất</a></li>
                                </ul>
                            </li>
                            <li><a href="departments.html" class="sub-menu-item">Hỗ trợ</a></li>
                            <li><a href="faqs.html" class="sub-menu-item">Liên hệ</a></li>
                        </ul>
                    </li>
                </ul><!--end navigation menu-->
            </div><!--end navigation-->
        </div><!--end container-->
    </header><!--end header-->
</body>