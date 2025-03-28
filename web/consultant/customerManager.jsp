<%-- 
    Document   : customerManager
    Created on : Feb 5, 2025, 4:58:02 PM
    Author     : LAPTOP
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <!-- DataTables CSS & jQuery -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
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
        <!-- Date picker -->
        <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/flatpickr.min.css">
        <link href="<%= request.getContextPath() %>/assets/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="<%= request.getContextPath() %>/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="<%= request.getContextPath() %>/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <!-- Css -->
        <link href="<%= request.getContextPath() %>/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <!-- DataTables CSS & jQuery -->
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

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
        <nav id="sidebar" class="sidebar-wrapper">
            <jsp:include page="template/sidebar.jsp"/>
            <!-- sidebar-content  -->
            <ul class="sidebar-footer list-unstyled mb-0">
                <li class="list-inline-item mb-0 ms-1">
                    <a href="#" class="btn btn-icon btn-pills btn-soft-primary">
                        <i class="uil uil-comment icons"></i>
                    </a>
                </li>
            </ul>
        </nav>
        <!-- sidebar-wrapper  -->

        <!-- Start Page Content -->
        <main class="page-content bg-light">
            <jsp:include page="template/header.jsp"/>
            <div class="container-fluid">
                <div class="layout-specing">
                    <div class="row">
                        <div class="col-xl-9 col-lg-6 col-md-4">
                            <h5 class="mb-0">Customer</h5>
                            <nav aria-label="breadcrumb" class="d-inline-block mt-2">
                                <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="index.html">Consultant</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Customer Manager</li>
                                </ul>
                            </nav>
                        </div><!--end col-->
                        <!--
                                                <div class="col-xl-3 col-lg-6 col-md-8 mt-4 mt-md-0">
                                                    <div class="justify-content-md-end">
                                                        <form>
                                                            <div class="justify-content-between">
                                                                <div class="">
                                                                    <div class="d-grid">
                                                                        <a href="#" class="btn btn-primary w-100" data-bs-toggle="modal"
                                                                           data-bs-target="#CreateAccountform">Create Account</a>
                                                                    </div>
                                                                </div>end col
                                                            </div>end row
                                                        </form>end form
                                                    </div>
                                                </div>end col-->
                    </div><!--end row-->

                    <div class="row">
                        <div class="col-12 mt-4">
                            <div class ="col-12">
                                <form action="consultant-customer" method="post" class="mt-4 form-create-account" enctype="multipart/form-data">
                                    <div class="modal fade" id="CreateAccountform" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="addUserModalLabel">Thêm mới Account</h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="container">
                                                    <input value="add" type="hidden" name="add">
                                                    <div class="col-md-12">
                                                        <div class="mb-3 mt-4">
                                                            <label for="otherImage">Image</label>
                                                            <input type="file" id="otherImage" name="otherImage" class="form-control-file">
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="mb-3">
                                                            <label class="form-label">Username <span class="text-danger">*</span></label>
                                                            <input type="text" class="form-control username" placeholder="Username" name="username" required="">
                                                            <small class="text-danger usernameError" style="display: none;">Username không được chứa space hoặc kí tự đặc biệt.</small>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="mb-3">                                               
                                                            <label class="form-label">First name <span class="text-danger">*</span></label>
                                                            <input type="text" class="form-control firstname" placeholder="First Name" name="firstname" required="">
                                                            <small class="text-danger firstnameError" style="display: none;">First name không được chứa số và kí tự được biệt</small>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="mb-3">                                                 
                                                            <label class="form-label">Last name <span class="text-danger">*</span></label>
                                                            <input type="text" class="form-control lastname" placeholder="Last Name" name="lastname" required="">
                                                            <small class="text-danger lastnameError" style="display: none;">Last name không được chứa số và kí tự được biệt</small>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="mb-3">
                                                            <label class="form-label">Your Email <span class="text-danger">*</span></label>
                                                            <input type="email" id="email" class="form-control email" name="email" placeholder="Email" required="">
                                                            <small class="text-danger emailError" style="display: none;">Email không đúng format</small>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="mb-3">
                                                            <label class="form-label">Day of birth <span class="text-danger">*</span></label>
                                                            <input type="date" class="form-control dob" name="dob" required="">
                                                            <small class="dobError text-danger" style="display: none;">Customer phải ít nhất 18 tuổi trở lên.</small>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="mb-3">
                                                            <label class="form-label">Gender <span class="text-danger">*</span></label>
                                                            <select type="text" class="form-control" name="gender" required="">
                                                                <option value="Male">Male</option>
                                                                <option value="Female">Female</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <!--                                                    <div class="col-md-12">
                                                                                                            <div class="mb-3">
                                                                                                                <label class="form-label">Password <span class="text-danger">*</span></label>
                                                                                                                <input type="password" class="form-control password" placeholder="Password" name="password" required="">
                                                                                                                <small class="passwordError text-danger" style="display: none;">Password phải có ít nhất 8 kí tự, chữ cái in hoa, số và 1 kí tự đặc biệt</small>
                                                                                                            </div>
                                                                                                        </div>-->
                                                    <div class="col-md-12">
                                                        <div class="mb-3">
                                                            <label class="form-label">Address <span class="text-danger">*</span></label>
                                                            <input type="text" class="form-control" placeholder="Address" name="address" required="">
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="mb-3">
                                                            <label class="form-label">Phone Number <span class="text-danger">*</span></label>
                                                            <input type="tel" class="form-control phone" name="phone" placeholder="Enter phone number" required="" pattern="0[1-9]\d{7,8}" title="">
                                                            <small class="text-danger phoneError" style="display: none;">Vui lòng nhập đúng format số điện thoại (9-10 số và không kí tự đặc biệt)</small>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <div class="">
                                                            <button type="submit" class="btn btn-primary w-100">CREATE</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <div class="d-flex w-100">
                                    <form action="consultant-customer" method="get" class="mb-3 form-search-account">
                                        <small class="text-danger phoneError" style="display: none;">Vui lòng nhập đúng format số điện thoại (9-10 số và không kí tự đặc biệt)</small>
                                        <div class="d-flex align-items-center gap-2">  
                                            <div class="">
                                                <input type="tel" id="phoneSearch" name="phoneSearch" class="form-control w-full phone" placeholder="Search for phone number" pattern="0[1-9]\d{7,8}">  
                                            </div>
                                            <div class="">
                                                <input type="tel" class="form-control w-30" placeholder="Số Customer hiện" name="recordPerPage">
                                            </div>
                                            <div class="">
                                                <button type="submit" class="btn btn-primary">Search</button>
                                            </div>
                                        </div>
                                    </form>
                                    <div class="ms-auto">
                                        <a href="#" class="btn btn-primary" data-bs-toggle="modal"
                                           data-bs-target="#CreateAccountform">Create Account</a>
                                    </div>
                                </div>
                                <div class="table-responsive bg-white shadow rounded">
                                    <table class="table table-bordered table-hover">
                                        <thead class="thead-dark">
                                            <tr>
                                                <th>#</th>
                                                <th>Image</th>
                                                <th>Name</th>
                                                <th>Email</th>
                                                <th>Address</th>
                                                <th>Phone</th>
                                                <th>Wallet</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                            <c:if test="${empty customers}">
                                                <tr>
                                                    <td colspan="8" class="text-center">Không tìm thấy tài khoản nào</td>
                                                </tr>
                                            </c:if>


                                            <c:forEach var="customer" items="${customers}">
                                                <tr>
                                                    <td>${customer.id}</td>
                                                    <td><img src="${customer.image}" width="100" height="100" alt="alt" /></td>
                                                    <td>${customer.username}</td>
                                                    <td>${customer.email}</td>
                                                    <td>${customer.address}</td>
                                                    <td>${customer.phone}</td>
                                                    <td>${customer.wallet} VND</td>

                                                    <td class="">
                                                        <!-- Edit button -->
                                                        <button type="button" class="btn btn-warning" data-bs-toggle="modal"
                                                                data-bs-target="#UpdateAccountform-${customer.id}">Edit</button>
                                                        <!-- Delete button -->
<!--                                                        <form onsubmit="deleteAlert(event)" action ="consultant-customer" method="post" style ="display:inline-block">
                                                            <input name="deleteId" value="${customer.id}" type="hidden">
                                                            <button class = "btn btn-danger">Delete</button> 
                                                        </form>-->
                                                        <!-- View profile button -->
                                                        <button type="button" class="btn btn-info" data-bs-toggle="modal"
                                                                data-bs-target="#ViewAccountModal-${customer.id}">View</button>
                                                        <div class="modal fade" id="ViewAccountModal-${customer.id}" tabindex="-1" aria-labelledby="viewModalLabel-${customer.id}" aria-hidden="true">
                                                            <div class="modal-dialog">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h1 class="modal-title fs-5" id="viewModalLabel-${customer.id}">Customer Details</h1>
                                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <!-- Customer Details -->
                                                                        <div class="mb-2">
                                                                            <img src="${customer.image}" width="200" height="auto" alt="alt" />
                                                                        </div>
                                                                        <div class="mb-2">
                                                                            <strong>Username:</strong> ${customer.username}
                                                                        </div>

                                                                        <div class="mb-2">
                                                                            <strong>First Name:</strong> ${customer.firstname}
                                                                        </div>

                                                                        <div class="mb-2">
                                                                            <strong>Last Name:</strong> ${customer.lastname}
                                                                        </div>

                                                                        <div class="mb-2">
                                                                            <strong>Email:</strong> ${customer.email}
                                                                        </div>

                                                                        <div class="mb-2">
                                                                            <strong>Day of Birth:</strong> ${customer.dob}
                                                                        </div>

                                                                        <div class="mb-2">
                                                                            <strong>Gender:</strong> ${customer.gender}
                                                                        </div>

                                                                        <div class="mb-2">
                                                                            <strong>Address:</strong> ${customer.address}
                                                                        </div>

                                                                        <div class="mb-2">
                                                                            <strong>Phone Number:</strong> ${customer.phone}
                                                                        </div>

                                                                        <div class="mb-2">
                                                                            <strong>Password:</strong> 
                                                                            <c:choose>
                                                                                <c:when test="${empty customer.password}">
                                                                                    <em>(password người dùng này đã được đổi)</em>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    ${customer.password} <em>(password người dùng chưa được đổi)</em>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </div>

                                                                        <div class="mb-2">
                                                                            <strong>Wallet Balance:</strong> ${customer.wallet}
                                                                        </div>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <form action="consultant-customer" method="post" class="mt-4 form-update-account" enctype="multipart/form-data">
                                                            <div class="modal fade" id="UpdateAccountform-${customer.id}" tabindex="-1" 
                                                                 aria-labelledby="updateModalLabel-${customer.id}" aria-hidden="true">
                                                                <div class="modal-dialog">
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <h1 class="modal-title fs-5" id="updateModalLabel-${customer.id}">Thay đổi thông tin Account</h1>
                                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                        </div>
                                                                        <div class="container">
                                                                            <input name="changeinfoId" value="${customer.id}" type="hidden">
                                                                            <div class="col-md-12">
                                                                                <div class="mb-3 mt-4">
                                                                                    <label for="otherImage">Image</label>
                                                                                    <input type="file" id="newImg-${customer.id}" name="newImg" class="form-control-file">
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-12">
                                                                                <div class="mb-3 mt-4">
                                                                                    <label class="form-label">Username <span class="text-danger">*</span></label>
                                                                                    <input type="text" class="form-control username" value="${customer.username}" name="username" required="">
                                                                                    <small class="text-danger usernameError" style="display: none;">Username không được chứa space hoặc kí tự đặc biệt.</small>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-6">
                                                                                <div class="mb-3">                                               
                                                                                    <label class="form-label">First name <span class="text-danger">*</span></label>
                                                                                    <input type="text" class="form-control firstname" value="${customer.firstname}" placeholder="First Name" name="firstname" required="">
                                                                                    <small class="text-danger firstnameError" style="display: none;">First name không được chứa số và kí tự được biệt</small>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-6">
                                                                                <div class="mb-3">                                                 
                                                                                    <label class="form-label">Last name <span class="text-danger">*</span></label>
                                                                                    <input type="text" class="form-control lastname" value="${customer.lastname}" placeholder="Last Name" name="lastname" required="">
                                                                                    <small class="text-danger lastnameError" style="display: none;">Last name không được chứa số và kí tự được biệt</small>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-12">
                                                                                <div class="mb-3">
                                                                                    <label class="form-label">Your Email <span class="text-danger">*</span></label>
                                                                                    <input type="email" class="form-control email" name="email" value="">
                                                                                    <small class="text-danger emailError" style="display: none;">Email không đúng format</small>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-12">
                                                                                <div class="mb-3">
                                                                                    <label class="form-label">Day of birth <span class="text-danger">*</span></label>
                                                                                    <input type="date" class="form-control dob" name="dob" value="${customer.dob}" required="">
                                                                                    <small class="dobError text-danger" style="display: none;">Customer phải ít nhất 18 tuổi trở lên.</small>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-12">
                                                                                <div class="mb-3">
                                                                                    <label class="form-label">Gender <span class="text-danger">*</span></label>
                                                                                    <select class="form-control gender" name="gender" required>
                                                                                        <option value="Male" ${customer.gender == 'Male' ? 'selected' : ''}>Male</option>
                                                                                        <option value="Female" ${customer.gender == 'Female' ? 'selected' : ''}>Female</option>
                                                                                    </select>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-12">
                                                                                <div class="mb-3">
                                                                                    <label class="form-label">Address <span class="text-danger">*</span></label>
                                                                                    <input type="text" class="form-control address" placeholder="Address" value="${customer.address}" name="address" required="">
                                                                                    <small class="text-danger addressError" style="display: none;">Address không được chứa kí tự được biệt</small>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-12">
                                                                                <div class="mb-3">
                                                                                    <label class="form-label">Phone number <span class="text-danger">*</span></label>
                                                                                    <input type="tel" class="form-control phone" name="phoneNumber" placeholder="Phone number" value="" pattern="0[1-9]\d{7,8}">
                                                                                    <small class="text-danger phoneError" style="display: none;">Vui lòng nhập đúng format số điện thoại (9-10 số và không kí tự đặc biệt)</small>
                                                                                </div>
                                                                            </div>
                                                                            <div class="modal-footer">
                                                                                <button type="submit" class="btn btn-warning">Edit</button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <script>
                                    document.querySelectorAll(".form-create-account, .form-update-account, .form-search-account").forEach(function (form) {
                                        // Username Validation
                                        form.querySelectorAll(".username").forEach(function (input) {
                                            input.addEventListener("input", function () {
                                                const username = this.value;
                                                const usernamePattern = /^[\p{L}0-9]+$/u;
                                                const errorMsg = form.querySelector(".usernameError");

                                                if (!usernamePattern.test(username)) {
                                                    errorMsg.style.display = "block";
                                                    this.setCustomValidity("Username must not contain spaces or special characters.");
                                                } else {
                                                    errorMsg.style.display = "none";
                                                    this.setCustomValidity("");
                                                }
                                            });
                                        });

                                        // First Name Validation
                                        form.querySelectorAll(".firstname").forEach(function (input) {
                                            input.addEventListener("input", function () {
                                                const firstname = this.value;
                                                const namePattern = /^[\p{L}0-9]+$/u;
                                                const errorMsg = form.querySelector(".firstnameError");

                                                if (!namePattern.test(firstname)) {
                                                    errorMsg.style.display = "block";
                                                    this.setCustomValidity("First name must only contain letters.");
                                                } else {
                                                    errorMsg.style.display = "none";
                                                    this.setCustomValidity("");
                                                    this.value = capitalize(firstname); // Capitalize the first letter
                                                }
                                            });
                                        });

                                        // Last Name Validation
                                        form.querySelectorAll(".lastname").forEach(function (input) {
                                            input.addEventListener("input", function () {
                                                const lastname = this.value;
                                                const namePattern = /^[\p{L}0-9]+$/u;
                                                const errorMsg = form.querySelector(".lastnameError");

                                                if (!namePattern.test(lastname)) {
                                                    errorMsg.style.display = "block";
                                                    this.setCustomValidity("Last name must only contain letters.");
                                                } else {
                                                    errorMsg.style.display = "none";
                                                    this.setCustomValidity("");
                                                    this.value = capitalize(lastname); // Capitalize the first letter
                                                }
                                            });
                                        });

                                        // Phone Validation
                                        form.querySelectorAll(".phone").forEach(function (input) {
                                            input.addEventListener("input", function () {
                                                let phoneInput = this.value;
                                                let phonePattern = /^0[1-9]\d{7,8}$/;
                                                let errorMsg = form.querySelector(".phoneError");

                                                if (phonePattern.test(phoneInput)) {
                                                    this.setCustomValidity("");
                                                    errorMsg.style.display = "none";
                                                } else {
                                                    this.setCustomValidity("Phone number không đúng format");
                                                    errorMsg.style.display = "block";
                                                }
                                            });
                                        });

                                        // Email Validation
                                        form.querySelectorAll(".email").forEach(function (input) {
                                            input.addEventListener("input", function () {
                                                let email = this.value;
                                                let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                                                let errorMsg = form.querySelector(".emailError");

                                                if (emailPattern.test(email)) {
                                                    this.setCustomValidity(""); // ✅ Allow form submission
                                                    errorMsg.style.display = "none"; // ✅ Hide error message
                                                } else {
                                                    this.setCustomValidity("Email không đúng format"); // ❌ Prevent form submission
                                                    errorMsg.style.display = "block"; // ❌ Show error message
                                                }
                                            });
                                        });

                                        // Date of Birth Validation (18+)
                                        form.querySelectorAll(".dob").forEach(function (input) {
                                            input.addEventListener("change", function () {
                                                const dobInput = this.value;
                                                const dobError = form.querySelector(".dobError");

                                                if (dobInput) {
                                                    const dob = new Date(dobInput);
                                                    const today = new Date();
                                                    const age = today.getFullYear() - dob.getFullYear();
                                                    const monthDiff = today.getMonth() - dob.getMonth();
                                                    const dayDiff = today.getDate() - dob.getDate();

                                                    const actualAge = (monthDiff < 0 || (monthDiff === 0 && dayDiff < 0)) ? age - 1 : age;

                                                    if (actualAge < 18) {
                                                        dobError.style.display = "block";
                                                        this.setCustomValidity("You must be at least 18 years old.");
                                                    } else {
                                                        dobError.style.display = "none";
                                                        this.setCustomValidity("");
                                                    }
                                                }
                                            });
                                        });
                                    });
                                    form.querySelectorAll(".password").forEach(function (input) {
                                        input.addEventListener("input", function () {
                                            const password = this.value;
                                            const passwordPattern = /^[A-Z](?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{7,}$/;
                                            const errorMsg = form.querySelector(".passwordError");

                                            if (passwordPattern.test(password)) {
                                                this.setCustomValidity("");
                                                errorMsg.style.display = "none";
                                            } else {
                                                this.setCustomValidity("Password must be at least 8 characters long, start with an uppercase letter, include at least one number, and one special character.");
                                                errorMsg.style.display = "block";
                                            }
                                        });
                                    });
                                </script>
                                <script>
                                    $(document).ready(function () {
                                        $(".form-update-account, .form-create-account").submit(function (event) {
                                            event.preventDefault(); // Stop default form submission

                                            var formData = new FormData(this); // Collect form data

                                            $.ajax({
                                                url: "consultant-customer", // Servlet URL
                                                type: "POST",
                                                data: formData,
                                                processData: false,
                                                contentType: false,
                                                success: function (response) {
                                                    if (response === "errorPhoneExist") {
                                                        alert("Số điện thoại đã có người sử dụng, vui lòng nhập số điện thoại khác.");
                                                    } else if (response === "errorEmailexist") {
                                                        alert("Email đã có người sử dụng, vui lòng nhập email khác.");
                                                    } else if (response === "errorImageSize") {
                                                        alert("Image lớn hơn 5mb");
                                                    } else if (response === "errorImageType") {
                                                        alert("Image không đúng định dạng jpg, png, jpeg");
                                                    } else {
                                                        alert("Tài khoản được cập nhật thành công!");
                                                        location.reload();
                                                    }
                                                },
                                                error: function () {
                                                    alert("Có lỗi xảy ra, vui lòng thử lại.");
                                                }
                                            });
                                        });
                                    });
                                </script>
                            </div>
                        </div>

                        <div class="row text-center">
                            <!-- PAGINATION START -->
                            <div class="col-12 mt-4">
                                <div class="d-md-flex align-items-center text-center justify-content-between">
                                    <span class="text-muted me-3"></span>
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination justify-content-center">
                                            <!-- Previous Button -->
                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link" 
                                                   href="?page=${currentPage - 1}&recordPerPage=${recordPerPage}&phoneSearch=${phoneSearch}" 
                                                   tabindex="-1">Previous</a>
                                            </li>

                                            <!-- Page Numbers -->
                                            <c:forEach var="i" begin="1" end="${totalPages}">
                                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                    <a class="page-link" 
                                                       href="?page=${i}&recordPerPage=${recordPerPage}&phoneSearch=${phoneSearch}">${i}</a>
                                                </li>
                                            </c:forEach>

                                            <!-- Next Button -->
                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link" 
                                                   href="?page=${currentPage + 1}&recordPerPage=${recordPerPage}&phoneSearch=${phoneSearch}">Next</a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </div><!--end col-->
                            <!-- PAGINATION END -->
                        </div><!--end row-->
                    </div>
                </div><!--end container-->

                <!-- Footer Start -->
                <jsp:include page="template/footer.jsp"/>
                <!-- End -->
        </main>
        <!--End page-content" -->
    </div>
    <!-- page-wrapper -->

    <!-- Offcanvas Start -->

    <!-- javascript -->
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
