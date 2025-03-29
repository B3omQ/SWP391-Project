<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8" />
    <title>OTP Verification - SmartBank</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            min-height: 100vh; /* Đảm bảo body có chiều cao tối thiểu bằng viewport */
        }
        /* Header cố định */
        header {
            position: sticky;
            top: 0;
            z-index: 1000; /* Đặt z-index cao để header luôn ở trên */
        }
        /* Section chính */
        .bg-home {
            flex: 1 0 auto; /* Nội dung chính mở rộng để đẩy footer xuống */
            display: flex;
            align-items: center; /* Căn giữa theo chiều dọc */
            justify-content: center; /* Căn giữa theo chiều ngang */
            min-height: calc(100vh - 120px); /* Trừ đi chiều cao của header và footer */
            padding: 30px 0; /* Thêm khoảng cách trên và dưới */
            background: url('<%= request.getContextPath() %>/assets/images/bg/bg-lines-one.png') center;
        }
        /* Footer */
        .bg-footer {
            flex-shrink: 0; /* Footer không co lại */
            background: #1a1a1a; /* Màu nền footer (đen đậm) */
            color: #ffffff; /* Màu chữ trắng */
        }
        .bg-footer a.text-muted:hover {
            color: #dc3545 !important; /* Màu khi hover cho các liên kết trong footer */
        }
        /* Tăng chiều rộng form (làm dài ra theo chiều ngang) */
        .login-page {
            padding: 40px 60px; /* Tăng padding ngang (60px) để làm form rộng hơn, giữ padding dọc (40px) */
            max-width: 100%; /* Đảm bảo form không bị giới hạn chiều rộng quá mức */
            border-radius: 12px; /* Bo góc nhẹ để trông mềm mại hơn */
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); /* Tăng bóng để nổi bật */
        }
        .login-page h4 {
            font-size: 32px; /* Kích thước tiêu đề */
            margin-bottom: 20px; /* Khoảng cách dưới tiêu đề */
            font-weight: 600; /* Tăng độ đậm của tiêu đề */
        }
        .login-page p {
            font-size: 18px; /* Kích thước đoạn văn */
            margin-bottom: 25px; /* Khoảng cách dưới đoạn văn */
            line-height: 1.6; /* Tăng khoảng cách dòng để thoáng hơn */
        }
        .login-page .form-control {
            height: 50px; /* Chiều cao của input */
            font-size: 18px; /* Kích thước chữ trong input */
            padding: 15px 20px; /* Padding trong input */
            border-radius: 8px; /* Bo góc input */
            border: 1px solid #ced4da; /* Đảm bảo viền rõ ràng */
        }
        .login-page .btn-primary {
            height: 50px; /* Chiều cao của nút */
            font-size: 18px; /* Kích thước chữ trong nút */
            padding: 15px; /* Padding trong nút */
            border-radius: 8px; /* Bo góc nút */
            background-color: #dc3545; /* Màu đỏ cho nút */
            border: none; /* Bỏ viền mặc định */
        }
        .login-page .btn-primary:hover {
            background-color: #c82333; /* Màu đỏ đậm hơn khi hover */
        }
        .login-page .mb-3 {
            margin-bottom: 25px !important; /* Khoảng cách giữa các phần tử */
        }
        .login-page .text-danger {
            font-size: 18px; /* Kích thước dấu * */
        }
        .login-page .form-label {
            font-size: 18px; /* Kích thước nhãn */
            margin-bottom: 10px; /* Khoảng cách dưới nhãn */
        }
        /* Tăng kích thước thông báo lỗi */
        .login-page p[style*="color: red"] {
            font-size: 16px; /* Kích thước thông báo lỗi */
            margin-top: 15px; /* Khoảng cách trên thông báo lỗi */
        }
    </style>
</head>

<body>
    <!-- Bao gồm Header -->
    <%@include file="/template/header.jsp" %>


    <!-- Loader End -->

    <!-- Nút Quay về Trang Chủ -->
    <div class="back-to-home rounded d-none d-sm-block">
        <a href="<%= request.getContextPath() %>/home.jsp" class="btn btn-icon btn-primary">
            <i data-feather="home" class="icons"></i>
        </a>
    </div>

    <!-- Hero Start -->
    <section class="bg-home bg-light">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8 col-md-12"> <!-- Tăng chiều rộng container: col-lg-8, col-md-12 -->
                    <img src="<%= request.getContextPath() %>/assets/images/logo-dark.png" height="40" class="mx-auto d-block" alt=""> <!-- Giữ kích thước logo -->
                    <div class="card login-page bg-white mt-5 rounded border-0">
                        <div class="card-body">
                            <h4 class="text-center">Xác Minh OTP</h4>
                            <form class="login-form mt-4" action="<%= request.getContextPath() %>/VerifyingOtp" method="POST">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <p class="text-muted">Vui lòng nhập mã OTP được gửi qua email.</p>
                                        <div class="mb-3">
                                            <label class="form-label">Mã OTP <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" placeholder="Nhập mã OTP" name="otp" required>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="d-grid">
                                            <button class="btn btn-primary" type="submit">Gửi</button>
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${not empty sessionScope.otpError}">
                                    <p style="color: red;">${sessionScope.otpError}</p>
                                    <c:remove var="otpError" scope="session"/>
                                </c:if>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Hero End -->

    <!-- Footer Start -->
    <%@include file="/template/footer.jsp" %>
    <!-- Footer End -->

    <!-- Javascript -->
    <script src="<%= request.getContextPath() %>/assets/js/bootstrap.bundle.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/feather.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/app.js"></script>
</body>
</html>