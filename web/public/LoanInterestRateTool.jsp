<%-- 
    Document   : LoanInterestRateTool
    Created on : Feb 11, 2025, 8:04:02 AM
    Author     : LAPTOP
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Bảng Tính Lãi Suất Vay</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

        <style>
            body {
                background-color: #f1f3f6;
                font-family: 'Arial', serif;
                margin-bottom: 50px;
            }

            .container {
                max-width: 1000px;
                margin: auto;
            }

            .result-box p {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }



            .calculator-container {
                background: white;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
            }

          

            .nav-tabs {
                border-bottom: 2px solid #e0e0e0;
            }

            .nav-tabs .nav-link {
                font-size: 18px;
                font-weight: bold;
                color: #555;
                padding: 12px 20px;
                transition: all 0.2s ease;
            }

            .nav-tabs .nav-link.active {
                color: #dc3545;
                border-bottom: 3px solid #dc3545;
                font-weight: bold;
            }


            .result-box {
                background: linear-gradient(135deg, #343a40, #212529);
                padding: 25px;
                border-radius: 12px;
                color: white;
                text-align: center;
                transition: all 0.2s ease-in-out;
            }


            .slider-label {
                display: flex;
                justify-content: space-between;
                font-size: 14px;
                color: #555;
            }

            .loan-percent {
                color: #007bff;
                font-weight: bold;
                font-size: 14px;


            }

            input.form-control, input.form-range {
                border: 2px solid #dee2e6;
                border-radius: 8px;
                padding: 8px;
                transition: all 0.3s ease;
            }

            input.form-control:focus {
                border-color: #dc3545;
                box-shadow: 0px 0px 8px rgba(220, 53, 69, 0.3);
            }


            a.text-white {
                display: inline-block;
                background: #dc3545;
                padding: 10px;
                border-radius: 8px;
                text-decoration: none;
                font-weight: bold;
                transition: all 0.3s ease-in-out;
            }



            .view-details-btn {
                background-color: #dc3545;
                border: none;
                border-radius: 8px;
                padding: 12px 20px;
                font-size: 16px;
                text-transform: uppercase;
                display: inline-block;
                transition: all 0.3s ease-in-out;
                width: 200px;
                margin: 20px auto;
            }


            .view-details-btn:hover {
                background-color: #d51518;

            }


            .tab-pane {
                opacity: 0;
                transition: opacity 0.2s ease-in-out;
            }

            .tab-pane.show {
                opacity: 1;
            }

            #loanRepaymentTable {
                border-collapse: collapse;
                width: 100%;
                text-align: center;
            }


            #loanRepaymentTable th,
            #loanRepaymentTable td {
                padding: 12px;
                font-size: 14px;
                vertical-align: middle;
            }


            #loanRepaymentTable thead {
                background-color: #007bff;
                color: white;
                font-weight: bold;
            }


            #loanRepaymentTable tbody tr:nth-child(odd) {
                background-color: #f8f9fa;
            }

            #loanRepaymentTable tbody tr:nth-child(even) {
                background-color: #ffffff;
            }


            #loanRepaymentTable tbody tr:hover {
                background-color: #dfe6e9;
                cursor: pointer;
            }


            #loanRepaymentTable th,
            #loanRepaymentTable td {
                border: 1px solid #dee2e6;
                border-radius: 5px;
            }


            .modal-content {
                border-radius: 12px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }


            .modal-header {
                background: linear-gradient(135deg, #343a40, #212529);
                color: white;
                border-radius: 12px 12px 0 0;
                padding: 12px;
            }


            .modal-footer {
                background-color: #f8f9fa;
                border-radius: 0 0 12px 12px;
            }

            .modal-dialog {
                max-width: 80%;
                width: 80%;
            }

            .modal-content {
                border-radius: 12px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                max-height: 90vh;
                overflow-y: auto;
                transition: transform 0.3s ease, opacity 0.3s ease;
                transform: translateY(-20%);
                opacity: 0;
            }


            .modal.show .modal-content {
                transform: translateY(0);
                opacity: 1;
            }


            .custom-btn {
                background-color: red;
                color: white;
                border: none;
                padding: 10px 20px;
                font-size: 16px;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }


            .custom-btn:hover {
                background-color: darkred;
            }


            .custom-btn:focus {
                outline: none;
            }


            .custom-close-btn {

                font-size: 20px;
                padding: 5px;
                cursor: pointer;
            }




        </style>
    </head>
    <body>

        <div class="container mt-4">
            <h2 class="mb-3 text-center">Bảng Tính Lãi Suất Vay</h2>
            <ul class="nav nav-tabs">
                <li class="nav-item">
                    <a class="nav-link active" data-bs-toggle="tab" href="#giamdan">Dư nợ giảm dần</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="tab" href="#codinh">Trả hàng tháng cố định</a>
                </li>
            </ul>

            <div class="tab-content">
                <!-- Declining Balance Loan Tab -->
                <div id="giamdan" class="tab-pane fade show active">
                    <div class="row mt-3">
                        <div class="col-md-7 calculator-container">
                            <div class="mb-3">
                                <label class="form-label">Giá trị bất động sản</label>
                                <div class="input-group">
                                    <input type="text" class="form-control text-end" id="propertyValue" value="0" >
                                    <span class="input-group-text">VND</span>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Số tiền vay</label>
                                <input type="range" class="form-range" min="0" max="100" value="0" id="loanRange">
                                <div class="slider-label">
                                    <span >0%</span>
                                    <span id="loanPercent" class="loan-percent">0%</span>
                                    <span>100%</span>
                                </div>
                                <div class="input-group">
                                    <input type="text" class="form-control text-end" id="loanAmount" value="" >
                                    <span class="input-group-text">VND</span>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Thời gian vay</label>
                                <div class="input-group">
                                    <input type="number" class="form-control text-end" id="loanDuration" min="1" value="" >
                                    <span class="input-group-text">Tháng</span>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Lãi suất</label>
                                <div class="input-group">
                                    <input type="number" class="form-control text-end" id="interestRate" min="1" max="100" value="" >
                                    <span class="input-group-text">%/Năm</span>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Ngày giải ngân</label>
                                <div class="input-group">
                                    <input type="date" class="form-control" id="disbursementDate" >
                                    <span class="input-group-text"><i class="bi bi-calendar"></i></span>
                                </div>
                            </div>

                        </div>

                        <div class="col-md-5 result-box" id="formgiamdan">
                            <div class="text-center">
                                <img src="https://techcombank.com/content/dam/techcombank/public-site/en/images/personal-banking/money-0f1c128322.png.rendition/cq5dam.web.1280.1280.png" width="80">
                            </div>
                            <h5 class="mt-3 text-center">Số tiền trả hàng tháng</h5>
                            <p class="fs-5 "><strong >Từ:</strong> <span class="float-end" id="maxPayment">0 VND</span></p>
                            <p class="fs-5 "><strong>Đến:</strong> <span class="float-end" id="minPayment">0 VND</span></p>
                            <hr>
                            <h5 class="text-center">Tổng lãi phải trả</h5>
                            <h4 class="fs-5" style="text-align: center" id="totalInterest">0 VND</h4>
                            <button type ="button" class="view-details-btn text-white d-block text-center"  
                                    data-bs-toggle="modal" 
                                    data-bs-target="#loanRepaymentModal">
                                Xem chi tiết
                            </button>

                        </div>
                    </div>
                </div>

                <!--  Payment Tab -->
                <div id="codinh" class="tab-pane fade">
                    <div class="row mt-3">
                        <div class="col-md-7 calculator-container">
                            <div class="mb-3">
                                <label class="form-label">Giá trị bất động sản</label>
                                <div class="input-group">
                                    <input type="text" class="form-control text-end" id="propertyValueCodinh" value="0">
                                    <span class="input-group-text">VND</span>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Số tiền vay</label>
                                <input type="range" class="form-range" min="0" max="100" value="0" id="loanRangeCodinh">
                                <div class="slider-label">
                                    <span>0%</span>
                                    <span id="loanPercentCodinh" class="loan-percent">0%</span>
                                    <span>100%</span>
                                </div>
                                <div class="input-group">
                                    <input type="text" class="form-control text-end" id="loanAmountCodinh" value="0">
                                    <span class="input-group-text">VND</span>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Thời gian vay</label>
                                <div class="input-group">
                                    <input type="number" class="form-control text-end" id="loanDurationCodinh" min="1" value="">
                                    <span class="input-group-text">Tháng</span>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Lãi suất</label>
                                <div class="input-group">
                                    <input type="number" class="form-control text-end" id="interestRateCodinh" value="5">
                                    <span class="input-group-text">%/Năm</span>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Ngày giải ngân</label>
                                <div class="input-group">
                                    <input type="date" class="form-control" id="disbursementDateCodinh">
                                    <span class="input-group-text"><i class="bi bi-calendar"></i></span>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-5 result-box" id="formcodinh">
                            <div class="text-center">
                                <img src="https://techcombank.com/content/dam/techcombank/public-site/en/images/personal-banking/protect/money-saving-2-a199a50889.svg" width="100">
                            </div>
                            <h5 class="mt-3 text-center">Số tiền trả hàng tháng</h5>
                            <h4 class="fs-5 text-center" id="monthlyPayment">0 VND</h4>
                            <hr>
                            <h5 class="text-center">Tổng lãi phải trả</h5>
                            <h4 class="fs-5" style="text-align: center" id="totalInterestCodinh">0 VND</h4>

                        </div>
                    </div>
                </div>

            </div>
            <!--  Modal -->
            <div class="modal fade" id="loanRepaymentModal" tabindex="-1" aria-labelledby="loanRepaymentModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title " id="loanRepaymentModalLabel">Bảng tính lịch trả nợ với dư nợ giảm dần</h5>
                            <button class="btn btn-close p-1 custom-close-btn" type="button" data-bs-dismiss="modal" aria-label="Close"></button>

                        </div>
                        <div class="modal-body">
                            <table class="table table-bordered" id="loanRepaymentTable">
                                <thead>
                                    <tr>
                                        <th scope="col">STT</th>
                                        <th scope="col">KỲ TRẢ NỢ</th> 
                                        <th scope="col">SỐ GỐC CÒN LẠI</th>
                                        <th scope="col">GỐC</th>
                                        <th scope="col">LÃI</th>
                                        <th scope="col">TỔNG GỐC + LÃI</th>
                                    </tr>
                                </thead>
                                <tbody>

                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="2"><strong>TỔNG</strong></td> 
                                        <td></td>                                        
                                        <td id="totalPrincipal" class="fw-bold"></td>
                                        <td id="totalInterestModal" class="fw-bold"></td>                                       
                                        <td id="totalPayment" class="fw-bold"></td>
                                    </tr>
                                </tfoot>

                            </table>
                        </div>
                        <div class="modal-footer">
                            <button class="btn custom-btn" type="button" data-bs-dismiss="modal">Close</button>
                        </div>

                    </div>
                </div>
            </div>



        </div>



        <script>
            $(document).ready(function () {

                $('#loanRepaymentModal').on('shown.bs.modal', function () {
                    $('.modal-content').addClass('show');
                });


                $('#loanRepaymentModal').on('hidden.bs.modal', function () {
                    $('.modal-content').removeClass('show');
                });

                function formatCurrency(value) {
                    return value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                }


                document.getElementById('propertyValue').addEventListener('input', function () {
                    let propertyValue = this.value;

                    propertyValue = propertyValue.replace(/\D/g, '');
                    this.value = formatCurrency(propertyValue);
                });

                document.getElementById('propertyValueCodinh').addEventListener('input', function () {
                    let propertyValueCodinh = this.value;                
                    propertyValueCodinh = propertyValueCodinh.replace(/\D/g, ''); 
                    this.value = formatCurrency(propertyValueCodinh);

          
                    document.getElementById('propertyValue').value = this.value;
                });


                var today = new Date().toISOString().split('T')[0];
                $('#disbursementDate, #disbursementDateCodinh').val(today);
                $("#loanRange, #loanRangeCodinh").on("input", function () {
                    let percent = $(this).val();
                    let propertyValue = parseInt($("#propertyValue").val().replace(/,/g, "")) || 0;
                    let loanAmount = (propertyValue * percent) / 100;
                    let context = $(this).closest('.tab-pane').attr('id');
                    if (context === "giamdan") {
                       $("#loanPercent").text(percent + '%');
                        $("#loanAmount").val(loanAmount.toLocaleString("en-US"));
                    } else if (context === "codinh") {
                        $("#loanPercentCodinh").text(percent + '%');
                        $("#loanAmountCodinh").val(loanAmount.toLocaleString("en-US"));
                    }
                });
                $("#loanAmount, #loanAmountCodinh").on("input", function () {
                    let context = $(this).closest('.tab-pane').attr('id');
                    let loanAmount = parseInt($(this).val().replace(/,/g, "")) || 0;
                    let propertyValue = parseInt($("#propertyValue").val().replace(/,/g, "")) || 0;
                    let percent = Math.round((loanAmount / propertyValue) * 100);
                    if (context === "giamdan") {
                        $("#loanPercent").text(percent);
                        $("#loanRange").val(percent);
                    } else if (context === "codinh") {
                        $("#loanPercentCodinh").text(percent);
                        $("#loanRangeCodinh").val(percent);
                    }
                });
                $("#loanAmount, #loanRange, #loanDuration, #interestRate, #loanAmountCodinh, #loanRangeCodinh, #loanDurationCodinh, #interestRateCodinh").on("input", function () {
                    calculateLoan();
                });
                function calculateLoan() {
                    let context = $(".tab-pane.active").attr('id');
                    let loanAmount, months, interestRate, monthlyInterest, principalPayment, totalInterest = 0;
                    let remainingBalance, totalMonthlyPayment = 0, interestPaymentFirstMonth = 0;
                    let fixedMonthlyPayment, totalFixedInterest, totalFixedInterest2, fixedMonthlyPayment2;
                    let totals = {
                        totalPrincipal: 0,
                        totalInterestModal: 0,
                        totalPayment: 0
                    };

                    if (context === "giamdan") {
                        loanAmount = parseInt($("#loanAmount").val().replace(/,/g, "")) || 0;
                        months = parseInt($("#loanDuration").val()) || 1;
                        interestRate = parseFloat($("#interestRate").val()) / 100;
                    } else if (context === "codinh") {
                        loanAmount = parseInt($("#loanAmountCodinh").val().replace(/,/g, "")) || 0;
                        months = parseInt($("#loanDurationCodinh").val()) || 1;
                        interestRate = parseFloat($("#interestRateCodinh").val()) / 100;
                    }

                    monthlyInterest = interestRate / 12;
                    principalPayment = loanAmount / months;
                    remainingBalance = loanAmount;
                    totalMonthlyPayment = 0;
                    let repaymentDetails = [];
                    let disbursementDate = new Date($("#disbursementDate").val());

                    for (let i = 0; i < months; i++) {
                        let interestPayment = (remainingBalance * monthlyInterest);
                        totalInterest += interestPayment;
                        totalMonthlyPayment = Math.round(principalPayment + interestPayment);
                        if (i === 0) {
                            interestPaymentFirstMonth = interestPayment;
                        }

                        totals.totalPrincipal += principalPayment;
                        totals.totalInterestModal += interestPayment;
                        totals.totalPayment += totalMonthlyPayment;



                        let paymentDate = moment(disbursementDate).add(i + 1, 'months').format('DD/MM/YYYY');
                        remainingBalance -= principalPayment;
                        let remainingBalance1 = remainingBalance;
                        remainingBalance = Math.max(remainingBalance, 0);
                        repaymentDetails.push({
                            month: i + 1,
                            paymentDate: paymentDate,
                            remainingBalance: (Math.round(remainingBalance).toLocaleString("en-US")),
                            principalPayment: Math.round(principalPayment).toLocaleString("en-US"),
                            interestPayment: Math.round(interestPayment).toLocaleString("en-US"),
                            totalPayment: Math.round(totalMonthlyPayment).toLocaleString("en-US")
                        });
                    }
                    console.log("repaymentDetails:", repaymentDetails);

                    fixedMonthlyPayment = (loanAmount * monthlyInterest) / (1 - Math.pow(1 + monthlyInterest, -months));
                    fixedMonthlyPayment = Math.round(fixedMonthlyPayment);
                    totalFixedInterest = (fixedMonthlyPayment * months) - loanAmount;
                    totalFixedInterest = Math.round(totalFixedInterest);
                    fixedMonthlyPayment2 = ((loanAmount * (months / 12) * interestRate) + loanAmount) / months;
                    fixedMonthlyPayment2 = Math.round(fixedMonthlyPayment2);
                    totalFixedInterest2 = ((loanAmount * (months / 12) * interestRate) + loanAmount);
                    totalFixedInterest2 = Math.round(totalFixedInterest2);
                    if (context === "giamdan") {
                        let totalFirstMonthPayment = Math.round(interestPaymentFirstMonth + principalPayment);

                        $("#minPayment").text(isNaN(Number(totalMonthlyPayment)) ? "0 VND" : Number(totalMonthlyPayment).toLocaleString("en-US") + " VND");
                        $("#maxPayment").text(isNaN(Number(totalFirstMonthPayment)) ? "0 VND" : Number(totalFirstMonthPayment).toLocaleString("en-US") + " VND");
                        $("#totalInterest").text(isNaN(Number(Math.round(totalInterest + loanAmount))) ? "0 VND" : Number(Math.round(totalInterest + loanAmount)).toLocaleString("en-US") + " VND");


                        populateRepaymentTable(repaymentDetails);
                        renderTotal(totals);
                        console.log("Total: ", totals);
                    } else if (context === "codinh") {
                        $("#monthlyPayment").text(isNaN(Number(fixedMonthlyPayment2)) ? "0 VND" : Number(fixedMonthlyPayment2).toLocaleString("en-US") + " VND");
                        $("#totalInterestCodinh").text(isNaN(Number(totalFixedInterest2)) ? "0 VND" : Number(totalFixedInterest2).toLocaleString("en-US") + " VND");

                    }



                }

                function populateRepaymentTable(repaymentDetails) {
                    const tableBody = $("#loanRepaymentTable tbody");
                    tableBody.empty();

                    repaymentDetails.forEach(function (detail) {
                        const row = $("<tr>");
                        row.append($("<td>").text(detail.month));
                        row.append($("<td>").text(detail.paymentDate));
                        row.append($("<td>").text(detail.remainingBalance));
                        row.append($("<td>").text(detail.principalPayment));
                        row.append($("<td>").text(detail.interestPayment));
                        row.append($("<td>").text(detail.totalPayment));
                        tableBody.append(row);
                    });

                }
                function renderTotal(totals) {

                    const totalPrincipal = isNaN(totals.totalPrincipal) ? 0 : totals.totalPrincipal;
                    const totalInterestModal = isNaN(totals.totalInterestModal) ? 0 : totals.totalInterestModal;
                    const totalPayment = isNaN(totals.totalPayment) ? 0 : totals.totalPayment;


                    $("#totalPrincipal").text(Math.round(totalPrincipal).toLocaleString("en-US"));
                    $("#totalInterestModal").text(Math.round(totalInterestModal).toLocaleString("en-US"));
                    $("#totalPayment").text(Math.round(totalPayment).toLocaleString("en-US"));
                }

            });
        </script>


    </body>
</html>
