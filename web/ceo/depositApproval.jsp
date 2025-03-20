<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="resources/script/animate.min.css">

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
                        <div class="row">
                            <div class="col-xl-6 col-lg-6 col-md-4">
                                <h5 class="mb-0">Banking System</h5>
                                <nav aria-label="breadcrumb" class="d-inline-block mt-2">
                                    <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item"><a href="index.html">Ceo</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Deposit Approval Lists</li>
                                    </ul>
                                </nav>
                            </div><!--end col-->
                            <div class="col-xl-6 col-lg-6 col-md-8 mt-4 mt-md-0">
                                <div class="justify-content-md-end">
                                    <form action="<%= request.getContextPath() %>/depositApproval" method="get" id="sort">
                                        <div class="row g-3 justify-content-between align-items-center">
                                            <!-- Search Input -->
                                            <div class="col-md-12 col-sm-12">
                                                <div class="input-group">
                                                    <input type="text" 
                                                           name="search" 
                                                           class="form-control" 
                                                           placeholder="Search "
                                                           value="${searchValue}">
                                                    <button type="submit" class="btn btn-primary">
                                                        <i class="uil uil-search"></i>
                                                    </button>
                                                </div>
                                            </div>

                                            <!-- Status Filter -->
                                            <div class="col-md-6">
                                                <div class="mb-0 position-relative d-flex align-items-center justify-content-center">
                                                    <label class="form-label me-2 mb-0">Status:</label>
                                                    <select class="form-control border-primary rounded-pill" name="pendingStatus" onchange="onChangeSubmit('sort')" id="status">
                                                        <option value="Approved" ${currentStatus == 'Approved' || empty currentStatus ? 'selected' : ''}>Approved</option>
                                                        <option value="Denied" ${currentStatus == 'Denied' ? 'selected' : ''}>Denied</option>
                                                        <option value="Pending" ${currentStatus == 'Pending' ? 'selected' : ''}>Pending</option>
                                                    </select>
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
                                                               onchange="document.getElementById('sort').submit()">
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- Order Filter -->
                                            <div class="col-md-6">
                                                <div class="mb-0 position-relative d-flex align-items-center justify-content-center">
                                                    <label class="form-label me-2 mb-0">Sort:</label>
                                                    <select class="form-control border-primary rounded-pill" name="sortBy" onchange="onChangeSubmit('sort')" id="sorBy">
                                                        <option value="DuringTime" ${currentSort == 'DuringTime' || empty currentSort ? 'selected' : ''}>Months</option>
                                                        <option value="MinimumDep" ${currentSort == 'MinimumDep' ? 'selected' : ''}>MinMoneyDep</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-0 position-relative d-flex align-items-center justify-content-center">
                                                    <label class="form-label me-2 mb-0"></label>
                                                    <select class="form-control border-primary rounded-pill" name="order" onchange="onChangeSubmit('sort')" id="order">
                                                        <option value="ASC" ${currentOrder == 'ASC' || empty currentOrder ? 'selected' : ''}>Asc</option>
                                                        <option value="DESC" ${currentOrder == 'DESC' ? 'selected' : ''}>Desc</option>
                                                    </select>
                                                </div>
                                            </div>      
                                        </div>
                                    </form>
                                </div>
                            </div><!--end col-->
                        </div><!--end row-->
                        <br>
                        <!-- Deposit Options List -->                     
                        <div class="row">
                            <c:choose>
                                <c:when test="${empty depOptionServiceList}">
                                    <div class="col-12 text-center text-muted fw-bold">Empty</div>
                                </c:when>
                                <c:otherwise>

                                    <form action="<%= request.getContextPath() %>/depositApproval" method="get">
                                        <div class="table-responsive bg-white shadow rounded">
                                            <table class="table table-bordered table-hover">
                                                <thead class="thead-dark">
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Name</th>
                                                        <th>MinimumDep</th>
                                                        <th>SavingRateMinimum</th>
                                                        <th>SavingRate</th>
                                                        <th>Term (Months)</th> 
                                                        <!-- Action -->
                                                        <c:if test="${currentStatus == 'Pending'}">
                                                            <th>Action</th>                                                  
                                                            </c:if>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="dep" items="${depOptionServiceList}">
                                                        <tr>
                                                            <td>${dep.id}</td>
                                                            <td>${dep.depServiceName}</td>  
                                                            <td>${dep.minimumDep}</td>  
                                                            <td>${dep.savingRateMinimum}</td>  
                                                            <td>${dep.savingRate}</td>  
                                                            <td>${dep.duringTime}</td>  
                                                            <td>                              
                                                                <c:if test="${currentStatus == 'Pending'}">
                                                                    <a href="depositApproval?id=${dep.id}&changeStatus=Approved" class="btn btn-icon btn-pills btn-soft-success">
                                                                        <i class="fas fa-check"></i>
                                                                    </a>
                                                                    <a href="depositApproval?id=${dep.id}&changeStatus=Denied" class="btn btn-icon btn-pills btn-danger">
                                                                        <i class="fas fa-times"></i>
                                                                    </a>
                                                                </c:if>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="row text-center">
                            <!-- PAGINATION START -->
                            <div class="col-12 mt-4">
                                <div class="d-md-flex align-items-center text-center justify-content-between">
                                    <span class="text-muted me-3">
                                        Total: ${numberOfRecords}
                                    </span>                                  
                                    <span class="mx-3">
                                        <input type="text" style="text-align: right; max-width: 60px" value="${page}" class="form-control d-inline w-auto"                                               
                                               onchange="location.href = '${pageContext.request.contextPath}/depositApproval?page=' + this.value">
                                        / ${endPage}
                                    </span>
                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <!-- Previous -->
                                        <c:if test="${page != 1}">
                                            <li class="page-item"><a class="page-link" href="<%= request.getContextPath() %>/depositApproval?page=${page - 1}" aria-label="Previous">Prev</a></li>
                                            </c:if>  
                                        <!-- Current Page -->  
                                        <!-- Start process -->
                                        <c:if test="${endPage < 8}">
                                            <c:forEach var="i" begin="1" end="${endPage}">
                                                <li class="page-item ${page == i? "active" : ""}"><a class="page-link" href="<%= request.getContextPath() %>/depositApproval?page=${i}" aria-label="Pages">${i}</a></li>
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${endPage >= 8}">
                                            <li class="page-item ${page == 1? "active" : ""}"><a class="page-link" href="<%= request.getContextPath() %>/depositApproval?page=1" aria-label="Pages">1</a></li>
                                                <c:if test="${page < 4 || page > endPage - 3}">
                                                <li class="page-item ${page == 2? "active" : ""}"><a class="page-link" href="<%= request.getContextPath() %>/depositApproval?page=2" aria-label="Pages">2</a></li>
                                                <li class="page-item ${page == 3? "active" : ""}"><a class="page-link" href="<%= request.getContextPath() %>/depositApproval?page=3" aria-label="Pages">3</a></li>
                                                </c:if>
                                                <c:if test="${page > 3 && page < endPage - 2}">
                                                <li class="page-item"><span class="page-link" aria-label="Pages">...</span></li>
                                                <li class="page-item ${page == page - 1 ? "active" : ""}"><a class="page-link" href="<%= request.getContextPath() %>/depositApproval?page=${page - 1}" aria-label="Pages">${page - 1}</a></li>
                                                <li class="page-item ${page == page? "active" : ""}"><a class="page-link" href="<%= request.getContextPath() %>/depositApproval?&page=${page}" aria-label="Pages">${page}</a></li>
                                                <li class="page-item ${page == page + 1 ? "active" : ""}"><a class="page-link" href="<%= request.getContextPath() %>/depositApproval?page=${page + 1}" aria-label="Pages">${page + 1}</a></li>
                                                <li class="page-item"><span class="page-link" aria-label="Pages">...</span></li>
                                                </c:if>
                                                <c:if test="${page < 4 || page > endPage - 3}">
                                                <li class="page-item"><span class="page-link" aria-label="Pages">...</span></li>
                                                <li class="page-item ${page == endPage - 2? "active" : ""}"><a class="page-link" href="<%= request.getContextPath() %>/depositApproval?page=${endPage - 2}" aria-label="Pages">${endPage - 2}</a></li>
                                                <li class="page-item ${page == endPage - 1? "active" : ""}"><a class="page-link" href="<%= request.getContextPath() %>/depositApproval?page=${endPage - 1}" aria-label="Pages">${endPage - 1}</a></li>
                                                </c:if> 
                                            <li class="page-item ${page == endPage? "active" : ""}"><a class="page-link" href="<%= request.getContextPath() %>/depositApproval?page=${endPage}" aria-label="Pages">${endPage}</a></li>
                                            </c:if>                                              
                                        <!-- End process -->
                                        <!-- Next -->
                                        <c:if test="${page lt endPage}">
                                            <li class="page-item"><a class="page-link" href="<%= request.getContextPath() %>/depositApproval?page=${page + 1}" aria-label="Next">Next</a></li>
                                            </c:if>
                                    </ul>
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
        <script src="resources/script/wow.min.js"></script>
        <script src="resources/script/jquery-3.7.1.min.js"></script>
        <script src="./assets/tinymce/tinymce.min.js"></script>
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
        <!-- SLIDER -->
        <script src="assets/js/tiny-slider.js"></script>
        <script src="assets/js/tiny-slider-init.js"></script>
        <!-- Counter -->
        <script src="assets/js/counter.init.js"></script>
        <script src="<%= request.getContextPath() %>/assets/js/flatpickr.min.js"></script>
        <script src="<%= request.getContextPath() %>/assets/js/flatpickr.init.js"></script>
        <script src="<%= request.getContextPath() %>/assets/js/jquery.timepicker.min.js"></script>
        <script src="<%= request.getContextPath() %>/assets/js/timepicker.init.js"></script>
        <!-- Icons -->
        <script src="<%= request.getContextPath() %>/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="<%= request.getContextPath() %>/assets/js/app.js"></script>
    </body>
</html>