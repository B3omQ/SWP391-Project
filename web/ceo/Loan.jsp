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
            .loan-container {
                width: 400px;
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
                text-align: center;
                border-top: 5px solid #DA251D; /* Màu đỏ Techcombank */
            }
            .loan-title {
                font-size: 22px;
                font-weight: bold;
                color: #DA251D;
                margin-bottom: 15px;
            }
            .loan-detail {
                font-size: 16px;
                margin: 10px 0;
                display: flex;
                justify-content: space-between;
                border-bottom: 1px solid #ddd;
                padding-bottom: 5px;
            }
            .loan-label {
                font-weight: bold;
            }
            .loan-button {
                margin-top: 20px;
                padding: 12px;
                background-color: #DA251D;
                color: white;
                text-align: center;
                border-radius: 5px;
                text-decoration: none;
                display: block;
                font-size: 16px;
                font-weight: bold;
                transition: 0.3s;
            }
            .loan-button:hover {
                background-color: #B71C1C;
                cursor: pointer;
            }
            .progress-bar {
                width: 100%;
                height: 10px;
                background-color: #ddd;
                border-radius: 5px;
                margin-top: 10px;
                position: relative;
            }
            .progress-fill {
                height: 100%;
                background-color: #DA251D;
                border-radius: 5px;
            }
            .warning {
                color: red;
                font-weight: bold;
                margin-top: 10px;
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
                                        <li class="breadcrumb-item"><a href="index.html">Customer</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Khoản vay</li>
                                    </ul>
                                </nav>
                            </div><!--end col-->
                        </div>
                        <c:choose>
                            <c:when test="${not empty loan}">
                                <div class="loan-container">
                                    <div class="loan-title">Chi Tiết Khoản Vay</div>

                                    <div class="loan-detail">
                                        <span class="loan-label">Số tiền vay:</span>
                                        <span><fmt:formatNumber value="${loan.amount}" type="currency" currencyCode="VND"/></span>
                                    </div>

                                    <div class="loan-detail">
                                        <span class="loan-label">Ngày bắt đầu:</span>
                                        <span><fmt:formatDate value="${loan.startDate}" pattern="dd/MM/yyyy"/></span>
                                    </div>

                                    <div class="loan-detail">
                                        <span class="loan-label">Ngày kết thúc:</span>
                                        <c:if test="${not empty loan.endDate}">
                                            <span><fmt:formatDate value="${loan.endDate}" pattern="dd/MM/yyyy"/></span>
                                        </c:if>
                                        <c:if test="${empty loan.endDate}">
                                            <span>Chưa có</span>
                                        </c:if>
                                    </div>

                                    <c:if test="${loan.dateExpiredCount} != 0">
                                        <div class="loan-detail">
                                            <span class="loan-label">Kỳ hạn trễ:</span>
                                            <span>${loan.dateExpiredCount} tháng</span>
                                        </div>
                                    </c:if>

                                    <div class="loan-detail">
                                        <span class="loan-label">Số tiền trả mỗi kỳ:</span>
                                        <span><fmt:formatNumber value="${loan.debtRepayAmount/loan.loanId.duringTime}" type="currency" currencyCode="VND"/></span>
                                    </div>
                                    <div class="loan-detail">
                                        <span class="loan-label">Tổng lãi phải trả:</span>
                                        <span><fmt:formatNumber value="${loan.debtRepayAmount}" type="currency" currencyCode="VND"/></span>
                                    </div>

                                    <!--                                     Thanh tiến trình 
                                                                        <div class="progress-bar">
                                                                            <div class="progress-fill" style="width: 50%;"></div>  Thay 50% bằng giá trị thực tế 
                                                                        </div>-->
                                    <!--                                    <small>Đã thanh toán 50%</small>
                                    
                                                                         Cảnh báo nếu trễ hạn 
                                                                        <div class="warning">⚠ Bạn đang trễ hạn 2 tháng!</div>-->

                                    <!-- Nút thanh toán -->
                                    <a href="<%= request.getContextPath() %>/customerLoanPayment?loanId=${loan.id}" class="loan-button" title="Nhấn để thanh toán khoản vay">
                                        💳 Thanh Toán
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <h3>Bạn không có khoản vay nào.</h3>
                            </c:otherwise>
                        </c:choose>
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
