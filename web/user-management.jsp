<!DOCTYPE html>
<html lang="en">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <link rel="shortcut icon" href="<%= request.getContextPath() %>/assets/images/favicon.ico.png">
    <!-- Bootstrap -->
    <link href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- simplebar -->
    <link href="<%= request.getContextPath() %>/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
    <!-- Select2 -->
    <link href="<%= request.getContextPath() %>/assets/css/select2.min.css" rel="stylesheet" />
    <!-- Date picker -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/flatpickr.min.css">
    <link href="<%= request.getContextPath() %>/assets/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css" />
    <!-- Icons -->
    <link href="<%= request.getContextPath() %>/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="<%= request.getContextPath() %>/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <!-- Css -->
    <link href="<%= request.getContextPath() %>/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

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

    <div class="page-wrapper doctris-theme toggled">
        <nav id="sidebar" class="sidebar-wrapper">
            <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
                <div class="sidebar-brand">
                    <a href="index.html">
                        <img src="<%= request.getContextPath() %>/assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                        <img src="<%= request.getContextPath() %>/assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                    </a>
                </div>

                <ul class="sidebar-menu pt-3">
                    <li><a href="index.html"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li>
                    <li><a href="user-management.jsp"><i
                                class="uil uil-stethoscope me-2 d-inline-block"></i>Account Management</a></li>

                    <li class="sidebar-dropdown">
                        <a href="javascript:void(0)"><i class="uil uil-user me-2 d-inline-block"></i>Doctors</a>
                        <div class="sidebar-submenu">
                            <ul>
                                <li><a href="doctors.html">Doctors</a></li>
                                <li><a href="add-doctor.html">Add Doctor</a></li>
                                <li><a href="dr-profile.html">Profile</a></li>
                            </ul>
                        </div>
                    </li>

                    <li class="sidebar-dropdown">
                        <a href="javascript:void(0)"><i class="uil uil-wheelchair me-2 d-inline-block"></i>Patients</a>
                        <div class="sidebar-submenu">
                            <ul>
                                <li><a href="patients.html">All Patients</a></li>
                                <li><a href="add-patient.html">Add Patients</a></li>
                                <li><a href="patient-profile.html">Profile</a></li>
                            </ul>
                        </div>
                    </li>

                    <li class="sidebar-dropdown">
                        <a href="javascript:void(0)"><i class="uil uil-apps me-2 d-inline-block"></i>Apps</a>
                        <div class="sidebar-submenu">
                            <ul>
                                <li><a href="chat.html">Chat</a></li>
                                <li><a href="email.html">Email</a></li>
                                <li><a href="calendar.html">Calendar</a></li>
                            </ul>
                        </div>
                    </li>

                    <li class="sidebar-dropdown">
                        <a href="javascript:void(0)"><i
                                class="uil uil-shopping-cart me-2 d-inline-block"></i>Pharmacy</a>
                        <div class="sidebar-submenu">
                            <ul>
                                <li><a href="shop.html">Shop</a></li>
                                <li><a href="product-detail.html">Shop Detail</a></li>
                                <li><a href="shopcart.html">Shopcart</a></li>
                                <li><a href="checkout.html">Checkout</a></li>
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

                    <li class="sidebar-dropdown">
                        <a href="javascript:void(0)"><i class="uil uil-file me-2 d-inline-block"></i>Pages</a>
                        <div class="sidebar-submenu">
                            <ul>
                                <li><a href="faqs.html">FAQs</a></li>
                                <li><a href="review.html">Reviews</a></li>
                                <li><a href="invoice-list.html">Invoice List</a></li>
                                <li><a href="invoice.html">Invoice</a></li>
                                <li><a href="terms.html">Terms & Policy</a></li>
                                <li><a href="privacy.html">Privacy Policy</a></li>
                                <li><a href="error.html">404 !</a></li>
                                <li><a href="blank-page.html">Blank Page</a></li>
                            </ul>
                        </div>
                    </li>

                    <li class="sidebar-dropdown">
                        <a href="javascript:void(0)"><i
                                class="uil uil-sign-in-alt me-2 d-inline-block"></i>Authentication</a>
                        <div class="sidebar-submenu">
                            <ul>
                                <li><a href="login.html">Login</a></li>
                                <li><a href="signup.html">Signup</a></li>
                                <li><a href="forgot-password.html">Forgot Password</a></li>
                                <li><a href="lock-screen.html">Lock Screen</a></li>
                                <li><a href="thankyou.html">Thank you...!</a></li>
                            </ul>
                        </div>
                    </li>

                    <li><a href="components.html"><i class="uil uil-cube me-2 d-inline-block"></i>Components</a></li>

                    <li><a href="../landing/index-two.html" target="_blank"><i
                                class="uil uil-window me-2 d-inline-block"></i>Landing page</a></li>
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
                        <div class="search-bar p-0 d-none d-lg-block ms-2">
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
                                <button type="button"
                                    class="btn btn-icon btn-pills btn-soft-primary dropdown-toggle p-0"
                                    data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i
                                        data-feather="mail" class="fea icon-sm"></i></button>
                                <span
                                    class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">4
                                    <span class="visually-hidden">unread mail</span></span>

                                <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow rounded border-0 mt-3 px-2 py-2"
                                    data-simplebar style="height: 320px; width: 300px;">
                                    <a href="#" class="d-flex align-items-center justify-content-between py-2">
                                        <div class="d-inline-flex position-relative overflow-hidden">
                                            <img src="<%= request.getContextPath() %>/assets/images/client/02.jpg"
                                                class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                            <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new
                                                email from <b>Janalia</b> <small
                                                    class="text-muted fw-normal d-inline-block">1 hour
                                                    ago</small></small>
                                        </div>
                                    </a>

                                    <a href="#"
                                        class="d-flex align-items-center justify-content-between py-2 border-top">
                                        <div class="d-inline-flex position-relative overflow-hidden">
                                            <img src="<%= request.getContextPath() %>/assets/images/client/Codepen.svg"
                                                class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                            <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new
                                                email from <b>codepen</b> <small
                                                    class="text-muted fw-normal d-inline-block">4 hour
                                                    ago</small></small>
                                        </div>
                                    </a>

                                    <a href="#"
                                        class="d-flex align-items-center justify-content-between py-2 border-top">
                                        <div class="d-inline-flex position-relative overflow-hidden">
                                            <img src="<%= request.getContextPath() %>/assets/images/client/03.jpg"
                                                class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                            <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new
                                                email from <b>Cristina</b> <small
                                                    class="text-muted fw-normal d-inline-block">5 hour
                                                    ago</small></small>
                                        </div>
                                    </a>

                                    <a href="#"
                                        class="d-flex align-items-center justify-content-between py-2 border-top">
                                        <div class="d-inline-flex position-relative overflow-hidden">
                                            <img src="<%= request.getContextPath() %>/assets/images/client/dribbble.svg"
                                                class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                            <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new
                                                email from <b>Dribbble</b> <small
                                                    class="text-muted fw-normal d-inline-block">24 hour
                                                    ago</small></small>
                                        </div>
                                    </a>

                                    <a href="#"
                                        class="d-flex align-items-center justify-content-between py-2 border-top">
                                        <div class="d-inline-flex position-relative overflow-hidden">
                                            <img src="<%= request.getContextPath() %>/assets/images/client/06.jpg"
                                                class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                            <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new
                                                email from <b>Donald Aghori</b> <small
                                                    class="text-muted fw-normal d-inline-block">1 day
                                                    ago</small></small>
                                        </div>
                                    </a>

                                    <a href="#"
                                        class="d-flex align-items-center justify-content-between py-2 border-top">
                                        <div class="d-inline-flex position-relative overflow-hidden">
                                            <img src="<%= request.getContextPath() %>/assets/images/client/07.jpg"
                                                class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                            <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new
                                                email from <b>Calvin</b> <small
                                                    class="text-muted fw-normal d-inline-block">2 day
                                                    ago</small></small>
                                        </div>
                                    </a>
                                </div>
                            </div>
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
                                            <span class="d-block mb-1">Calvin Carlo</span>
                                            <small class="text-muted">Orthopedic</small>
                                        </div>
                                    </a>
                                    <a class="dropdown-item text-dark" href="index.html"><span
                                            class="mb-0 d-inline-block me-1"><i
                                                class="uil uil-dashboard align-middle h6"></i></span> Dashboard</a>
                                    <a class="dropdown-item text-dark" href="dr-profile.html"><span
                                            class="mb-0 d-inline-block me-1"><i
                                                class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                    <div class="dropdown-divider border-top"></div>
                                    <a class="dropdown-item text-dark" href="lock-screen.html"><span
                                            class="mb-0 d-inline-block me-1"><i
                                                class="uil uil-sign-out-alt align-middle h6"></i></span> Logout</a>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="container-fluid">
                <div class="layout-specing">
                    <div class="row">
                        <div class="col-xl-9 col-lg-6 col-md-4">
                            <h5 class="mb-0">Appointment</h5>
                            <nav aria-label="breadcrumb" class="d-inline-block mt-2">
                                <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="index.html">Doctris</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Appointment</li>
                                </ul>
                            </nav>
                        </div><!--end col-->

                        <div class="col-xl-3 col-lg-6 col-md-8 mt-4 mt-md-0">
                            <div class="justify-content-md-end">
                                <form>
                                    <div class="row justify-content-between align-items-center">
                                        <div class="col-sm-12 col-md-5">
                                            <div class="mb-0 position-relative">
                                                <select class="form-control time-during select2input">
                                                    <option value="EY">Today</option>
                                                    <option value="GY">Tomorrow</option>
                                                    <option value="PS">Yesterday</option>
                                                </select>
                                            </div>
                                        </div><!--end col-->

                                        <div class="col-sm-12 col-md-7 mt-4 mt-sm-0">
                                            <div class="d-grid">
                                                <a href="#" class="btn btn-primary" data-bs-toggle="modal"
                                                    data-bs-target="#appointmentform">Appointment</a>
                                            </div>
                                        </div><!--end col-->
                                    </div><!--end row-->
                                </form><!--end form-->
                            </div>
                        </div><!--end col-->
                    </div><!--end row-->

                   <div class="row">
    <div class="col-12 mt-4">

<form action="<%= request.getContextPath() %>/userManager" method="get">
            <div class="table-responsive bg-white shadow rounded">
                <table class="table table-bordered table-hover">
                    <thead class="thead-dark">
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Gender</th>
                            <th>Phone</th>
                            <th>Address</th>
                            <th>Role</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                
                        <c:if test="${empty accounts}">
                            <tr>
                                <td colspan="8" class="text-center">No users available.</td>
                            </tr>
                        </c:if>

                       
                        <c:forEach var="account" items="${accounts}">
                            <tr>
                                <td>${account.id}</td>
                                <td>${account.fullName}</td>
                                <td>${account.email}</td>
                                <td>${account.gender}</td>
                                <td>${account.phoneNumber}</td>
                                <td>${account.address}</td>
                                <td>${account.role != null ? account.role.roleName : 'No Role'}</td>
                                <td>
                                    <button type="button" class="btn btn-warning btn-sm">Edit</button>
                                    <button type="button" class="btn btn-danger btn-sm">Delete</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </form>
</div>
</div>

                    <div class="row text-center">
                        <!-- PAGINATION START -->
                        <div class="col-12 mt-4">
                            <div class="d-md-flex align-items-center text-center justify-content-between">
                                <span class="text-muted me-3">Showing 1 - 10 out of 50</span>
                                <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                    <li class="page-item"><a class="page-link" href="javascript:void(0)"
                                            aria-label="Previous">Prev</a></li>
                                    <li class="page-item active"><a class="page-link" href="javascript:void(0)">1</a>
                                    </li>
                                    <li class="page-item"><a class="page-link" href="javascript:void(0)">2</a></li>
                                    <li class="page-item"><a class="page-link" href="javascript:void(0)">3</a></li>
                                    <li class="page-item"><a class="page-link" href="javascript:void(0)"
                                            aria-label="Next">Next</a></li>
                                </ul>
                            </div>
                        </div><!--end col-->
                        <!-- PAGINATION END -->
                    </div><!--end row-->
                </div>
            </div><!--end container-->

            <!-- Footer Start -->
            <footer class="bg-white shadow py-3">
                <div class="container-fluid">
                    <div class="row align-items-center">
                        <div class="col">
                            <div class="text-sm-start text-center">
                                <p class="mb-0 text-muted">
                                    <script>document.write(new Date().getFullYear())</script> © Doctris. Design with <i
                                        class="mdi mdi-heart text-danger"></i> by <a href="../../../index.html"
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
    <!-- page-wrapper -->

    <!-- Offcanvas Start -->
  
    <!-- javascript -->
    <script src="<%= request.getContextPath() %>/assets/js/jquery.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/bootstrap.bundle.min.js"></script>
    <!-- simplebar -->
    <script src="<%= request.getContextPath() %>/assets/js/simplebar.min.js"></script>
    <!-- Select2 -->
    <script src="<%= request.getContextPath() %>/assets/js/select2.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/select2.init.js"></script>
    <!-- Datepicker -->
    <script src="<%= request.getContextPath() %>/assets/js/flatpickr.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/flatpickr.init.js"></script>
    <!-- Datepicker -->
    <script src="<%= request.getContextPath() %>/assets/js/jquery.timepicker.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/timepicker.init.js"></script>
    <!-- Icons -->
    <script src="<%= request.getContextPath() %>/assets/js/feather.min.js"></script>
    <!-- Main Js -->
    <script src="<%= request.getContextPath() %>/assets/js/app.js"></script>

</body>

</html>