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
                width: 600px;
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
            .tabs {
                display: flex;
                margin-top: 15px;
            }
            .tab {
                flex: 1;
                text-align: center;
                padding: 8px;
                border-radius: 8px;
                font-size: 14px;
                cursor: pointer;
                background: #ddd;
                margin: 0 5px;
                text-decoration: none; /* Bỏ gạch chân */
                color: black; /* Màu chữ đen giống như div */
                display: block; /* Giúp tab không bị co lại */
            }
            .tab.active {
                background-color: red;
                color: white;
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
                        
                        <div class="tabs">
                            <a href="<%= request.getContextPath() %>/customerLoanPayment?loanId=${loan.id}&payType=Monthly" 
                               class="tab ${payType == 'Monthly' ? 'active' : ''}">Trả nợ định kỳ</a>
                            <a href="<%= request.getContextPath() %>/customerLoanPayment?loanId=${loan.id}&payType=Full" 
                               class="tab ${payType == 'Full' ? 'active' : ''}">Trả nợ toàn phần</a>
                                <a href="<%= request.getContextPath() %>/customerLoanPayment?loanId=${loan.id}&payType=ToNow"
                                   class="tab ${payType == 'ToNow' ? 'active' : ''}">Trả nợ tới hiện tại</a>
                        </div>
                        <div class="loan-container">
                            <div class="loan-title">Thanh Toán Khoản Vay</div>
                            <!-- Hiển thị thông báo nếu có -->
                            <c:if test="${not empty message}">
                                <div class="message">${message}</div>
                            </c:if>
                            <c:if test="${not empty errorMess}">
                                <div class="error">${errorMess}</div>
                            </c:if>

                            <c:set var="now" value="<%= new java.util.Date() %>" scope="page" />

                            <div class="loan-detail">
                                <span class="loan-label">Ngày thanh toán:</span>
                                <span><fmt:formatDate value="${now}" pattern="dd/MM/yyyy"/></span>
                            </div>

                            <div class="loan-detail">
                                <span class="loan-label">Số tiền đang vay:</span>
                                <span><fmt:formatNumber value="${loan.amount}" pattern="#,##0 VND"/></span>
                            </div>
                            <div class="loan-detail">
                                <span class="loan-label">Lãi suất 6 tháng đầu:</span>
                                <span>${loan.loanId.onTermRate}%/năm</span>
                            </div>

                            <div class="loan-detail">
                                <span class="loan-label">Lãi suất:</span>
                                <span>${loan.loanId.afterTermRate}%/năm</span>
                            </div>

                            <div class="loan-detail">
                                <span class="loan-label">Lãi suất quá hạn:</span>
                                <span>${loan.loanId.penaltyRate}%/năm</span>
                            </div>

                            <div class="loan-detail">
                                <span class="loan-label">Kỳ hạn:</span>
                                <span>${loan.loanId.duringTime} tháng</span>
                            </div>

                            <div class="loan-detail">
                                <span class="loan-label">Số gốc còn lại:</span>
                                <span><fmt:formatNumber value="${loan.debtRepayAmount}"  pattern="#,##0 VND"/></span>
                            </div>

                            <div class="loan-detail">
                                <span class="loan-label">Số tiền lãi trong hạn:</span>
                                <span><fmt:formatNumber value="${interestAmount}"  pattern="#,##0 VND"/></span>
                            </div>

                            <div class="loan-detail">
                                <span class="loan-label">Nợ lãi quá hạn:</span>
                                <span><fmt:formatNumber value="${overdueInterestDebt}"  pattern="#,##0 VND"/></span>
                            </div>

                            <div class="loan-detail">
                                <span class="loan-label">Nợ gốc quá hạn:</span>
                                <span><fmt:formatNumber value="${overduePrincipal}"  pattern="#,##0 VND"/></span>
                            </div>

                            <div class="loan-detail">
                                <span class="loan-label">Có thể thanh toán định kỳ sau:</span>
                                <span><fmt:formatDate value="${minDate}" pattern="dd/MM/yyyy"/></span>
                            </div>

                            <div class="loan-detail">
                                <span class="loan-label">Hạn thanh toán kì này:</span>
                                <span><fmt:formatDate value="${dueDate}" pattern="dd/MM/yyyy"/></span>
                            </div>

                            <div class="loan-detail">
                                <span class="loan-label">Số tiền trong ví:</span>
                                <span><fmt:formatNumber value="${loan.cusId.wallet}"  pattern="#,##0 VND"/></span>
                            </div>
                            <form action="customerLoanPayment" method="post">
                                <!-- Giả sử loan.id chứa ID của LoanServiceUsed -->  
                                <input type="hidden" name="loanId" value="${loan.id}" />
                                <div class="loan-detail">
                                    <span class="loan-label">Tổng số tiền phải trả:</span>
                                    <span><fmt:formatNumber value="${paymentAmount}"  pattern="#,##0 VND"/></span>
                                </div>
                                <input type="hidden" name="repayAmount" value="${paymentAmount}"/>
                                <input type="hidden" name="monthsToPay" value="${monthsToPay}"/>
                                <input type="hidden" name="pType" value="${payType}"/>
                                <c:if test="${now > minDate || payType == 'Full'}">
                                    <button type="submit" class="loan-button">Xác Nhận Thanh Toán</button>
                                </c:if>
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
