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

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">


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

                <c:set value="${sessionScope.staff}" var="staff"/>
                <jsp:include page="template/header.jsp"/>

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
                                        class="form-control border-dark me-2"
                                        type="text"
                                        placeholder="Search by phone number"
                                        id="phoneSearch"
                                        name="phoneSearch"
                                        />
                                    <a href="customer-manager?page=1" class="btn border-dark me-2">Reset</a>
                                    <button class="btn btn-danger" type="submit">Search</button>
                                </form>
                            </div>
                        </div>
                        <!-- Customer Table -->
                        <style>

                            .table {
                                border-collapse: separate; /* Để box-shadow hiển thị đúng */
                                border-spacing: 0; /* Loại bỏ khoảng cách giữa các ô */
                                border-radius: 20px; /* Bo góc */
                                overflow: hidden; /* Đảm bảo góc bo tròn không bị mất */
                                background: white; /* Đảm bảo bảng có màu nền để bóng đẹp hơn */
                                box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.15),
                                    0px 0px 8px rgba(0, 0, 0, 0.1); /* Hiệu ứng đổ bóng xung quanh */
                            }
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
                                width: 100px;
                                height: 100px;
                                object-fit: cover; /* Giữ tỷ lệ ảnh, không méo */
                            }
                            .modal-body .row div {
                                text-align: left !important; /* Đưa dữ liệu về căn trái */
                            }

                            .head {
                                font-weight: bold;
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

                            .table-responsive {
                                padding : 1rem;
                                text-align: center;
                            }

                            .photo {
                                border-radius: 50%;
                            }

                            .profile-header {
                                background-color: #f8f9fa;
                                padding: 20px;
                                border-bottom: 1px solid #dee2e6;
                            }
                            .profile-image {
                                border-radius: 10%;
                                width: 150px;
                                height: 150px;
                            }
                            .profile-info {
                                padding: 20px;
                            }
                            .profile-info p {
                                margin-bottom: 10px;
                            }

                        </style>

                        <div class="table-responsive mt-4">
                            <table class="table table-striped table-bordered table-hover">
                                <thead class="thead-dark bg-dark text-white" style ="text-align:center">
                                    <tr>
                                        <th>ID</th>
                                        <th>Image</th>
                                        <th>Firstname</th>
                                        <th>Lastname</th>
                                        <th>Phone</th>
                                        <th>Gender</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty customerList}">
                                            <tr>
                                                <td colspan="100%" class="text-center text-muted fw-bold">Search list is empty</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="customer" items="${customerList}">
                                                <tr>
                                                    <td>${customer.id}</td>
                                                    <td style="max-width: 100px;">
                                                        <div class ="photo-div">
                                                            <img src="${customer.image}" class="photo" alt="Customer Image" />
                                                        </div>
                                                    </td>
                                                    <td class="text-truncate" style="max-width: 120px;">${customer.firstname}</td>
                                                    <td class="text-truncate" style="max-width: 120px;">${customer.lastname}</td>
                                                    <td class="text-truncate" style="max-width: 120px;">${customer.phone}</td>
                                                    <td>${customer.gender}</td>
                                                    <td class="text-center align-middle">
                                                        <div class="row justify-content-center">
                                                            <div class="col-auto">
                                                                <button type="button" class="btn btn-info btn-md" data-bs-toggle="modal"
                                                                        data-bs-target="#detailsModal${customer.id}">
                                                                    <i class="fas fa-eye"></i>
                                                                </button>
                                                            </div>
                                                            <div class="col-auto">
                                                                <button data-bs-toggle="modal" data-bs-target="#editModal${customer.id}" 
                                                                        class="btn btn-primary btn-md">
                                                                    <i class="fas fa-edit"></i>
                                                                </button>
                                                            </div>
                                                            <div class="col-auto">
                                                                <form action="customer-manager" method="post" id="deleteCustomer-${customer.id}">
                                                                    <input name="deleteId" value="${customer.id}" type="hidden">
                                                                    <button class="btn btn-danger btn-md" type="submit">
                                                                        <i class="fas fa-trash-alt"></i>
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </div>
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
                                            <div class="modal fade" id="detailsModal${customer.id}" tabindex="-1" aria-labelledby="detailsModalLabel${customer.id}" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header bg-danger text-white">
                                                            <h1 class="modal-title fs-5" id="detailsModalLabel${customer.id}">Customer's Detail</h1>
                                                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="profile-header text-center">
                                                                <img src="${customer.image}" alt="Customer Image" class="profile-image">
                                                                <h2>${customer.firstname} ${customer.lastname}</h2>
                                                                <p class="text-muted">Customer</p>
                                                            </div>
                                                            <div class="profile-info">
                                                                <p><strong>Id:</strong> ${customer.id}</p>
                                                                <p><strong>Email contact:</strong> ${customer.email}</p>
                                                                <p><strong>Address:</strong> ${customer.address}</p>
                                                                <p><strong>Phone:</strong> ${customer.phone}</p>
                                                                <p><strong>Date of Birth:</strong> ${customer.dob}</p>

                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn text-white bg-danger" data-bs-dismiss="modal">Close</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Pagination -->                 
                <nav aria-label="Page navigation" class="mt-4">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link text-danger" href="?page=${currentPage - 1}" tabindex="-1">Previous</a>
                        </li>

                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link text-red" href="?page=${i}">${i}</a>
                            </li>
                        </c:forEach>

                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link text-danger" href="?page=${currentPage + 1}">Next</a>
                        </li>
                    </ul>
                </nav>

                <!-- Footer Start -->
                <jsp:include page="template/footer.jsp"/>
                <!-- End -->
            </main>
            <!--End page-content-->

        </div>

        <script src ="resources/script/jquery-3.7.1.min.js"></script>
        <script>
            $(document).ready(function () {
                showToastrAfterReload();
                
                $('form[id^="deleteCustomer-"]').on('submit', function (event) {
                    event.preventDefault();

                    let form = $(this);
                    let customerId = form.find('input[name="deleteId"]').val();

                    if (confirm("Are you sure you want to delete this customer?")) {
                        $.ajax({
                            url: 'customer-manager',
                            type: 'POST',
                            data: {deleteId: customerId},
                            success: function (response) {
                                if (response.success) {
                                    showSuccessMessage("Success", "Deleted!");
                                    form.closest('tr').remove();
                                } else {
                                    showErrorMessage("Error", "Something wrong here");
                                }
                            },
                            error: function () {
                                showErrorMessage("Error", "Server is busy right now. Please try again later.");
                            }
                        });
                    }
                });

                $('form[id^="editCustomer-"]').on('submit', function (event) {
                    event.preventDefault(); // Chặn form submit mặc định

                    let form = $(this);
                    let customerId = form.find('input[name="updateId"]').val(); // Lấy ID từ input hidden
                    let formData = new FormData(this); // Lấy dữ liệu form (bao gồm file)

                    if (confirm("Are you sure you want to update this customer?")) {
                        $.ajax({
                            url: form.attr('action'), // Lấy URL action từ form
                            type: form.attr('method'), // Lấy method từ form
                            data: formData,
                            processData: false, // Không xử lý dữ liệu (FormData sẽ làm việc này)
                            contentType: false, // Để browser tự động chọn content type
                            success: function (response) {
                                if (response.success) {
                                    reloadWithMessage("success", "Success", "Edit successful");
                                } else {
                                    showErrorMessage("Error", response.message);
                                }
                            },
                            error: function () {
                                showErrorMessage("Error", "Server is busy right now. Please try again later.");
                            }
                        });
                    }
                });
            });
        </script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
        <script src="./resources/script/script.js"></script>
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