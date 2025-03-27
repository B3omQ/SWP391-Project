<!DOCTYPE html>

<html lang="en">
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <style>
            .success-container {
                width: 400px;
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
                margin: auto;
            }
            .success-icon {
                font-size: 50px;
                color: #28a745;
            }
            .success-title {
                font-size: 22px;
                font-weight: bold;
                color: #d70000;
                margin: 20px 0;
            }
            .success-detail {
                font-size: 16px;
                margin-bottom: 15px;
            }
            .back-button {
                display: inline-block;
                padding: 12px 20px;
                background-color: #d70000;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                font-size: 16px;
            }
            .back-button:hover {
                background-color: #b30000;
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
            <!-- Start Page Content -->
            <main class="page-content bg-light" style="padding-left: 0px;">
                <jsp:include page="template/header.jsp"/> 
                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="success-container">
                            <div class="success-icon">✅</div>
                            <div class="success-title">Đăng Ký Thành Công!</div>
                            <div class="success-detail">Bạn đã đăng ký khoản vay thành công với số tiền:</div>
                            <div class="success-detail"><strong><fmt:formatNumber value="${loanServiceUsed.amount}" type="currency" currencyCode="VND"/></strong></div>
                            <div class="success-detail">Thời gian vay: <strong>${loanServiceUsed.loanId.duringTime} tháng</strong></div>
                            <div class="success-detail">Lãi suất: <strong>${loanServiceUsed.loanId.onTermRate} % / năm</strong></div>
                            
                            <div class="success-detail">
                                <span class="loan-label">Tổng lãi phải trả:</span>
                                <span><fmt:formatNumber value="${loanServiceUsed.debtRepayAmount}" type="currency" currencyCode="VND"/></span>
                            </div>
                            <div class="success-detail">Trạng thái: <strong>${loanServiceUsed.loanStatus}</strong></div>
                        </div>
                    </div>       
                </div><!--end container-->

                <!-- Footer Start -->
                <jsp:include page="template/footer.jsp"/>
                <!-- End -->
            </main>
            <!--End page-content" -->

        </div>
        <!-- page-wrapper --> 
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
