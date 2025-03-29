<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <title>SmartBanking</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
    <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
    <meta name="author" content="Shreethemes" />
    <meta name="email" content="support@shreethemes.in" />
    <meta name="website" content="https://shreethemes.in" />
    <meta name="Version" content="v1.2.0" />

    <!-- Favicon -->
    <link rel="shortcut icon" href="<%= request.getContextPath() %>/assets/images/favicon.png">

    <!-- Bootstrap -->
    <link href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Icons -->
    <link href="<%= request.getContextPath() %>/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="<%= request.getContextPath() %>/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <!-- Css -->
    <link href="<%= request.getContextPath() %>/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

    <!-- Updated Styles -->
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }
        /* Đảm bảo header không bị chồng lấn */
        header {
            position: relative; /* Đảm bảo header nằm trong luồng bố cục */
            z-index: 1000; /* Đặt z-index cao để header luôn ở trên */
        }
        /* Đẩy login section xuống dưới header */
        .login-section {
            min-height: 100vh; /* Chiều cao tối thiểu bằng viewport */
            width: 100vw;
            display: flex;
            justify-content: center;
            align-items: center;
            background: url('<%= request.getContextPath() %>/assets/images/bg/bg-lines-one.png') center;
            background-size: cover;
            padding-top: 100px; /* Tăng padding-top để đẩy nội dung xuống dưới header */
            padding-bottom: 50px; /* Thêm padding-bottom để tránh footer chồng lấn */
            box-sizing: border-box;
        }
        /* Thu nhỏ và tối ưu login card */
        .login-card {
            width: 100%;
            max-width: 380px; /* Thu nhỏ hơn nữa từ 400px xuống 380px */
            padding: 10px; /* Giảm padding */
        }
        .card-body {
            padding: 10px; /* Giảm padding bên trong card */
        }
        .login-form .mb-3 {
            margin-bottom: 8px !important; /* Giảm khoảng cách giữa các phần tử form */
        }
        .login-form .btn {
            padding: 6px; /* Giảm padding của nút */
            font-size: 14px; /* Giảm kích thước chữ của nút */
        }
        .login-form h4 {
            margin-bottom: 10px; /* Giảm khoảng cách dưới tiêu đề */
            font-size: 20px; /* Giảm kích thước tiêu đề */
        }
        .text-muted {
            margin: 8px 0 !important; /* Giảm khoảng cách cho "Hoặc" */
            font-size: 14px; /* Giảm kích thước chữ */
        }
        .mt-3 {
            margin-top: 8px !important; /* Giảm khoảng cách cho nút Google */
        }
        .form-label {
            font-size: 14px; /* Giảm kích thước chữ của nhãn */
        }
        .form-control {
            padding: 6px; /* Giảm padding của input */
            font-size: 14px; /* Giảm kích thước chữ trong input */
        }
        .d-flex.justify-content-between {
            font-size: 13px; /* Giảm kích thước chữ cho "Ghi nhớ tôi" và "Quên mật khẩu" */
        }
    </style>
</head>

<body>
    <!-- Include Header -->
    <jsp:include page="/template/header.jsp" />

    <!-- Login Section -->
    <section class="login-section bg-light">
        <div class="container login-card">
            <img src="<%= request.getContextPath() %>/assets/images/logo-dark.png" height="20" class="mx-auto d-block" alt="Logo"> <!-- Giảm chiều cao logo -->
            <div class="card login-page bg-white shadow mt-3 rounded border-0"> <!-- Giảm margin-top -->
                <div class="card-body">
                    <h4 class="text-center">Đăng nhập</h4>
                    <!-- Error Message -->
                    <%
                        String errorAccount = (String) session.getAttribute("errorAccount");
                        if (errorAccount != null) {
                    %>
                        <div class="alert alert-danger text-center" style="font-size: 14px; padding: 8px;"><%= errorAccount %></div>
                    <%
                            session.removeAttribute("errorAccount");
                        }
                    %>

                    <!-- Login Form -->
                    <form action="<%= request.getContextPath() %>/AuthServlet?action=login" method="POST" class="login-form mt-3"> <!-- Giảm margin-top -->
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="mb-3">
                                    <label class="form-label">Email của bạn <span class="text-danger">*</span></label>
                                    <input type="email" class="form-control" placeholder="Email" name="email" required>
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="mb-3 position-relative">
                                    <label class="form-label">Mật khẩu <span class="text-danger">*</span></label>
                                    <input type="password" class="form-control" placeholder="Mật khẩu" name="password" id="password" required>
                                    <span class="position-absolute top-50 end-0 translate-middle-y pe-3 cursor-pointer" onclick="togglePassword()" style="padding-top: 20px;"> <!-- Giảm padding-top -->
                                        <i id="togglePasswordIcon" class="mdi mdi-eye-outline"></i>
                                    </span>
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="d-flex justify-content-between">
                                    <div class="mb-3">
                                        <div class="form-check">
                                            <input class="form-check-input align-middle" type="checkbox" value="on" name="remember" id="remember-check">
                                            <label class="form-check-label" for="remember-check">Ghi nhớ tôi</label>
                                        </div>
                                    </div>
                                    <a href="<%= request.getContextPath() %>/auth/template/requestPassword.jsp" class="text-dark h6 mb-0">Quên mật khẩu?</a>
                                </div>
                            </div>
                            <div class="col-lg-12 mb-0">
                                <div class="d-grid">
                                    <button class="btn btn-primary" type="submit">Đăng nhập</button>
                                </div>
                            </div>

                            <div class="col-lg-12 mt-3 text-center">
                                <h6 class="text-muted">Hoặc</h6>
                            </div>  
                            <div class="col-12 mt-3">
                                <div class="d-grid">
                                    <a href="https://accounts.google.com/o/oauth2/auth?scope=email+profile+openid&redirect_uri=http://localhost:9999/BankingSystem/AuthServlet?action=loginGG&response_type=code&client_id=392132792045-5118009rsft2t9rc2q71n9b45pvh0gg0.apps.googleusercontent.com&approval_prompt=force" class="btn btn-lg btn-danger">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-google" viewBox="0 0 16 16"> <!-- Giảm kích thước icon -->
                                            <path d="M15.545 6.558a9.42 9.42 0 0 1 .139 1.626c0 2.434-.87 4.492-2.384 5.885h.002C11.978 15.292 10.158 16 8 16A8 8 0 1 1 8 0a7.689 7.689 0 0 1 5.352 2.082l-2.284 2.284A4.347 4.347 0 0 0 8 3.166c-2.087 0-3.86 1.408-4.492 3.304a4.792 4.792 0 0 0 0 3.063h.003c.635 1.893 2.405 3.301 4.492 3.301 1.078 0 2.004-.276 2.722-.764h-.003a3.702 3.702 0 0 0 1.599-2.431H8v-3.08h7.545z" />
                                        </svg>
                                        <span class="ms-2 fs-6">Đăng nhập bằng Google</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
    <jsp:include page="/template/footer.jsp" />

    <!-- Javascript -->
    <script src="<%= request.getContextPath() %>/assets/js/bootstrap.bundle.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/feather.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/app.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/tiny-slider.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/tiny-slider-init.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/counter.init.js"></script>
    <script src="<%= request.getContextPath() %>/resources/script/wow.min.js"></script>
    <script>new WOW().init();</script>

    <!-- Toggle Password Script -->
    <script>
        function togglePassword() {
            const passwordField = document.getElementById('password');
            const toggleIcon = document.getElementById('togglePasswordIcon');
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                toggleIcon.classList.remove('mdi-eye-outline');
                toggleIcon.classList.add('mdi-eye-off-outline');
            } else {
                passwordField.type = 'password';
                toggleIcon.classList.remove('mdi-eye-off-outline');
                toggleIcon.classList.add('mdi-eye-outline');
            }
        }
    </script>
</body>
</html>