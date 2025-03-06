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
                                        <li class="breadcrumb-item active" aria-current="page">Customer Management</li>
                                    </ul>
                                </nav>
                            </div><!--end col-->
                            <div class="col-xl-6 col-lg-6 col-md-8 mt-4 mt-md-0">
                                <div class="justify-content-md-end">
                                    <form action="<%= request.getContextPath() %>/customerManagement" method="get" id="RoleFilterList">
                                        <div class="row g-3 justify-content-between align-items-center">
                                            <!-- Search Input -->
                                            <div class="col-md-12 col-sm-12">
                                                <div class="input-group">
                                                    <input type="text" 
                                                           name="search" 
                                                           class="form-control" 
                                                           placeholder="Search name/email/phone"
                                                           value="${searchValue}">
                                                    <button type="submit" class="btn btn-primary">
                                                        <i class="uil uil-search"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <!-- Pagination Input -->
                                            <div class="col-md-6">
                                                <div class="mb-0 position-relative d-flex align-items-center justify-content-center">
                                                    <label class="form-label me-2 mb-0">Items/page:</label>
                                                    <div class="position-relative">
                                                        <input type="number" 
                                                               name="perPage" 
                                                               value="${perPage}"
                                                               class="form-control border-primary rounded-pill"
                                                               min="1"
                                                               step="1"
                                                               onchange="document.getElementById('RoleFilterList').submit()">
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </form>
                                </div>
                            </div><!--end col-->
                        </div><!--end row-->

                        <div class="row">
                            <div class="col-12 mt-4">

                                <form action="<%= request.getContextPath() %>/customerManagement" method="get">
                                    <div class="table-responsive bg-white shadow rounded">
                                        <table class="table table-bordered table-hover">
                                            <thead class="thead-dark">
                                                <tr>
                                                    <th>#</th>
                                                    <th>Avatar</th>
                                                    <th>Name</th>
                                                    <th>Gender</th>
                                                    <th>Email</th>                                                  
                                                    <th>Phone</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                                <c:if test="${empty customers}">
                                                    <tr>
                                                        <td colspan="8" class="text-center">No customers available.</td>
                                                    </tr>
                                                </c:if>


                                                <c:forEach var="customer" items="${customers}">
                                                    <tr>
                                                        <td>${customer.id}</td>
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <img src="${customer.image}" width="40" height="" alt="alt"/>
                                                            </div>
                                                        </td>
                                                        <td>${customer.firstname} ${customer.lastname}</td>
                                                        <td>${customer.gender}</td>
                                                        <td>${customer.email}</td>
                                                        <td>${customer.phone}</td>                                                       
                                                        <td>                              
                                                            <a href="#" class="btn btn-icon btn-pills btn-soft-primary" 
                                                               data-bs-toggle="modal" 
                                                               data-bs-target="#viewprofile"
                                                               data-id="${customer.id}"
                                                               data-username="${customer.username}"
                                                               data-image="${customer.image}"
                                                               data-firstname="${customer.firstname}"
                                                               data-lastname="${customer.lastname}"
                                                               data-gender="${customer.gender}"
                                                               data-email="${customer.email}"
                                                               data-phone="${customer.phone}"
                                                               data-dob="<fmt:parseDate value="${customer.dob}" type="date" pattern="yyyy-MM-dd" var="parsedDate" /> <fmt:formatDate value="${parsedDate}" type="date" pattern="dd/MM/yyyy" />"
                                                               data-address="${customer.getAddress()}"
                                                               data-wallet="${customer.wallet}">
                                                                <i class="uil uil-eye"></i>
                                                            </a>
                                                            <!-- Các nút khác -->
                                                            <!-- Các nút khác -->
                                                            <a href="editCustomerInfo?uid=${customer.id}" class="btn btn-icon btn-pills btn-soft-success"><i class="uil uil-pen"></i></a>
                                                            <button type="button" class="btn btn-icon btn-pills btn-soft-danger" onclick="deleteCustomer('${customer.id}')">
                                                                <i class="uil uil-trash"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <div class="row text-center">
                            <!-- PAGINATION START -->
                            <div class="col-12 mt-4">
                                <div class="d-md-flex align-items-center text-center justify-content-between">
                                    <span class="text-muted me-3">
                                        <c:if test="${page == endPage}">
                                            <c:if test="${(page - 1)* recordsPerPage + 1 == numberOfRecords}">
                                                Showing ${numberOfRecords} out of ${numberOfRecords}
                                            </c:if>
                                            <c:if test="${(page - 1)* recordsPerPage + 1 != numberOfRecords}">
                                                Showing ${(page - 1)* recordsPerPage + 1} - ${numberOfRecords} out of ${numberOfRecords}
                                            </c:if>    
                                        </c:if>
                                        <c:if test="${page != endPage}">
                                            Showing ${(page - 1)* recordsPerPage + 1} - ${page * recordsPerPage} out of ${numberOfRecords}
                                        </c:if>
                                    </span>                                  
                                    <span class="mx-3">
                                        <input type="text" style="text-align: right; max-width: 60px" value="${page}" class="form-control d-inline w-auto"                                               
                                               onchange="location.href = '${pageContext.request.contextPath}/customerManagement?page=' + this.value">
                                        / ${endPage}
                                    </span>
                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <!-- Previous -->
                                        <c:if test="${page != 1}">
                                            <li class="page-item"><a class="page-link" href="<%= request.getContextPath() %>/customerManagement?page=${page - 1}" aria-label="Previous">Prev</a></li>
                                            </c:if>  
                                        <!-- Current Page -->  
                                        <!-- Start process -->
                                        <c:if test="${endPage < 8}">
                                            <c:forEach var="i" begin="1" end="${endPage}">
                                                <li class="page-item ${page == i? "active" : ""}"><a class="page-link" href="<%= request.getContextPath() %>/customerManagement?page=${i}" aria-label="Pages">${i}</a></li>
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${endPage >= 8}">
                                            <li class="page-item ${page == 1? "active" : ""}"><a class="page-link" href="<%= request.getContextPath() %>/customerManagement?page=1" aria-label="Pages">1</a></li>
                                                <c:if test="${page < 4 || page > endPage - 3}">
                                                <li class="page-item ${page == 2? "active" : ""}"><a class="page-link" href="<%= request.getContextPath() %>/customerManagement?page=2" aria-label="Pages">2</a></li>
                                                <li class="page-item ${page == 3? "active" : ""}"><a class="page-link" href="<%= request.getContextPath() %>/customerManagement?page=3" aria-label="Pages">3</a></li>
                                                </c:if>
                                                <c:if test="${page > 3 && page < endPage - 2}">
                                                <li class="page-item"><span class="page-link" aria-label="Pages">...</span></li>
                                                <li class="page-item ${page == page - 1 ? "active" : ""}"><a class="page-link" href="<%= request.getContextPath() %>/customerManagement?page=${page - 1}" aria-label="Pages">${page - 1}</a></li>
                                                <li class="page-item ${page == page? "active" : ""}"><a class="page-link" href="<%= request.getContextPath() %>/customerManagement?page=${page}" aria-label="Pages">${page}</a></li>
                                                <li class="page-item ${page == page + 1 ? "active" : ""}"><a class="page-link" href="<%= request.getContextPath() %>/customerManagement?page=${page + 1}" aria-label="Pages">${page + 1}</a></li>
                                                <li class="page-item"><span class="page-link" aria-label="Pages">...</span></li>
                                                </c:if>
                                                <c:if test="${page < 4 || page > endPage - 3}">
                                                <li class="page-item"><span class="page-link" aria-label="Pages">...</span></li>
                                                <li class="page-item ${page == endPage - 2? "active" : ""}"><a class="page-link" href="<%= request.getContextPath() %>/customerManagement?page=${endPage - 2}" aria-label="Pages">${endPage - 2}</a></li>
                                                <li class="page-item ${page == endPage - 1? "active" : ""}"><a class="page-link" href="<%= request.getContextPath() %>/customerManagement?page=${endPage - 1}" aria-label="Pages">${endPage - 1}</a></li>
                                                </c:if> 
                                            <li class="page-item ${page == endPage? "active" : ""}"><a class="page-link" href="<%= request.getContextPath() %>/customerManagement?page=${endPage}" aria-label="Pages">${endPage}</a></li>
                                            </c:if>                                              
                                        <!-- End process -->
                                        <!-- Next -->
                                        <c:if test="${page lt endPage}">
                                            <li class="page-item"><a class="page-link" href="<%= request.getContextPath() %>/customerManagement?page=${page + 1}" aria-label="Next">Next</a></li>
                                            </c:if>
                                    </ul>
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
        <script>
                                            // Cập nhật script xử lý modal
                                            $('#viewprofile').on('show.bs.modal', function (event) {
                                                var button = $(event.relatedTarget);
                                                var modal = $(this);

                                                // Lấy tất cả dữ liệu từ data attributes
                                                var customerData = {
                                                    id: button.data('id'),
                                                    username: button.data('username'),
                                                    image: button.data('image'),
                                                    firstname: button.data('firstname'),
                                                    lastname: button.data('lastname'),
                                                    gender: button.data('gender'),
                                                    email: button.data('email'),
                                                    phone: button.data('phone'),
                                                    dob: button.data('dob'),
                                                    address: button.data('address'),
                                                    wallet: button.data('wallet')
                                                };
                                                var username = button.data('username');
                                                console.log('Username ' + username);

                                                // Điền dữ liệu vào modal
                                                modal.find('#viewId').text(customerData.id);
                                                modal.find('#viewUsername').text(customerData.username);
                                                modal.find('#viewName').text(customerData.firstname + ' ' + customerData.lastname);
                                                modal.find('#viewAvatar').attr('src', customerData.image);
                                                modal.find('#viewGender').text(customerData.gender);
                                                modal.find('#viewEmail').text(customerData.email);
                                                modal.find('#viewPhone').text(customerData.phone);
                                                modal.find('#viewDob').text(customerData.dob);
                                                modal.find('#viewAddress').text(customerData.address);
                                                modal.find('#viewWallet').text(customerData.wallet);
                                            });
        </script>
        <script>
            function deleteCustomer(Id) {
                if (confirm("Are you sure to delete customer with id = " + Id)) {
                    window.location = "customerManagement?deleteId=" + Id;
                }
            }
        </script>
    </body>

</html>