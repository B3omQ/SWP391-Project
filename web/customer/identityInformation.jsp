<%@ page import="model.Customer" %>
<%@ page import="model.VerifyIdentityInformation" %>
<%@ page import="dal.IdentityDAO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Doctris - Doctor Appointment Booking System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
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
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="<%= request.getContextPath() %>/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    </head>
    <%
   // Ki?m tra session
   if (session.getAttribute("account") == null) {
       response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
       return; 
   }

   Customer account = (Customer) session.getAttribute("account");
   String imagePath;

   if (account != null && account.getImage() != null && !account.getImage().isEmpty()) {
       imagePath = request.getContextPath() + "/uploads/" + account.getImage();
   } else {
       imagePath = request.getContextPath() + "/assets/images/default-avatar.jpg";
   }

    %>

    <body>


        <!-- Navbar STart -->
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
                            <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img src="<%= imagePath %>" class="avatar avatar-ex-small rounded-circle" alt=""></button>
                            <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                <a class="dropdown-item d-flex align-items-center text-dark" href="doctor-profile.html">
                                    <img src="<%= imagePath %>" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                    <div class="flex-1 ms-2">
                                        <span class="d-block mb-1">
                                            ${account.firstname} ${account.lastname}
                                        </span>

                                        <small class="text-muted">Customer</small>
                                    </div>
                                </a>
                                <a class="dropdown-item text-dark" href="Customer.jsp"><span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Dashboard</a>
                                <a class="dropdown-item text-dark" href="account-profile.jsp"><span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                <div class="dropdown-divider border-top"></div>
                                <a class="dropdown-item text-dark" href="<%= request.getContextPath() %>/AuthServlet?action=logout">
                                    <span class="mb-0 d-inline-block me-1">
                                        <i class="uil uil-sign-out-alt align-middle h6"></i>
                                    </span> 
                                    Logout
                                </a>                            </div>
                        </div>
                    </li>
                </ul>
                <!-- Start Dropdown -->

                <div id="navigation">
                    <!-- Navigation Menu-->   
                    <ul class="navigation-menu nav-left">
                        <li class="has-submenu parent-menu-item">
                            <a href="javascript:void(0)">Home</a><span class="menu-arrow"></span>
                            <ul class="submenu">
                                <li><a href="index.jsp" class="sub-menu-item">Index One</a></li>
                                <li><a href="index-two.html" class="sub-menu-item">Index Two</a></li>
                                <li><a href="index-three.html" class="sub-menu-item">Index Three</a></li>
                            </ul>
                        </li>
                    </ul><!--end navigation menu-->
                </div><!--end navigation-->
            </div><!--end container-->
        </header><!--end header-->
        <!-- Navbar End -->

        <!-- Start -->
        <section class="bg-dashboard">



            <div class="container-fluid">
                <div class="layout-specing">

                    <div class="container">
                        <c:set value="${sessionScope.account}" var="customer"/> 

                        <c:if test="${sessionScope.status == 'approved'}">
                            <script>
                                sessionStorage.setItem("status", "approved");
                            </script>
                        </c:if> 

                        <c:if test="${sessionScope.status == 'none'}">
                            <div class="col-md-6">
                                <label for="identityCardNumber" class="form-label">Tạo đơn xác thực danh tính</label>   
                                <div class="col-md-4 text-center">
                                    <a href="identity-information-controller" class="btn btn-primary">Tạo mới duyệt</a>
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${sessionScope.status == 'pending'}">
                            <script>
                                sessionStorage.setItem("status", "pending");
                            </script>
                            <div class="col-md-12 text-center">
                                <h3>Đơn của bạn đang được kiểm duyệt</h3>                    
                            </div>
                        </c:if>

                        <c:if test="${sessionScope.status == 'denied'}">
                            <script>
                                sessionStorage.setItem("status", "denied");
                            </script>

                            <c:set value="${sessionScope.reasonRejectIdentity}" var="reasonReject"/>  
                            <div class="row">
                                <h3>Đơn của bạn đã bị từ chối</h3>

                                <div class="col-md-2 text-center">
                                    <a href="identity-information-controller" class="btn btn-primary">Tạo mới duyệt</a>
                                </div>
                                <div class="col-md-2 text-center">                                                            
                                    <div class="col-auto">
                                        <button data-bs-toggle="modal" data-bs-target="#editModal" class="btn btn-primary btn-md">Nguyên nhân</button>
                                    </div>
                                </div>
                            </div>
                            <jsp:include page="template/viewReasonReject.jsp">
                                <jsp:param name="id" value="${reasonReject.id}"/>
                                <jsp:param name="identityCardFrontSide" value="${reasonReject.identityCardFrontSide}"/>
                                <jsp:param name="identityCardBackSide" value="${reasonReject.identityCardBackSide}" />
                                <jsp:param name="identityCardNumber" value="${reasonReject.identityCardNumber}" />
                                <jsp:param name="portraitPhoto" value="${reasonReject.portraitPhoto}" />
                                <jsp:param name="fullnameCustomer" value="${reasonReject.cusId.fullname}" />
                                <jsp:param name="pendingStatus" value="${reasonReject.pendingStatus}" />
                                <jsp:param name="reasonReject" value="${reasonReject.reasonReject}" />
                            </jsp:include>
                        </c:if>  



                    </div>
                </div>
            </div>


        </section><!--end section-->
        <!-- End -->

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
        <script src ="resources/script/jquery-3.7.1.min.js"></script>
        <script src="./resources/script/script.js"></script>
        <!-- javascript -->
        <script src="<%= request.getContextPath() %>/assets/js/bootstrap.bundle.min.js"></script>
        <!-- Icons -->
        <script src="<%= request.getContextPath() %>/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="<%= request.getContextPath() %>/assets/js/app.js"></script>
        <script>
                                function previewImage(event, previewId) {
                                    const input = event.target;
                                    const preview = document.getElementById(previewId);

                                    if (input.files && input.files[0]) {
                                        const reader = new FileReader();
                                        reader.onload = function (e) {
                                            preview.src = e.target.result;
                                            preview.style.display = 'block';
                                        };
                                        reader.readAsDataURL(input.files[0]);
                                    } else {
                                        preview.src = '#';
                                        preview.style.display = 'none';
                                    }
                                }


                                if (sessionStorage.getItem("status") === "approved") {
                                    Swal.fire({
                                        title: "Thành công!",
                                        text: "Tài khoản của bạn đã được xác minh",
                                        icon: "success"
                                    }).then((result) => {
                                        if (result.isConfirmed) {
                                            sessionStorage.removeItem("status");
                                            window.location.href = "customer/account-profile.jsp";
                                        }
                                    });
                                }

                                if (sessionStorage.getItem("status") === "pending") {
                                    Swal.fire({
                                        title: "Gửi thành công!",
                                        text: "Đang chờ phê duyệt",
                                        icon: "success"
                                    }).then((result) => {
                                        if (result.isConfirmed) {
                                            sessionStorage.removeItem("status");
                                            window.location.href = "customer/account-profile.jsp";
                                        }
                                    });
                                }


                                if (sessionStorage.getItem("status") === "denied") {
                                    Swal.fire({
                                        icon: "error",
                                        title: "Thất bại!",
                                        text: "Yêu cầu của bạn đã bị từ chối",
                                        footer: '<a href="identity-information-controller">Tạo phê duyệt mới?</a>'
                                    }).then((result) => {
                                        if (result.isConfirmed) {
                                            sessionStorage.removeItem("status");
                                            window.location.href = "customer/account-profile.jsp";
                                        }
                                    });
                                }



        </script>
    </body>

</html>