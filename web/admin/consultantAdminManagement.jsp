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
                                <form id="search" action="consultant-admin-management" method="get" class="d-flex">
                                    <input
                                        value="${currentPhoneSearch}"
                                        class="form-control border-custome me-2"
                                        type="text"
                                        placeholder="Search by phone number"
                                        id="phoneSearch"
                                        name="phoneSearch"
                                        />
                                    <select class="btn border-custome me-2" name="recordsPerPage" onchange="onChangeSubmit('search')" id="entries">
                                        <option value="3" ${currentRecords == 3 ? 'selected' : ''}>3</option>
                                        <option value="5" ${currentRecords == 5 ? 'selected' : ''}>5</option>
                                        <option value="8" ${currentRecords == 8 ? 'selected' : ''}>8</option>
                                        <option value="10" ${currentRecords == 10 ? 'selected' : ''}>10</option>
                                        <option value="12" ${currentRecords == 12 ? 'selected' : ''}>12</option>
                                        <option value="15" ${currentRecords == 15 ? 'selected' : ''}>15</option>
                                    </select>
                                    <a href="?page=1&phoneSearch=&recordsPerPage=${currentRecords}" class="btn border-custome me-2">Reset</a>
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
                            .border-custome {
                                border-color : #c9c9c9;
                            }
                        </style>

                        <div class="table-responsive mt-4">
                            <table class="table table-striped table-bordered table-hover">
                                <thead class="thead-dark bg-dark text-white" style ="text-align:center">
                                    <tr>
                                        <th>ID</th>
                                        <th>Image</th>
                                        <th>Fullname</th>
                                        <th>Phone</th>
                                        <th>Gender</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty staffList}">
                                            <tr>
                                                <td colspan="100%" class="text-center text-muted fw-bold">Search list is empty</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="consultant" items="${staffList}">
                                                <tr>
                                                    <td>${consultant.id}</td>
                                                    <td style="max-width: 100px;">
                                                        <div class ="photo-div">
                                                            <img src="${consultant.image}" class="photo" alt="Customer Image" />
                                                        </div>
                                                    </td>
                                                    <td class="text-truncate" style="max-width: 120px;">${consultant.fullname}</td>
                                                    <td class="text-truncate" style="max-width: 120px;">${consultant.phone}</td>
                                                    <td>${consultant.gender}</td>
                                                    <td class="text-center align-middle">
                                                        <div class="row justify-content-center">
                                                            <div class="col-auto">
                                                                <button type="button" class="btn btn-info btn-md" data-bs-toggle="modal"
                                                                        data-bs-target="#detailsModal${consultant.id}">
                                                                    <i class="fas fa-eye"></i>
                                                                </button>
                                                            </div>
                                                            <div class="col-auto">
                                                                <button data-bs-toggle="modal" data-bs-target="#editModal${consultant.id}" 
                                                                        class="btn btn-primary btn-md">
                                                                    <i class="fas fa-edit"></i>
                                                                </button>
                                                            </div>
                                                            <div class="col-auto">
                                                                <form action="consultant-admin-management" method="post" id="deleteConsultant-${consultant.id}">
                                                                    <input name="deleteId" value="${consultant.id}" type="hidden">
                                                                    <button class="btn btn-danger btn-md" type="submit">
                                                                        <i class="fas fa-trash-alt"></i>
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                        <jsp:include page="template/editConsultant.jsp">
                                                            <jsp:param name="id" value="${consultant.id}" />
                                                            <jsp:param name="email" value="${consultant.email}" />
                                                            <jsp:param name="firstname" value="${consultant.firstname}" />
                                                            <jsp:param name="lastname" value="${consultant.lastname}" />
                                                            <jsp:param name="gender" value="${consultant.gender}" />
                                                            <jsp:param name="dob" value="${consultant.dob}" />
                                                            <jsp:param name="phone" value="${consultant.phone}" />
                                                            <jsp:param name="address" value="${consultant.address}" />
                                                        </jsp:include>           
                                                    </td>
                                                </tr>
                                                <!-- Details Modal -->
                                            <div class="modal fade" id="detailsModal${consultant.id}" tabindex="-1" aria-labelledby="detailsModalLabel${consultant.id}" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header bg-danger text-white">
                                                            <h1 class="modal-title fs-5" id="detailsModalLabel${consultant.id}">Customer's Detail</h1>
                                                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="profile-header text-center">
                                                                <img src="${consultant.image}" alt="Customer Image" class="profile-image">
                                                                <h2>${consultant.firstname} ${consultant.lastname}</h2>
                                                                <p class="text-muted">Customer</p>
                                                            </div>
                                                            <div class="profile-info">
                                                                <p><strong>Id:</strong> ${consultant.id}</p>
                                                                <p><strong>Email contact:</strong> ${consultant.email}</p>
                                                                <p><strong>Address:</strong> ${consultant.address}</p>
                                                                <p><strong>Phone:</strong> ${consultant.phone}</p>
                                                                <p><strong>Date of Birth:</strong> ${consultant.dob}</p>

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
                        <!-- Nút First và Previous -->
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link text-danger" href="?page=1&phoneSearch=${currentPhoneSearch}&recordsPerPage=${currentRecords}">First</a>
                        </li>
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link text-danger" href="?page=${currentPage - 1}&phoneSearch=${currentPhoneSearch}&recordsPerPage=${currentRecords}">Previous</a>
                        </li>

                        <c:choose>
                            <c:when test="${totalPages > 10}">
                                <c:choose>
                                    <c:when test="${currentPage <= 3}">
                                        <c:forEach var="i" begin="1" end="4">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link text-red" href="?page=${i}&phoneSearch=${currentPhoneSearch}&recordsPerPage=${currentRecords}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <li class="page-item disabled"><a class="page-link">...</a></li>
                                        <li class="page-item">
                                            <a class="page-link text-red" href="?page=${totalPages}&phoneSearch=${currentPhoneSearch}&recordsPerPage=${currentRecords}">${totalPages}</a>
                                        </li>
                                    </c:when>

                                    <c:when test="${currentPage == 4}">
                                        <c:forEach var="i" begin="1" end="5">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link text-red" href="?page=${i}&phoneSearch=${currentPhoneSearch}&recordsPerPage=${currentRecords}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <li class="page-item disabled"><a class="page-link">...</a></li>
                                        <li class="page-item">
                                            <a class="page-link text-red" href="?page=${totalPages}&phoneSearch=${currentPhoneSearch}&recordsPerPage=${currentRecords}">${totalPages}</a>
                                        </li>
                                    </c:when>


                                    <c:when test="${currentPage > totalPages - 3}">
                                        <li class="page-item">
                                            <a class="page-link text-red" href="?page=1&phoneSearch=${currentPhoneSearch}&recordsPerPage=${currentRecords}">1</a>
                                        </li>
                                        <li class="page-item disabled"><a class="page-link">...</a></li>
                                            <c:forEach var="i" begin="${totalPages - 3}" end="${totalPages}">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link text-red" href="?page=${i}&phoneSearch=${currentPhoneSearch}&recordsPerPage=${currentRecords}">${i}</a>
                                            </li>
                                        </c:forEach>
                                    </c:when>

                                    <c:when test="${currentPage == totalPages - 3}">
                                        <li class="page-item">
                                            <a class="page-link text-red" href="?page=1&phoneSearch=${currentPhoneSearch}&recordsPerPage=${currentRecords}">1</a>
                                        </li>
                                        <li class="page-item disabled"><a class="page-link">...</a></li>
                                            <c:forEach var="i" begin="${totalPages - 4}" end="${totalPages}">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link text-red" href="?page=${i}&phoneSearch=${currentPhoneSearch}&recordsPerPage=${currentRecords}">${i}</a>
                                            </li>
                                        </c:forEach>
                                    </c:when>

                                    <c:otherwise>
                                        <li class="page-item">
                                            <a class="page-link text-red" href="?page=1&phoneSearch=${currentPhoneSearch}&recordsPerPage=${currentRecords}">1</a>
                                        </li>
                                        <li class="page-item disabled"><a class="page-link">...</a></li>

                                        <c:forEach var="i" begin="${currentPage - 1}" end="${currentPage + 1}">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link text-red" href="?page=${i}&phoneSearch=${currentPhoneSearch}&recordsPerPage=${currentRecords}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <li class="page-item disabled"><a class="page-link">...</a></li>
                                        <li class="page-item">
                                            <a class="page-link text-red" href="?page=${totalPages}&phoneSearch=${currentPhoneSearch}&recordsPerPage=${currentRecords}">${totalPages}</a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>

                            <c:otherwise>
                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link text-red" href="?page=${i}&phoneSearch=${currentPhoneSearch}&recordsPerPage=${currentRecords}">${i}</a>
                                    </li>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>

                        <!-- Nút Next và Last -->
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link text-danger" href="?page=${currentPage + 1}&phoneSearch=${currentPhoneSearch}&recordsPerPage=${currentRecords}">Next</a>
                        </li>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link text-danger" href="?page=${totalPages}&phoneSearch=${currentPhoneSearch}&recordsPerPage=${currentRecords}">Last</a>
                        </li>
                    </ul>
                    <c:choose>
                        <c:when test="${totalPages > 10}">
                            <form method="get" action="consultant-admin-management" class="d-flex justify-content-center mt-2">
                                <input type="hidden" name="phoneSearch" value="${currentPhoneSearch}">
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

        <script src ="resources/script/jquery-3.7.1.min.js"></script>
        <script>
                                        document.addEventListener("DOMContentLoaded", function () {
                                            tippy('#entries', {
                                                content: "Entries",
                                                animation: 'fade',
                                                duration: [300, 300],
                                                placement: 'top',
                                                theme: 'light-border'
                                            });

                                            tippy('#newImg', {
                                                content: "Only accept file jpg, jpeg, png, gif and size smaller than 5mbs",
                                                animation: 'fade',
                                                duration: [300, 300],
                                                placement: 'top',
                                                theme: 'light-border'
                                            });

                                            tippy('#newPhone', {
                                                content: "Phone must be 10 - 11 digits number",
                                                animation: 'fade',
                                                duration: [300, 300],
                                                placement: 'top',
                                                theme: 'light-border'
                                            });
                                        });

                                        function validatePhoneSearch() {
                                            var phoneInput = document.getElementById("phoneSearch");
                                            var phoneValue = phoneInput.value.trim();
                                            var phonePattern = /^\d{10,11}$/; // Chỉ chứa 10-11 số

                                            if (!phonePattern.test(phoneValue)) {
                                                showErrorMessage("Error", "Invalid phone number")
                                                phoneInput.focus();
                                                return false;
                                            }
                                            return true;
                                        }

                                        document.getElementById("search").addEventListener("submit", function (event) {
                                            if (!validatePhoneSearch()) {
                                                event.preventDefault(); // Ngăn chặn form submit nếu không hợp lệ
                                            }
                                        });

                                        $(document).ready(function () {
                                            showToastrAfterReload();

                                            $('form[id^="deleteConsultant-"]').on('submit', function (event) {
                                                event.preventDefault();

                                                let form = $(this);
                                                let consultantId = form.find('input[name="deleteId"]').val();

                                                if (confirm("Are you sure you want to delete this customer?")) {
                                                    $.ajax({
                                                        url: 'consultant-admin-management',
                                                        type: 'POST',
                                                        data: {deleteId: consultantId},
                                                        success: function (response) {
                                                            if (response.success) {
                                                                reloadWithMessage("success", "Success", "Deleted!");
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

                                            $('form[id^="editConsultant-"]').on('submit', function (event) {
                                                event.preventDefault(); // Chặn form submit mặc định

                                                let form = $(this);
                                                let consultantId = form.find('input[name="updateId"]').val(); // Lấy ID từ input hidden
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
        <script src="https://unpkg.com/@popperjs/core@2"></script>
        <script src="https://unpkg.com/tippy.js@6"></script>
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