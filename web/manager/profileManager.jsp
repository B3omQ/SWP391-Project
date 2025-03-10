<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

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
        <!-- Icons -->
        <link href="<%= request.getContextPath() %>/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="<%= request.getContextPath() %>/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
        <!-- SLIDER -->
        <link href="<%= request.getContextPath() %>/assets/css/tiny-slider.css" rel="stylesheet" />
        <!-- Css -->
        <link href="<%= request.getContextPath() %>/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link rel="stylesheet" href="https://unpkg.com/tippy.js@6/dist/tippy.css">

    </head>

    <style>
        .card-body {
            border-radius: 15px;
            border: 1px solid rgba(0, 0, 0, 0.05); /* Viền mờ */
            padding: 30px;
            margin-bottom: 30px;
        }
        h3 {
            color: #1a1d24;
            font-weight: 600;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e9ecef;
        }

    </style>


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
            <jsp:include page="template/sidebar.jsp"/>
            <!-- sidebar-wrapper  -->

            <!-- Start Page Content -->
            <main class="page-content bg-light">

                <c:set value="${sessionScope.staff}" var="staff"/>
                <jsp:include page="template/header.jsp"/>                
                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="container">
                            <div class="row">
                                <div class="col-xl-4 col-lg-4 col-md-5 col-12">
                                    <div class="rounded shadow overflow-hidden sticky-bar">
                                        <div class="card border-0">
                                            <img src="<%= request.getContextPath() %>/assets/images/doctors/profile-bg.jpg" class="img-fluid" alt="">
                                        </div>

                                        <div class="text-center avatar-profile margin-nagative mt-n5 position-relative pb-4 border-bottom">
                                            <img src="${staff.image}" class="rounded-circle shadow-md avatar avatar-md-md" alt="">
                                            <h5 class="mt-3 mb-1"> ${staff.fullname}</h5>

                                            <p class="text-muted mb-0">Quản lí</p>
                                        </div>

                                        <ul class="list-unstyled sidebar-nav mb-0">                                            
                                            <li class="navbar-item"><a href="#" class="navbar-link"><i class="ri-user-settings-line align-middle navbar-icon"></i>Email liên hệ: ${staff.email}</a></li>
                                        </ul>
                                    </div>
                                </div>


                                <div class="col-xl-8 col-lg-8 col-md-7 mt-4 pt-2 mt-sm-0 pt-sm-0">
                                    <div class="card-body">
                                        <h3 style="font-weight: bold">
                                            Trang cá nhân
                                        </h3>

                                        <form action="profile-manager" method="post" id="profileManagerForm" enctype="multipart/form-data">
                                            <input name="changeInfo" type="hidden" value="changeInfo" /> 
                                            <div class="row d-flex flex-row">
                                                <div class="col-lg-12">
                                                    <div class="">                                              
                                                        <div class="row">
                                                            <!-- Image Upload Section -->
                                                            <div class="">
                                                                <div class="mb-4 mt-3">
                                                                    <label for="newImg" class="form-label text-muted">Ảnh có size nhỏ hơn 5mb vả chỉ chấp nhận các file có đuôi jpg, jpeg, png, gif.</label>
                                                                    <input type="file" id="newImg" accept=".jpg,.png,.jpeg,.gif" name="newImg" class="form-control mb-4">
                                                                </div>

                                                                <div class="row mt-3">
                                                                    <div class="col-md-6">
                                                                        <label for="newFirstname" class="form-label head">Tên đầu</label>
                                                                        <input value="${staff.firstname}" type="text" id="newFirstname" name="newFirstname" class="form-control" required>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <label for="newLastname" class="form-label head">Tên họ</label>
                                                                        <input value="${staff.lastname}" type="text" id="newLastname" name="newLastname" class="form-control" required>
                                                                    </div>
                                                                </div>
                                                                <div class="row mt-3">
                                                                    <div class="col-md-6">
                                                                        <label for="newPhone" class="form-label head">Số điện thoại</label>
                                                                        <input value="${staff.phone}" type="text" id="newPhone" name="newPhone" class="form-control" required>
                                                                        <p class="text-danger">${errorPhoneMess}</p>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <label for="newAddress" class="form-label head">Địa chỉ</label>
                                                                        <input value="${staff.address}" type="text" id="newAddress" name="newAddress" class="form-control" required>
                                                                    </div>
                                                                </div>
                                                                <div class="row mt-3">
                                                                    <div class="col-md-6">
                                                                        <label for="newGender" class="form-label head">Giới tính</label>
                                                                        <select id="newGender" name="newGender" class="form-control">
                                                                            <option value="Male" ${staff.gender == 'Male' ? 'selected' : ''}>Nam</option>
                                                                            <option value="Female" ${staff.gender == 'Female' ? 'selected' : ''}>Nữ</option>
                                                                            <option value="Other" ${staff.gender == 'Other' ? 'selected' : ''}>Khác</option>
                                                                        </select>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <label for="newDob" class="form-label head">Ngày khai sinh</label>
                                                                        <input type="date" id="newDob" name="newDob" value="${staff.dob}" class="form-control">
                                                                    </div>
                                                                </div>
                                                                <div class="row mt-5">
                                                                    <div class="col-md-8 text-center">
                                                                        <p id="error-message-info" class="text-danger"></p>
                                                                    </div>
                                                                    <div class="col-md-4 text-center">
                                                                        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                                                    </div>
                                                                </div>                                                                       

                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>

                                        <h3 style="font-weight: bold">
                                            Thay mật khẩu
                                        </h3>

                                        <form action="profile-manager" method="post" id="changePasswordForm">
                                            <input name="changePwd" type="hidden" value="changePwd" /> 
                                            <div class="row d-flex flex-row">
                                                <div class="">
                                                    <div class="">

                                                        <div class="mb-4">
                                                            <div class="row mt-3">
                                                                <div class="col-md-12">
                                                                    <label for="currentPassword" class="head form-label">Mật khẩu hiện tại</label>
                                                                    <input type="password" id="currentPassword" name="currentPassword" class="form-control" placeholder="Mật khẩu hiện tại" required>
                                                                    <span class="position-absolute top-50 end-0 translate-middle-y pe-3 cursor-pointer" onclick="togglePassword('currentPassword', 'toggleCurrentPasswordIcon')" style="padding-top: 30px;">
                                                                        <i id="toggleCurrentPasswordIcon" class="mdi mdi-eye-outline"></i>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <div class="row mt-3">
                                                                <div class="col-md-12">
                                                                    <label for="newPassword" class="head form-label">Mật khẩu mới</label>
                                                                    <input type="password" id="newPassword" name="newPassword" class="form-control" placeholder="Mật khẩu mới" required>
                                                                    <span class="position-absolute top-50 end-0 translate-middle-y pe-3 cursor-pointer" onclick="togglePassword('newPassword', 'toggleNewPasswordIcon')" style="padding-top: 30px;">
                                                                        <i id="toggleNewPasswordIcon" class="mdi mdi-eye-outline"></i>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <div class="row mt-3">
                                                                <div class="col-md-12">
                                                                    <label for="confirmPassword" class="head form-label">Nhập lại mật khẩu mới</label>
                                                                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu mới" required>
                                                                    <span class="position-absolute top-50 end-0 translate-middle-y pe-3 cursor-pointer" onclick="togglePassword('confirmPassword', 'toggleConfirmPasswordIcon')" style="padding-top: 30px;">
                                                                        <i id="toggleConfirmPasswordIcon" class="mdi mdi-eye-outline"></i>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <div class="row mt-5">
                                                                <div class="col-md-8 text-center">
                                                                    <p id="error-message" class="text-danger"></p>
                                                                </div>
                                                                <div class="col-md-4 text-center">
                                                                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>

                                </div><!--end row-->

                            </div>

                        </div>
                    </div>
                </div>
                <!-- Footer Start -->
                <jsp:include page="template/footer.jsp"/>
                <!-- End -->
            </main>

        </div>

        <script src ="resources/script/jquery-3.7.1.min.js"></script>
        <script src="https://unpkg.com/@popperjs/core@2"></script>
        <script src="https://unpkg.com/tippy.js@6"></script>

        <script>
                                                                        document.addEventListener("DOMContentLoaded", function () {
                                                                            tippy('#newPassword', {
                                                                                content: "Password must be at least 8 characters long and include an uppercase letter, a lowercase letter, a number, a special character and not contains space characters.",
                                                                                animation: 'fade',
                                                                                duration: [300, 300],
                                                                                placement: 'top',
                                                                                theme: 'light-border'
                                                                            });

                                                                            tippy('#confirmPassword', {
                                                                                content: "Password must be at least 8 characters long and include an uppercase letter, a lowercase letter, a number, a special character and not contains space characters.",
                                                                                animation: 'fade',
                                                                                duration: [300, 300],
                                                                                placement: 'top',
                                                                                theme: 'light-border'
                                                                            });

                                                                            tippy('#newPhone', {
                                                                                content: "Phone must be 10 - 11 digits number",
                                                                                animation: 'fade',
                                                                                duration: [300, 300],
                                                                                placement: 'top',
                                                                                theme: 'light-border'
                                                                            });
                                                                        });

                                                                        $(document).ready(function () {
                                                                            showToastrAfterReload();
                                                                            $('#changePasswordForm').on('submit', function (event) {
                                                                                event.preventDefault();
                                                                                var currentPassword = $('#currentPassword');
                                                                                var newPassword = $('#newPassword');
                                                                                var confirmPassword = $('#confirmPassword');
                                                                                var formData = {
                                                                                    changePwd: "true",
                                                                                    currentPassword: currentPassword.val(),
                                                                                    newPassword: newPassword.val(),
                                                                                };
                                                                                console.log(formData);
                                                                                if (newPassword.val() !== confirmPassword.val()) {
                                                                                    showErrorMessage("Error", "Your confirm password is incorrect");
                                                                                    newPassword.val("");
                                                                                    confirmPassword.val("");
                                                                                    return;
                                                                                }

                                                                                $.ajax({
                                                                                    url: 'profile-manager',
                                                                                    type: 'POST',
                                                                                    data: formData,
                                                                                    success: function (response) {
                                                                                        if (response.success) {
                                                                                            reloadWithMessage("success", "Success", "Change successful");
                                                                                        } else {
                                                                                            showErrorMessage("Error", response.message);
                                                                                        }
                                                                                    },
                                                                                    error: function () {
                                                                                        showErrorMessage("Error", "Server is busy right now, try again");
                                                                                    }
                                                                                });
                                                                            }
                                                                            );

                                                                            $('#profileManagerForm').on('submit', function (event) {
                                                                                event.preventDefault();
                                                                                var formData = new FormData(this); // Lấy dữ liệu từ form (bao gồm cả file ảnh)
                                                                                formData.append("changeInfo", "true");

                                                                                $.ajax({
                                                                                    url: 'profile-manager',
                                                                                    type: 'POST',
                                                                                    data: formData,
                                                                                    processData: false, // Không xử lý dữ liệu thành query string
                                                                                    contentType: false, // Để trình duyệt tự động set multipart/form-data
                                                                                    success: function (response) {
                                                                                        if (response.success) {
                                                                                            reloadWithMessage("success", "Success", "Update successful");
                                                                                        } else {
                                                                                            showErrorMessage("Error", response.message);
                                                                                        }
                                                                                    },
                                                                                    error: function () {
                                                                                        showErrorMessage("Error", "Server is busy right now, try again");
                                                                                    }
                                                                                });
                                                                            });
                                                                            $('#sendOtpBtn').click(function () {
                                                                                event.preventDefault();
                                                                                $.ajax({
                                                                                    url: 'AuthServlet',
                                                                                    type: 'POST',
                                                                                    data: {action: 'sendOtp'},
                                                                                    success: function (response) {
                                                                                        window.location.href = "otpEmail.jsp";
                                                                                    },
                                                                                    error: function () {
                                                                                        showErrorMessage("Error", "Something wrong");
                                                                                    }
                                                                                });
                                                                            });
                                                                        });

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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
        <script src="./resources/script/script.js"></script>

        <!-- page-wrapper -->
        <script src="<%= request.getContextPath() %>/assets/js/jquery.min.js"></script>
        <script src="<%= request.getContextPath() %>/assets/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/js/all.min.js"></script>

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