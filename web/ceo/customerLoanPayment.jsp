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
                margin: 50px auto;
            }
            .loan-title {
                font-size: 22px;
                font-weight: bold;
                color: #DA251D;
                margin-bottom: 20px;
            }
            .loan-detail {
                font-size: 16px;
                margin: 10px 0;
                display: flex;
                justify-content: space-between;
            }
            .loan-label {
                font-weight: bold;
            }
            input[type='number'] {
                width: 100%;
                padding: 10px;
                margin-top: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
            }
            .loan-button {
                margin-top: 20px;
                padding: 12px;
                background-color: #DA251D;
                color: white;
                text-align: center;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                width: 100%;
            }
            .loan-button:hover {
                background-color: #B71C1C;
            }
            .message, .error {
                font-size: 16px;
                margin-bottom: 10px;
                padding: 10px;
            }
            .message {
                color: green;
            }
            .error {
                color: red;
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
                        <div class="loan-container">
                            <div class="loan-title">Thanh Toán Khoản Vay</div>

                            <!-- Hiển thị thông báo nếu có -->
                            <c:if test="${not empty message}">
                                <div class="message">${message}</div>
                            </c:if>
                            <c:if test="${not empty error}">
                                <div class="error">${error}</div>
                            </c:if>

                            <!-- Giả sử bạn đã lấy thông tin khoản vay từ session hoặc request attribute -->
                            <div class="loan-detail">
                                <span class="loan-label">Dư nợ:</span>
                                <span><fmt:formatNumber value="${loan.debtRepayAmount}" type="currency" currencyCode="VND"/></span>
                            </div>

                            <form action="customerLoanPayment" method="post">
                                <!-- Giả sử loan.id chứa ID của LoanServiceUsed -->  
                                <input type="hidden" name="loanId" value="${loan.id}" />
                                <input type="number" name="repayAmount" placeholder="Nhập số tiền muốn thanh toán" required step=\"0.01\" />
                                <button type="submit" class="loan-button">Xác Nhận Thanh Toán</button>
                            </form>
                            <button onclick="location.href = 'customerLoanServlet'" class="loan-button back-button">Quay Lại</button>

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
