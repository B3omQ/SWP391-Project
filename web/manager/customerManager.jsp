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

                <jsp:include page="template/headbar.jsp"/>

                <div class="container-fluid">
                    <div class="layout-specing">
                        <!-- Header Section -->
                        <div class="row align-items-center">
                            <!-- Title & Breadcrumb -->
                            <div class="col-md-6">
                                <h5 class="mb-0">Customer Management</h5>
                                <nav aria-label="breadcrumb" class="mt-2">
                                    <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item">
                                            <a href="index.html" class="text-decoration-none text-danger">SmartBanking</a>
                                        </li>
                                        <li class="breadcrumb-item active" aria-current="page">Customers</li>
                                    </ul>
                                </nav>
                            </div>

                            <!-- Search form -->
                            <div class="col-md-6">
                                <form id="search" action="customer-manager" method="get" class="d-flex">
                                    <input
                                        value="${currentPhoneSearch}"
                                        class="form-control border-danger me-2"
                                        type="text"
                                        placeholder="Search by phone number"
                                        id="phoneSearch"
                                        name="phoneSearch"
                                        />
                                    <a href="customer-manager?page=1" class="btn btn-outline-danger me-2">Reset</a>
                                    <button class="btn btn-danger" type="submit">Search</button>
                                </form>
                            </div>
                        </div>
                        <!-- Customer Table -->
                        <style>
                            /* Cố định kích thước hàng */
                            .table tbody tr {
                                height: 60px; /* Đặt chiều cao hàng cố định */
                            }

                            /* Cột có nội dung dài sẽ bị cắt bớt với dấu "..." */
                            .table tbody td {
                                white-space: nowrap; /* Không xuống dòng */
                                overflow: hidden; /* Ẩn phần dư */
                                text-overflow: ellipsis; /* Hiển thị "..." nếu quá dài */
                                max-width: 150px; /* Giới hạn độ rộng */
                            }

                            /* Chỉnh lại ô hình ảnh */
                            .table img {
                                width: 150px;
                                height: 150px;
                                object-fit: cover; /* Giữ tỷ lệ ảnh, không méo */
                            }

                        </style>

                        <div class="table-responsive mt-4">
                            <table class="table table-striped table-bordered table-hover">
                                <thead class="thead-dark bg-danger text-white">
                                    <tr>
                                        <th>ID</th>
                                        <th>Image</th>
                                        <th>First Name</th>
                                        <th>Last Name</th>
                                        <th>Phone</th>
                                        <th>Gender</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="customer" items="${customerList}">
                                        <tr>
                                            <td>${customer.id}</td>
                                            <td class="text-truncate" style="max-width: 100px;">
                                                <img src="${customer.image}" alt="Customer Image" />
                                            </td>
                                            <td class="text-truncate" style="max-width: 120px;">${customer.firstname}</td>
                                            <td class="text-truncate" style="max-width: 120px;">${customer.lastname}</td>
                                            <td class="text-truncate" style="max-width: 120px;">${customer.phone}</td>
                                            <td>${customer.gender}</td>
                                            <td class="text-center align-middle">
                                                <button type="button" class="btn btn-info btn-sm" data-bs-toggle="modal"
                                                        data-bs-target="#detailsModal${customer.id}">
                                                    View
                                                </button>
                                                <button data-bs-toggle="modal" data-bs-target="#editModal${customer.id}" 
                                                        class="btn btn-primary btn-sm">
                                                    Update
                                                </button>
                                                <form onsubmit="deleteAlert(event)" style="display:inline-block" action="customer-manager" method="post">
                                                    <input name="deleteId" value="${customer.id}" type="hidden">
                                                    <button class="btn btn-danger btn-sm" type="submit">Delete</button>
                                                </form>
                                                <jsp:include page="template/editCustomer.jsp">
                                                    <jsp:param name="id" value="${customer.id}" />
                                                    <jsp:param name="email" value="${customer.email}" />
                                                    <jsp:param name="firstname" value="${customer.firstname}" />
                                                    <jsp:param name="lastname" value="${customer.lastname}" />
                                                    <jsp:param name="gender" value="${customer.gender}" />
                                                    <jsp:param name="dob" value="${customer.dob}" />
                                                    <jsp:param name="phone" value="${customer.phone}" />
                                                    <jsp:param name="address" value="${customer.address}" />
                                                </jsp:include>
                                            </td>

                                        </tr>

                                        <!-- Details Modal -->
                                    <div class="modal fade" id="detailsModal${customer.id}" tabindex="-1"
                                         aria-labelledby="detailsModalLabel${customer.id}" aria-hidden="true">
                                        <div class="modal-dialog modal-xl">
                                            <div class="modal-content">
                                                <div class="modal-header bg-danger text-white">
                                                    <h1 class="modal-title fs-5" id="detailsModalLabel${customer.id}">Customer's Detail</h1>
                                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                                            aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-md-6 text-center">
                                                            <img src="${customer.image}" width="300" height="300" 
                                                                 alt="Customer Image" class="img-fluid rounded" />
                                                        </div>
                                                        <div class="col-md-6">
                                                            <p><strong>Id: </strong>${customer.id}</p>
                                                            <p><strong>Username: </strong>${customer.username}</p>
                                                            <p><strong>Password: </strong>${customer.password}</p>
                                                            <p><strong>First Name: </strong>${customer.firstname}</p>
                                                            <p><strong>Last Name: </strong>${customer.lastname}</p>
                                                            <p><strong>Address: </strong>${customer.address}</p>
                                                            <p><strong>Phone: </strong>${customer.phone}</p>
                                                            <p><strong>Date of Birth: </strong>${customer.dob}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>


                        <!-- Pagination -->

                    </div>
                </div>
                <nav aria-label="Page navigation" class="mt-4">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link text-danger" href="?page=${currentPage - 1}" tabindex="-1">Previous</a>
                        </li>

                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link bg-danger text-white" href="?page=${i}">${i}</a>
                            </li>
                        </c:forEach>

                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link text-danger" href="?page=${currentPage + 1}">Next</a>
                        </li>
                    </ul>
                </nav>

                <!-- Footer Start -->
                <footer class="bg-white shadow py-3">
                    <div class="container-fluid">
                        <div class="row align-items-center">
                            <div class="col">
                                <div class="text-sm-start text-center">
                                    <p class="mb-0 text-muted">
                                        <script>document.write(new Date().getFullYear())</script> © Doctris. Design with <i
                                            class="mdi mdi-heart text-danger"></i> by <a href="../../../index.html"
                                            target="_blank" class="text-reset">Shreethemes</a>.
                                    </p>
                                </div>
                            </div><!--end col-->
                        </div><!--end row-->
                    </div><!--end container-->
                </footer><!--end footer-->
                <!-- End -->
            </main>
            <!--End page-content-->
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