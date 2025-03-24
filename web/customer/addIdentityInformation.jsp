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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
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
            .preview-img {
                width: 150px;
                height: 150px;
                border: 1px solid #ddd;
                display: flex;
                align-items: center;
                justify-content: center;
                overflow: hidden;
                border-radius: 5px;
                position: relative;
                margin: 0 auto; /* Căn giữa theo chiều ngang */
            }


            .preview-img img {
                max-width: 100%;
                max-height: 100%;
                object-fit: cover;
                display: block;

            }


        </style>

        <!-- Start -->
        <section class="bg-dashboard">
            <div class="container-fluid">
                <div class="layout-specing">
                    <div class="container">
                        <div class="col-md-6">
                            <h5 class="mb-0">Trang thông tin định danh</h5>
                            <nav aria-label="breadcrumb" class="mt-2">
                                <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item">
                                        <a href="#" class="text-decoration-none text-danger">SmartBanking</a>
                                    </li>
                                    <li class="breadcrumb-item">
                                        <a href="#" class="text-decoration-none text-danger">Trang cá nhân</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">Xác thực tài khoản</li>
                                </ul>
                            </nav>
                        </div>
                        <br>

                        <c:set value="${sessionScope.account}" var="customer"/>    
                        <form action="identity-information-controller" method="POST" id="identityForm" enctype="multipart/form-data">
                            <input name="add" type="hidden" value="add" /> 
                            <input name="customerId" type="hidden" value="${customer.id}" />

                            <div class=" row d-flex flex-row">
                                <div class="col-lg-12">                                                                                    
                                    <div class="row ">                                        
                                        <div class="">
                                            <div class="mb-4 mt-3">
                                                <div class="col-md-6">
                                                    <label for="identityCardNumber" class="form-label">Mã số CCCD/CMND: </label>
                                                    <input type="text" id="identityCardNumber" required name="identityCardNumber" class="form-control mb-4" placeholder="Nhập số CCCD/CMND">
                                                </div>
                                            </div>

                                            <!-- Ảnh mặt trước -->
                                            <div class="mb-4 mt-3 d-flex">
                                                <div class="col-md-6">
                                                    <label for="identityCardFrontSide" class="form-label">Ảnh CCCD/CMND mặt trước: </label>
                                                    <label class="form-label text-muted">Ảnh có size nhỏ hơn 5MB, chỉ chấp nhận jpg, jpeg, png, gif. Chụp rõ ảnh, không làm mờ ảnh, không chấp nhận ảnh cũ</label>
                                                    <input type="file" id="identityCardFrontSide" required accept=".jpg,.png,.jpeg,.gif" name="identityCardFrontSide" class="form-control mb-4" onchange="previewImage(event, 'preview1')">
                                                </div>
                                                <!--                                                <div class="col-md-6 text-center">                                                    
                                                                                                    <label class="form-label">Xem trước ảnh</label>
                                                                                                    <div class="preview-img">
                                                                                                        <img id="preview1" src="#" alt="Image Preview" style="display:none;">
                                                                                                    </div>
                                                                                                </div>-->
                                            </div>

                                            <!-- Ảnh mặt sau -->
                                            <div class="mb-4 mt-3 d-flex">
                                                <div class="col-md-6">
                                                    <label for="identityCardBackSide" class="form-label">Ảnh CCCD/CMND mặt sau: </label>
                                                    <label class="form-label text-muted">Ảnh có size nhỏ hơn 5MB, chỉ chấp nhận jpg, jpeg, png, gif. Chụp rõ ảnh, không làm mờ ảnh, không chấp nhận ảnh cũ</label>
                                                    <input type="file" id="identityCardBackSide" required accept=".jpg,.png,.jpeg,.gif" name="identityCardBackSide" class="form-control mb-4" onchange="previewImage(event, 'preview2')">
                                                </div>
                                                <!--                                                <div class="col-md-6 text-center">                                                    
                                                                                                    <label class="form-label">Xem trước ảnh</label>
                                                                                                    <div class="preview-img">
                                                                                                        <img id="preview2" src="#" alt="Image Preview" style="display:none;">
                                                                                                    </div>
                                                                                                </div>-->
                                            </div>

                                            <!-- Ảnh chân dung -->
                                            <div class="mb-4 mt-3 d-flex">
                                                <div class="col-md-6">
                                                    <label for="portraitPhoto" class="form-label">Ảnh chân dung của bạn: </label>
                                                    <label class="form-label text-muted">Ảnh có size nhỏ hơn 5MB, chỉ chấp nhận jpg, jpeg, png, gif. Chụp rõ mặt, không đeo kính, không làm mờ ảnh</label>
                                                    <input type="file" id="portraitPhoto" required accept=".jpg,.png,.jpeg,.gif" name="portraitPhoto" class="form-control mb-4" onchange="previewImage(event, 'preview3')">
                                                </div>
                                                <!--                                                <div class="col-md-6 text-center">                                                    
                                                                                                    <label class="form-label">Xem trước ảnh</label>
                                                                                                    <div class="preview-img">
                                                                                                        <img id="preview3" src="#" alt="Image Preview" style="display:none;">
                                                                                                    </div>
                                                                                                </div>                                                        -->
                                            </div>

                                            <div class="row mt-5">
                                                <div class="col-md-6 text-center">
                                                    <p id="error-message-info" class="text-danger"></p>
                                                </div>
                                                <div class="col-md-6 text-center">
                                                    <button type="submit" class="btn btn-primary">Gửi phê duyệt</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>                                        
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
        <!-- End -->

        <!-- Footer Start -->
        <!--        <footer class="bg-footer py-4">
                    <div class="container-fluid">
                        <div class="row align-items-center">
                            <div class="col-sm-6">
                                <div class="text-sm-start text-center">
                                    <p class="mb-0"><script>document.write(new Date().getFullYear())</script> © Doctris. Design with <i class="mdi mdi-heart text-danger"></i> by <a href="../../../index.jsp" target="_blank" class="text-reset">Shreethemes</a>.</p>
                                </div>
                            </div>end col
        
                            <div class="col-sm-6 mt-4 mt-sm-0">
                                <ul class="list-unstyled footer-list text-sm-end text-center mb-0">
                                    <li class="list-inline-item"><a href="terms.html" class="text-foot me-2">Terms</a></li>
                                    <li class="list-inline-item"><a href="privacy.html" class="text-foot me-2">Privacy</a></li>
                                    <li class="list-inline-item"><a href="aboutus.html" class="text-foot me-2">About</a></li>
                                    <li class="list-inline-item"><a href="contact.html" class="text-foot me-2">Contact</a></li>
                                </ul>
                            </div>end col
                        </div>end row
                    </div>end container
                </footer>end footer-->
        <!-- End -->       
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
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

                                                        $(document).ready(function () {

                                                            $('#identityForm').submit(function (e) {
                                                                e.preventDefault();
                                                                const formData = new FormData(this);

                                                                $.ajax({
                                                                    url: 'identity-information-controller',
                                                                    type: 'POST',
                                                                    data: formData,
                                                                    contentType: false,
                                                                    processData: false,
                                                                    success: function (response) {
                                                                        if (response.success) {
                                                                            Swal.fire({
                                                                                title: 'Thành công!',
                                                                                text: 'Thông tin đã được gửi để phê duyệt.',
                                                                                icon: 'success',
                                                                                confirmButtonText: 'OK'
                                                                            }).then((result) => {
                                                                                if (result.isConfirmed) {
                                                                                    window.location.href = "identity-information-switch-case";
                                                                                }
                                                                            });
                                                                        } else {
                                                                            Swal.fire({
                                                                                title: 'Lỗi!',
                                                                                text: response.message || 'Có lỗi xảy ra. Vui lòng kiểm tra lại thông tin.',
                                                                                icon: 'error',
                                                                                confirmButtonText: 'OK'
                                                                            });
                                                                        }
                                                                    },
                                                                    error: function (error) {
                                                                        Swal.fire({
                                                                            title: 'Lỗi!',
                                                                            text: 'Có lỗi xảy ra khi lưu thông tin. Vui lòng thử lại.',
                                                                            icon: 'error',
                                                                            confirmButtonText: 'OK'
                                                                        });
                                                                    }
                                                                });
                                                            });
                                                        });
        </script>
    </body>

</html>