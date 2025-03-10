<%-- 
    Document   : disbursementsManager
    Created on : Mar 7, 2025, 6:11:42 PM
    Author     : LAPTOP
--%>

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
                <div class="layout-specing">
                    <div class="row">
                        <div class="col-xl-9 col-lg-6 col-md-4">
                            <h5 class="mb-0">Disbursements Management</h5>
                            <nav aria-label="breadcrumb" class="d-inline-block mt-2">
                                <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="index.html">Accountant</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Disbursements</li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                    <div class="row">
                        <div class="table-responsive bg-white shadow rounded">
                            <table class="table table-bordered table-hover">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>Id#</th>
                                        <th>Customer</th>
                                        <th>Amount</th>
                                        <th>Ngày khởi tạo</th>
                                        <th>EndDate</th>
                                        <th>LoanStatus</th>
                                        <th>Option</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:if test="${empty loanServiceUseds}">
                                        <tr>
                                            <td colspan="8" class="text-center">Không tìm thấy khoản vay nào nào</td>
                                        </tr>
                                    </c:if>
                                    <c:forEach var="loanServiceUsed" items="${loanServiceUseds}">
                                        <tr>
                                            <td>${loanServiceUsed.id}</td>
                                            <td>${loanServiceUsed.cusId.username}</td>
                                            <td>${loanServiceUsed.amount}</td>
                                            <td>${loanServiceUsed.startDate}</td>
                                            <td>${loanServiceUsed.endDate}</td>
                                            <td>${loanServiceUsed.loanStatus}</td>
                                            <td>
                                                <button type="button" class="btn btn-danger" data-bs-toggle="modal"
                                                        data-bs-target="#loanDetailModal-${loanServiceUsed.id}">View</button>
                                                <button type="button" class="btn btn-danger" data-bs-toggle="modal"
                                                        data-bs-target="#UpdateAccountform-${loanServiceUsed.id}">Delete</button>                
                                            </td>
                                    <div class="modal fade" id="loanDetailModal-${loanServiceUsed.id}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Chi tiết khoản vay</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <p><strong>Customer:</strong> ${loanServiceUsed.cusId.username}</p>
                                                    <p><strong>Amount:</strong> ${loanServiceUsed.amount}</p>
                                                    <p><strong>Start Date:</strong> ${loanServiceUsed.startDate}</p>
                                                    <p><strong>End Date:</strong> ${loanServiceUsed.endDate}</p>
                                                    <p><strong>Status:</strong> ${loanServiceUsed.loanStatus}</p>
                                                </div>
                                                <div class="modal-footer">
                                                    <form action="Disbursement" method="post">
                                                        <input type="hidden" name="updateLoanId" value="${loanServiceUsed.id}">
                                                        <input type="hidden" name="updateCusId" value="${loanServiceUsed.cusId.id}">
                                                        <input type="hidden" name="amount" value="${loanServiceUsed.amount}">
                                                        <input type="hidden" name="wallet" value="${loanServiceUsed.cusId.wallet}">
                                                        <input type="hidden" name="status" value="In Progress">
                                                        <button type="submit" class="btn btn-success">Chuyển Tiền</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    </tr>    
                                </c:forEach>
                                </tbody>
                            </table>

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
                </div>





                <!-- Footer Start -->
                <jsp:include page="template/footer.jsp"/>
                <!-- End -->
            </main>
            <!--End page-content-->

        </div>

        <script src ="resources/script/jquery-3.7.1.min.js"></script>
        <script src="./resources/script/tinymceConfig.js"></script>
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
