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

        <style>
            .card-title {
                font-size: 1.5rem;
                font-weight: bold;
                margin-bottom: 1.5rem;
                background-color: red;
                color: white;
                padding: 10px;
                border-radius: 20px;
            }

            .form-label {
                font-weight: 500;
            }

            .btn-primary {
                padding: 0.5rem 2rem;
                font-size: 1rem;
            }

            .layout-specing {
                padding: 20px;
            }

            .card {
                margin-bottom: 20px;
                border-collapse: separate; /* Để box-shadow hiển thị đúng */
                border-spacing: 0; /* Loại bỏ khoảng cách giữa các ô */
                border-radius: 30px; /* Bo góc */
                overflow: hidden; /* Đảm bảo góc bo tròn không bị mất */
                background: white; /* Đảm bảo bảng có màu nền để bóng đẹp hơn */
                box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.15),
                    0px 0px 8px rgba(0, 0, 0, 0.1); /* Hiệu ứng đổ bóng xung quanh */
            }

            .card-body {
                padding: 20px;
            }

            .text-center {
                text-align: center;
            }

            .mb-4 {
                margin-bottom: 1.5rem !important;
            }

            .mt-3 {
                margin-top: 1rem !important;
            }

            .mt-2 {
                margin-top: 0.5rem !important;
            }

            .container {
                display: flex;
                justify-content: center;
                align-items: center;
                /* Full viewport height */
            }

            .head {
                font-weight: bold;
            }
        </style>
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
                                <form action="profile-manager" method="post" id="profileManagerForm" enctype="multipart/form-data">
                                    <input name="changeInfo" type="hidden" value="changeInfo" /> 
                                    <div class="row d-flex flex-row">
                                        <div class="card col-lg-12">
                                            <div class="card-body">
                                                <h4 class="card-title text-center">Edit information</h4>                                               
                                                <div class="row">
                                                    <!-- Image Upload Section -->
                                                    <div class="col-lg-5 text-center">
                                                        <img src="${staff.image}" alt="Image"
                                                             style="width: 205px; height: 205px; object-fit: cover; border-radius: 30%;">
                                                        <div class="mb-4 mt-3">
                                                            <label for="newImg" class="form-label text-muted">Upload a new avatar. Larger images will be resized automatically. Maximum upload size is 5 MB. Only accept jpg, jpeg, png, gif file</label>
                                                            <input type="file" id="newImg" accept=".jpg,.png,.jpeg,.gif" name="newImg" class="form-control-file">
                                                        </div>
                                                        <div class="mb-4">
                                                            <p class="text-muted">Your email: ${staff.email}
                                                                <a href="customer-manager" class="ms-2 text-decoration-none">
                                                                    <i class="fas fa-edit"></i>
                                                                </a>
                                                            </p>
                                                        </div>
                                                    </div>
                                                    <!-- User Info Section -->
                                                    <div class="col-lg-7">
                                                        <div class="row mt-3">
                                                            <div class="col-md-6">
                                                                <label for="newFirstname" class="form-label head">First Name</label>
                                                                <input value="${staff.firstname}" type="text" id="newFirstname" name="newFirstname" class="form-control" required>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <label for="newLastname" class="form-label head">Last Name</label>
                                                                <input value="${staff.lastname}" type="text" id="newLastname" name="newLastname" class="form-control" required>
                                                            </div>
                                                        </div>
                                                        <div class="row mt-3">
                                                            <div class="col-md-6">
                                                                <label for="newPhone" class="form-label head">Phone</label>
                                                                <input value="${staff.phone}" type="text" id="newPhone" name="newPhone" class="form-control" required>
                                                                <p class="text-danger">${errorPhoneMess}</p>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <label for="newAddress" class="form-label head">Address</label>
                                                                <input value="${staff.address}" type="text" id="newAddress" name="newAddress" class="form-control" required>
                                                            </div>
                                                        </div>
                                                        <div class="row mt-3">
                                                            <div class="col-md-6">
                                                                <label for="newGender" class="form-label head">Gender</label>
                                                                <select id="newGender" name="newGender" class="form-control">
                                                                    <option value="Male" ${staff.gender == 'Male' ? 'selected' : ''}>Male</option>
                                                                    <option value="Female" ${staff.gender == 'Female' ? 'selected' : ''}>Female</option>
                                                                    <option value="Other" ${staff.gender == 'Other' ? 'selected' : ''}>Other</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <label for="newDob" class="form-label head">Date of Birth</label>
                                                                <input type="date" id="newDob" name="newDob" value="${staff.dob}" class="form-control">
                                                            </div>
                                                        </div>
                                                        <div class="row mt-5">
                                                            <div class="col-md-8 text-center">
                                                                <p id="error-message-info" class="text-danger"></p>
                                                            </div>
                                                            <div class="col-md-4 text-center">
                                                                <button type="submit" class="btn btn-primary">Save</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>

                                <form action="profile-manager" method="post" id="changePasswordForm">
                                    <input name="changePwd" type="hidden" value="changePwd" /> 
                                    <div class="row d-flex flex-row">
                                        <div class="card">
                                            <div class="card-body">
                                                <h4 class ="card-title text-center">
                                                    Edit password
                                                </h4>
                                                <div class="mb-4">
                                                    <div class="row mt-3">
                                                        <div class="col-md-12">
                                                            <label for="currentPassword" class="head form-label">Current Password</label>
                                                            <input type="password" id="currentPassword" name="currentPassword" class="form-control" placeholder="Current Password" required>
                                                            <span class="position-absolute top-50 end-0 translate-middle-y pe-3 cursor-pointer" onclick="togglePassword('currentPassword', 'toggleCurrentPasswordIcon')" style="padding-top: 30px;">
                                                                <i id="toggleCurrentPasswordIcon" class="mdi mdi-eye-outline"></i>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="row mt-3">
                                                        <div class="col-md-12">
                                                            <label for="newPassword" class="head form-label">New Password</label>
                                                            <input type="password" id="newPassword" name="newPassword" class="form-control" placeholder="New password" required>
                                                            <span class="position-absolute top-50 end-0 translate-middle-y pe-3 cursor-pointer" onclick="togglePassword('newPassword', 'toggleNewPasswordIcon')" style="padding-top: 30px;">
                                                                <i id="toggleNewPasswordIcon" class="mdi mdi-eye-outline"></i>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="row mt-3">
                                                        <div class="col-md-12">
                                                            <label for="confirmPassword" class="head form-label">Confirm Password</label>
                                                            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Confirm your password" required>
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
                                                            <button type="submit" class="btn btn-primary">Save</button>
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