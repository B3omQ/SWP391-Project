<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bảng Tính Lãi Suất Tiết Kiệm</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>

            body {
                background-color: #f1f3f6;
                font-family: 'Arial', serif;

            }
            input.form-range {
                border: 2px solid #dee2e6;
                border-radius: 8px;
                padding: 8px;
                transition: all 0.3s ease;
            }

            .container {
                max-width: 1000px;
                margin: 50px auto;
            }

            .calculator-container {
                background-color: #f9f9f9;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .result-box {
                background: linear-gradient(135deg, #343a40, #212529);
                padding: 24px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                text-align: center;
                color: white;
            }
            .result-box img {
                margin-bottom: 15px;
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
        </style>
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="mb-3 text-center">Bảng Tính Lãi Suất Tiết Kiệm</h2>
            <div class="row align-items-center">
                <!-- Cột nhập dữ liệu -->
                <div class="col-md-7 calculator-container">
                    <div class="mb-3">
                        <label class="form-label">Số tiền gửi</label>
                        <div class="input-group">
                            <input type="text" class="form-control text-end" id="depositAmount" value="">
                            <span class="input-group-text">VND</span>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Lãi suất (%/Năm)</label>
                        <input type="range" class="form-range" id="interestRate" min="2" max="10" value="2">
                        <div class="slider-label">
                            <span>2%</span>
                            <span class="loan-percent" id="currentRate">2%</span>
                            <span>10%</span>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Thời gian gửi (Tháng)</label>
                        <div class="input-group">
                            <input type="number" class="form-control text-end" id="depositDuration" value="" min="1" >
                            <span class="input-group-text">Tháng</span>
                        </div>
                    </div>
                </div>

                <!-- Cột hiển thị kết quả -->
                <div class="col-md-5 result-box">
                    <div class="text-center">
                        <img src="https://techcombank.com/content/dam/techcombank/public-site/en/images/personal-banking/protect/money-saving-2-a199a50889.svg" width="100">
                    </div>
                    <h5>Tiền lãi nhận được cuối kỳ</h5>
                    <p class="fs-5"><span id="totalInterest">0 VND</span></p>
                    <hr>
                    <h5>Tổng tiền nhận được</h5>
                    <h4 class="fs-5" id="totalAmount">0 VND</h4>
                </div>
            </div>
        </div>

        <script>
            function calculateInterest() {
                // Parse depositAmount by removing commas before calculating
                var depositAmount = parseFloat($("#depositAmount").val().replace(/,/g, ''));
                var interestRate = parseFloat($("#interestRate").val());
                var depositDuration = parseInt($("#depositDuration").val());

                // Check if input is NaN or zero
                if (isNaN(depositAmount) || isNaN(interestRate) || isNaN(depositDuration) || depositAmount <= 0 || depositDuration <= 0) {
                    $("#totalInterest").text("0 VND");
                    $("#totalAmount").text("0 VND");
                    return;
                }

                var totalInterest = depositAmount * (interestRate / 100) * (depositDuration / 12);
                var totalAmount = depositAmount + totalInterest;

               
                $("#totalInterest").text(formatCurrency(totalInterest.toFixed(0)) + " VND");
                $("#totalAmount").text(formatCurrency(totalAmount.toFixed(0)) + " VND");
            }

            function formatCurrency(value) {
                
                return value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            }

            $(document).ready(function () {
              
                $("#depositAmount").on("input", function () {
                    let inputValue = $(this).val();
                    inputValue = inputValue.replace(/\D/g, "");
                    $(this).val(formatCurrency(inputValue)); 
                    calculateInterest(); 
                });

             
                calculateInterest();


                $("#depositAmount, #interestRate, #depositDuration").on("input change", function () {
                    calculateInterest();
                    $("#currentRate").text($("#interestRate").val() + "%");
                });
            });
        </script>

    </body>
</html>