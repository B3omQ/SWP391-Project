<!DOCTYPE html>
<html lang="en">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <head>
        <meta charset="utf-8" />
        <title>Doctris - Doctor Appointment Booking System</title>
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
                        <li><a href="<%= request.getContextPath() %>/staffManagement"><i
                                    class="uil uil-stethoscope me-2 d-inline-block"></i>Staff Management</a></li>
                        <li><a href="<%= request.getContextPath() %>/customerManagement"><i
                                    class="uil uil-stethoscope me-2 d-inline-block"></i>Customer Management</a></li>

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
                                <h5 class="mb-0">Banking System</h5>
                                <nav aria-label="breadcrumb" class="d-inline-block mt-2">
                                    <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item"><a href="index.html">Ceo</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Edit Staff Information</li>
                                    </ul>
                                </nav>
                            </div><!--end col-->

                           
                        </div><!--end row-->



                        <div class="row justify-content-center">
                            <div class="col-10 mt-4">
                                <div class="card login-page bg-white shadow mt-4 rounded border-0">
                                    <div class="card-body">
                                        <h4 class="text-center">Edit</h4>


                                        <c:if test="${not empty successMessage}">
                                            <div class="alert alert-success text-center">
                                                ${successMessage}
                                            </div>
                                        </c:if>

                                        <form action="<%= request.getContextPath() %>/editStaffInfo" method="post" enctype="multipart/form-data" class="login-form mt-4">
                                            <div class="row">

                                                <!-- ID -->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label>ID</label>
                                                        <input type="text" class="form-control" name="id" value="${staff.id}" readonly>
                                                        <c:if test="${not empty errorID}">
                                                            <span class="text-danger">${errorID}</span>
                                                        </c:if>
                                                    </div>
                                                </div>

                                                <!-- Image -->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label>Image</label>
                                                        <div>
                                                            <img src="<%= request.getContextPath() %>/${staff.image}" width="100" height="" alt=""/>
                                                        </div>
                                                        <div class="md-5" style="padding-top: 10px">
                                                            <input type="file" class="form-control-file" name="image" accept=".jpg,.png,.jpeg"> 
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Username -->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label>Username</label>
                                                        <input type="text" class="form-control" name="username" value="${staff.username}">
                                                        <c:if test="${not empty errorUsername}">
                                                            <span class="text-danger">${errorUsername}</span>
                                                        </c:if>
                                                    </div>
                                                </div>

                                                <!-- Email -->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label>Email</label>
                                                        <input type="email" class="form-control" name="email" value="${staff.email}">
                                                        <c:if test="${not empty errorEmail}">
                                                            <span class="text-danger">${errorEmail}</span>
                                                        </c:if>
                                                    </div>
                                                </div>

                                                <!-- First Name -->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label>First Name</label>
                                                        <input type="text" class="form-control" name="firstName" value="${staff.firstname}">
                                                        <c:if test="${not empty errorFirstName}">
                                                            <span class="text-danger">${errorFirstName}</span>
                                                        </c:if>
                                                    </div>
                                                </div>

                                                <!-- Last Name -->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label>Last Name</label>
                                                        <input type="text" class="form-control" name="lastName" value="${staff.lastname}">
                                                        <c:if test="${not empty errorLastName}">
                                                            <span class="text-danger">${errorLastName}</span>
                                                        </c:if>
                                                    </div>
                                                </div>

                                                <!-- Gender -->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label>Gender</label>
                                                        <select id="role" class="form-control" name="gender" required>
                                                            <option value="Male" <c:if test="${staff.gender == 'Male'}">selected</c:if>>Male</option>
                                                            <option value="Female" <c:if test="${staff.gender == 'Female'}">selected</c:if>>Female</option>
                                                            </select>
                                                        </div>
                                                    <c:if test="${not empty errorGender}">
                                                        <span class="text-danger">${errorGender}</span>
                                                    </c:if>
                                                </div>

                                                <!-- DoB -->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label for="dob">DoB:</label>
                                                        <input type="date" id="dob" name="dob" value="${staff.dob}" required />
                                                    </div>
                                                    <c:if test="${not empty errorDob}">
                                                        <span class="text-danger">${errorDob}</span>
                                                    </c:if>
                                                </div>

                                                <!-- Phone Number -->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label>Phone Number</label>
                                                        <input type="text" class="form-control" name="phone" value="${staff.phone}">
                                                        <c:if test="${not empty errorPhone}">
                                                            <span class="text-danger">${errorPhone}</span>
                                                        </c:if>
                                                    </div>
                                                </div>

                                                <!-- Address -->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label>Address</label>
                                                        <input type="text" class="form-control" name="address" value="${staff.address}">
                                                        <c:if test="${not empty errorAddress}">
                                                            <span class="text-danger">${errorAddress}</span>
                                                        </c:if>
                                                    </div>
                                                </div>

                                                <!-- Salary -->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label>Salary</label>
                                                        <input type="number" step="0.01" class="form-control" name="salary" value="${staff.salary}" required>
                                                        <c:if test="${not empty errorSalary}">
                                                            <span class="text-danger">${errorSalary}</span>
                                                        </c:if>
                                                    </div>
                                                </div>

                                                <!-- Role -->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label>Role</label>
                                                        <select id="role" class="form-control" name="role" required>
                                                            <c:forEach var="r" items="${roles}">
                                                                <option value="${r.name}" <c:if test="${staff.roleId.id == r.id}">selected</c:if>>${r.name}</option>
                                                            </c:forEach> 
                                                        </select>
                                                    </div>
                                                </div>        

                                                <div class="row justify-content-center">
                                                    <div class="col-md-10 text-center">
                                                        <button type="submit" class="btn btn-primary">Confirm</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>           


                                    </div>
                                </div>
                            </div>
                        </div>

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