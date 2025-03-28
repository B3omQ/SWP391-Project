<!DOCTYPE html>
<html lang="en">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                            <div class="col-xl-6 col-lg-6 col-md-4">
                                <h5 class="mb-0">Banking System</h5>
                                <nav aria-label="breadcrumb" class="d-inline-block mt-2">
                                    <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item"><a href="index.html">Ceo</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Thông tin cá nhân</li>
                                    </ul>
                                </nav>
                            </div><!--end col-->
                        </div><!--end row-->
                        <div class="col-xl-8 col-lg-12 col-md-7 mt-4 pt-2 mt-sm-0 pt-sm-0">
                            <div class="rounded shadow mt-4">
                                <div class="p-4 border-bottom">
                                    <h5 class="mb-0">Thông tin cá nhân :</h5>
                                </div>
                                <c:if test="${not empty errorMessages}">
                                    <div class="alert alert-danger">
                                        <ul>
                                            <c:forEach var="error" items="${errorMessages}">
                                                <li>${error}</li>
                                                </c:forEach>
                                        </ul>
                                    </div>
                                </c:if>

                                <form action="<%= request.getContextPath() %>/ceoProfileServlet" method="post" enctype="multipart/form-data">
                                    <div class="p-4 border-bottom">
                                        <div class="row align-items-center">
                                            <label class="form-label">Ảnh đại diện</label>
                                            <div class="col-lg-2 col-md-4">
                                                <img src="<%= request.getContextPath() %>/${staff.image}" class="avatar avatar-md-md rounded-pill shadow mx-auto d-block" alt="">
                                            </div><!--end col-->
                                            <div class="md-5" style="padding-top: 10px">
                                                <input type="file" class="form-control-file" name="image" accept=".jpg,.png,.jpeg"> 
                                            </div>
                                        </div><!--end row-->
                                    </div>
                                    <div class="p-4">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Tên đăng nhập</label>
                                                    <input name="username" type="text" class="form-control" value="${staff.username}">
                                                </div>
                                            </div><!--end col-->
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Họ</label>
                                                    <input name="firstname" type="text" class="form-control" value="${staff.firstname}">
                                                </div>
                                            </div><!--end col-->

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Tên</label>
                                                    <input name="lastname" type="text" class="form-control" value="${staff.lastname}">
                                                </div>
                                            </div><!--end col-->

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Giới tính</label>
                                                    <select class="form-control" name="gender" required>
                                                        <option value="Male" <c:if test="${staff.gender == 'Male'}">selected</c:if>>Male</option>
                                                        <option value="Female" <c:if test="${staff.gender == 'Female'}">selected</c:if>>Female</option>
                                                        </select>
                                                    </div>
                                                </div> <!--end col-->

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Ngày sinh</label>
                                                        <input type="date" class="form-control" name="dob" value="${staff.dob}" readonly=""/>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Email</label>
                                                    <input name="email" type="email" class="form-control" value="${staff.email}" readonly="">
                                                </div> 
                                            </div><!--end col-->

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Số điện thoại</label>
                                                    <input name="phone" type="text" class="form-control" value="${staff.phone}" readonly="">
                                                </div>                                                                               
                                            </div><!--end col-->

                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Địa chỉ</label>
                                                    <input type="text" class="form-control" name="address" value="${staff.getAddress()}">
                                                </div>
                                            </div>
                                        </div><!--end row-->

                                        <div class="row">
                                            <div class="col-sm-12">
                                                <input type="submit" id="submit" name="send" class="btn btn-primary" value="Lưu">
                                            </div><!--end col-->
                                        </div><!--end row-->
                                    </div>
                                </form>

                            </div>

                        </div><!--end col-->
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
        <div class="modal fade" id="viewprofile" tabindex="-1" aria-labelledby="viewProfileLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header border-bottom p-3">
                        <h5 class="modal-title" id="viewProfileLabel">Customer Profile</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-3 pt-4">
                        <div class="d-flex align-items-center">
                            <img id="viewAvatar" src="" class="avatar avatar-medium rounded-pill me-3" alt="Avatar">
                            <div>
                                <h5 class="mb-0" id="viewName"></h5>
                            </div>
                        </div>

                        <div class="row mt-4">
                            <div class="col-md-6">
                                <ul class="list-unstyled mb-0">
                                    <li class="d-flex mb-2">
                                        <span class="text-muted col-5">Staff ID:</span>
                                        <span class="col-7" id="viewId"></span>
                                    </li>
                                    <li class="d-flex mb-2">
                                        <span class="text-muted col-5">Date of Birth:</span>
                                        <span class="col-7" id="viewDob"></span>
                                    </li>
                                    <li class="d-flex mb-2">
                                        <span class="text-muted col-5">Gender:</span>
                                        <span class="col-7" id="viewGender"></span>
                                    </li>
                                    <li class="d-flex mb-2">
                                        <span class="text-muted col-5">Wallet</span>
                                        <span class="col-7" id="viewWallet"></span>
                                    </li>
                                </ul>
                            </div>

                            <div class="col-md-6">
                                <ul class="list-unstyled mb-0">
                                    <li class="d-flex mb-2">
                                        <span class="text-muted col-5">Email:</span>
                                        <span class="col-7" id="viewEmail"></span>
                                    </li>
                                    <li class="d-flex mb-2">
                                        <span class="text-muted col-5">Phone:</span>
                                        <span class="col-7" id="viewPhone"></span>
                                    </li>
                                    <li class="d-flex mb-2">
                                        <span class="text-muted col-5">Address:</span>
                                        <span class="col-7" id="viewAddress"></span>
                                    </li>
                                    <li class="d-flex mb-2">
                                        <span class="text-muted col-5">Username:</span>
                                        <span class="col-7" id="viewUsername"></span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
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