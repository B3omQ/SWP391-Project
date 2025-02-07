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

                    <div class="col-xl-3 col-lg-6 col-md-8 mt-4 mt-md-0">
                        <div class="justify-content-md-end">
                            <form>
                                <div class="justify-content-between">
                                    <div class="">
                                        <div class="d-grid">
                                            <a href="#" class="btn btn-primary w-100" data-bs-toggle="modal"
                                               data-bs-target="#CreateAccountform">Create Account</a>
                                        </div>
                                    </div><!--end col-->
                                </div><!--end row-->
                            </form><!--end form-->
                        </div>
                    </div><!--end col-->
                </div><!--end row-->

                <div class="row">
                    <div class="col-12 mt-4">
                        <form action="consultant-customer" method="post" class="mt-4">
                            <div class="modal fade" id="CreateAccountform" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="addUserModalLabel">Thêm mới Account</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="container">
                                            <input value="add" type="hidden" name="add">
                                            <!--                                            <div class="col-md-12">
                                                                                            <div class="mb-3 mt-4">
                                                                                                <label for="otherImage">Image</label>
                                                                                                <input type="file" id="otherImage" name="otherImage" class="form-control-file">
                                                                                            </div>
                                                                                        </div>-->
                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Username <span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" placeholder="Username" name="username" required="">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">                                               
                                                    <label class="form-label">First name <span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" placeholder="First Name" name="firstname" required="">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">                                                
                                                    <label class="form-label">Last name <span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" placeholder="Last Name" name="lastname" required="">
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Your Email <span class="text-danger">*</span></label>
                                                    <input type="email" class="form-control" name="email" placeholder="Email" required="">
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Day of birth <span class="text-danger">*</span></label>
                                                    <input type="Date" class="form-control" name="dob" required="">
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
                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Password <span class="text-danger">*</span></label>
                                                    <input type="password" class="form-control" placeholder="Password" name="password" required="">
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Address <span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" placeholder="Address" name="address" required="">
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Phone Number <span class="text-danger">*</span></label>
                                                    <input type="tel" class="form-control" id="phoneNumber" name="phone" 
                                                           placeholder="Enter phone number" required 
                                                           pattern="0[1-9]\d{7,8}" 
                                                           title="Vui lòng nhập đúng format số điện thoại(9-10 số và không kí tự đặc biệt)">
                                                    <small class="text-danger" id="phoneError" style="display: none;">Vui lòng nhập đúng format số điện thoại(9-10 số và không kí tự đặc biệt)</small>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <div class="">
                                                    <button type="submit" class="btn btn-primary w-100 ">CREATE</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <script>
                            document.getElementById("phoneNumber").addEventListener("input", function () {
                                let phoneInput = this.value;
                                let phonePattern = /^0[1-9]\d{7,8}$/;
                                let errorMsg = document.getElementById("phoneError");

                                if (phonePattern.test(phoneInput)) {
                                    this.setCustomValidity("");
                                    errorMsg.style.display = "none";
                                } else {
                                    this.setCustomValidity("Phone number không đúng format");
                                    errorMsg.style.display = "block";
                                }
                            });
                        </script>
                        <div class="d-flex justify-content-between mb-3">
                            <!-- Search Box -->
                            <input type="text" id="searchInput" class="form-control w-25" placeholder="Search users...">

                            <!-- Sort Buttons -->
                            <div>
                                <button class="btn btn-danger" onclick="sortTable(1)">Sort by Name</button>
                                <button class="btn btn-warning" onclick="sortTable(2)">Sort by Email</button>
                                <button class="btn btn-info" onclick="sortTable(6)">Sort by Wallet</button>
                            </div>
                        </div>
                        <form action="<%= request.getContextPath() %>/CustomerManager" method="get">
                        </form>
                        <div class="table-responsive bg-white shadow rounded">
                            <table class="table table-bordered table-hover">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>#</th>
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
                                            <td colspan="8" class="text-center">No users available.</td>
                                        </tr>
                                    </c:if>


                                    <c:forEach var="customer" items="${customers}">
                                        <tr>
                                            <td>${customer.id}</td>
                                            <td>${customer.username}</td>
                                            <td>${customer.email}</td>
                                            <td>${customer.address}</td>
                                            <td>${customer.phone}</td>
                                            <td>${customer.wallet} VND</td>

                                            <td class="">
                                                <!-- Edit button -->
                                                <button type="button" class="btn btn-warning" data-bs-toggle="modal"
                                                        data-bs-target="#UpdateAccountform">Edit</button>
                                                <!-- Delete button -->
                                                <form onsubmit="deleteAlert(event)" action ="consultant-customer" method="post" style ="display:inline-block">
                                                    <input name="deleteId" value="${customer.id}" type="hidden">
                                                    <button class = "btn btn-danger">Delete</button> 
                                                </form>
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
                                                                    <strong>Wallet Balance:</strong> ${customer.wallet}
                                                                </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <form action="consultant-customer" method="post" class="mt-4">
                                                    <div class="modal fade" id="UpdateAccountform" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h1 class="modal-title fs-5" id="addUserModalLabel">Thay đổi thông tin Account</h1>
                                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                </div>
                                                                <div class="container">
                                                                    <input name="changeinfoId" value="${customer.id}" type="hidden">
                                                                    <div class="col-md-12">
                                                                        <div class="mb-3 mt-4">
                                                                            <label class="form-label">Username <span class="text-danger">*</span></label>
                                                                            <input type="text" class="form-control" value="${customer.username}" name="username" required="">
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <div class="mb-3">                                               
                                                                            <label class="form-label">First name <span class="text-danger">*</span></label>
                                                                            <input type="text" class="form-control" value="${customer.firstname}" placeholder="First Name" name="firstname" required="">
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <div class="mb-3">                                                 
                                                                            <label class="form-label">Last name <span class="text-danger">*</span></label>
                                                                            <input type="text" class="form-control" value="${customer.lastname}" placeholder="Last Name" name="lastname" required="">
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-12">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Your Email <span class="text-danger">*</span></label>
                                                                            <input type="email" class="form-control" name="email" value="${customer.email}" required="">
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-12">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Day of birth <span class="text-danger">*</span></label>
                                                                            <input type="date" class="form-control" name="dob" value="${customer.dob}" required="">
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-12">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Gender <span class="text-danger">*</span></label>
                                                                            <select class="form-control" name="gender" required>
                                                                                <option value="Male" ${customer.gender == 'Male' ? 'selected' : ''}>Male</option>
                                                                                <option value="Female" ${customer.gender == 'Female' ? 'selected' : ''}>Female</option>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-12">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Address <span class="text-danger">*</span></label>
                                                                            <input type="text" class="form-control" placeholder="Address" value="${customer.address}" name="address" required="">
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-12">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Phone number <span class="text-danger">*</span></label>
                                                                            <input type="tel" class="form-control" placeholder="Phone number" value="${customer.phone}" name="phoneNumber" required="">
                                                                        </div>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <div class="">
                                                                            <button type="submit" class="btn btn-warning">Edit</button>
                                                                        </div>
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
                        <!--                         JavaScript for Search & Sort -->
                        <script>
                            document.getElementById("searchInput").addEventListener("keyup", function () {
                                let input = this.value.toLowerCase();
                                let rows = document.querySelectorAll("tbody tr");

                                rows.forEach(row => {
                                    let text = row.innerText.toLowerCase();
                                    row.style.display = text.includes(input) ? "" : "none";
                                });
                            });

                            function sortTable(columnIndex) {
                                let table = document.querySelector(".table tbody");
                                let rows = Array.from(table.rows);

                                let sortedRows = rows.sort((a, b) => {
                                    let aText = a.cells[columnIndex].textContent.trim().toLowerCase();
                                    let bText = b.cells[columnIndex].textContent.trim().toLowerCase();

                                    return isNaN(aText) || isNaN(bText) ? aText.localeCompare(bText) : aText - bText;
                                });

                                sortedRows.forEach(row => table.appendChild(row));
                            }
                        </script>
                    </div>
                </div>

                <div class="row text-center">
                    <!-- PAGINATION START -->
                    <div class="col-12 mt-4">
                        <div class="d-md-flex align-items-center text-center justify-content-between">
                            <span class="text-muted me-3">Showing 1 - 10 out of 50</span>
                            <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                <li class="page-item"><a class="page-link" href="javascript:void(0)"
                                                         aria-label="Previous">Prev</a></li>
                                <li class="page-item active"><a class="page-link" href="javascript:void(0)">1</a>
                                </li>
                                <li class="page-item"><a class="page-link" href="javascript:void(0)">2</a></li>
                                <li class="page-item"><a class="page-link" href="javascript:void(0)">3</a></li>
                                <li class="page-item"><a class="page-link" href="javascript:void(0)"
                                                         aria-label="Next">Next</a></li>
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
