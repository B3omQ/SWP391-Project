<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <!-- Css -->
    <link href="<%= request.getContextPath() %>/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
    </head>
    <body class="bg-primary">
   <div class="back-to-home rounded d-none d-sm-block">
        <a href="index.jsp" class="btn btn-icon btn-primary"><i data-feather="home" class="icons"></i></a>
    </div>
        <%-- Display success message and redirect if exists --%>
        <% String success = (String) request.getAttribute("success"); %>
        <% if (success != null) { %>
            <script>
                alert("<%= success %>");
                window.location.href = "index.jsp"; 
            </script>
        <% } %>

        <section class="p-3 p-md-4 p-xl-5">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 col-md-9 col-lg-7 col-xl-6 col-xxl-5">
                        <div class="card border-0 shadow-sm rounded-4" style="margin-top: 170px">
                            <div class="card-body p-3 p-md-4 p-xl-5">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="mb-5">
                                            <h3>Reset password</h3>
                                        </div>
                                    </div>
                                </div>
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
                                                <button class="btn bsb-btn-2xl btn-primary" type="submit">Reset password</button>
                                            </div>
                                        </div>
                                    </div>
                                    <p class="text-danger">${mess}</p>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

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
         <script src="<%= request.getContextPath() %>/assets/js/bootstrap.bundle.min.js"></script>
    <!-- Icons -->
    <script src="<%= request.getContextPath() %>/assets/js/feather.min.js"></script>
    <!-- Main Js -->
    <script src="<%= request.getContextPath() %>/assets/js/app.js"></script>
    </body>
</html>
