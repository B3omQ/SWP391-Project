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
                            <div class="col-md-4">
                                <h5 class="mb-0">Trang thông tin định danh khách hàng</h5>
                                <nav aria-label="breadcrumb" class="mt-2">
                                    <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item">
                                            <a href="index.html" class="text-decoration-none text-danger">SmartBanking</a>
                                        </li>
                                        <li class="breadcrumb-item active" aria-current="page">Danh sách khách hàng</li>
                                        <li class="breadcrumb-item active" aria-current="page">Danh sách thông tin định danh</li>
                                    </ul>
                                </nav>
                            </div>

                            <!-- Search form -->
                            <div class="col-md-8">
                                <form id="sort" action="identity-customer-management" method="get" class="d-flex">
                                    <select class="form-control border-custome me-2" name="pendingStatus" onchange="onChangeSubmit('sort')" id="pendingStatus">
                                        <option value="Pending" ${currentStatus == 'Pending' || empty currentStatus ? 'selected' : ''}>Đang chờ</option>
                                        <option value="Denied" ${currentStatus == 'Denied' ? 'selected' : ''}>Từ chối</option>
                                        <option value="Approved" ${currentStatus == 'Approved' ? 'selected' : ''}>Đã duyệt</option>
                                    </select>
                                    <input
                                        value="${currentPhoneSearch}"
                                        class="form-control border-custome me-2"
                                        type="text"
                                        placeholder="Tìm kiếm bằng số điện thoại"
                                        id="phoneSearch"
                                        name="phoneSearch"
                                        />
                                    <input
                                        value="${currentIdentityCardNumberSearch}"
                                        class="form-control border-custome me-2"
                                        type="text"
                                        placeholder="Tìm kiếm bằng số CCCD/CMND"
                                        id="identityCardNumberSearch"
                                        name="identityCardNumberSearch"
                                        />
                                    <a href="?page=1&phoneSearch=&identityCardNumberSearch=&recordsPerPage=${currentRecords}" class="btn border-custome me-2">Reset</a>
                                    <button class="btn btn-danger" type="submit">Tìm</button>
                                </form>
                            </div>
                        </div>
                        <!-- Customer Table -->
                        <style>

                            /* CSS cho bảng */
                            .table_component {
                                overflow-x: auto; /* Đảm bảo bảng cuộn ngang trên màn hình nhỏ */
                                width: 100%;
                                margin-top: 1.5rem;
                            }

                            .table_component table {
                                width: 100%;
                                border-collapse: collapse; /* Loại bỏ khoảng cách giữa các ô */
                                text-align: center;
                                background-color: #fff;
                                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05); /* Thêm bóng nhẹ để nổi bật */
                            }

                            .table_component th,
                            .table_component td {
                                padding: 12px 15px; /* Tăng padding để thoáng hơn */
                                border: 2px solid #cfcfd3; /* Viền nhẹ nhàng hơn #cfcfd3 */
                                vertical-align: middle; /* Căn giữa theo chiều dọc */
                            }

                            .table_component th {
                                background-color: #f8f9fa; /* Màu nền nhẹ cho tiêu đề */
                                color: #333; /* Màu chữ đậm hơn */
                                font-weight: 600; /* Chữ đậm cho tiêu đề */
                            }

                            .table_component td {
                                color: #555; /* Màu chữ nhẹ nhàng hơn */
                            }

                            /* Chỉnh ô chứa ảnh */
                            .table_component .photo-div {
                                display: flex;
                                justify-content: center;
                                align-items: center;
                            }

                            .table_component .photo {
                                width: 100px; /* Giảm kích thước ảnh để vừa vặn hơn */
                                height: 100px;
                                object-fit: cover; /* Đảm bảo ảnh không bị méo */
                                border-radius: 5px; /* Bo góc nhẹ cho ảnh */
                                border: 1px solid #dee2e6; /* Viền nhẹ cho ảnh */
                            }

                            /* Tối ưu chiều rộng cột */
                            .table_component td.text-truncate {
                                max-width: 150px; /* Tăng chiều rộng tối đa cho cột Fullname và Phone */
                                white-space: nowrap; /* Ngăn xuống dòng */
                                overflow: hidden;
                                text-overflow: ellipsis; /* Thêm dấu ... khi bị cắt */
                            }

                            /* Hiệu ứng hover cho hàng */
                            .table_component tbody tr:hover {
                                background-color: #f5f6f8; /* Màu nền khi hover */
                                transition: background-color 0.2s ease; /* Hiệu ứng mượt mà */
                            }

                            /* Tùy chỉnh nút trong cột Actions */
                            .table_component .btn {
                                font-size: 0.9rem;
                                margin: 0 2px; /* Khoảng cách giữa các nút */
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

                        <div class="table_component mt-4">
                            <table>
                                <thead style ="text-align:center">
                                    <tr>
                                        <th>ID</th>
                                        <th>Ảnh đại diện</th>
                                        <th>Họ và tên</th>
                                        <th>Số điện thoại</th>
                                        <th>Số CCCD/CMND</th>
                                        <th>Giới tính</th>
                                        <th>Trạng thái</th>
                                        <th>Hồ sơ danh tính</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty identityList}">
                                            <tr>
                                                <td colspan="100%" class="text-center text-muted fw-bold">Danh sách trống.</td>
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
                                                    <td class="text-truncate" style="max-width: 120px;">${identity.cusId.phone}</td>    
                                                    <td class="text-truncate" style="max-width: 120px;">${identity.identityCardNumber}</td>    
                                                    <td class="text-truncate" style="max-width: 120px;">${identity.cusId.gender}</td> 
                                                    <td class="text-truncate" style="max-width: 120px;">${identity.pendingStatus}</td>   
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
                                                            <jsp:param name="identityCardNumber" value="${identity.identityCardNumber}" />
                                                            <jsp:param name="portraitPhoto" value="${identity.portraitPhoto}" />
                                                            <jsp:param name="fullnameCustomer" value="${identity.cusId.fullname}" />
                                                            <jsp:param name="pendingStatus" value="${identity.pendingStatus}" />
                                                            <jsp:param name="reasonReject" value="${identity.reasonReject}" />
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
                        <!-- Nút Đầu và Trước -->
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link text-danger" href="?page=1&pendingStatus=${currentStatus}&recordsPerPage=${currentRecords}">Đầu</a>
                        </li>
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link text-danger" href="?page=${currentPage - 1}&pendingStatus=${currentStatus}&recordsPerPage=${currentRecords}">Trước</a>
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

                        <!-- Nút Tiếp và Sau -->
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link text-danger" href="?page=${currentPage + 1}&pendingStatus=${currentStatus}&recordsPerPage=${currentRecords}">Tiếp</a>
                        </li>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link text-danger" href="?page=${totalPages}&pendingStatus=${currentStatus}&recordsPerPage=${currentRecords}">Sau</a>
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
                                <button type="submit" class="btn btn-primary ms-2">Đi</button>
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