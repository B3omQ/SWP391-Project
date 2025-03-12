<%-- 
    Document   : reviewManager
    Created on : Mar 12, 2025, 8:55:26 AM
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
        <nav id="sidebar" class="sidebar-wrapper">
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
                            <h5 class="mb-0">Customer Review</h5>
                            <nav aria-label="breadcrumb" class="d-inline-block mt-2">
                                <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="index.html">Consultant</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Customer Review Manager</li>
                                </ul>
                            </nav>
                        </div><!--end col-->
                        <!--
                                                <div class="col-xl-3 col-lg-6 col-md-8 mt-4 mt-md-0">
                                                    <div class="justify-content-md-end">
                                                        <form>
                                                            <div class="justify-content-between">
                                                                <div class="">
                                                                    <div class="d-grid">
                                                                        <a href="#" class="btn btn-primary w-100" data-bs-toggle="modal"
                                                                           data-bs-target="#CreateAccountform">Create Account</a>
                                                                    </div>
                                                                </div>end col
                                                            </div>end row
                                                        </form>end form
                                                    </div>
                                                </div>end col-->
                    </div><!--end row-->
                    <div class="alert" style="background-color: rgb(237, 28, 36); color: white;" role="alert">
                        <c:set var="totalReviews" value="0"/>
                        <c:set var="positiveReviews" value="0"/>
                        <c:set var="neutralReviews" value="0"/>
                        <c:set var="negativeReviews" value="0"/>
                        
                        <c:forEach var="cr" items="${crList}">
                            <c:set var="totalReviews" value="${totalReviews + 1}"/>
                            <c:choose>
                                <c:when test="${cr.rate >= 4}">
                                    <c:set var="positiveReviews" value="${positiveReviews + 1}"/>
                                </c:when>
                                <c:when test="${cr.rate == 3}">
                                    <c:set var="neutralReviews" value="${neutralReviews + 1}"/>
                                </c:when>
                                <c:when test="${cr.rate <= 2}">
                                    <c:set var="negativeReviews" value="${negativeReviews + 1}"/>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                        
                        <c:choose>
                            <c:when test="${totalReviews > 0}">
                                <c:set var="positivePercentage" value="${(positiveReviews * 100) div totalReviews}"/>
                                <c:set var="neutralPercentage" value="${(neutralReviews * 100) div totalReviews}"/>
                                <c:set var="negativePercentage" value="${(negativeReviews * 100) div totalReviews}"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="positivePercentage" value="0"/>
                                <c:set var="neutralPercentage" value="0"/>
                                <c:set var="negativePercentage" value="0"/>
                            </c:otherwise>
                        </c:choose>
                        
                        <p>Positive Reviews: <strong>${positivePercentage}%</strong></p>
                        <p>Neutral Reviews: <strong>${neutralPercentage}%</strong></p>
                        <p>Negative Reviews: <strong>${negativePercentage}%</strong></p>
                    </div>
            <div class="row">
                <div class="col-12 mt-4">
                    <div class ="col-12">
                        <div class="table-responsive bg-white shadow rounded">
                            <table class="table table-bordered table-hover">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>#</th>
                                        <th>Username</th>
                                        <th>rate</th>
                                        <th>Create At</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="crList" items="${crList}">
                                        <tr>
                                            <td>${crList.id}</td>
                                            <td>${crList.cusid.username}</td>
                                            <td>
                                                <c:forEach var="i" begin="1" end="5">
                                        <li class="list-inline-item">
                                            <i class="mdi mdi-star ${i <= crList.rate ? 'text-warning' : 'text-secondary'}"></i>
                                        </li>
                                    </c:forEach>
                                    </td>
                                    <td>${crList.createAt}</td>
                                    <td class="">
                                        <button type="button" class="btn" style="background-color: rgb(237, 28, 36); color: white;" data-bs-toggle="modal" data-bs-target="#ViewAccountModal${crList.id}">View detail</button>
                                        <form onsubmit="deleteAlert(event)" action ="CustomerReviewManager" method="post" style ="display:inline-block">
                                                            <input name="deleteId" value="${crList.id}" type="hidden">
                                                            <button class = "btn" style="background-color: rgb(237, 28, 36); color: white;">Delete</button> 
                                                        </form>
                                    </td>
                                    <div class="modal fade" id="ViewAccountModal${crList.id}" tabindex="-1" aria-labelledby="ViewAccountModalLabel${crList.id}" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="ViewAccountModalLabel${crList.id}">Customer Review Details</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <p><strong>Username:</strong> ${crList.cusid.username}</p>
                                                    <p><strong>Phone:</strong> ${crList.cusid.phone}</p>
                                                    <p><strong>Email:</strong> ${crList.cusid.email}</p>
                                                    <p><strong>Review:</strong> ${crList.review}</p>
                                                    <p><strong>Rating:</strong> 
                                                        <c:forEach var="i" begin="1" end="5">
                                                            <i class="mdi mdi-star ${i <= crList.rate ? 'text-warning' : 'text-secondary'}"></i>
                                                        </c:forEach>
                                                    </p>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>


                <div class="row text-center">
                    <!-- PAGINATION START -->
                    <div class="col-12 mt-4">
                        <div class="d-md-flex align-items-center text-center justify-content-between">
                            <span class="text-muted me-3"></span>
                            <nav aria-label="Page navigation">
                                <ul class="pagination justify-content-center">
                                    <!-- Previous Button -->
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" 
                                           href="?page=${currentPage - 1}&recordPerPage=${recordPerPage}&phoneSearch=${phoneSearch}" 
                                           tabindex="-1">Previous</a>
                                    </li>

                                    <!-- Page Numbers -->
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" 
                                               href="?page=${i}&recordPerPage=${recordPerPage}&phoneSearch=${phoneSearch}">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <!-- Next Button -->
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" 
                                           href="?page=${currentPage + 1}&recordPerPage=${recordPerPage}&phoneSearch=${phoneSearch}">Next</a>
                                    </li>
                                </ul>
                            </nav>
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

