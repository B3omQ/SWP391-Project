<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
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

        <!-- Back to home button -->
        <div class="back-to-home rounded d-none d-sm-block">
            <a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-icon btn-primary">
                <i data-feather="home" class="icons"></i>
            </a>
        </div>

        <!-- Login Section -->
        <section class="bg-home d-flex bg-light align-items-center" style="background: url('<%= request.getContextPath() %>/assets/images/bg/bg-lines-one.png') center;">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-8">
                        <img src="<%= request.getContextPath() %>/assets/images/logo-dark.png" height="24" class="mx-auto d-block" alt="Logo">
                        <div class="card login-page bg-white shadow mt-4 rounded border-0">
                            <div class="card-body">
                                <h4 class="text-center">Login</h4>
                                <!-- Error Message -->
                                <%
          String errorAccount = (String) session.getAttribute("errorAccount");
          if (errorAccount != null) {
                                %>
                                <div class="alert alert-danger text-center"><%= errorAccount %></div>
                                <%
                                        session.removeAttribute("errorAccount");  
                                    }
                                %>

                                <!-- Login Form -->
                                <form action="<%= request.getContextPath() %>/AuthServlet?action=login" method="POST" class="login-form mt-4">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Your Email <span class="text-danger">*</span></label>
                                                <input type="email" class="form-control" placeholder="Email" name="email" required>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="mb-3 position-relative">
                                                <label class="form-label">Password <span class="text-danger">*</span></label>
                                                <input type="password" class="form-control" placeholder="Password" name="password" id="password" required>
                                                <span class="position-absolute top-50 end-0 translate-middle-y pe-3 cursor-pointer" onclick="togglePassword()" style="padding-top: 30px;">
                                                    <i id="togglePasswordIcon" class="mdi mdi-eye-outline"></i>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="d-flex justify-content-between">
                                                <div class="mb-3">
                                                    <div class="form-check">
                                                        <input class="form-check-input align-middle" type="checkbox" value="on" name="remember" id="remember-check">
                                                        <label class="form-check-label" for="remember-check">Remember me</label>
                                                    </div>
                                                </div>
                                                <a href="<%= request.getContextPath() %>/auth/template/requestPassword.jsp" class="text-dark h6 mb-0">Forgot password?</a>
                                            </div>
                                        </div>
                                        <div class="col-lg-12 mb-0">
                                            <div class="d-grid">
                                                <button class="btn btn-primary" type="submit">Login</button>
                                            </div>
                                        </div>

                                        <div class="col-lg-12 mt-3 text-center">
                                            <h6 class="text-muted">Or</h6>
                                        </div>  
                                        <div class="col-12 mt-3">
                                            <div class="d-grid">
                                                <!-- Ch?nh s?a ???ng d?n Google OAuth -->
                                                <a href="https://accounts.google.com/o/oauth2/auth?scope=email+profile+openid&redirect_uri=http://localhost:8080/BankingSystem/AuthServlet?action=loginGG&response_type=code&client_id=392132792045-5118009rsft2t9rc2q71n9b45pvh0gg0.apps.googleusercontent.com&approval_prompt=force
                                                   " class="btn btn-lg btn-danger">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-google" viewBox="0 0 16 16">
                                                    <path d="M15.545 6.558a9.42 9.42 0 0 1 .139 1.626c0 2.434-.87 4.492-2.384 5.885h.002C11.978 15.292 10.158 16 8 16A8 8 0 1 1 8 0a7.689 7.689 0 0 1 5.352 2.082l-2.284 2.284A4.347 4.347 0 0 0 8 3.166c-2.087 0-3.86 1.408-4.492 3.304a4.792 4.792 0 0 0 0 3.063h.003c.635 1.893 2.405 3.301 4.492 3.301 1.078 0 2.004-.276 2.722-.764h-.003a3.702 3.702 0 0 0 1.599-2.431H8v-3.08h7.545z" />
                                                    </svg>
                                                    <span class="ms-2 fs-6">Sign in with Google</span>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>
        </section>

        <!-- Javascript -->
        <script src="<%= request.getContextPath() %>/assets/js/bootstrap.bundle.min.js"></script>
        <script src="<%= request.getContextPath() %>/assets/js/feather.min.js"></script>
        <script src="<%= request.getContextPath() %>/assets/js/app.js"></script>
    </body>
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

</html>