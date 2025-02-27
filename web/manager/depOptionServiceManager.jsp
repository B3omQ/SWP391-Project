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

        <style>
            .bubble {
                cursor: pointer;
                transition: transform 0.2s, box-shadow 0.2s;
            }

            .bubble:hover {
                transform: scale(1.02);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .card-title {
                font-size: 1.25rem;
                font-weight: 600;
                color: #007bff; /* Màu xanh Bootstrap */
            }

            .card-text {
                font-size: 1rem;
                color: #555;
            }

            .delete-icon {
                color: #dc3545; /* Màu đỏ của Bootstrap */
                font-size: 1.2rem;
            }

        </style>
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
                        <div class="row mb-4">
                            <div class="col-12">
                                <h2 class="text-primary">Deposit Options</h2>
                            </div>
                        </div>

                        <!-- Title & Dropdown -->
                        <div class="row align-items-center mb-4">
                            <form id="sort" action="dep-option-service" method="get" class="d-flex">
                                <select class="form-select me-2" name="pendingStatus" onchange="onChangeSubmit('sort')" id="status">
                                    <option value="Approved" ${currentStatus == 'Approved' || empty currentStatus ? 'selected' : ''}>Approved</option>
                                    <option value="Denied" ${currentStatus == 'Denied' ? 'selected' : ''}>Denied</option>
                                    <option value="Pending" ${currentStatus == 'Pending' ? 'selected' : ''}>Pending</option>
                                </select>                                
                            </form>
                        </div>
                        <!-- Deposit Options List -->                     
                        <div class="row">
                            <c:choose>
                                <c:when test="${empty depOptionServiceList}">
                                    <div class="col-12 text-center text-muted fw-bold">Search list is empty</div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="dep" items="${depOptionServiceList}">
                                        <div class="col-md-6 mb-4">
                                            <div class="card bubble" data-id="${dep.id}">
                                                <div class="card-body position-relative">
                                                    <!-- Biểu tượng xóa -->
                                                    <c:if test="${dep.pendingStatus != 'Approved'}">
                                                        <i class="fas fa-times delete-icon" style="position: absolute; top: 10px; right: 10px; cursor: pointer;"></i>
                                                    </c:if>
                                                    <div class="row align-items-center">
                                                        <!-- Cột cho hình ảnh -->
                                                        <div class="col-4">
                                                            <img src="<%= request.getContextPath() %>/assets/images/piggy.png" alt="img" class="img-fluid">
                                                        </div>
                                                        <!-- Cột cho thông tin -->
                                                        <div class="col-8 text-center">
                                                            <h5 class="card-title">Deposit Option ID: ${dep.id}</h5>
                                                            <p class="card-text"><strong>Deposit Minimum:</strong> ${dep.minimumDep}</p>
                                                            <p class="card-text"><strong>During Time:</strong> ${dep.duringTime} months</p>
                                                            <p class="card-text"><strong>Saving Rate:</strong> ${dep.savingRate}%</p>
                                                            <p class="card-text"><strong>Saving Rate Minimum:</strong> ${dep.savingRateMinimum}%</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- Footer Start -->
                <jsp:include page="template/footer.jsp"/>
                <!-- End -->
            </main>
            <!--End page-content-->
        </div>

        <script src="resources/script/jquery-3.7.1.min.js"></script>
        <script src="./assets/tinymce/tinymce.min.js"></script>
        <script src="./resources/script/tinymceConfig.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
        <script src="https://unpkg.com/@popperjs/core@2"></script>
        <script src="https://unpkg.com/tippy.js@6"></script>
        <script src="./resources/script/script.js"></script>

        <script>
                                    $(document).ready(function () {
                                        showToastrAfterReload();
                                        // Handle bubble click to review
                                        $('.bubble').on('click', function () {
                                            var depId = $(this).data('id');
                                            window.location.href = 'view-dep-option?depId=' + depId;
                                        });

                                        // Handle delete icon click
                                        $('.delete-icon').on('click', function (event) {
                                            event.stopPropagation(); // Prevent bubble click event
                                            var depId = $(this).closest('.bubble').data('id');
                                            var column = $(this).closest('.col-md-6');
                                            if (confirm("Are you sure you want to delete this option?")) {
                                                $.ajax({
                                                    url: 'dep-option-service',
                                                    type: 'POST',
                                                    data: {delete: depId},
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
                                    });
        </script>

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
        <script src="<%= request.getContextPath() %>/assets/js/jquery.timepicker.min.js"></script>
        <script src="<%= request.getContextPath() %>/assets/js/timepicker.init.js"></script>
        <!-- Icons -->
        <script src="<%= request.getContextPath() %>/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="<%= request.getContextPath() %>/assets/js/app.js"></script>
    </body>
</html>