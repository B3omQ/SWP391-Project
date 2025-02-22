 <%@ page contentType="text/html; charset=UTF-8" language="java" %>
 <%@ page import="model.Customer" %>

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
    <meta name="website" content="../../../index.jsp" />
    <meta name="Version" content="v1.2.0" />
    <!-- favicon -->
    <link rel="shortcut icon" href="<%= request.getContextPath() %>/assets/images/favicon.ico.png">
    <!-- Bootstrap -->
    <link href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- simplebar -->
    <link href="<%= request.getContextPath() %>/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
    <!-- Select2 -->
    <link href="<%= request.getContextPath() %>/assets/css/select2.min.css" rel="stylesheet" />
    <!-- Icons -->
            <link href="<%= request.getContextPath() %>/assets/css/deposit.css" rel="stylesheet" type="text/css" />

    <link href="<%= request.getContextPath() %>/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="<%= request.getContextPath() %>/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <!-- SLIDER -->
    <link href="<%= request.getContextPath() %>/assets/css/tiny-slider.css" rel="stylesheet" />
    <!-- Css -->
    <link href="<%= request.getContextPath() %>/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
    <link href="<%= request.getContextPath() %>/assets/css/deposit.css" rel="stylesheet" type="text/css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/js/all.min.js" crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

    <style>
        .btn-custom {
            border: 2px solid #d70000;
            color: #d70000;
            font-weight: bold;
        }
        .btn-custom:hover {
            background-color: #d70000;
            color: white;
        }
        .feature-box {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
        }
        .icon-large {
            font-size: 2rem;
            color: #d70000;
        }
    </style>
</head>

    <body>
          <%
       if (session.getAttribute("account") == null) {
           response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
           return; 
       }

       // Lấy thông tin người dùng từ session
       Customer account = (Customer) session.getAttribute("account");
       String imagePath;

       if (account != null && account.getImage() != null && !account.getImage().isEmpty()) {
           imagePath = request.getContextPath() + "/uploads/" + account.getImage();
       } else {
           imagePath = request.getContextPath() + "/assets/images/default-avatar.jpg"; // Ảnh mặc định
       }
        %>

    <div class="page-wrapper doctris-theme toggled">
        <nav id="sidebar" class="sidebar-wrapper">
            <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
                <div class="sidebar-brand">
                    <a href="Customer.jsp">
                        <!--<a href="index.jsp">-->
                        <img src="<%= request.getContextPath() %>/assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                        <img src="<%= request.getContextPath() %>/assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                    </a>
                </div>

                <ul class="sidebar-menu pt-3">
                    <li><a href="Customer.jsp"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li>      
                    <li>
    <a href="account-profile.jsp">
        <i class="uil uil-cog me-2 d-inline-block"></i>
        Account-Settings
    </a>
</li>

              <li class="sidebar-dropdown"> 
                            <a href="javascript:void(0)"><i class="uil uil-university me-2 d-inline-block"></i>Manage Account Bank</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="blogs.html">Trang chủ</a></li>
                                    <li><a href="deposit.jsp">Nạp tiền</a></li>
                                    <li><a href="Saving.jsp">Gửi tiết kiệm</a></li>
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
        <!-- sidebar-wrapper  -->

        <!-- Start Page Content -->
        <main class="page-content bg-light">
            <div class="top-header">
                <div class="header-bar d-flex justify-content-between border-bottom">
                    <div class="d-flex align-items-center">
                        <a href="#" class="logo-icon">
                            <img src="<%= request.getContextPath() %>/assets/images/logo-icon2.png" height="30" class="small" alt="">
                            <span class="big">
                                <img src="<%= request.getContextPath() %>/assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                                <img src="<%= request.getContextPath() %>/assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                            </span>
                        </a>
                        <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2" href="#">
                            <i class="uil uil-bars"></i>
                        </a>
                        <div class="search-bar p-0 d-none d-md-block ms-2">
                            <div id="search" class="menu-search mb-0">
                                <form role="search" method="get" id="searchform" class="searchform">
                                    <div>
                                        <input type="text" class="form-control border rounded-pill" name="s" id="s"
                                            placeholder="Search Keywords...">
                                        <input type="submit" id="searchsubmit" value="Search">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <ul class="list-unstyled mb-0">
                        <li class="list-inline-item mb-0">
                            <div class="dropdown dropdown-primary">
                                <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0"
                                    data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img
                                        src="<%= request.getContextPath() %>/assets/images/language/american.png"
                                        class="avatar avatar-ex-small rounded-circle p-2" alt=""></button>
                                <div class="dropdown-menu dd-menu drop-ups dropdown-menu-end bg-white shadow border-0 mt-3 p-2"
                                    data-simplebar style="height: 175px;">
                                    <a href="javascript:void(0)" class="d-flex align-items-center">
                                        <img src="<%= request.getContextPath() %>/assets/images/language/chinese.png"
                                            class="avatar avatar-client rounded-circle shadow" alt="">
                                        <div class="flex-1 text-left ms-2 overflow-hidden">
                                            <small class="text-dark mb-0">Chinese</small>
                                        </div>
                                    </a>

                                    <a href="javascript:void(0)" class="d-flex align-items-center mt-2">
                                        <img src="<%= request.getContextPath() %>/assets/images/language/european.png"
                                            class="avatar avatar-client rounded-circle shadow" alt="">
                                        <div class="flex-1 text-left ms-2 overflow-hidden">
                                            <small class="text-dark mb-0">European</small>
                                        </div>
                                    </a>

                                    <a href="javascript:void(0)" class="d-flex align-items-center mt-2">
                                        <img src="<%= request.getContextPath() %>/assets/images/language/indian.png"
                                            class="avatar avatar-client rounded-circle shadow" alt="">
                                        <div class="flex-1 text-left ms-2 overflow-hidden">
                                            <small class="text-dark mb-0">Indian</small>
                                        </div>
                                    </a>

                                    <a href="javascript:void(0)" class="d-flex align-items-center mt-2">
                                        <img src="<%= request.getContextPath() %>/assets/images/language/japanese.png"
                                            class="avatar avatar-client rounded-circle shadow" alt="">
                                        <div class="flex-1 text-left ms-2 overflow-hidden">
                                            <small class="text-dark mb-0">Japanese</small>
                                        </div>
                                    </a>

                                    <a href="javascript:void(0)" class="d-flex align-items-center mt-2">
                                        <img src="<%= request.getContextPath() %>/assets/images/language/russian.png"
                                            class="avatar avatar-client rounded-circle shadow" alt="">
                                        <div class="flex-1 text-left ms-2 overflow-hidden">
                                            <small class="text-dark mb-0">Russian</small>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </li>

                        <li class="list-inline-item mb-0 ms-1">
                            <a href="javascript:void(0)" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
                                aria-controls="offcanvasRight">
                                <div class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="settings"
                                        class="fea icon-sm"></i></div>
                            </a>
                        </li>


                        <li class="list-inline-item mb-0 ms-1">
                            <div class="dropdown dropdown-primary">
                                <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0"
                                    data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img
                                        src="<%= request.getContextPath() %>/assets/images/doctors/01.jpg"
                                        class="avatar avatar-ex-small rounded-circle" alt=""></button>
                                <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3"
                                    style="min-width: 200px;">
                                    <a class="dropdown-item d-flex align-items-center text-dark"
                                        href="https://shreethemes.in/doctris/layouts/admin/profile.html">
                                        <img src="<%= request.getContextPath() %>/assets/images/doctors/01.jpg"
                                            class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                        <div class="flex-1 ms-2">

<span class="d-block mb-1">
    ${account.firstname} ${account.lastname}
</span>
                                 <small class="text-muted">Khách Hàng</small>
                                        </div>
                                    </a>
                                    <a class="dropdown-item text-dark" href="Customer.jsp"><span
                                            class="mb-0 d-inline-block me-1"><i
                                                class="uil uil-dashboard align-middle h6"></i></span> Dashboard</a>
                                    <a class="dropdown-item text-dark" href="account-profile.jsp"><span
                                            class="mb-0 d-inline-block me-1"><i
                                                class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                    <div class="dropdown-divider border-top"></div>
                                    <a class="dropdown-item text-dark" href="<%= request.getContextPath() %>/AuthServlet?action=logout">
    <span class="mb-0 d-inline-block me-1">
        <i class="uil uil-sign-out-alt align-middle h6"></i>
    </span> 
    Logout
</a>
                                    
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>

     <div class="container-fluid">
    <div class="layout-specing">
         <div class="container mt-5">
        <div class="text-center">
            <h2><i class="fas fa-piggy-bank"></i> Tiền gửi có kỳ hạn</h2>
            <p>Giữ tiền an toàn, sinh lời hấp dẫn với lãi suất lên đến 5%/năm.</p>
        </div>
        <div class="row text-center mt-4">
            <div class="col-md-4">
                <div class="feature-box">
                    <i class="fas fa-shield-alt icon-large"></i>
                    <p>An toàn và bảo mật tuyệt đối</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-box">
                    <i class="fas fa-percentage icon-large"></i>
                    <p>Nhận lãi suất đến 5%/năm</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-box">
                    <i class="fas fa-wallet icon-large"></i>
                    <p>Rút tiền linh hoạt theo nhu cầu</p>
                </div>
            </div>
        </div>
        <div class="text-center mt-4">
            <button class="btn btn-dark px-4 py-2" onclick="startSaving()"><i class="fas fa-play"></i> Bắt đầu ngay</button>
        </div>
    </div>

    </div>
</div>

            <!-- Footer Start -->
            <footer class="bg-white shadow py-3">
                <div class="container-fluid">
                    <div class="row align-items-center">
                        <div class="col">
                            <div class="text-sm-start text-center">
                                <p class="mb-0 text-muted">
                                    <script>document.write(new Date().getFullYear())</script> © Doctris. Design with <i
                                        class="mdi mdi-heart text-danger"></i> by <a href="../../../Customer.jsp"
                                        target="_blank" class="text-reset">Shreethemes</a>.
                                </p>
                            </div>
                        </div><!--end col-->
                    </div><!--end row-->
                </div><!--end container-->
            </footer><!--end footer-->
            <!-- End -->
        </main>
        <!--End page-content" -->
    </div>
                        <script src="<%= request.getContextPath() %>/assets/js/bootstrap.bundle.min.js"></script>
    <!-- simplebar -->
    <script src="<%= request.getContextPath() %>/assets/js/simplebar.min.js"></script>
    <!-- Chart -->
    <script src="<%= request.getContextPath() %>/assets/js/apexcharts.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/columnchart.init.js"></script>
    <!-- Icons -->
    <script src="<%= request.getContextPath() %>/assets/js/feather.min.js"></script>
    <!-- Main Js -->
    <script src="<%= request.getContextPath() %>/assets/js/app.js"></script>
 <script>
        function startSaving() {
            window.location.href = 'savemoney.jsp';
        }
    </script>
    </body>
</html>
