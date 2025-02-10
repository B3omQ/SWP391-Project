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
        <!-- SLIDER -->
        <link href="<%= request.getContextPath() %>/assets/css/tiny-slider.css" rel="stylesheet" />
        <!-- Css -->
        <link href="<%= request.getContextPath() %>/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

        <style>
            .card-title {
                font-size: 1.5rem;
                font-weight: bold;
                margin-bottom: 1.5rem;
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

                <jsp:include page="template/header.jsp"/>
                <c:set value="${sessionScope.staff}" var="staff"/>
                <div class="container-fluid">
                    <div class="layout-specing">

                        <div class="container">
                            <form action="profile-manager" method="post" enctype="multipart/form-data">
                                <input name="changeInfo" type="hidden" value="changeInfo" />

                                <div class="row">
                                    <!-- Image Upload Section -->
                                    <div class="col-lg-5">
                                        <div class="card">
                                            <div class="card-body text-center">
                                                <h4 class ="card-title" style="background-color: red; color: white; padding: 10px; border-radius: 5px;">
                                                    Upload New Photo
                                                </h4>

                                                <img src="${staff.image}" alt="Image" accept=".jpg,.png"
                                                     style="width: 300px;
                                                     height: 300px;
                                                     object-fit: cover;
                                                     border-radius: 30%;">
                                                <div class="mb-4 mt-3">
                                                    <label for="newImg" class="form-label">Upload a new avatar. Larger images will be resized automatically. Maximum upload size is 1 MB.</label>
                                                    <input type="file" id="newImg" name="newImg" class="form-control-file">
                                                </div>
                                                <div class="mb-4">
                                                    <p class="text-muted">
                                                        Your email: ${staff.email}
                                                        <a href="customer-manager" class="ms-2 text-decoration-none text-muted">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- User Info Section -->
                                    <div class="col-lg-7">
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="mb-4">
                                                    <h4 class ="card-title text-center" style="background-color: red; color: white; padding: 10px; border-radius: 5px;">
                                                        Edit information
                                                    </h4>
                                                    <div class="row mt-3">
                                                        <div class="col-md-6">
                                                            <label for="newFirstname" class="form-label head">First Name</label>
                                                            <input value="${staff.firstname}" type="text" id="newFirstname" name="newFirstname" class="form-control">
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label for="newLastname" class="form-label head">Last Name</label>
                                                            <input value="${staff.lastname}" type="text" id="newLastname" name="newLastname" class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="row mt-3">
                                                        <div class="col-md-6">
                                                            <label for="newPhone" class="form-label head">Phone</label>
                                                            <input value="${staff.phone}" type="text" id="newPhone" name="newPhone" class="form-control">
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label for="newAddress" class="form-label head">Address</label>
                                                            <input value="${staff.address}" type="text" id="newAddress" name="newAddress" class="form-control">
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
                                                        <div class="col-md-12 text-center">
                                                            <button type="submit" class="btn btn-primary">Save</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card">
                                            <div class="card-body">
                                                <h4 class ="card-title text-center" style="background-color: red; color: white; padding: 10px; border-radius: 5px;">
                                                    Edit password
                                                </h4>
                                                <div class="mb-4">
                                                    <div class="row mt-3">
                                                        <div class="col-md-12">
                                                            <label for="currentPassword" class="head form-label">Current Password</label>
                                                            <input type="password" id="currentPassword" name="currentPassword" class="form-control" placeholder="Password">
                                                            <span class="position-absolute top-50 end-0 translate-middle-y pe-3 cursor-pointer" onclick="togglePassword('currentPassword', 'toggleCurrentPasswordIcon')" style="padding-top: 30px;">
                                                                <i id="toggleCurrentPasswordIcon" class="mdi mdi-eye-outline"></i>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="row mt-3">
                                                        <div class="col-md-12">
                                                            <label for="newPassword" class="head form-label">New Password</label>
                                                            <input type="password" id="newPassword" name="newPassword" class="form-control" placeholder="New password">
                                                            <span class="position-absolute top-50 end-0 translate-middle-y pe-3 cursor-pointer" onclick="togglePassword('newPassword', 'toggleNewPasswordIcon')" style="padding-top: 30px;">
                                                                <i id="toggleNewPasswordIcon" class="mdi mdi-eye-outline"></i>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="row mt-3">
                                                        <div class="col-md-12">
                                                            <label for="confirmPassword" class="head form-label">Confirm Password</label>
                                                            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Confirm your password">
                                                            <span class="position-absolute top-50 end-0 translate-middle-y pe-3 cursor-pointer" onclick="togglePassword('confirmPassword', 'toggleConfirmPasswordIcon')" style="padding-top: 30px;">
                                                                <i id="toggleConfirmPasswordIcon" class="mdi mdi-eye-outline"></i>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="row mt-5">
                                                        <div class="col-md-12 text-center">
                                                            <button type="submit" class="btn btn-primary">Save</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>


                    <!-- Footer Start -->
                    <jsp:include page="template/footer.jsp"/>
                    <!-- End -->
            </main>

        </div>
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