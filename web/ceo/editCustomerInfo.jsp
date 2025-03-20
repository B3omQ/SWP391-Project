<!DOCTYPE html>
<html lang="en">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <head>
        <meta charset="utf-8" />
        <title>Doctris - Doctor Appointment Booking System</title>
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

            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <c:set value="${sessionScope.staff}" var="staff"/>
                <jsp:include page="template/header.jsp"/>

                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="row">
                            <div class="col-xl-9 col-lg-6 col-md-4">
                                <h5 class="mb-0">Banking System</h5>
                                <nav aria-label="breadcrumb" class="d-inline-block mt-2">
                                    <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item"><a href="index.html">Ceo</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Edit Customer Information</li>
                                    </ul>
                                </nav>
                            </div><!--end col-->


                        </div><!--end row-->



                        <div class="row justify-content-center">
                            <div class="col-10 mt-4">
                                <div class="card login-page bg-white shadow mt-4 rounded border-0">
                                    <div class="card-body">
                                        <h4 class="text-center">Edit</h4>

                                        <!-- Hiển thị thông báo lỗi nếu có -->
                                        <c:if test="${not empty errorMessages}">
                                            <div class="alert alert-danger">
                                                <ul>
                                                    <c:forEach var="error" items="${errorMessages}">
                                                        <li>${error}</li>
                                                        </c:forEach>
                                                </ul>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty successMessage}">
                                            <div class="alert alert-success text-center">
                                                ${successMessage}
                                            </div>
                                        </c:if>

                                        <form action="<%= request.getContextPath() %>/editCustomerInfo" method="post" enctype="multipart/form-data" class="login-form mt-4">
                                            <div class="row">
                                                <!-- ID -->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label>ID</label>
                                                        <input type="text" class="form-control" name="id" value="${customer.id}" readonly>
                                                        <c:if test="${not empty errorID}">
                                                            <span class="text-danger">${errorID}</span>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <!-- Image -->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label>Image</label>
                                                        <div>
                                                            <img src="<%= request.getContextPath() %>/${customer.image}" width="100" height="" alt=""/>
                                                        </div>
                                                        <div class="md-5" style="padding-top: 10px">
                                                            <input type="file" class="form-control-file" name="image" accept=".jpg,.png,.jpeg"> 
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- Username -->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label>Username</label>
                                                        <input type="text" class="form-control" name="username" value="${customer.username}">
                                                        <c:if test="${not empty errorUsername}">
                                                            <span class="text-danger">${errorUsername}</span>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <!-- Email -->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label>Email</label>
                                                        <input type="email" class="form-control" name="email" value="${customer.email}">
                                                        <c:if test="${not empty errorEmail}">
                                                            <span class="text-danger">${errorEmail}</span>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <!-- First Name -->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label>First Name</label>
                                                        <input type="text" class="form-control" name="firstName" value="${customer.firstname}">
                                                        <c:if test="${not empty errorFirstName}">
                                                            <span class="text-danger">${errorFirstName}</span>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <!-- Last Name -->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label>Last Name</label>
                                                        <input type="text" class="form-control" name="lastName" value="${customer.lastname}">
                                                        <c:if test="${not empty errorLastName}">
                                                            <span class="text-danger">${errorLastName}</span>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <!-- Gender -->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label>Gender</label>
                                                        <select id="role" class="form-control" name="gender" required>
                                                            <option value="Male" <c:if test="${customer.gender == 'Male'}">selected</c:if>>Male</option>
                                                            <option value="Female" <c:if test="${customer.gender == 'Female'}">selected</c:if>>Female</option>
                                                            </select>
                                                        </div>
                                                    <c:if test="${not empty errorGender}">
                                                        <span class="text-danger">${errorGender}</span>
                                                    </c:if>
                                                </div>
                                                <!-- DoB -->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label for="dob">DoB:</label>
                                                        <input type="date" id="dob" name="dob" value="${customer.dob}" required />
                                                    </div>
                                                    <c:if test="${not empty errorDob}">
                                                        <span class="text-danger">${errorDob}</span>
                                                    </c:if>
                                                </div>
                                                <!-- Phone Number -->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label>Phone Number</label>
                                                        <input type="text" class="form-control" name="phone" value="${customer.phone}">
                                                        <c:if test="${not empty errorPhone}">
                                                            <span class="text-danger">${errorPhone}</span>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <!-- Address -->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label>Address</label>
                                                        <input type="text" class="form-control" name="address" value="${customer.address}">
                                                        <c:if test="${not empty errorAddress}">
                                                            <span class="text-danger">${errorAddress}</span>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <!-- Wallet -->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label>Wallet</label>
                                                        <input type="number" step="0.01" class="form-control" name="wallet" value="${customer.wallet}" required>
                                                        <c:if test="${not empty errorWallet}">
                                                            <span class="text-danger">${errorWallet}</span>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <div class="row justify-content-center">
                                                    <div class="col-md-10 text-center">
                                                        <button type="submit" class="btn btn-primary">Confirm</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>           


                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div><!--end container-->

                <!-- Footer Start -->
                <jsp:include page="template/footer.jsp"/>
                <!-- End -->
            </main>
            <!--End page-content" -->
        </div>
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