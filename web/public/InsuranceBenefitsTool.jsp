<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bảng Tính Quyền Lợi Bảo Hiểm</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            body {
                background-color: #f1f3f6;
                font-family: 'Arial', serif;
            }
            .calculator-container {
                background-color: #ffffff;
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
            .input-group-text {
                background-color: #f1f1f1;
            }
            .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
            }
            .btn-primary:hover {
                background-color: #0056b3;
                border-color: #0056b3;
            }
            .info-icons {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }
            .info-icons img {
                width: 40px;
                height: 40px;
            }
            .insurance-detail {
                margin-top: 30px;
            }
            .insurance-detail h6 {
                font-size: 18px;
            }
            .insurance-detail p {
                font-size: 16px;
            }
        </style>
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="mb-3 text-center">Minh Họa Quyền Lợi Bảo Hiểm</h2>
            <div class="row">
                <div class="col-md-7 calculator-container">
                    <form id="insuranceForm">
                        <div class="mb-3">
                            <label class="form-label">Ngày sinh</label>
                            <input type="date" class="form-control" id="birthDate" value="" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Giới tính</label>
                            <select class="form-select" id="gender" required>
                                <option value="male" selected>Nam</option>
                                <option value="female">Nữ</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Số tiền muốn được bảo hiểm chính</label>
                            <div class="input-group">
                                <input type="text" class="form-control text-end" id="insuranceAmount" value="">
                                <span class="input-group-text">VND</span>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="col-md-5 result-box">
                    <div class="text-center">
                        <img src="https://techcombank.com/content/dam/techcombank/public-site/en/images/personal-banking/money-0f1c128322.png.rendition/cq5dam.web.1280.1280.png" width="80">
                    </div>
                    <h5 class="text-center">Số tiền muốn được bảo hiểm chính</h5>
                    <h4 class="fs-5" style="text-align: center" id="annualPremiumAmount">0 VND</h4>
                </div>
            </div>
        </div>

        <script>
            function calculateInsurance() {
                var gender = $("#gender").val();
                var insuranceAmount = parseFloat($("#insuranceAmount").val().replace(/,/g, ''));

                if (isNaN(insuranceAmount) || insuranceAmount <= 0) {
                    $("#annualPremiumAmount").text("0 VND");
                    return;
                }

                var multiplier = (gender === "male") ? 0.011 : 0.009;
                var totalInsuranceAmount = insuranceAmount * multiplier;

                $("#annualPremiumAmount").text(formatCurrency(totalInsuranceAmount.toFixed(0)) + " VND");
            }

            function formatCurrency(value) {
                return value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            }

            $(document).ready(function () {
                $("#insuranceAmount").on("input", function () {
                    let inputValue = $(this).val();
                    inputValue = inputValue.replace(/\D/g, "");
                    $(this).val(formatCurrency(inputValue));
                    calculateInsurance();
                });

                $("#gender").on("change", function () {
                    calculateInsurance();
                });

                $("#insuranceForm").on("submit", function (event) {
                    event.preventDefault();
                    calculateInsurance();
                });

                calculateInsurance();
            });
        </script>
    </body>
</html>
