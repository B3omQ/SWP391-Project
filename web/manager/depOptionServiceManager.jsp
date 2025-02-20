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
    <style>

    </style>

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
                            <div class="row justify-content-center">
                                <div class="col-auto">
                                    <button data-bs-toggle="modal" data-bs-target="#addDepositeModal" 
                                            class="btn btn-primary btn-md">
                                        <a>ADD</a>
                                    </button>
                                </div>

                            </div>
                            <jsp:include page="template/addDepOptionService.jsp"/>

                        </div>
                        <!-- Customer Table -->

                        <style>
                            .table {
                                border-collapse: collapse; /* Đảm bảo viền không bị gãy */
                                width: 100%;
                                border: 1px solid black; /* Viền bên ngoài */
                                background-color: white; /* Nền trắng */
                                border-collapse: separate; /* Để box-shadow hiển thị đúng */
                                border-spacing: 0; /* Loại bỏ khoảng cách giữa các ô */
                                border-radius: 10px; /* Bo góc */
                                overflow: hidden; /* Đảm bảo góc bo tròn không bị mất */
                                background: white; /* Đảm bảo bảng có màu nền để bóng đẹp hơn */
                                box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.15),
                                    0px 0px 8px rgba(0, 0, 0, 0.1); /* Hiệu ứng đổ bóng xung quanh */
                            }

                            .table th, .table td {
                                border: 1px solid black; /* Viền bên trong */
                                color: black; /* Màu chữ đen */
                                padding: 10px; /* Khoảng cách trong các ô */
                                text-align: center; /* Căn giữa chữ */
                            }

                            .table th {
                                background-color: white; /* Nền trắng cho header */
                                font-weight: bold; /* Chữ in đậm cho tiêu đề */
                            }

                            .table tbody tr:hover {
                                background-color: #f2f2f2; /* Nền màu khi hover */
                            }

                            .thead-dark {
                                background-color: white; /* Đảm bảo màu nền header là trắng */
                                color: black; /* Màu chữ header là đen */
                            }

                            .table td, .table th {
                                vertical-align: middle; /* Căn giữa theo chiều dọc */
                            }
                        </style>


                        <div class="table-responsive mt-4">
                            <table class="table table-striped table-bordered table-hover">
                                <thead class="thead-dark bg-dark text-black" style ="text-align:center">
                                    <tr>
                                        <th>ID</th>
                                        <th>Deposite Minimum</th>
                                        <th>During Time (Months)</th>
                                        <th>Saving Rate (%)</th>
                                        <th>Saving Rate Minimum (%)</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty depOptionServiceList}">
                                            <tr>
                                                <td colspan="100%" class="text-center text-muted fw-bold">Search list is empty</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="dep" items="${depOptionServiceList}">
                                                <tr>
                                                    <td>${dep.id}</td>
                                                    <td>${dep.minimumDep}</td>
                                                    <td>${dep.duringTime}</td>
                                                    <td>${dep.savingRate}</td>
                                                    <td>${dep.savingRateMinimum}</td>
                                                    <td class="text-center align-middle" style="display:flex">
                                                        <div class="col-auto">
                                                            <a href="view-dep-option?depId=${dep.id}" class="btn btn-info btn-md">
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                        </div>
                                                        <div class="col-auto">
                                                            <form action="dep-option-service" method="post" id="deleteDepOptionService-${dep.id}">
                                                                <input name="delete" value="${dep.id}" type="hidden">
                                                                <button class="btn btn-danger btn-md" type="submit">
                                                                    <i class="fas fa-trash-alt"></i>
                                                                </button>
                                                            </form>
                                                        </div>
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




                <!-- Footer Start -->
                <jsp:include page="template/footer.jsp"/>
                <!-- End -->
            </main>
            <!--End page-content-->

        </div>
        <script src ="resources/script/jquery-3.7.1.min.js"></script>
        <script src="./assets/tinymce/tinymce.min.js"></script>
        <script src="./resources/script/tinymceConfig.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
        <script src="https://unpkg.com/@popperjs/core@2"></script>
        <script src="https://unpkg.com/tippy.js@6"></script>
        <script src="./resources/script/script.js"></script>

        <script>
            $(document).ready(function () {

                $('form[id^="deleteDepOptionService-"]').on('submit', function (event) {
                    event.preventDefault();

                    let form = $(this);
                    let depId = form.find('input[name="delete"]').val();

                    if (confirm("Are you sure you want to delete this option?")) {
                        $.ajax({
                            url: 'dep-option-service',
                            type: 'POST',
                            data: {delete: depId},
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
        <!-- Datepicker -->
        <script src="<%= request.getContextPath() %>/assets/js/jquery.timepicker.min.js"></script>
        <script src="<%= request.getContextPath() %>/assets/js/timepicker.init.js"></script>
        <!-- Icons -->
        <script src="<%= request.getContextPath() %>/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="<%= request.getContextPath() %>/assets/js/app.js"></script>

    </body>

</html>