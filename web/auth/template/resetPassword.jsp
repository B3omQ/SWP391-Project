<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>SmartBanking - Reset Password</title>
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
        /* Sticky Footer */
        html, body {
            height: 100%;
            margin: 0;
        }
        body {
            display: flex;
            flex-direction: column;
        }
        .content {
            flex: 1 0 auto; /* Nội dung chính mở rộng để đẩy footer xuống */
        }
        .bg-footer {
            flex-shrink: 0; /* Footer không bị co lại */
        }
        .success-message {
            text-align: center;
            margin-top: 20px;
        }
        .success-message .btn {
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/template/header.jsp" />

    <!-- Main Content -->
    <div class="content">
        <div class="back-to-home rounded d-none d-sm-block">
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-icon btn-primary"><i data-feather="home" class="icons"></i></a>
        </div>

        <section class="p-3 p-md-4 p-xl-5">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 col-md-9 col-lg-7 col-xl-6 col-xxl-5">
                        <div class="card border-0 shadow-sm rounded-4" style="margin-top: 170px">
                            <div class="card-body p-3 p-md-4 p-xl-5">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="mb-5">
                                            <h3>Reset Password</h3>
                                        </div>
                                    </div>
                                </div>

                                <!-- Hiển thị thông báo thành công nếu có -->
                                <c:if test="${not empty success}">
                                    <div class="success-message">
                                        <p class="text-success">${success}</p>
                                        <a href="${pageContext.request.contextPath}/auth/template/login.jsp" class="btn btn-primary">Quay lại đăng nhập</a>
                                    </div>
                                </c:if>

                                <!-- Hiển thị form nếu không có thông báo thành công -->
                                <c:if test="${empty success}">
                                    <form action="resetPassword" method="POST">
                                        <div class="row gy-3 overflow-hidden">
                                            <div class="col-12">
                                                <div class="form-floating mb-3">
                                                    <input type="email" class="form-control" value="${email}" name="email" id="email" placeholder="name@example.com" required>
                                                    <label for="email" class="form-label">Email</label>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <div class="form-floating mb-3 position-relative">
                                                    <input type="password" class="form-control" name="password" id="password" value="" placeholder="Password" required>
                                                    <label for="password" class="form-label">Password</label>
                                                    <span class="position-absolute top-50 end-0 translate-middle-y pe-3 cursor-pointer" onclick="togglePassword('password', 'togglePasswordIcon')" style="padding-top: 30px;">
                                                        <i id="togglePasswordIcon" class="mdi mdi-eye-outline"></i>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <div class="form-floating mb-3 position-relative">
                                                    <input type="password" class="form-control" name="confirm_password" id="confirm_password" value="" placeholder="Confirm Password" required>
                                                    <label for="confirm_password" class="form-label">Confirm Password</label>
                                                    <span class="position-absolute top-50 end-0 translate-middle-y pe-3 cursor-pointer" onclick="togglePassword('confirm_password', 'toggleConfirmPasswordIcon')" style="padding-top: 30px;">
                                                        <i id="toggleConfirmPasswordIcon" class="mdi mdi-eye-outline"></i>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <div class="d-grid">
                                                    <button class="btn bsb-btn-2xl btn-primary" type="submit">Reset Password</button>
                                                </div>
                                            </div>
                                        </div>
                                        <p class="text-danger">${mess}</p>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <!-- Include Footer -->
    <jsp:include page="/template/footer.jsp" />

    <!-- Back to top -->
    <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>

    <!-- Javascript -->
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <!-- SLIDER -->
    <script src="${pageContext.request.contextPath}/assets/js/tiny-slider.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/tiny-slider-init.js"></script>
    <!-- Counter -->
    <script src="${pageContext.request.contextPath}/assets/js/counter.init.js"></script>
    <!-- Icons -->
    <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
    <!-- Main Js -->
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    <script src="${pageContext.request.contextPath}/resources/script/wow.min.js"></script>
    <script>new WOW().init();</script>

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