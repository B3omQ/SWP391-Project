<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8" />
    <title>Doctris - Hệ Thống Đặt Lịch Bác Sĩ</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Mẫu Trang Đích Bootstrap 4 Cao Cấp" />
    <meta name="keywords" content="Đặt lịch, Hệ thống, Bảng điều khiển, Sức khỏe" />
    <meta name="author" content="Shreethemes" />
    <meta name="email" content="support@shreethemes.in" />
    <meta name="website" content="https://shreethemes.in" />
    <meta name="Version" content="v1.2.0" />
    <!-- Favicon -->
    <link rel="shortcut icon" href="<%= request.getContextPath() %>/assets/images/favicon.ico.png">
    <!-- Bootstrap -->
    <link href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Icons -->
    <link href="<%= request.getContextPath() %>/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="<%= request.getContextPath() %>/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <!-- Css -->
    <link href="<%= request.getContextPath() %>/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

    <!-- CSS Điều Chỉnh -->
    <style>
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
            margin-top: 80px; /* Thêm khoảng cách để tránh chồng lấn với header */
        }
        .bg-footer {
            flex-shrink: 0; /* Footer không co lại */
        }
        /* Đảm bảo header không bị đè */
        header {
            position: relative;
            z-index: 1000; /* Đặt z-index cao để header luôn ở trên */
        }
    </style>
</head>

<body>
    <!-- Loader -->

    <!-- Loader -->

    <!-- Bao gồm Header -->
    <jsp:include page="/template/header.jsp" />

    <!-- Nút Quay về Trang Chủ -->
    <div class="back-to-home rounded d-none d-sm-block">
        <a href="<%= request.getContextPath() %>/home.jsp" class="btn btn-icon btn-primary">
            <i data-feather="home" class="icons"></i>
        </a>
    </div>

    <!-- Phần Khôi Phục Tài Khoản -->
    <section class="bg-home d-flex bg-light align-items-center content" style="background: url('<%= request.getContextPath() %>/assets/images/bg/bg-lines-one.png') center;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-5 col-md-8">
                    <img src="<%= request.getContextPath() %>/assets/images/logo-dark.png" height="24" class="mx-auto d-block" alt="Logo">
                    <div class="card login-page bg-white shadow mt-4 rounded border-0">
                        <div class="card-body">
                            <h4 class="text-center">Khôi Phục Tài Khoản</h4>
                            <form class="login-form mt-4" action="<%= request.getContextPath() %>/requestPassword" method="POST">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <p class="text-muted">Vui lòng nhập địa chỉ email của bạn. Bạn sẽ nhận được một liên kết để tạo mật khẩu mới qua email.</p>
                                        <div class="mb-3">
                                            <label class="form-label">Địa chỉ email <span class="text-danger">*</span></label>
                                            <input type="email" class="form-control" placeholder="Nhập địa chỉ email của bạn" name="email" required>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="d-grid">
                                            <button class="btn btn-primary" type="submit">Gửi</button>
                                        </div>
                                    </div>
                                    <div class="mx-auto">
                                        <p class="mb-0 mt-3">
                                            <small class="text-dark me-2">Nhớ mật khẩu của bạn?</small> 
                                            <a href="<%= request.getContextPath() %>/auth/template/login.jsp" class="text-dark h6 mb-0">Đăng nhập</a>
                                        </p>
                                    </div>
                                    <p class="text-danger text-center">${mess}</p>
                                </div>
                            </form>
                        </div>
                    </div>
                </div> <!--end col-->
            </div><!--end row-->
        </div> <!--end container-->
    </section><!--end section-->
    <!-- Kết Thúc Phần Khôi Phục -->

    <!-- Bao gồm Footer -->
    <jsp:include page="/template/footer.jsp" />

    <!-- Javascript -->
    <script src="<%= request.getContextPath() %>/assets/js/bootstrap.bundle.min.js"></script>
    <!-- Icons -->
    <script src="<%= request.getContextPath() %>/assets/js/feather.min.js"></script>
    <!-- Main Js -->
    <script src="<%= request.getContextPath() %>/assets/js/app.js"></script>
</body>
</html>