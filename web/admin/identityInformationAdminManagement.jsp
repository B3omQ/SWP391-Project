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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <link rel="stylesheet" href="https://unpkg.com/tippy.js@6/dist/tippy.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">



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
                                <h5 class="mb-0">Customer's Identity Management</h5>
                                <nav aria-label="breadcrumb" class="mt-2">
                                    <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item">
                                            <a href="index.html" class="text-decoration-none text-danger">SmartBanking</a>
                                        </li>
                                        <li class="breadcrumb-item active" aria-current="page">Customers</li>
                                        <li class="breadcrumb-item active" aria-current="page">Identity</li>
                                    </ul>
                                </nav>
                            </div>

                            <!-- Search form -->
                            <div class="row align-items-center mb-4">
                                <form id="sort" action="identity-customer-management" method="get" class="d-flex">
                                    <select class="form-select me-2" name="pendingStatus" onchange="onChangeSubmit('sort')" id="pendingStatus">
                                        <option value="Pending" ${currentStatus == 'Pending' || empty currentStatus ? 'selected' : ''}>Pending</option>
                                        <option value="Denied" ${currentStatus == 'Denied' ? 'selected' : ''}>Denied</option>
                                        <option value="Approved" ${currentStatus == 'Approved' ? 'selected' : ''}>Approved</option>
                                    </select>
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
                            .border-custome {
                                border-color : #c9c9c9;
                            }
                        </style>

                        <div class="table-responsive mt-4">
                            <table class="table table-striped table-bordered table-hover">
                                <thead class="thead-dark bg-dark text-white" style ="text-align:center">
                                    <tr>
                                        <th>ID</th>
                                        <th>Ảnh đại diện</th>
                                        <th>Họ và tên</th>
                                        <th>Hồ sơ danh tính</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty identityList}">
                                            <tr>
                                                <td colspan="100%" class="text-center text-muted fw-bold">Search list is empty</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="identity" items="${identityList}">
                                                <tr>
                                                    <td>${identity.id}</td>
                                                    <td style="max-width: 100px;">
                                                        <div class ="photo-div">
                                                            <img src="${identity.cusId.image}" class="photo" alt="Customer Image" />
                                                        </div>
                                                    </td>
                                                    <td class="text-truncate" style="max-width: 120px;">${identity.cusId.fullname}</td>                                                   
                                                    <td class="text-center align-middle">
                                                        <div class="row justify-content-center">                                                            
                                                            <div class="col-auto">
                                                                <button data-bs-toggle="modal" data-bs-target="#editModal${identity.id}" 
                                                                        class="btn btn-primary btn-md">
                                                                    <i class="fas fa-eye"></i>
                                                                </button>
                                                            </div>
                                                        </div>
                                                        <jsp:include page="template/editVerifyIdentityCustomer.jsp">
                                                            <jsp:param name="id" value="${identity.id}"/>
                                                            <jsp:param name="identityCardFrontSide" value="${identity.identityCardFrontSide}"/>
                                                            <jsp:param name="identityCardBackSide" value="${identity.identityCardBackSide}" />
                                                            <jsp:param name="portraitPhoto" value="${identity.portraitPhoto}" />
                                                            <jsp:param name="fullnameCustomer" value="${identity.cusId.fullname}" />
                                                            <jsp:param name="pendingStatus" value="${identity.pendingStatus}" />
                                                        </jsp:include>           
                                                    </td>
                                                </tr>
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
                        <!-- Nút First và Previous -->
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link text-danger" href="?page=1&pendingStatus=${currentStatus}&recordsPerPage=${currentRecords}">First</a>
                        </li>
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link text-danger" href="?page=${currentPage - 1}&pendingStatus=${currentStatus}&recordsPerPage=${currentRecords}">Previous</a>
                        </li>

                        <c:choose>
                            <c:when test="${totalPages > 10}">
                                <c:choose>
                                    <c:when test="${currentPage <= 3}">
                                        <c:forEach var="i" begin="1" end="4">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link text-red" href="?page=${i}&pendingStatus=${currentStatus}&recordsPerPage=${currentRecords}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <li class="page-item disabled"><a class="page-link">...</a></li>
                                        <li class="page-item">
                                            <a class="page-link text-red" href="?page=${totalPages}&pendingStatus=${currentStatus}&recordsPerPage=${currentRecords}">${totalPages}</a>
                                        </li>
                                    </c:when>

                                    <c:when test="${currentPage == 4}">
                                        <c:forEach var="i" begin="1" end="5">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link text-red" href="?page=${i}&pendingStatus=${currentStatus}&recordsPerPage=${currentRecords}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <li class="page-item disabled"><a class="page-link">...</a></li>
                                        <li class="page-item">
                                            <a class="page-link text-red" href="?page=${totalPages}&pendingStatus=${currentStatus}&recordsPerPage=${currentRecords}">${totalPages}</a>
                                        </li>
                                    </c:when>


                                    <c:when test="${currentPage > totalPages - 3}">
                                        <li class="page-item">
                                            <a class="page-link text-red" href="?page=1&pendingStatus=${currentStatus}&recordsPerPage=${currentRecords}">1</a>
                                        </li>
                                        <li class="page-item disabled"><a class="page-link">...</a></li>
                                            <c:forEach var="i" begin="${totalPages - 3}" end="${totalPages}">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link text-red" href="?page=${i}&pendingStatus=${currentStatus}&recordsPerPage=${currentRecords}">${i}</a>
                                            </li>
                                        </c:forEach>
                                    </c:when>

                                    <c:when test="${currentPage == totalPages - 3}">
                                        <li class="page-item">
                                            <a class="page-link text-red" href="?page=1&pendingStatus=${currentStatus}&recordsPerPage=${currentRecords}">1</a>
                                        </li>
                                        <li class="page-item disabled"><a class="page-link">...</a></li>
                                            <c:forEach var="i" begin="${totalPages - 4}" end="${totalPages}">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link text-red" href="?page=${i}&pendingStatus=${currentStatus}&recordsPerPage=${currentRecords}">${i}</a>
                                            </li>
                                        </c:forEach>
                                    </c:when>

                                    <c:otherwise>
                                        <li class="page-item">
                                            <a class="page-link text-red" href="?page=1&pendingStatus=${currentStatus}&recordsPerPage=${currentRecords}">1</a>
                                        </li>
                                        <li class="page-item disabled"><a class="page-link">...</a></li>

                                        <c:forEach var="i" begin="${currentPage - 1}" end="${currentPage + 1}">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link text-red" href="?page=${i}&pendingStatus=${currentStatus}&recordsPerPage=${currentRecords}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <li class="page-item disabled"><a class="page-link">...</a></li>
                                        <li class="page-item">
                                            <a class="page-link text-red" href="?page=${totalPages}&pendingStatus=${currentStatus}&recordsPerPage=${currentRecords}">${totalPages}</a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>

                            <c:otherwise>
                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link text-red" href="?page=${i}&pendingStatus=${currentStatus}&recordsPerPage=${currentRecords}">${i}</a>
                                    </li>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>

                        <!-- Nút Next và Last -->
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link text-danger" href="?page=${currentPage + 1}&pendingStatus=${currentStatus}&recordsPerPage=${currentRecords}">Next</a>
                        </li>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link text-danger" href="?page=${totalPages}&pendingStatus=${currentStatus}&recordsPerPage=${currentRecords}">Last</a>
                        </li>
                    </ul>
                    <c:choose>
                        <c:when test="${totalPages > 10}">
                            <form method="get" action="identity-customer-management" class="d-flex justify-content-center mt-2">
                                <input type="hidden" name="pendingStatus" value="${currentStatus}">
                                <input type="hidden" name="recordsPerPage" value="${currentRecords}">
                                <input type="number" name="page" min="1" max="${totalPages}" 
                                       placeholder="Page" 
                                       class="form-control w-auto text-center px-2">
                                <button type="submit" class="btn btn-primary ms-2">Go</button>
                            </form>
                        </c:when>
                    </c:choose>                
                </nav>
                <!-- Footer Start -->
                <jsp:include page="template/footer.jsp"/>
                <!-- End -->
            </main>
            <!--End page-content-->

        </div>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
        <script src ="resources/script/jquery-3.7.1.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
        <script src="https://unpkg.com/@popperjs/core@2"></script>
        <script src="https://unpkg.com/tippy.js@6"></script>
        <script src="./resources/script/script.js"></script>
        <!-- page-wrapper -->
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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
                                        const urlParams = new URLSearchParams(window.location.search);
                                        if (urlParams.get("notify") === "success") {
                                            Swal.fire({
                                                title: "Thành công!",
                                                text: "Đã gửi phê duyệt thành công.",
                                                icon: "success"
                                            }).then(() => {

                                                window.history.replaceState(null, null, window.location.pathname);
                                            });
                                        }
        </script>
    </body>

</html>