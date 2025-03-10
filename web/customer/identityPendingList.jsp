<%@ page import="model.Customer" %>
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <link rel="stylesheet" href="https://unpkg.com/tippy.js@6/dist/tippy.css">
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
        <style>
            .photo-div {
                width: 100%;
                height: auto;
                overflow: hidden;
            }
            .photo-div img {
                width: 100%;
                height: auto;
                display: block;
            </style>

            <main>
                <!-- Start -->
                <section class="bg-dashboard">
                    <div class="container mt-5">
                        <c:set value="${sessionScope.account}" var="customer"/>
                        <c:set value="${sessionScope.identityList}" var="iden"/>
                        <div class="card p-5 shadow-sm">
                            <div class="row">
                                <h3 class="text-center mb-4">Xác thực danh tính</h3>                                
                            </div>                            
                            <div class="table-responsive">
                                <table class="table table-bordered">
                                    <thead class="table-bordered text-center">
                                        <tr>
                                            <th>Số CMND</th>
                                            <th>Mặt trước CCCD</th>
                                            <th>Mặt sau CCCD</th>
                                            <th>Ảnh chân dung</th>
                                            <th>Trạng thái</th>
                                            <th>Khác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="identity" items="${identityList}">
                                            <tr style="text-align: center;
                                                align-items: center">
                                                    <td style="max-width: 100px;">${identity.identityCardNumber}</td>
                                                <td style="max-width: 100px;">
                                                    <div class="photo-div">
                                                        <img src="${identity.identityCardFrontSide}" class="photo">
                                                    </div>
                                                </td>
                                                <td style="max-width: 100px;">
                                                    <div class="photo-div">
                                                        <img src="${identity.identityCardBackSide}" class="photo">
                                                    </div>
                                                </td>
                                                <td style="max-width: 100px;">
                                                    <div class="photo-div">
                                                        <img src="${identity.portraitPhoto}" class="photo">
                                                    </div>                                            
                                                </td>
                                                <td style="max-width: 100px;">
                                                    ${identity.pendingStatus}
                                                </td>
                                                <td style="max-width: 100px;">
                                                    <c:if test="${identity.pendingStatus == 'Denied'}">
                                                        <button type="button" class="btn btn-info ms-2" data-bs-toggle="modal" 
                                                                data-bs-target="#detailsModal${identity.id}">
                                                            <i class="fas fa-eye"></i>
                                                        </button>
                                                    </c:if>                                                    
                                                </td>
                                            </tr>
                                        <div class="modal fade" id="detailsModal${identity.id}" tabindex="-1">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title text-danger">Lí do từ chối</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <p class="text-center">${identity.reasonReject}</p>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn-primary" data-bs-dismiss="modal">Đóng</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <form action="identity-information-controller" method="post">
                                <input name="create" type="hidden" value="create"/>
                                <button type="submit" class="btn text-white bg-danger">Tạo duyệt mới</button>
                            </form>
                        </div>
                    </div>



                </section><!--end section-->                
            </main>            
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

        </body>

    </html>