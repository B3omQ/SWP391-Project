<!DOCTYPE html>
<html lang="en">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    
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
            .savings-container {
                margin: auto;
                background: white;
                border-radius: 12px;
                padding: 25px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }
            .title {
                text-align: center;
                font-weight: bold;
                color: #673ab7;
            }
            .amount {
                text-align: center;
                font-size: 24px;
                font-weight: bold;
                color: #333;
            }
            .selected-info {
                text-align: center;
                font-size: 16px;
                font-weight: bold;
                color: #d32f2f;
                margin-bottom: 15px;
            }
            .option {
                border: 2px solid #ddd;
                padding: 15px;
                border-radius: 8px;
                margin-bottom: 10px;
                cursor: pointer;
                background-color: white;
                transition: all 0.3s ease-in-out;
            }
            .option:hover {
                background-color: #f9f9f9;
            }
            .option.selected {
                border-color: #ff9800;
                background-color: #fff7e6;
            }
            .btn-continue {
                width: 100%;
                background-color: #673ab7;
                color: white;
                font-weight: bold;
                padding: 12px;
                border-radius: 8px;
                transition: background 0.3s;
            }
            .btn-continue:disabled {
                background-color: #b39ddb;
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
                        <div class="col-xl-8 col-lg-12 col-md-7 mt-4 pt-2 mt-sm-0 pt-sm-0">
                            <div class="rounded shadow mt-4">
                                <div class="p-4 border-bottom">
                                    <h5 class="mb-0">Đăng ký vay :</h5>
                                </div>
                                <c:if test="${not empty errorMessages}">
                                    <div class="alert alert-danger">
                                        <ul>
                                            <c:forEach var="error" items="${errorMessages}">
                                                <li>${error}</li>
                                                </c:forEach>
                                        </ul>
                                    </div>
                                </c:if>

                                <form action="applyLoan" method="post" enctype="multipart/form-data">
                                    <div class="p-4">
                                        <div class="p-4">
                                            <div class="row">

                                                <div class="row align-items-center">
                                                    <label class="form-label">Chứng minh thu nhập</label>
                                                    <div class="md-5" style="padding-top: 10px">
                                                        <input type="file" class="form-control-file" id="fileInput" name="incomeVertification" accept=".jpg,.png,.jpeg"> 
                                                        <small id="fileError" style="color: red;"></small>
                                                    </div>
                                                </div><!--end row-->

                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label class="form-label">Nhập số tiền (VNĐ):</label>
                                                        <div class="input-group">
                                                            <input id="amountInput" name="amount" type="number" class="form-control" min="0" oninput="updateDisplay()" />
                                                            <span class="input-group-text" id="formattedAmount">0 VND</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="savings-container">
                                            <input type="hidden" id="loanId" name="loanId" value="">
                                            <p class="text-muted">Chọn gói</p>
                                            <c:forEach var="optionLoan" items="${optionLoanList}">
                                                <div id="options-container">
                                                    <div class="option" data-loan-id="${optionLoan.id}" data-months="1" data-rate="0.5%" data-date="10/04/2025">
                                                        <strong>${optionLoan.loanServiceName}</strong><br>
                                                        ${optionLoan.duringTime} Tháng - Lãi suất: ${optionLoan.afterTermRate}%/năm <br>
                                                        <c:if test="${optionLoan.loanTypeRepay == 'Amortized Loan'}">
                                                            Lãi suất ưu đãi: ${optionLoan.onTermRate}%/năm<br>
                                                        </c:if>
                                                        Hạn mức: <span><fmt:formatNumber value="${optionLoan.minimumLoan}" pattern="#,##0 VND"/> - 
                                                            <fmt:formatNumber value="${optionLoan.maximumLoan}" pattern="#,##0 VND"/></span>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>

                                        <div class="row" style="margin: 10px">
                                            <div class="col-sm-12">
                                                <input type="submit" id="submit" name="send" class="btn btn-primary" value="Submit">
                                            </div><!--end col-->
                                        </div><!--end row-->
                                    </div>
                                </form>
                            </div>
                        </div><!--end col-->
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
        <script>
            const options = document.querySelectorAll('.option');
            const continueButton = document.querySelector('.btn-continue');
            const selectedInfo = document.getElementById('selected-info');
            let selectedMonths = null;

            // Xử lý chọn kỳ hạn
            options.forEach(option => {
                option.addEventListener('click', function () {
                    options.forEach(o => o.classList.remove('selected'));
                    this.classList.add('selected');
                });
            });


        </script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Lấy tất cả các phần tử option
                const options = document.querySelectorAll('.option');
                const selectedInfo = document.getElementById('selected-info');
                const loanIdInput = document.getElementById('loanId');
                const continueButton = document.querySelector('.btn.btn-continue');

                options.forEach(option => {
                    option.addEventListener('click', function () {
                        // Lấy giá trị loanID từ thuộc tính data-loan-id
                        const loanId = this.getAttribute('data-loan-id');

                        // Cập nhật input hidden
                        loanIdInput.value = loanId;

                        // Cập nhật thông tin hiển thị cho người dùng
                        selectedInfo.textContent = "Đã chọn loanID: " + loanId;

                        // Kích hoạt nút "Tiếp tục" (nếu cần)
                        continueButton.disabled = false;

                        console.log("Loan ID đã chọn:", loanId);
                    });
                });
            });
        </script>
        <script>
            function updateDisplay() {
                let input = document.getElementById("amountInput");
                let display = document.getElementById("formattedAmount");

                let value = input.value;
                if (value === "") {
                    display.innerText = "0 VND";
                    return;
                }

                let formattedValue = new Intl.NumberFormat("vi-VN").format(value);
                display.innerText = formattedValue + " VND";
            }
        </script>
        <script>
            document.getElementById('fileInput').addEventListener('change', function () {
                const file = this.files[0];
                const maxSize = 5 * 1024 * 1024; // 5MB

                if (file.size > maxSize) {
                    alert('❌ File quá lớn! Chỉ chấp nhận file tối đa 5MB.');
                    this.value = ''; // Xóa file đã chọn
                }
            });
        </script>
    </body>

</html>