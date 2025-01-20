<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset page</title>
        <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://unpkg.com/bs-brain@2.0.4/components/logins/login-6/assets/css/login-6.css">
    </head>
    <body class="bg-primary">

        <%-- Display success message and redirect if exists --%>
        <% String success = (String) request.getAttribute("success"); %>
        <% if (success != null) { %>
            <script>
                alert("<%= success %>");
                window.location.href = "index.html"; 
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
    </body>
</html>
