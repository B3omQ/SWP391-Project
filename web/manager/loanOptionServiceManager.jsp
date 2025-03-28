<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

        <link rel="stylesheet" href="resources/script/animate.min.css">

    </head>
    <style>
        /* Tổng thể layout */
        .layout-specing {
            max-width: 1600px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Tiêu đề chính */
        h2.text-primary {
            font-family: 'Poppins', sans-serif;
            font-size: 2rem;
            font-weight: 600;
            color: #ff6f61;
            text-align: center;
            margin-bottom: 30px;
        }

        /* Dropdown */
        .form-select {
            font-family: 'Poppins', sans-serif;
            font-size: 1rem;
            padding: 10px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            background: #fafafa;
            transition: all 0.3s ease;
        }

        .form-select:focus {
            border-color: #ff6f61;
            box-shadow: 0 0 5px rgba(255, 111, 97, 0.3);
            outline: none;
        }

        /* Card bubble */
        .bubble {
            cursor: pointer;
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            transition: transform 0.2s ease, box-shadow 0.2s ease, border 0.2s ease;
            overflow: hidden;
            font-family: 'Poppins', sans-serif;
            position: relative; /* Để định vị icon tuyệt đối */
        }

        .bubble:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            border: 1px solid #ff6f61; /* Viền đỏ khi hover */
        }

        .card-body {
            padding: 20px;
            position: relative;
        }

        /* Icon xóa */
        .delete-icon {
            color: #ff6f61;
            font-size: 1.2rem;
            position: absolute;
            top: 15px;
            right: 15px;
            transition: transform 0.2s ease;
        }

        .delete-icon:hover {
            transform: scale(1.2);
        }

        /* Icon piggy */
        .piggy-icon {
            color: #ff6f61;
            font-size: 1.2rem;
            position: absolute;
            top: 15px;
            left: 15px;
            transition: transform 0.2s ease;
        }

        .piggy-icon:hover {
            transform: scale(1.2);
        }

        /* Nội dung trong card */
        .bubble .row {
            align-items: center;
        }

        .bubble .col-4 a {
            font-size: 3.5rem;
            font-weight: 700;
            color: #333;
        }

        .bubble .col-4 p {
            font-size: 1rem;
            color: #777;
            margin: 0;
        }

        .bubble .col-4 {
            border-right: 2px solid #e0e0e0;
            text-align: center;
        }

        .bubble .col-8 {
            text-align: right;
            padding-left: 20px;
        }

        .bubble .col-8 p {
            font-size: 1.1rem;
            color: #555;
            margin: 5px 0;
        }

        .bubble .col-8 p strong {
            color: #333;
            font-weight: 600;
        }

        /* Thông báo khi danh sách rỗng */
        .text-muted.fw-bold {
            font-family: 'Poppins', sans-serif;
            font-size: 1.2rem;
            color: #777;
            text-align: center;
            padding: 20px;
        }
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
                            <div class="col-md-6">
                                <h5 class="mb-0">Trang quản lí dịch vụ gói vay</h5>
                                <nav aria-label="breadcrumb" class="mt-2">
                                    <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item">
                                            <a href="#" class="text-decoration-none text-danger">SmartBanking</a>
                                        </li>
                                        <li class="breadcrumb-item">
                                            <a href="#" class="text-decoration-none text-danger">Dịch vụ cho vay</a>
                                        </li>
                                        <li class="breadcrumb-item active" aria-current="page">Danh sách các gói dịch vụ</li>
                                    </ul>
                                </nav>
                            </div>  

                            <div class="col-md-6">
                                <form id="sort" action="loan-option-service" method="get" class="d-flex">
                                    <select class="form-select me-2" name="pendingStatus" onchange="onChangeSubmit('sort')" id="status">
                                        <option value="Approved" ${currentStatus == 'Approved' || empty currentStatus ? 'selected' : ''}>Phê duyệt</option>
                                        <option value="Denied" ${currentStatus == 'Denied' ? 'selected' : ''}>Từ chối</option>
                                        <option value="Pending" ${currentStatus == 'Pending' ? 'selected' : ''}>Đang chờ</option>
                                    </select>   
                                    <select class="form-select me-2" name="sortBy" onchange="onChangeSubmit('sort')" id="sorBy">
                                        <option value="DuringTime" ${currentSort == 'DuringTime' || empty currentSort ? 'selected' : ''}>Thời gian vay</option>
                                        <option value="MinimumLoan" ${currentSort == 'MinimumLoan' ? 'selected' : ''}>Giá trị vay tối thiểu</option>
                                        <option value="MaximumLoan" ${currentSort == 'MaximumLoan' ? 'selected' : ''}>Giá trị vay tối đa</option>
                                    </select>     
                                    <select class="form-select me-2" name="order" onchange="onChangeSubmit('sort')" id="order">
                                        <option value="ASC" ${currentOrder == 'ASC' || empty currentOrder ? 'selected' : ''}>Tăng dần</option>
                                        <option value="DESC" ${currentOrder == 'DESC' ? 'selected' : ''}>Giảm dần</option>
                                    </select> 
                                    <button class="btn btn-outline-primary w-100" type="reset" 
                                            onclick="window.location.href = './loan-option-service?pendingStatus=&sortBy=&order='">
                                        Đặt lại
                                    </button> 
                                </form>                       
                            </div>

                        </div>
                        </br>                        


                        <!-- Title & Dropdown -->

                        <!-- Deposit Options List -->                     
                        <div class="row">
                            <c:choose>
                                <c:when test="${empty loanOptionServiceList}">
                                    <div class="col-12 text-center text-muted fw-bold">Danh sách trống</div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="loan" items="${loanOptionServiceList}" varStatus="status">
                                        <div class="col-md-6 mb-4">
                                            <div class="card bubble wow fadeInUp" data-id="${loan.id}" data-wow-delay="${status.index * 0.1}s">
                                                <div class="card-body position-relative" >
                                                    <!-- Biểu tượng xóa -->
                                                    <c:if test="${loan.pendingStatus != 'Approved'}">
                                                        <i class="fas fa-trash delete-icon" style="position: absolute; top: 10px; right: 10px; cursor: pointer;"></i>
                                                    </c:if>
                                                    <div class="row align-items-center">
                                                        <div class="col-4 text-center" style="border-right: 2px solid rgba(0, 0, 0, 0.1); ">
                                                            <p style="font-weight: bold; color: black">${loan.loanServiceName}</p>
                                                            <a class="" style="font-size: 4rem; font-weight: bold; color: black"> ${loan.duringTime}</a>
                                                            <p class="text-muted">tháng</p>
                                                        </div>
                                                        <div class="col-8" style="text-align: right">                    
                                                            <p><strong>Số tiền vay (VNĐ):</strong> <fmt:formatNumber value="${loan.minimumLoan}" type="number" groupingUsed="true" /> - <fmt:formatNumber value="${loan.maximumLoan}" type="number" groupingUsed="true" /></p>                                                             
                                                            <p><strong>Lãi suất 6 tháng đầu:</strong> ${loan.onTermRate}% / năm</p>
                                                            <p><strong>Lãi suất những tháng sau:</strong> ${loan.afterTermRate}% / năm</p> 
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
        <script src="resources/script/wow.min.js"></script>
        <script src ="resources/script/jquery-3.7.1.min.js"></script>
        <script src="./resources/script/tinymceConfig.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
        <script src="https://unpkg.com/@popperjs/core@2"></script>
        <script src="https://unpkg.com/tippy.js@6"></script>
        <script src="./resources/script/script.js"></script>
        <script>
                                                new WOW().init();

                                                $(document).ready(function () {

                                                    showToastrAfterReload();
                                                    // Handle bubble click to review
                                                    $('.bubble').on('click', function () {
                                                        var loanId = $(this).data('id');
                                                        window.location.href = 'view-loan-option?loanId=' + loanId;
                                                    });

                                                    // Handle delete icon click
                                                    $('.delete-icon').on('click', function (event) {
                                                        event.stopPropagation(); // Prevent bubble click event
                                                        var loanId = $(this).closest('.bubble').data('id');
                                                        var column = $(this).closest('.col-md-6');
                                                        if (confirm("Are you sure you want to delete this option?")) {
                                                            $.ajax({
                                                                url: 'loan-option-service',
                                                                type: 'POST',
                                                                data: {delete: loanId},
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
        <!-- Datepicker -->
        <script src="<%= request.getContextPath() %>/assets/js/jquery.timepicker.min.js"></script>
        <script src="<%= request.getContextPath() %>/assets/js/timepicker.init.js"></script>
        <!-- Icons -->
        <script src="<%= request.getContextPath() %>/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="<%= request.getContextPath() %>/assets/js/app.js"></script>

    </body>

</html>