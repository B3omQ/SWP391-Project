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

                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="row ">
                            <div class="col-lg-5">
                                <div class="card">
                                    <div class="card-body">
                                        <h5>Upload New Photo</h5>
                                        <form>
                                            <img src="./assets/images/111117kpbaothanhthien7.jpeg" alt="Image" width="500" height="auto">
                                            <div class="mb-4">
                                                <label for="profilePhoto" class="form-label">Upload a new avatar. Larger images will be resized automatically. Maximum upload size is 1 MB.</label>
                                                <input type="file" class="form-control" id="profilePhoto">
                                            </div>
                                            <div class="mb-4">
                                                <p class="text-muted">Member: Bomnamana</p>
                                            </div>
                                            <div class="text-center">
                                                <button type="submit" class="btn btn-primary">Update Image</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-7">
                                <div class="card">
                                    <div class="card-body">
                                        <h4 class="card-title">Edit Profile</h4>
                                        <form>
                                            <div class="mb-4">
                                                <h5>User Info</h5>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <label for="fullName" class="form-label">First Name</label>
                                                        <input type="text" class="form-control" id="fullName" value="James Allan">
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label for="username" class="form-label">Last Name</label>
                                                        <input type="text" class="form-control" id="username" value="@James">
                                                    </div>
                                                </div>
                                                <div class="row mt-3">
                                                    <div class="col-md-6">
                                                        <label for="password" class="form-label">Phone</label>
                                                        <input type="password" class="form-control" id="password" placeholder="091203765">
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label for="confirmPassword" class="form-label">Address</label>
                                                        <input type="password" class="form-control" id="confirmPassword" placeholder="Welcome to the rice filed">
                                                    </div>
                                                </div>
                                                <div class="row mt-3">
                                                    <div class="col-md-6">
                                                        <label for="newGender" class="form-label">Gender</label>
                                                        <select id="newGender" name="newGender" class="form-control">
                                                            <option value="Male" ${param.gender == 'Male' ? 'selected' : ''}>Male</option>
                                                            <option value="Female" ${param.gender == 'Female' ? 'selected' : ''}>Female</option>
                                                            <option value="Other" ${param.gender == 'Other' ? 'selected' : ''}>Other</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label for="newDob" class="form-label">Date of Birth</label>
                                                        <input type="date" id="newDob" name="newDob" value="${param.dob}" class="form-control">
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="text-center">
                                                <button type="submit" class="btn btn-primary">Update Info</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Footer Start -->
                <jsp:include page="template/footer.jsp"/>
                <!-- End -->
            </main>

        </div>

        <!-- page-wrapper -->
        <script src="<%= request.getContextPath() %>/assets/js/jquery.min.js"></script>
        <script src="<%= request.getContextPath() %>/assets/js/bootstrap.bundle.min.js"></script>

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