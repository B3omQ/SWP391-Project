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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/elevatezoom/3.0.8/jquery.elevatezoom.min.js"></script>


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
                                <h5 class="mb-0">Trang dịch vụ khách hàng</h5>
                                <nav aria-label="breadcrumb" class="mt-2">
                                    <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item">
                                            <a href="#" class="text-decoration-none text-danger">SmartBanking</a>
                                        </li>
                                        <li class="breadcrumb-item">
                                            <a href="#" class="text-decoration-none text-danger">Dịch vụ khách hàng</a>
                                        </li>
                                        <li class="breadcrumb-item active" aria-current="page">Dịch vụ cho vay</li>
                                    </ul>
                                </nav>
                            </div>

                            <!-- Search form -->
                            <div class="col-md-6">
                                <form id="search" action="customer-loan-service-management" method="get" class="d-flex">
                                    <input
                                        value="${currentPhoneSearch}"
                                        class="form-control border-custome me-2"
                                        type="text"
                                        placeholder="Tìm kiếm bằng số điện thoại"
                                        id="phoneSearch"
                                        name="phoneSearch"
                                        />
                                    <select class="form-control border-custome me-2" name="pendingStatus" onchange="onChangeSubmit('search')" id="pendingStatus">
                                        <option value="Pending" ${currentStatus == 'Pending' || empty currentStatus ? 'selected' : ''}>Đang đợi</option>
                                        <option value="Denied" ${currentStatus == 'Denied' ? 'selected' : ''}>Từ chối</option>
                                        <option value="Approved" ${currentStatus == 'Approved' ? 'selected' : ''}>Phê duyệt</option>
                                    </select>
                                    <a href="?page=1&phoneSearch=&pendingStatus=&recordsPerPage=${currentRecords}" class="btn border-custome me-2">Reset</a>
                                    <button class="btn btn-danger" type="submit">Tìm</button>
                                </form>
                            </div>
                        </div>

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

                        </style>
                        <div class="table_component mt-4" role="region" tabindex="0">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Id</th>
                                        <th>Ảnh đại diện</th>
                                        <th>Họ và tên</th>
                                        <th>Giới tính</th>
                                        <th>Số điện thoại</th>
                                        <th>trạng thái</th>
                                        <th>Thông tin chi tiết</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="loan" items="${loanList}">
                                        <tr>
                                            <td>${loan.id}</td>
                                            <td style="max-width: 100px;">
                                                <div class ="photo-div">
                                                    <img src="${loan.cusId.image}" class="photo" alt="Customer Image" />
                                                </div>
                                            </td>
                                            <td>${loan.cusId.fullname}</td>
                                            <td>${loan.cusId.gender}</td>
                                            <td style="max-width: 100px;">${loan.cusId.phone}</td>
                                            <td style="max-width: 100px;">${loan.loanStatus}</td>
                                            <td class="text-center align-middle">
                                                <div class="row justify-content-center">                                                            
                                                    <div class="col-auto">
                                                        <button data-bs-toggle="modal" data-bs-target="#editModal${loan.id}" 
                                                                class="btn btn-primary btn-md">
                                                            <i class="fas fa-eye"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                                <jsp:include page="template/editApprovalCustomerLoanService.jsp">
                                                    <jsp:param name="id" value="${loan.id}"/>
                                                    <jsp:param name="customerId" value="${loan.cusId.id}"/>
                                                    <jsp:param name="customerFullname" value="${loan.cusId.fullname}"/>
                                                    <jsp:param name="customerDateOfBirth" value="${loan.cusId.dob}"/>
                                                    <jsp:param name="customerIncomeVertification" value="${loan.incomeVertification}"/>
                                                    <jsp:param name="customerEmail" value="${loan.cusId.email}"/>
                                                    <jsp:param name="customerPhone" value="${loan.cusId.phone}"/>
                                                    <jsp:param name="customerAddress" value="${loan.cusId.address}"/>
                                                    <jsp:param name="customerPhoto" value="${loan.cusId.image}"/>
                                                    <jsp:param name="pendingStatus" value="${loan.loanStatus}"/>
                                                </jsp:include>           
                                            </td>
                                        </tr> 
                                    </c:forEach>
                                </tbody>
                            </table>
                            <c:if test="${empty loanList}">
                                <div colspan="100%" class="text-center text-muted fw-bold mt-4">Search list is empty</div>
                            </c:if>
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
                            <form method="get" action="customer-admin-management" class="d-flex justify-content-center mt-2">
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

        <!--        <script>
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
        
                                                    $('form[id^="deleteCustomer-"]').on('submit', function (event) {
                                                        event.preventDefault();
        
                                                        let form = $(this);
                                                        let customerId = form.find('input[name="deleteId"]').val();
        
                                                        if (confirm("Are you sure you want to delete this customer?")) {
                                                            $.ajax({
                                                                url: 'customer-admin-management',
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
                </script>-->

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