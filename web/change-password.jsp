<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>SmartBanking</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Account Recovery Page for Secure System" />
    <meta name="keywords" content="Recovery, Reset, Password, Security, Account" />
    
    <!-- Favicon -->
    <link rel="shortcut icon" href="<%= request.getContextPath() %>/assets/images/favicon.ico.png">

    <!-- Bootstrap -->
    <link href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Icons -->
    <link href="<%= request.getContextPath() %>/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="<%= request.getContextPath() %>/assets/css/style.min.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <div id="preloader">
        <div id="status">
            <div class="spinner">
                <div class="double-bounce1"></div>
                <div class="double-bounce2"></div>
            </div>
        </div>
    </div>
    
    <!-- Back to Home -->
    <div class="back-to-home rounded d-none d-sm-block">
        <a href="<%= request.getContextPath() %>/Customer.jsp" class="btn btn-icon btn-primary">
            <i data-feather="home" class="icons"></i>
        </a>
    </div>

    <!-- Hero Section -->
    <section class="bg-home d-flex bg-light align-items-center" style="background: url('<%= request.getContextPath() %>/assets/images/bg/bg-lines-one.png') center;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-5 col-md-8">
                    <img src="<%= request.getContextPath() %>/assets/images/logo-dark.png" height="24" class="mx-auto d-block" alt="">
                    <div class="card login-page bg-white shadow mt-4 rounded border-0">
                        <div class="card-body">
                            <h4 class="text-center">Change Password</h4>
                            <form action="<%= request.getContextPath() %>/changePassword" method="POST">
                                <div class="mb-3">
                                    <label for="fullName" class="form-label">Full Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Enter your full name" required>
                                </div>

                                <div class="mb-3">
                                    <label for="phoneNumber" class="form-label">Phone Number <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" placeholder="Enter your phone number" required>
                                </div>

                                <div class="mb-3">
                                    <label for="oldPassword" class="form-label">Old Password <span class="text-danger">*</span></label>
                                    <input type="password" class="form-control" id="oldPassword" name="oldPassword" placeholder="Enter your old password" required>
                                </div>

                                <div class="mb-3">
                                    <label for="newPassword" class="form-label">New Password <span class="text-danger">*</span></label>
                                    <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="Enter your new password" required>
                                </div>

                                <div class="mb-3">
                                    <label for="confirmPassword" class="form-label">Confirm New Password <span class="text-danger">*</span></label>
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm your new password" required>
                                </div>

                                <div class="d-grid">
                                    <button type="submit" class="btn btn-primary">Change Password</button>
                                </div>
                            </form> 

                            <!-- Error Message -->
                            <c:if test="${not empty msg}">
                                <p class="text-center text-danger">${msg}</p>
                            </c:if>

                            <!-- Success Message -->
                            <c:if test="${not empty msg2}">
                                <p class="text-center text-success">${msg2}</p>
                            </c:if>
                        </div>
                    </div>
                </div> <!--end col-->
            </div><!--end row-->
        </div> <!--end container-->
    </section><!--end section-->

    <!-- Javascript -->
    <script src="<%= request.getContextPath() %>/assets/js/bootstrap.bundle.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/feather.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/app.js"></script>
</body>
</html>
